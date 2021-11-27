makefile dersi
^^^^^^^^^^^^^^
makefile formatı yazılan bir kaynak kodu derlemek ve yüklemek için kullanılan ne yaygın derleme talimatı formatlarından biridir.

Bu yazıda sizlere makefile dosyası nasıl yazılır anlatacağım.

Genel bakış
===========

Örneğin aşağıdaki gibi bir **C** kodumuz olsun

.. code-block:: C

	#include <stdio.h>
	int main(){
	    puts("Hello world!\n");
	    return 0;
	}

Bunu aşağıdaki komutu kulanarak derleriz ve kurarız.

.. code-block:: C

	$ gcc -o hello hello.c
	$ install hello /usr/bin/hello

Makefile dosyalarının bölüm tanımlamalarında girintileme amaçlı **Tab** kullanılır.

Şimdi aşağıdaki makefile dosyasını inceleyelim.

.. code-block:: makefile

	PREFIX=/usr
	build:
		$(CC) -o hello hello.c

	install:
		install hello $(DESTDIR)/$(PREFIX)/bin/hello

Burada **PREFIX**, **CC**, **DESTDIR** gibi parametreler değişkendir. Bu değişkenler derleme esnasında değiştirilebilir.

Bu makefile dosyasını kullanarak derlemeyi ve yüklemeyi aşağıdaki gibi yaparız.

.. code-block:: C

	$ make
	$ make install

Görüldüğü gibi derleme ve yükleme işlemi daha kolay ve nasıl derleneceğini basitçe belirtmiş olduk.

Burada kullandığımız değişkenler şu şekilde açılnabilir.

* PREFIX = /usr olarak tanımladık. 
* DESTDIR = paket sistemleri paket yaparken bu değişkeni otomatik olarak değiştirir. Kurulacak kök dizin konumudur.
* CC = derleyicinin adıdır. Bu değişkeni ayarlayarak derleyiciyi değiştirebilirsiniz.

Make komutuna eğer hiç parametre verimezsek ilk baştaki bölümü çalıştırır. Biz ilk başta **build** tanımladığımız için make komutu build çalıştırır. make komutuna parametre olarak bölüm verirsek o bölüm çalıştırılır. 


Değişken işlemleri
==================

Değişken tanımlamak için **variable=value** şeklinde tanımlanabilir. değişkeni kullanırken de **$()** işareti arasına alınır. Örneğin:

.. code-block:: makefile

	yazi=hello world
	hello:
		echo $(yazi)


Bu değişkeni **make yazi=deneme123** şeklinde komut vererek değiştirebiliriz.

Var olan bir değişkene ekleme yapmak için **+=** ifadesi kullanılır.  **:=** ifadesi eğer tanımlama varsa ekleme yapar. **?=** sadece daha önceden tanımlanmışsa ekleme yapar.

.. code-block:: makefile

	yazi=hello
	yazi+=world
	sayi:=$(shell ls)
	hello:
		echo $(yazi)


Eğer **$** işareti kullanmanız gereken bir durum oluşursa **$$** ifadesi kullanabilirsiniz. Örneğin:

.. code-block:: makefile

	hello:
		bash -c "echo $$HOME"


Bölümler
========
Makefile yazarken bölümler tanımlanır ve eğer bölümün adı belirtilmemişse ilk bölüm çalıştırılır. Bölümler arası bağımlılık vermek için aşağıdaki gibi bir kullanım yapılmalıdır.

.. code-block:: makefile

	yazi: sayi test
		echo "Hello world"
	sayi:
		echo 12
	test:
		echo test123
		
Yukarıdaki dosyayı çalıştırdığımızda sırasıyla **sayi** -> **test** -> **yazi** bölümleri çalıştırılır.

Aynı işi yapan birden çok bölüm şu şekilde tanımlanabilir.

.. code-block:: makefile

	bol1 bol2:
		echo Merhaba
	# Şuna eşittir.
	bol1:
		echo Merhaba
	bol2:
		echo Merhaba

Bölümün adını **$@** kullanarak öğrenebiliriz.

.. code-block:: makefile

	bolum:
		echo $@

Bölümün tüm bağımlılıklarını almak için için **$^** kullanabiliriz.

.. code-block:: makefile

	bolum: bol1 bol2
		echo $^
	bol1 bol2:
		true

**$?** ifadesi **$^** ile benzerdir fakat sadece geçerli bölümden sonra tanımlanan bölümleri döndürür.

.. code-block:: makefile

	bol1:
		true
	bolum: bol1 bol2
		echo $?
	bol2:
		true

**$<** ifadesi sadece ilk bağımlılığı almak için kullanılır.

.. code-block:: makefile

	bol1 bol2:
		true
	bolum: bol1 bol2
		echo $<

Eğer **xxxx.o** şeklinde bir kural tanımlarsanız bu kural çalıştırıldıktan sonra gcc ile kural adındaki dosya derlenir.

.. code-block:: makefile

	main: main.o
	main.o: main.c test.c

	main.c:
		echo "int main(){}" > main.c
	%.c:
		touch $@
		
Burada main.c dosyası var olmayan bir dosyadır ve derleme esnasında oluşturulur. test.c dosyası ise daha önceden var olan bir dosyadır ve o dosyaya bir şey yapılmaz. main.c kuralı sadece main.c için çalıştırılırken **%.c** şeklinde belirtilen kular hem main.c hem test.c için çalıştırılır.
**main** ile belirttiğimiz kuralda main.o bağımlılığı olduğu için bi derlemenin sonucu olarak main adında bir derlenmiş dosya üretilmektedir.


wildcard ve shell
=================

Wildcard ifadesi eşleşen dosyaları döndürür.

.. code-block:: makefile

	files := $(wildcard *.c)
	main:
		gcc -o main $(files)

Shell ifadesi ise komut çalıştırarak sonucunu döndürür.

.. code-block:: makefile

	files := $(shell find -type f -iname "*.c")
	main:
		gcc -o main $(files)

Birden çok dosya ile çalışma
============================
**make -C xxx** şeklinde alt dizindeki bir makefile dosyasını çalıştırabilirsiniz.

.. code-block:: makefile

	build:
		make -C src

Ayrıca **include** kullanarak başka bir dosyada bulunan kuralları kullanabilirsiniz.

.. code-block:: makefile

	# Makefile dosyası
	include build.mk
	build: main
		gcc main.c -o main
	# build.mk dosyası
	main:
		echo "int main(){return 0;}" > main.c

Koşullar
========
**ifeq** ifadesi ile koşul tanımlanabilir.  aşağıdaki ifadeşi **make CC=clang** şeklinde çalıştırırkanız clang yazdırır, parametresiz bir şekilde çalıştırırsanız gcc yazdırır. Burada dikkat edilmesi gereken konu **ifeq**, **else**, **endif** girintilenmeden yazılır.

.. code-block:: makefile

	build:
	ifeq ($(CC),clang)
		echo "clang"
	else
		echo "gcc"
	endif

Komut özellik ifadeleri
=======================
Eğer komutun başına **@** işareti koyarsanız komut ekrana yazılmadan çalıştırılır. **-** yazarsanız komut hata alsa bile geri kalan kısımlar çalışmaya devam eder.

.. code-block:: makefile

	build:
		@echo "Merhaba dünya"
		-gcc main.c -o main
