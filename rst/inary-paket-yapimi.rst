Inary paket yapımı
==================
Bu anlatımda inary paketi oluşturma anlatılacaktır. Örnek paket olarak bash paketi üzerinden anlatılacakdır. 

Tüm adımlar root yetkisi gerektirir.

Gerekenler
^^^^^^^^^^
Nosystemd bir dağıtım üzerinde chroot içerisinden çalışan sulin yada kurulu bir sulin gerekmektedir.

Paket yapmak isteyen kişinin python3 programlama dili bilmesi gerekmektedir.

Derleme yapacak bilgisayarın yeterince güçlü bir işlemciye sahip olması gereklidir.

Derleme ortamının hazırlanması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
İlk olarak inary-devel kaynaktan derlenecektir. Kaynak kodu git üzerinden çekip kuralım.

.. code-block:: shell

	git clone https://gitlab.com/sulinos/inary -b develop
	cd inary
	make && make install

Ardından **system.devel** componentini kuralım. Burada temel derleyiciler bulunur.

.. code-block:: shell

	inary it -c system.devel

Derleme işlemleri /var/inary dizini içerisinde gerçekleşecektir. Buraya isterseniz farklı bir disk bağlayabilirsiniz.
Derlemenin hızlı olması ve diske yüklenmemesi için buraya ramdisk bağlamanızı öneririm. Ram miktarının yeteri kadar fazla olduğundan emin olur.

.. code-block:: shell

	mkdir /var/inary
	mount -t tmpfs tmpfs /var/inary

Taslak hazırlama
^^^^^^^^^^^^^^^^
**inary-template** komutunu kullanarak şablon oluşturalım. İsim ve adres zorunlu parametredir.
Nasıl kullanıldığını öğrenmek için *inary-template --help* çalıştırın.

.. code-block:: shell

	inary-template -n bash -a "https://ftp.gnu.org/gnu/bash/bash-5.1.8.tar.gz" -v "5.1.8"

Bize otomatik olarak 3 tane dosya üretti.

*  **actions.py** dosyası nasıl derleneceğini anlatan dosyadır. 
*  **pspec.xml** dosyası paket bilgisinin bulunduğu dosyadır. Inary bu dosyayı kullanır.
*  **pspec.py** dosyası xml üretmek için kullanılabilen ek dosyadır. **genpspec** komutu ile xml haline çevirilebilir.

pspec.py formatı inary tarafından kullanılmaz. Bu yüzden bu dosyayı düzenledikten sonra pspec.xml dosyasını güncellemelisiniz. Bu dosyayı kullanmayıp elle pspec.xml dosyasını düzenleyebilirsiniz. SulinOS kaynak depolarında pspec.py formatındaki dosyalar mevcut değildir.

pspec.xml dosyasını kullanarak pspec.py üretmek için ise **revpspec** komutunu kullanmalısınız. Bu komut kısmen kararlı değildir.

Derlemeye hazır hale gelmiş talimatları **inary bi** kullanarak dertiriz. 

.. code-block:: shell

	inary bi
	
**inary-template** ile üretilen pspec.xml veya pspec.py dosyalarını düzenlemek kolay olduğu için içeriği ile ilgili detaylı bilgilere yazının devamında değineceğim. **actions.py** dosyasının yapısını ve **actionsapi** kütüphanesini anlatarak devam edelim.

Actions.py dosyası
^^^^^^^^^^^^^^^^^^
Bu dosyada python3 ile yazılır. Sırasıyla **setup build check install** fonksionları mevcutsa çalıştırılır. Bu dosyada derleme işlemi yapılırken **actionsapi** adı verilen inary kaynak kodu ile beraber gelen bir kütüphane kullanılır. Bash derlemek için aşağıdakine benzer bir actions dosyası yazılabilir.

.. code-block:: python

	from inary.actionsapi import inarytools
	from inary.actionsapi import autotools
	
	def setup():
	    autotools.configure()
	    
	def build():
	    autotools.make()
	    
	def build():
	    autotools.install()

Actionsapi paket yapma işlemini daha kolay hale getirebilir. Bununla birlikte kullanımı zorunlu değildir. Bu actions dosyamız aşağıdakine benzer şekilde bir komut çalıştırarak derleme yapar.

.. code-block:: shell

	./configure --prefix=/usr # autotools.configure()
	make -j$(nproc) # autotools.make()
	make install DESTDIR=/paketleme/dizini # autotools.install()

Actionsapi içerisindeki her aracın birer **configure**, **make** ve **install** fonksionu bulunur. kullanım şekilleri de aynıdır. Bu sayede kopyala yapıştır mantığı ile ilerleyerek hızlıca onlarca paket yapabilirsiniz. (Araçtan kasıt: autotools cmaketools mesontools ...)

Bu yazıda başlıca actionsapi modüllerini anlatacağım. Tamamına inary kaynak kodundan ulaşabilirsiniz. Kaynak kodda bulunan `get_actionsapi_functions` betiğini çalıştırınız.

