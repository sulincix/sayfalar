Debian için depo oluşturma
==========================
Bu dokümanda **debian** için depo oluşturma ve depoyu güncelleme konusu anlatılmıştır.

Gerekli paketlerin kurulması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. code-block:: shell

	$ apt-get instal apt-ftparchive
	
Depo ile ilgili temel kavramlar
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Deponun 2 temel dizini bulunmaktadır **pool** ve **dists**

Dists
#####

*dists* içerisinde depo indexi depo imzası ve hangi ortama uyumlu çalıştığına dair bilgiler bulnur.

**dists** dizini içerisinde dağıtım adına göre dizinler bulunur. ve bu dizinler içerisinde de kısımlara dair dizinler ve **Release** dosyası bulunur. 

Örnek depo **dists** dizin yapısı (imzalanmamış depo):

.. code-block:: shell

	dists/
	`-- stable
	    |-- Release
	    |-- contrib
	    |   |-- binary-amd64
	    |   |   |-- Packages
	    |   |   `-- Packages.gz
	    |   `-- binary-i386
	    |       |-- Packages
	    |       `-- Packages.gz
	    |-- main
	    |   |-- binary-amd64
	    |   |   |-- Packages
	    |   |   `-- Packages.gz
	    |   `-- binary-i386
	    |       |-- Packages
	    |       `-- Packages.gz
	    `-- non-free
	        |-- binary-amd64
	        |   |-- Packages
	        |   `-- Packages.gz
	        `-- binary-i386
	            |-- Packages
	            `-- Packages.gz

	10 directories, 14 files
	
Pool
####
*pool* içerisinde de pakekler uygun hiyerarşiye göre dizilmiştir.

**pool** dizininde bulunan paketler genel bir kural olmaması ile birlikte şu kurallara uygun şekilde dizilmeleri tavsiye edilmektedir:

Alfabetik kural:

1. Paket isminin ilk harfi ile başlayar dizin içerisinde paket adını taşıyan bir dizin olmalı ve paket bu dizinde yer almalı.

   test adındaki bir paket için **pool/t/test/test_1.0_amd64.deb**

2. Paket adının başında lib varsa ve kütüphane dosyası ise ilk harf yerine lib kısmından sonraki ilk harf ile beraber alınmalı.

   libncurses paketi için **pool/libn/libncurses/libncurses_6.2-1_amd64.deb**

Bölümsel kural:

1. Bölümler belirlenmeli.

   *system*, *util*, *network*, *optional*, *appications* gibi.

2. Alt bölümler oluşturulabilir.

   bash paketi için **pool/system/shell/bash/bash_5.0_amd64.deb**

Küçük depolar için tüm paketleri tek bir dizine yığabilirsiniz.

Alfabetik kurala göre dizilmiş örnek **pool** dizini:

.. code-block:: shell

	pool/
	|-- contrib
	|-- main
	|   `-- f
	|       `-- foo
	|           `-- foo_1.0_all.deb
	`-- non-free

	5 directories, 1 file
	
Paketler **paket_version_mimari.deb** şeklinde isimlendirilmelidir.

amd64 mimaride ve 1.0 sürümünde olan test adındaki bir paket için **test_1.0_amd64.deb**

**Release** dosyasında depoya dair bilgiler yer almaktadır. Bu bilgilerden sonra da dists içerisindeki indexlerin md5sum değerleri yer alır. Örneğin:

.. code-block:: shell

	Origin: Debian
	Label: Debian
	Suite: stable
	Version: 10.5
	Codename: stable
	Changelogs: https://sulincix.github.io
	Date: Sat, 01 Aug 2020 11:04:59 UTC
	Acquire-By-Hash: yes
	Architectures: amd64 i386
	Components: main contrib non-free
	Description: Test repository
	MD5Sum:
	  d3979f7e69655dcb641d283f1af376a7  dists/stable/main/binary-i386/Packages
	  0270b0287abd69d7ba7670c3eb24cbc1  dists/stable/main/binary-i386/Packages.gz
	  d3979f7e69655dcb641d283f1af376a7  dists/stable/main/binary-amd64/Packages
	  0270b0287abd69d7ba7670c3eb24cbc1  dists/stable/main/binary-amd64/Packages.gz
	  d41d8cd98f00b204e9800998ecf8427e  dists/stable/non-free/binary-i386/Packages
	  de9e533c25149db7878032320d7d13db  dists/stable/non-free/binary-i386/Packages.gz
	  d41d8cd98f00b204e9800998ecf8427e  dists/stable/non-free/binary-amd64/Packages
	  de9e533c25149db7878032320d7d13db  dists/stable/non-free/binary-amd64/Packages.gz
	  d41d8cd98f00b204e9800998ecf8427e  dists/stable/contrib/binary-i386/Packages
	  de9e533c25149db7878032320d7d13db  dists/stable/contrib/binary-i386/Packages.gz
	  d41d8cd98f00b204e9800998ecf8427e  dists/stable/contrib/binary-amd64/Packages
	  de9e533c25149db7878032320d7d13db  dists/stable/contrib/binary-amd64/Packages.gz

İndex alınması
^^^^^^^^^^^^^^
**pool** dizini içerisine yukarıda anlatılan hiyerarşilere uygun şekilde paketlerimizi yerleştirmeliyiz. pool içerisinde **main**, **contrib**, **non-free** adında dizinler olmalıdır. Bu isimler ile **dists** dizini içerisindeki isimler aynı olmalıdır.

pool içerisindeki paket yerleştirme işlemi bittikten sonra şu komutu kullanarak index almalıyız:

.. code-block:: shell

	$ apt-ftparchive -a amd64 packages pool/main > dists/stable/main/binary-amd64/Packages
	$ gzip -k dists/stable/main/binary-amd64/Packages
	$ xz -k dists/stable/main/binary-amd64/Packages
	
İlk komut ile pool/main içerisindeki paketlerin indexlerini dists içerisindeki main bölümüne yerleştiriyoruz. Bu işlem contrib ve non-free için benzer şekilde yapılmalıdır. ayrıca eğer i386 veya arm64 veya armhf için de paketler varsa onlar için de tekrarlamanız gerekmektedir.

İkinci ve üçüncü komut ise aldığımız indexi gzip formatta sıkıştırmaktadır. Depolarda daha az ağ trafiği yaparak index indirmek için gzip, bz2 veya xz formatında sıkıtşıtma yapılabilir.

Release dosyasının yazılması
############################

Release dosyasını elle yazmak hem uğraştırıcıdır. Başlık kısmındaki değerler değişmeyeceği için onları ayrı bir dosyaya yazıp md5sum değerlerini de komut kullanarak üstüne ekleyebilirsiniz. *sed* komutu ile de biçimlendirseniz güzel olur :D

başlık dosyası içeriği şu şekilde olamalı:

.. code-block:: YAML

	$ cat baslik
	Origin: Debian
	Label: Debian
	Suite: stable
	Version: 10.5
	Codename: stable
	Changelogs: https://sulincix.github.io
	Date: Sat, 01 Aug 2020 11:04:59 UTC
	Acquire-By-Hash: yes
	Architectures: amd64 i386
	Components: main contrib non-free
	Description: Test repository
	MD5Sum:


başlık ile md5sum bilreştirmek için aşağıdakine benzer bir komut kullanabilirsiniz:

.. code-block:: shell

	$ cat baslik > dists/stable/Release
        $ find dists/stable -type f | xargs md5sum | sed "s/^/  /" >> dists/stable/Release
        
Deponun imzalanması
###################

Depoyu eğer imzalamazsak depoyu güncellerken ve depodan paket kurarken uyarı verirler. Eğer gpg anahtarınız mevcutsa şu komutu kullanabilirsiniz:

.. code-block:: shell

	$ gpg --clearsign -o InRelease Release
	$ gpg -abs -o Release.gpg Release
	
Eğer gpg anahtarınız yoksa oluşturmak için:

.. code-block:: shell
	
	$ gpg --gen-key
	
Oluşturduğumuz gpg anahtarını listelemek için:

.. code-block:: shell
	
	$ gpg --list-keys
	
Bu listede gpg anahtarını id değerleri bulunur. Bu değeri kullanarak gpg anahtarımızı dışarı aktarabiliriz. Aktarılan bu anahtar depoyu kullanmak isteyen kullanıcılar tarafından anahtar deposuna eklenmelidir.

Elimizdeki gpg anahtarını dışarı aktarmak için:

.. code-block:: shell

	$ gpg --output Release.key --armor --export gpg_id_değeri
	
Deponun ağda paylaşılması
^^^^^^^^^^^^^^^^^^^^^^^^^
**Apache** veya **nginx** tavsiye etmekle birlikte **busybox httpd** ve **python3 http.server** kullanılabilir.

Eğer sunucunuz yoksa bir hostingde yada github.io gibi static site üzerinde de barındırabilirsiniz. (Eğer kullanım şartlarına ihlal durum oluşturmuyorsa.)

Deponun kullanıcılar tarafından sisteme eklenmesi
#################################################

Depomuz tamamlandı ve internet ağının bir parçası haline geldikten sonra kullanıcılar bu depoyu kullanmak istediklerinde şu adımları uygulamalılar.

1. Depoyu imzalayan gpg anahtarını içeri aktarmalılar.

.. code-block:: shell

	$ wget -O - http://depo_sunucusu/depo_konumu/dists/stable/Release.key | apt-key add -
	
2. /etc/sources.list.d/ dizinine dosya içerisine eklemeliler. (veya sources.list dosyasına)

.. code-block:: shell

	$ echo "deb http://depo_sunucusu/depo_konumu stable main contrib non-free" > /etc/apt/sources.list.d/testrepo.list
	
3. Depoyu güncellemeliler.

.. code-block:: shell

	$ apt-get update

