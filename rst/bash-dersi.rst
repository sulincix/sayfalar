Hızlı bash dersleri
^^^^^^^^^^^^^^^^^^^
Bu yazıda bash betiği yazmayı hızlıca anlatacağım. Bu yazıda karışmaması için girdilerin olduğu satırlar *<-* ile çıktıların olduğu satırlar *->* ile işaretlenmiştir.

Açıklama satırı ve dosya başlangıcı
===================================

Açıklamalar **#** ifadesiden başlayıp satır sonuna kadar devam eder. Dosyanın ilk satırına **#!/bin/bash** eklememiz gerekmektedir. Bash betikleri genellikle **.sh** uzantılı olur.
Bash betikleri girintilemeye duyarlı değildir. Bash betiği yazarken girintileme için 4 boşluk veya tek tab kullanmanızı öneririm.

.. code-block:: shell

	#!/bin/bash
	#Bu bir açıklama satırıdır.

Bash betiklerini çalıştırmak için öncelikle çalıştırılabilir yapmalı ve sonrasında aşağıdaki gibi çalıştırılmalıdır.

.. code-block:: shell
	
	chmod +x ders1.sh
	./ders1.sh

Ekrana yazı yazalım
===================
Ekrana yazı yazmak için **echo** ifadesi kulanılır.

.. code-block:: shell

	echo Merhaba dünya
	-> Merhaba dünya

Değişkenler ve Sabitler
=======================
Değişkenler ve sabitler programımızın içerisinde kullanılan verilerdir. Değişkenler tanımlandıktan sonra değiştirilebilirken sabitler tanımlandıktan sonra değiştirilemez.

Normal Değişkenler aşağıdaki gibi tanımlanır.

.. code-block:: shell

	sayı=23
	yazi="merhaba"

Çevresel değişkenler tüm alt programlarda da geçerlidir. Çevresel değişken tanımlamak için başına **export** ifadesi yerleştirilir.

.. code-block:: shell

	export sayi=23
	export yazi="merhaba"

Sabitler daha sonradan değeri değiştirilemeyen verilerdir. Sabit tanımlamak için başına **decrale -r** ifadesi yerleştirilir.

.. code-block:: shell

	declare -r yazi="merhaba"
	declade -r sayi=23
	
Değişkenler ve sabitler kullanılırken **${}** işareti içine alınırlar.

.. code-block:: shell

	deneme="abc123"
	echo ${deneme}
	-> abc123

sayı ve yazı türünden değişkenler farklıdır. sayıyı yazıya çevirmek için **"** işaretleri arasına alabiliriz. Birden fazla yazıyı toplamak için yan yana yazmamız yeterlidir.

.. code-block:: shell

	sayi=11
	yazi="karpuz"
	echo "${sayi}${karpuz} limon"
	-> 11karpuz limon

sayı değişkenleri üzerinde matematiksel işlem yapmak için aşağıdaki ifade kullanılır. `(+-*/ işlemleri için geçerlidir.)`

.. code-block:: shell

	sayi=12
	sayi=$((${sayi}/2))
	echo ${sayi}
	-> 6


Klavyeden değer alma
====================
Klavyeden değer almak için **read** komutu kullanılır. Alınan değer değişken olarak tanımlanır.


.. code-block:: shell

	read deger
	<- merhaba
	echo $deger
	-> merhaba
	
Koşullar
========
Koşullar **if** ile **fi** ile biter.  Koşul ifadesi sonrası **then** kullanılır. ilk koşul sağlanmıyorsa **elif** ifadesi ile ikinci koşul sorgulanabilir. Eğer hiçbir koşul sağlanmıyorsa **else** ifadesi içerisindeki eylem gerçekleştirilir.

.. code-block:: shell

	if ifade ; then
	    eylem
	elif ifade ; then
	    eylem
	else
	    eylem
	fi
	

