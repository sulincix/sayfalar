Python dersi
^^^^^^^^^^^^

Bu yazıda python programlama dilini hızlıca anlatacağım. Bu yazıda karıştırılmaması için girdilerin olduğu satırlar *<-* ile çıktıların olduğu satırlar *->* ile işaretlenmiştir.

Temel bilgiler
==============

Python programlarının ilk satırında **#!/usr/bin/python3** satırı bulunmalıdır.
Bir python programını çalıştırmak için Şunları uygulamamız gereklidir.

.. code-block:: shell

	#!/usr/bin/python3
	# Çalıştırma izni vererek çalıştırabiliriz.
	chmod +x dosya.py
	./dosya.py
	# Veya doğrudan çalıştırabiliriz.
	python3 dosya.py

Python programlama dilinde satır sonuna **;** koyulmaz.

Python programlarında işler fonksionlar üzerinden yürür. fonksionların girdileri ve çıktıları bulunur. 

.. code-block:: shell

	cikti = fonksion(girdi1, girdi2)


Pythonda girintileme olayı için de **{** ve **}** kullanılmak yerine boşluklandırma kullanılır. Herhangi bir girintilemeye başlanan satırın sonunda **:** işareti bulunur. Örneğin:
Girintileme için 4 boşluk, 2 boşluk veya tek tab kullanabilirsiniz. Bu yazıda 4 boşluğu tercih edeceğiz.

.. code-block:: python

	f = 12 # f sayısını 12ye eşitledik
	if f == 12: # f sayısı 12ye eşit mi diye sorguladık
	    print("eşit") # ekrana yazı yazdırık

Açıklama satırları
==================

Python programlama dilinde açıklamalar **#** işaretinden sonrası için geçerlidir. Örneğin:

.. code-block:: python

	#bu bir açıklama satırıdır.

Bununla birlikte çoklu açıklama satırı yapmak için **"""** işareti arasına alabiliriz.

.. code-block:: python

	""" Bu bir açıklama satırı
	Bu diğer açıklama satırı
	Bu son açıklama satırı """

Yazı yazdırma
=============

Pythonda ekrana yazı yazmak için **print** fonksionunu kullanıyoruz. 

.. code-block:: python

	print("Merhaba Dünya")
	-> Merhaba Dünya

Birden çok ifadeyi yazdırmak için **print** fonksionuna birden çok girdi verebilirsiniz. Bu şekilde aralarına birer boşluk koyarak yazdırır.

.. code-block:: python

	print("Merhaba",12,"Dünya",True)
	-> Merhaba 12 Dünya True

Değişkenler
===========

Değişkenler tanımlanırken **degisken = deger** şeklinde bir ifade kulanılır.

.. code-block:: python

	i = 12
	yazi = "merhaba dünya"
	k = 1.2
	hmm = True

Değişken adları sayı ile başlayamaz, Türkçe karakter içeremez ve sadece harfler, sayılar ve **-** **_** karakterlerinden oluşur.

Değişkenler kullanılırken başına herhangi bir işaret almasına gerek yoktur. Örneğin:

.. code-block:: python

	i = 12
	print(i)
	-> 12

Değişkenler tanımlanırken her ne kadar türlerini belirtmesek bile birer türe sahip olarak tanımlanır. Bunlar başlıca **integer**, **float**, **string**, **boolean** türleridir.

Bir değişkenin türünü öğrenmek için **type** fonksionunu kullanabiliriz.

.. code-block:: python

	veri = "abc123"
	turu = type(veri)
	print(turu)
	-> <class 'str'>

String
******

String türünden değişkenler yazı içerir. **"**, **'** veya **"""** arasına yazılırarak tanımlanır.

.. code-block:: python

	yazi1 = "merhaba"
	yazi2 = 'yazım'
	yazi3 = """dünya"""

String türünden değişkenler **+** işareti ile uc uca eklenebilir. 

.. code-block:: python

	yazi = "merhaba" + ' ' + """dünya"""
	print(yazi)
	-> merhaba dünya
	
