Inary paket yapımı
""""""""""""""""""
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
==================
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

Actions ile inary paket sistemi arasında çevresel değişkenler yardımı ile bağlantı kurulur. Bazı önemli çevresel değişkenler ve örnek değerleri aşağıda verilmiştir.

.. code-block:: shell

	SRCDIR=/tmp/inary/test-1.0.0-1/work
	SRC_RELEASE=1
	OPERATION=setup
	INSTALL_DIR=/var/inary/test-1.0.0-1/install
	PKG_DIR=/var/inary/test-1.0.0-1
	WORK_DIR=/var/inary/test-1.0.0-1/work
	SRC_VERSION=1.0.0
	INARY_BUILD_TYPE=
	SRC_NAME=test

Burada **WORK_DIR** çevresel değişkeni inary tarafından otomatik olarak belirlenir. Bunu değiştirmek için actions betiğinin başına **WorkDir=dizinyolu** şeklinde belirtmelisiniz. **INARY_BUILD_TYPE** çevresel değişkeni kullanarak bir paket ile birden çok türde veya yapılandırmada paket üretmek mümkündür. Örneğin Sulin depolarında 32bit kütüphaneleri üretmek için emul32 adında özel bir değer tanımlanır. Inary her tanımlanan build type için tüm fonksionları tekrar çalıştırır. Bu değeri kontrol ederek kodu istediğiniz yönte ayarlayabilirsiniz. Örneğin aşağıda bir paketin 32bit kütüphanesini de derlemek için:


.. code-block:: python

	from inary.actionsapi import inarytools
	from inary.actionsapi import autotools
	from inary.actionsapi import get
	
	def setup():
	    opts = "--prefix=/usr" # parametreler
	    if get.buildTYPE() == "emul32": # build type türünü çeker
	        shelltools.export("CC","{} -m32".format(get.CC())) # derleyiciyi 32bit moduna alır
	        shelltools.export("CXX","{} -m32".format(get.CXX())) # derleyiciyi 32bit moduna alır
	        opts += " --libdir=/usr/lib32"
	    autotools.rawConfigure(opts)
	    
	def build():
	    autotools.make()
	    
	def build():
	    autotools.install()
	    if get.buildTYPE() == "emul32":
	        inarytools.removeDir("/usr/bin") # 32bit derlenmiş olanın çalıştırılabilir dosyasını sil.


Burada önce **emul32** için çalıştırılır. Sonra tanımlanmamış olan varsayılan tür için çalıştırılır. Yukarıdakö örnekte derleyiciyi 32bit olarak ayarlayıp derleme yaptırdık. daha sonra 32bit olarak derlenen kısımdaki /usr/bin/ dizinini sildik.

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

4. Inarytools
^^^^^^^^^^^^^
Inarytools kütüphanesi derleme işlemine yardımcı olan bir araçtır. Dosya işlemleri ve bazı uzun kodları kısatlma amaçlı yapılmıştır. 

Destination konumlarını tanımlarken paket içeriğindeki yollarını yazmamız yeterlidir.

Inarytools fonksionları aşağıdaki gibidir. Bunların kullanımı ve örneklerini kaynak koddan bulabilirsiniz.

