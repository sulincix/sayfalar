Debian paket yapımı
^^^^^^^^^^^^^^^^^^^
Bu anlatımda debian tabanı için deb paketi yapmayı anlatacağım. Tüm adımlar root ile gerçekleştirilmiştir. Debian tabanlı bir dağıtım yada debootstrap ile kurulmuş bir chroot kullanmanız gerekmektedir. 

Bu yazının ikinci kısmında da elimizdeki bir paketi açıp üzerinde değişiklik yapıp tekrar paketlemeyi anlatacağım.

Hazırlık
========
Aşağıdaki paketleri kurarak paket derleme aşaması için gereken araçları yüklemeniz gerekmektedir.

.. code-block:: shell

	$ apt-get install build-essential

Paket talimatı hazırlanması
===========================
Debian tabanında paketlerin derleme talimatı **debian** dizininde bulunur. Bu dizinde **source/format**, **copyright**, **control**, **rules**, **compat** dosyaları bulunur. **copyright** dosyasında lisans metnimiz yer alır. *http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/* adresindeki formata uygun şekilde yazarız. Aşağıda örnek bir **copyright** dosyası yer almaktadır.

.. code-block:: yaml

	Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
	Upstream-Name: test
	Source: https://example.org
	
	Files: *
	Copyright: 2021 user name <user@example.org>
	License: GPL-3.0+
	
	License: GPL-3.0+
	 This program is free software: you can redistribute it ...

**source/format** dosyası paketin kaynak formatını belirtir. Bu dosya içerisine **3.0 (native)** yazabilirsiniz.

**compat** dosyası içerisinde paketin hangi sürüme uyumlu olacağı yazılmıştır. Bu yazıyı yazarken en son sürüm olarak **11** olduğu için dosyaya **11** yazabiliriz.

**control** dosyası içerisinde paketin adı bağımlılıkları gibi değerleri taşır. Aşağıda örnek control dosyası verilmiştir.

.. code-block:: yaml

	Source: example
	Section: utils
	Priority: optional
	Maintainer: user name <user@example.org>
	Build-Depends: package1, package2
	Standards-Version: 4.3.0
	Homepage: https://example.org
	
	Package: example
	Architecture: any
	Depends: package3,
	         package4
	
	Description: example package
 	 Example package for sayfalar documentation

Eğer **Architecture** değerine any yazarsanız paket derlediğiniz mimariye bağımlı olur. Eğer all yazarsanız tümünde çalışabilir. 

**rules** dosyası derleme yapılırken kullanılan dosyadır. Bu dosyanın türü genellikle **Makefile** olur fakat istediğiniz herhangi bir dille de yazabilirsiniz.

**make && make install** şeklinde derlenip kurulan bir kaynak kodu rules dosyasında aşağıdaki gibi belirtebiliriz. Bunun için **dh** komutu kullanılır.

.. code-block:: makefile

	#!/usr/bin/make -f
	
	%:
		dh $@

Eğer **./configure** işlemimiz de varsa aşağıdakini rules içine ekleyebiliriz.

.. code-block:: makefile

	override_dh_auto_configure:
		./configre --prefix=/usr

Burada sırasıyla rules dosyasına aşağıdaki gibi komut yollanır.

.. code-block:: shell

	./debian/rules clean # dh clean
	./debian/rules build # dh build
	./debian/rules binary # dh binary

Biraz önceki rules dosyamızı biraz değiştirerek tekrar yazalım.

.. code-block:: makefile

	#!/usr/bin/make -f
	
	clean:
		dh clean
	build:
		./configure --prefix=/usr
		: dh build yerine aşağıdaki komutları yazabiliriz.
		make
		make install DESTDIR=debian/example # DESTDIR konumu debian/paketadı şeklinde olmalıdır.
	binary:
		dh binary

Burada **dh clean** komutu kaynağı temizlemek için kullanılır. **dh binary** ise paketleme işlemi için gereken komuttur.

**changelog** dosyası ise paketin sürüm numarası ve değişikliklerini belirtir. Aşağıda örnek **changelog** dosyası yer almaktadır.

.. code-block:: shell

	example (0.3.1) stable; urgency=medium
	  [ user name ]
	  * Initial commit

	 -- user name  <user@example.org>  Mon, 31 Dec 2021 13:31:31 +0000

Paketin derlenmesi
==================

**dpkg-buildpackage -b** komutunu derlenecek olan paketin kaynağının bulunduğu dizinde çalıştırın.

Paket dosyaları kaynağın bulunduğu dizinin bir öncesinde oluşturulur. **deb** uzantılı dosyalarımızı eğer varsa depoya atabiliriz.

Paket kayağının temizlenmesi
============================
**dh clean** komutunu kullanabilirsiniz.

Post install betikleri
======================
debian dizini içine atacağımız **postinst**, **preinst**, **prerm**, **postrm** dosyaları paketin içerisine eklenir ve gerektiği yerde çalıştırılır. Genellikle bash betiğidir fakat istediğiniz dille yazabilirsiniz.



Paket parçalama işlemi
======================
Bir deb dosyasını parçalamak için öncelikle **ar** komutu kullanarak paketin dosyaları açılır. Bu işlemde karşımıza 3 tane dosya çıkar. data.tar.xz dosyası paketin dosyalarını barındırır. debian-binary dosyası paket formatını gösterir. Bu dosyayı silebiliriz. control.tar.xz dosyası paket bilgisi içerir.

.. code-block:: shell

	$ ar x paket.deb
	$ ls
	-> control.tar.xz  data.tar.xz  debian-binary  paket.deb
	$ tar -xf data.tar.xz && rm -f data.tar.xz debian-binary paket.deb
	$ mkdir DEBIAN
	$ mv control.tar.xz DEBIAN
	$ cd DEBIAN
	$ tar -xf control.tar.xz && rm -f control.tar.xz
	$ cd ..
	$ ls
	-> DEBIAN/ usr/ etc/

Parçalanan paketin tekrar paketlenmesi
======================================
Parçalanan paketin tekrar paketlenmesi için aşağıdaki komutu kullanabiliriz. Burada paket yolunu tam yol olarak vermeniz gerekmektedir. Paket dizininin dışında çalıştırılmalıdır. Paket adı dizinin adı şeklinde ayarlanmaktadır.

.. code-block:: shell

	$ dpkg -b /home/sulincix/test/example
	-> dpkg-deb: building package 'example' in 'example.deb'.