0. Shelltools
^^^^^^^^^^^^^
Shelltools en önemli modüldür. diğer araçlar shelltools üzerinden çalışmaktadır. Bu sebeple 0. olarak adlandırdım. Buradaki fonksionları guruplandırarak anlatacağım. Diğer araçları ise topluca anlatacağım.

Dizin değiştirmek için **cd** dizin içeriği listesi almak için **ls** Komut çalıştırmak için ise **system** fonksionları kullanılır. Çevresel değişken ayarı için ise export kullanılır.

.. code-block:: shell

	  - cd(directoryName=''):
	  - ls(source):
	  - system(command):
	  - export(key, value):

Dizin veya dosya isimleri ile ilgili işlemler için aşağıdaki fonksionlar kullanılabilir. 

.. code-block:: shell

	  - realPath(filePath):
  	  - baseName(filePath):
	  - dirName(filePath):


Erişim ve varlık kontrolleri aşağıdaki fonksionlar ile yapılır. Bunlar boolean değer döndürür.

.. code-block:: shell

	  - can_access_file(filePath):
	  - can_access_directory(destinationDirectory):
	  - isLink(filePath):
	  - isFile(filePath):
  	  - isDirectory(filePath):
	  - isEmpty(filePath):


Dizin oluşturmak için **makedirs** kullanılır. Bu fonksion eğer alt dizinler yoksa onlarla beraber oluşturur. (bir nevi mkdir -p gibi)

.. code-block:: shell

	  - makedirs(destinationDirectory):

Dosya işlemleri için aşağıdaki fonksionlar kullanılır.

.. code-block:: shell

	  - echo(destionationFile, content):
	  - chmod(filePath, mode=0o755):
	  - chown(filePath, uid='root', gid='root'):
	  - sym(source, destination):
	  - unlink(pattern):
	  - unlinkDir(sourceDirectory):
	  - move(source, destination):
	  - copy(source, destination, sym=True):
	  - copytree(source, destination, sym=True):
	  - touch(filePath):


1. Autotools
^^^^^^^^^^^^
Autotools kütüphanesi `./configure`, `make`, `make install` şeklinde derlenen kaynaklar için kullanılır.

Autotools fonksionları aşağıdaki gibidir:

.. code-block:: shell

	inary/actionsapi/autotools.py:
  	  - configure(parameters=''): ./configure --prefix=/usr ...
	  - rawConfigure(parameters=''): prefix olmadan configure
	  - compile(parameters=''): gcc kullanarak derleme yapar (gcc ...)
	  - make(parameters=''): make komutunu çalıştırır
	  - fixInfoDir(): paketleme dizinindeki /usr/share/info/dir dizinini siler
	  - fixpc(): 32bit pkgconfig dosyalarının konumunu düzeltir
	  - install(parameters='', argument='install'): make install çalıştırır
	  - rawInstall(parameters='', argument='install'): destdir olmadan install
	  - aclocal(parameters=''): aclocal.m4 dosyalı üretir
	  - autogen(noconfigure=True): bash autogen.sh
	  - autoconf(parameters=''): autoconf çalıştırır
	  - autoreconf(parameters=''): autoreconf çalıştırır
	  - automake(parameters=''): automake çalıştırır
	  - autoheader(parameters=''): autoheader çalıştırır

2. Mesontools
^^^^^^^^^^^^^

Mesontools kütüphanesi `meson build`, `ninja -C build`, `ninja -C build install` şeklinde derlenen kaynaklar için kullanılır.

Mesontools fonksionları aşağıdaki gibidir:

.. code-block:: shell

	inary/actionsapi/mesontools.py:
	  - fixpc(): 32bit pkgconfig dosyalarının konumunu düzeltir
	  - configure(parameters="", type="meson"): cmake yada meson kullanarak configure işlemi (varsayılan meson)
	  - meson_configure(parameters=""): meson build
	  - cmake_configure(parameters=""): mkdir build && cd build && cmake -G ninja ..
	  - ninja_build(parameters=""): ninja -C build
  	  - make(parameters=""): ninja_build ile aynı
  	  - ninja_install(parameters=""): ninja -C install
	  - install(parameters=""):  ninja_install ile aynı
  	  - ninja_check(): ninja -C build check
	  - check(): ninja_check ile aynı

3. Cmaketools
^^^^^^^^^^^^^
Cmaketools kütüphanesi `cmake ..`, `make`, `make install` şeklinde derlenen kaynaklar için kullanılır.

Cmake fonksionları aşağıdaki gibidir.

.. code-block:: shell

	inary/actionsapi/cmaketools.py:
	  - configure(parameters='',installPrefix='', sourceDir='.'): cmake kullanarak configure işlemi
	  - make(parameters=''): make çalıştırır
	  - fixInfoDir(): paketleme dizinindeki /usr/share/info/dir dizinini siler
	  - install(parameters='', argument='install'): make install çalıştırır
	  - rawInstall(parameters='', argument='install'): destdir olmadan make install