.. code-block:: shell

	  - executable_insinto(destinationDirectory, *sourceFiles):
	  - readable_insinto(destinationDirectory, *sourceFiles):
	  - lib_insinto(sourceFile, destinationDirectory, permission=644):
	  - dobin(sourceFile, destinationDirectory='/usr/bin'):
	  - dopixmaps(sourceFile, destinationDirectory='/usr/share/pixmaps'):
	  - dodir(destinationDirectory):
	  - dodoc(*sourceFiles, **kw):
	  - dohtml(*sourceFiles, **kw):
	  - doinfo(*sourceFiles):
	  - dolib(sourceFile, destinationDirectory='/usr/lib', mode=755):
	  - doman(*sourceFiles, pageDirectory=None):
	  - domo(sourceFile, locale, destinationFile,
	  - domove(sourceFile, destination, destinationFile=''):
	  - rename(sourceFile, destinationFile):
	  - dosed(sources, findPattern, replacePattern='', deleteLine=False, level=-1):
	  - dosbin(sourceFile, destinationDirectory='/usr/sbin'):
	  - dosym(sourceFile, destinationFile):
	  - insinto(destinationDirectory, sourceFile, destinationFile='', sym=True):
	  - newdoc(sourceFile, destinationFile):
	  - newman(sourceFile, destinationFile):
	  - remove(sourceFile):
	  - removeDir(destinationDirectory):

5. Get
^^^^^^
Get kütüphanesi ile derlemeye ait bazı değişkenlere ulaşmak mümkündür. get fonksionları parametre almaz ve string türünden değer döndürür.

.. code-block:: shell

	  - curDIR():         - docDIR():            - srcVERSION():     - qtDIR():
  	  - curKERNEL():      - sbinDIR():           - srcRELEASE():     - existBinary(bin):
	  - curPYTHON():      - infoDIR():           - srcTAG():         - getBinutilsInfo(util):
	  - curPERL():        - manDIR():            - srcDIR():         - AR():
	  - ENV(environ):     - dataDIR():           - ARCH():           - AS():
	  - pkgDIR():         - confDIR():           - HOST():           - CC():
	  - workDIR():        - localstateDIR():     - CHOST():          - CXX():
	  - operation():      - libexecDIR():        - CFLAGS():         - LD():
	  - installDIR():     - libDIR():            - CXXFLAGS():       - NM():
	  - lsbINFO():        - defaultprefixDIR():  - LDFLAGS():        - RANLIB():
	  - kernelVERSION():  - emul32prefixDIR():   - makeJOBS():       - F77():
	  - srcNAME():        - kdeDIR():            - buildTYPE():      - GCJ():

Pspec.xml dosyası
=================
Anlatımımıza pspec.xml ile devam edeceğim. Bu dosya inary tarafından okunarak gereken değerler alınarak derleme işlemi yapılır. **Source**, **Package** ve **History** olmak üzere 3 bölümden oluşur.

Örneğin aşağıda örnek pspec dosyası verilmiştir.

.. code-block:: xml

	<?xml version="1.0" ?>
	<!DOCTYPE INARY SYSTEM "https://raw.githubusercontent.com/Zaryob/inary/master/inary-spec.dtd">
	<INARY>
	    <Source>
	        ... <!--Burası source bölümüdür.-->
	    </Source>

	    <Package>
	        ... <!--Burası package bölümüdür.-->
	    </Package>

	    <Package>
	        ... <!--Burası diğer package bölümüdür.-->
	    </Package>

	    <History>
	        ... <!--Burası history bölümüdür.-->
	    </History>
	</INARY>

Source bölümü
^^^^^^^^^^^^^
Bu bölümde kaynağın özellikleri belirtilir. **Name**, **Homepage**, ***Packager**, **Summary**, **Description**, **Archive** kısımları zorunludur.

**Archive** kısmı birden fazla olabilir.

Archive türü ikili dosyaysa veya açılmayacaksa **type="binary"** eklemeniz gerekmektedir. (`<Archive sha1sum="..." type="archive">https://.../file.bin</Archive>`)

**BuildDependency** kısmında yazılan paketler derleme öncesi kurulur. Oluşturulan paketlere bağımlılık olarak eklenmez.

.. code-block:: xml

	 <Source>
	        <Name>bash</Name>
	        <Homepage>https://www.gnu.org/software/bash</Homepage>
	        <Packager>
	             <Name>Ali Rıza KESKİN</Name>
	             <Email>paledega@yandex.ru</Email>
	        </Packager>
	        <License>GPLv2</License>
	        <IsA>app:console</IsA>
	        <!--<Rfp>Bu paket deneyseldir</Rfp>-->
	        <PartOf>system.base</PartOf>
	        <Summary>Bourne-Again shell</Summary>
	        <Description>GNU bash shell</Description>
	        <Archive sha1sum="d116b469b9e6ea5264a74661d3a4c797da7f997b">https://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz</Archive>
	        <BuildDependencies>
	            <Dependency>ncurses-devel</Dependency>
	            <Dependency>readline-devel</Dependency>
	        </BuildDependencies>
	    </Source>

Eğer **Rfp** tagı kullanırsanız paket **Rfp** olarak oluşturulur. Bu paketler kararlı olmayan veya deneysel paketlerdir. Derlenirken ve kurulurken onay ister. Onay mesajını bu tagın arasına yazmalısınız. **Rfp** paketler Sulin deposunda bulunmaz.

Package bölümü
^^^^^^^^^^^^^^
Bu bölüm birden çok kez bulunabilir. Paket oluşturulurken kullanılır. **Name**, **Files** kısımları zorunludur.

**File** kısmında en az 1 tane **Path** bulunmalıdır ve **fileType** değeri belirtilmek zorundadır. Bu değer **config**, **executable**, **library**, **header**, **localedata**, **data**, **info** alabilir.

.. code-block:: xml

	 <Package>
	        <Name>bash</Name>
	        <IsA>postOps</IsA>
	        <IsA>app:console</IsA>
	        <RuntimeDependencies>
	            <Dependency>ncurses</Dependency>
	        </RuntimeDependencies>
	        <Files>
	            <Path fileType="config">/etc</Path>
	            <Path fileType="executable">/bin</Path>
	            <Path fileType="executable">/usr/bin</Path>
	            <Path fileType="info">/usr/share/info</Path>
	            <Path fileType="header">/usr/include</Path>
	            <Path fileType="library">/usr/lib/</Path>
	            <Path fileType="localedata">/usr/share/locale</Path>
	        </Files>
	    </Package>
	    
**RuntimeDependencies** kısmında yazılan paketler paketlere bağımlılık olarak eklenir. Derleme öncesi kurulacak listesine eklenmez.

**fileType** türüne **config** verirseniz o dizindeki dosyaları ayar dosyası olarak ekler. Paket güncelleme esnasında configleri kullanıcılar isterse güncellemeyebilir.

**IsA** değerini **postOps** ayarlarsanız paketin içine **postoperations.py** dosyası eklenir. Bu dosya kurulum aşamasında çalıştırılacak betik dosyasıdır.

History bölümü
^^^^^^^^^^^^^^
Bu bölümde paket geçmişi bulunur. Dernenen paket sürümü en güncel olanın sürümü olarak alınır. **Update** kısmı birden çok kez bulunabilir ve en az 1 tane bulunmalıdır.

.. code-block:: xml

	<History>
	    <Update release="1">
	           <Date>2019-01-17</Date>
	           <Version>5.0</Version>
	           <Comment>First release</Comment>
	           <Name>Ali Rıza KESKİN</Name>
	           <Email>paledega@yandex.ru</Email>
	    </Update>
	</History>

Pspec.py dosyası
================
Bu dosya doğrudan kullanılmaz. Bu dosyayı **pspec.xml** üretmek için kullanırız. Bu dosyanın bulunduğu dizinde **genpspec** komutunu çalıştırarak **pspec.xml** dosyasını üretebilirsiniz.
Bu dosya bir olarak python sınıfıdır. Ve alt sınıflardan oluşur.

.. code-block:: python

	class inary:
	    class source:
	        # Source bölümü
	    class pkg_bash:
	        # Package bölümü
	    class history:
	        # History bölümü

Source bölümü
^^^^^^^^^^^^^
Bu bölümde kaynağın özellikleri belirtilir. **packages** dizisindeki elemanların adına sahip olan sınıflar **pspec.xml** oluşturulurken kullanılır. 

.. code-block:: python

	class source:
	    name = "bash"
	    homepage = "http://cnswww.cns.cwru.edu/~chet/bash/bashtop.html"
	    class packager:
	        name = "Süleyman POYRAZ"
	        email = "zaryob.dev@gmail.com"
	    license = ['GPLv2']
	    isa = ['app:console']
	    partof = "system.base"
	    summary = "Bourne-Again shell"
	    description = "GNU bash shell"
	    archive = [
	        ("6399bd1f9ef4dd0d901c7b76737bc409de73c77a","https://ftp.gnu.org/gnu/bash/bash-5.1.8.tar.gz"),
	    ]
	    builddependencies = ['ncurses-devel', 'readline-devel']
	    packages = ['pkg_bash', 'pkg_bash_devel', 'pkg_bash_docs', 'pkg_bash_pages']


Package bölümü
^^^^^^^^^^^^^^
Bu bölümde paket özellikleri yer alır. Bu bölümün sınıf adını **Source** bölümündeki **packages** dizisi içine eklediğinizde buradaki değerler kullanılır. 

.. code-block:: python

	class pkg_bash
	    name = "bash"
	    runtimedependencies = ["ncurses"]
	    files = [
	        ("config","/etc"),
	        ("executable","/bin"),
	        ("info","/usr/share/info"),
	        ("library","/lib"),
	        ("localedata","/usr/share/locale"),
	    ]

History bölümü
^^^^^^^^^^^^^^
Bu bölümde paket geçmişi bulunur. Release bilgisi yer almaz. Bunun yerine release bilgisi otomatik olarak hesaplanır. **update** dizisine dizi halinde eklenir.

.. code-block:: python

	class history:
	    update = [
	        ["2021-08-29","5.1.8","First release","Süleyman POYRAZ","zaryob.dev@gmail.com"],
	    ]

Postoperations.py dosyası
=========================

Bu dosya basitçe bir python betiğidir ve 4 temel fonksiondan oluşur. Bunlar **postInstall**, **preInstall**, **postRemove**, **preRemove** şeklindedir. Bu fonksionlar argument almazlar.

.. code-block:: python

	 def postInstall(): # paket kurulduktan sonra çalıştırılır.
	 def postRemove(): # paket silindikten sonra çalıştırılır.
	 def preInstall(): # paket kurulmadan önce çalıştırılır.
	 def preRemove(): # paket silinmeden önce çalıştırılır.

Bu dosyada bununan **postInstall** fonksionu aynı zamanda paketler yeniden yapılandırılmaya çalışılırken de çalıştırılır. Bu betiklerde actionsapi kullanımı ile ilgili herhangi bir kısıtlama bulunmamasına karşın kullanımı tavsiye edilmemektedir.

Inary komutu her çalıştırıldığında işlem bitiminde sysconf modülü tetiklenir. Bu modül dosya sistemindeki değişiklikleri baz alarak çalışır ve önbellek dosyalarını güncelleme gibi bazı işleri otomatik olarak yerine getirir. Bu sebeple postoperations betiklerine nadiren ihtiyaç duyulur.
