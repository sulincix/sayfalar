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

Var olan bir değişkene ekleme yapmak için **+=** ifadesi kullanılır. 

.. code-block:: makefile

	yazi=hello
	yazi+=world
	hello:
		echo $(yazi)

Eğer **$** işareti kullanmanız gereken bir durum oluşursa **$$** ifadesi kullanabilirsiniz. Örneğin:

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