Koşul ifadeleri kısmında çalıştırılan komut 0 döndürüyorsa doğru döndürmüyorsa yalnış olarak değerlendirilir. **[** komutu ile büyük-küçük-eşit kıyaslaması, dosya veya dizin varlığı vb. gibi sorgulamalar yapılabilir.

.. code-block:: shell

	read veri
	if [ ${veri} -lt 10 ] ; then
	    echo "Veri 10dan küçük"
	else
	    echo "Veri 10dan büyük veya 10a eşit"
	fi
	
	<- 9
	-> Veri 10dan küçük
	<- 15
	-> Veri 10dan büyük veya 10a eşit
	
**[** komutu ile ilgili başlıca ifadeleri ve kullanımlarını aşağıda tablo olarak ifade ettim.

.. list-table:: **[ ifadeleri ve kullanımları**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Anlamı
     - Kullanım şekli

   * - -lt
     - küçüktür
     - [ ${a} -lt 5 ]

   * - -gt
     - büyüktür
     - [ ${a} -gt 5 ]

   * - -eq
     - eşittir
     - [ ${a} -eq 5 ]

   * - -le
     - küçük eşittir
     - [ ${a} -le 5 ]

   * - -ge
     - büyük eşittir
     - [ ${a} -ge 5 ]

   * - -f
     - dosyadır
     - [ -f /etc/os-release ]

   * - -d 
     - dizindir
     - [ -d /etc ]

   * - -e
     - vardır (dosya veya dizindir)
     - [ -e /bin/bash ]

   * - -L 
     - sembolik bağdır
     - [ -L /lib ] 

   * - -n
     - uzunluğu 0 değildir
     - [ -n ${a} ]

   * - -z
     - uzunluğu 0dır
     - [ -z ${a} ]

   * - !
     - ifadenin tersini alır.
     - [ ! .... veya ! [ ....

   * - > 
     - alfabeti olarak büyüktür
     - [ "portakal" > "elma" ]

   * - < 
     - alfabetik olarak küçüktür
     - [ "elma" < "limon" ]

   * - ==
     - alfabetik eşittir
     - [ "nane" == "nane" ]

   * - != 
     - alfabetik eşit değildir
     - [ "name" != "limon" ]

   * - ||
     - mantıksal veya bağlacı
     - [ .... || .... ] veya [ .... ] || [ .... ]

   * - &&
     - mantıksal ve bağlacı
     - [ .... && .... ] veya [ .... ] && [ .... ]



Döngüler
========

Döngülerde **while** ifadesi sonrası koşul gelir. **do** ile devam eder ve eylemden sonra **done** ifadesi ile biter. Döngülerde ifade doğru olduğu sürece eylem sürekli olarak tekrar eder.

.. code-block:: shell

	while ifade ; do
	    eylem
	done

Örneğin 1den 10a kadar sayıları ekrana yan yana yazdıralım. Eğer echo komutumuzda **-n** parametresi verilirse alt satıra geçmeden yazmaya devam eder.

.. code-block:: shell

	i=1
	while [ ${i} -le 10 ] ; do
	    echo -n "$i " # sayıyı yazıya çevirip sonuna yanına boşluk koyduk
	    i=$((${i}+1)) # sayıya 1 ekledik
	done
	echo # en son alt satıra geçmesi için
	-> 1 2 3 4 5 6 7 8 9 10 
	
**for** ifadesinde değişken adından sonra **in** kullanılır daha sonra dizi yer alır. diziden sonra **do** ve bitişte de **done** kullanılır.

.. code-block:: shell

	for degisken in dizi ; do
	    eylem
	done

Ayrı örneğin for ile yapılmış hali

.. code-block:: shell

	for i in 1 2 3 4 5 6 7 8 9 10 ; do
	    echo -n "${i} "
	done
	echo
	-> 1 2 3 4 5 6 7 8 9 10 
	
Ayrıca uzun uzun 1den 10a kadar yazmak yerine şu şekilde de yapabiliyoruz.

.. code-block:: shell

	for i in {1..10} ; do
	    echo -n "${i} "
	done
	echo
	-> 1 2 3 4 5 6 7 8 9 10 
	
