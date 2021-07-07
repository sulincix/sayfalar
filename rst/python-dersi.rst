Python dersi
^^^^^^^^^^^^

Bu yazıda python programlama dilini hızlıca anlatacağım. Bu yazıda karıştırılmaması için girdilerin olduğu satırlar *<-* ile çıktıların olduğu satırlar *->* ile işaretlenmiştir.

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

Python programlarında işler işlevler üzerinden yürür. işlevlerin girdileri ve çıktıları bulunur. 

.. code-block:: shell

	cikti = islev(girdi1, girdi2)


Pythonda girintileme olayı için de **{** ve **}** kullanılmak yerine boşluklandırma kullanılır. Herhangi bir girintilemeye başlanan satırın sonunda **:** işareti bulunur. Örneğin:
Girintileme için 4 boşluk, 2 boşluk veya tek tab kullanabilirsiniz. Bu yazıda 4 boşluğu tercih edeceğiz.

.. code-block:: python

	f = 12 # f sayısını 12ye eşitledik
	if f == 12: # f sayısı 12ye eşit mi diye sorguladık
	    print("eşit") # ekrana yazı yazdırık

Yazı yazdırma
=============

Pythonda ekrana yazı yazmak için **print** işlevini kullanıyoruz. 

.. code-block:: python

	print("Merhaba Dünya")
	-> Merhaba Dünya

Birden çok ifadeyi yazdırmak için **print** işlevine birden çok girdi verebilirsiniz. Bu şekilde aralarına birer boşluk koyarak yazdırır.

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

Bir değişkenin türünü öğrenmek için **type** işlevini kullanabiliriz.

.. code-block:: python

	veri = "abc123"
	turu = type(veri)
	print(turu)
	-> <class 'str'>
	
Boş bir değişken tanımlamak için onun değerine **None** atayabiliriz. Bu sayede değişken tanımlanmış fakar değeri atanmamış olur.

.. code-block:: python

	veri = None
	tur = type(veri)
	print(tur)
	-> <class 'NoneType'>


String
******

String türünden değişkenler yazı içerir. **"** veya **'** veya **"""** arasına yazılırarak tanımlanır.

.. code-block:: python

	yazi1 = "merhaba"
	yazi2 = 'yazım'
	yazi3 = """dünya"""

String türünden değişkenler **+** işareti ile uc uca eklenebilir. 

.. code-block:: python

	yazi = "merhaba" + ' ' + """dünya"""
	print(yazi)
	-> merhaba dünya

Değişkeni birden çok kez toplamak için ***** işareti kullanılabilir.

.. code-block:: python

	yazi = "ali"*5 
	print(yazi)
	-> alialialialiali

Integer
*******

Integer türünden değişkenler tam sayı belirtir. Dört işlem işaretleri ile işleme sokulabilirler. 

.. code-block:: python

	sayi = (((24/2)+4)*2)-1
	"""
	24/2 = 12
	12+4 = 16
	16*2 = 32
	32-1 = 31
	"""
	print(sayi)
	-> 31

Integer değişkenlerin kuvvetlerini almak için ****** kullanılır.

.. code-block:: python

	sayi = 2**3
	print(sayi)
	-> 8

String türünden bir değişkeni integer haline getirmek için **int** işlevi kullanılır.

.. code-block:: python

	print(int("12")/2)
	-> 6

Float
*****

Float türünden değişkenler virgüllü sayılardır. Aynı integer sayılar gibi dört işleme sokulabilirler. İki integer değişkenin birbirine bölümü ile float oluşabilir.

.. code-block:: python

	sayi = 1/2 # sayi = 0.5 şeklinde de tanımlanabilir.
	print(sayi)
	-> 0.5
	
Bir float değişkenini integer haline getirmek için **int** işlevi kullanılır. Bu dönüşümde virgülden sonraki kısım atılır.

.. code-block:: python

	sayi = 3.2
	print(sayi)
	sayi2 = int(3.2)
	print(sayi2)
	-> 3.2
	-> 3

**Not:** float ile string çarpılamaz.

String türünden bir değişkeni float haline getirmek için **float** işlevi kullanılır.

.. code-block:: python

	print(float("2.2")/2)
	-> 1.1


Boolean
*******

Boolean değişkenler sadece **True** veya **False** değerlerini alabilir. Bu değişken daha çok koşullarda ve döngülerde kullanılır. iki değişkenin eşitliği sorgulanarak boolean üretilebilir.

.. code-block:: python

	bool = 12 == 13
	"""
	== eşit
	!= eşit değil
	<  küçük
	>  büyük
	<= küçük eşit
	>= büyük eşit
	"""
	print(bool)
	-> False

boolean değişkeninin tersini almak için **not** ifadesi kullanılabilir.


.. code-block:: python

	veri = not True
	print(veri)
	-> False

Bir string türünden değişkenin içinde başka bir string türünden değişken var mı diye kontrol etmek için **in** ifadesi kullanılır. Bu ifadenin sonucu boolean üretir.

.. code-block:: python

	veri = "ef" in "Dünya"
	veri2 = "ny" in "Dünya"
	print(veri,veri2)
	-> False True

Boolean değişkenlerde mantıksal işlemler **and** ve **or** ifadeleri ile yapılır.

.. code-block:: python

	veri = 12 < 6 or 4 > 2 # False or True = True
	print(veri)
	-> True


Klavyeden değer alma
====================

Python programlarının kullanıcı ile etkileşime girmesi için klavye üzerinden kullanıcıdan değer alması gerekebilir. Bunun için **input** işlevi kullanılır. Bu işlevin çıkışı string türündendir.

.. code-block:: python

	a = input("Bir değer girin >")
	print(a,type(a))
	<- 12
	-> 12 <class 'str'>

String türünden bir ifadeyi bir değişken üretmek için kullanmak istiyorsak **eval** işlevini kullanabiliriz.

.. code-block:: python

	a = eval("12/2 == 16-10") # string ifade çalıştırılır ve sonucu aktarılır.
	print(a)
	-> True

**Not:** Bu işlev tehlikelidir. Potansiyel güvenlik açığına neden olabilir! Mümkün olduğu kadar kullanmayın :D

Koşullar
========

Koşul tanımı yapmak için **if** ifadesi kullanılır. Koşul sağlanmıyorsa **elif** ifadesi ile yeni bir koşul tanımlanabilir veya **else** ifadesi ile koşulun sağlanmadığı durum tanımlanabilir.

.. code-block:: python

	if koşul:
	    durum
	elif koşul:
	    durum
	else:
	    durum

Örneğin bir integer değişkenin çift olup olmadığını bulalım.

.. code-block:: python

	if 13 % 2 == 0 : # % işareti bölümden kalanı bulmaya yarar.
	    print("Çift sayı")
	else:
	    print("Tek sayı")
	    
Değeri olmayan (None) değişkenler koşul ifadelerinde **False** olarak kabul edilir.

.. code-block:: python

	veri = None
	if veri:
	    print("Tanımlı")
	else:
	    print("Tanımsız")
	-> Tanımsız

Koşul tanımlamayı alternatif olarak şu şekilde de yapabiliriz:

.. code-block:: python

	koşul and durum
	""" Şununla aynıdır:
	if koşul:
	    durum
	"""
	koşul or durum
	""" Şununla aynıdır:
	if not koşul:
	    durum
	"""

Bu konunun daha iyi anlaşılması için:

.. code-block:: python

	12 == 12 and print("eşittir")
	12 == 14 or print("eşit değildir")
	-> eşittir
	-> eşit değildir
	
While döngüsü
=============

Döngüler belli bir işi koşul bağlanana kadar tekrar etmeye yarayan işlevdir. Kısaca **while** döngüsü ile **if** arasındaki fark **while** içerisindeki durum tamamlandığı zaman tekrar başa dönüp koşulu kontrol eder.

.. code-block:: python

	while koşul:
	    durum

Örneğin 1den 10a kadar olan sayıları yazalım. Bu durumda *i* sayısı 10 olana kadar sürekli olarak ekrana yazılıp değeri 1 arttırılacakdır. 

.. code-block:: python

	i = 1
	while i < 10:
	    print(i)
	    i+=1 # i = i + 1 ile aynı anlama gelir.
	-> 1 2 3 4 5 6 7 8 9 (Bunu alt alta yazdığını hayal edin :D )

Diziler
=======

Diziler birden çok elemanı içerebilen değişkenlerdir. Diziler aşağıdaki gibi tanımlanır:

.. code-block:: python

	a = [1, 3, "merhaba", True, 1.2, None]

Dizilerin elemanlarının türü aynı olmak zorunda değildir. Hatta None bile olabilir.

Dizilerde eleman eklemek için **append** veya **insert** işlevini eleman silmek için ise **remove**  veya **pop** işlevi kullanılır. Örneğin:

.. code-block:: python

	a = [22]
	print(a)
	a.append("Merhaba") # Sona ekleme yapar.
	a.insert(0,12) # 0 elemanın ekleneceği yeri ifade eder.
	print(a)
	a.remove(22) # 22 elemanını siler
	print(a)
	a.pop(0) # 0. elemanı siler.
	print(a)
	-> [22]
	-> [12, 22, 'Merhaba']
	-> [12, 'Merhaba']
	-> ['Merhaba']
	
Dizileri sıralamak için **sort** boşaltmak için ise **clear** işlevi kullanılır.  Bir dizinin istenilen elemanını öğrenmek için **liste[index]** şeklinde bir ifade kullanılır. Index numaraları 0dan başyan integer olmalıdır. negatif değerlerde sondan saymaya başlar.

.. code-block:: python

	a = [1, 3, 6, 4, 7, 9, 2]
	print(a[2],a[-3])
	a.sort()
	print(a)
	a.clear()
	print(a)
	-> 3
	-> 7
	-> [1, 2, 3, 4, 6, 7, 9]
	-> []

Dizideki bir elemanın uzunluğunu bulmak için **len** işlevi, elemanın dizinin kaçıncısı olduğunu bulmak için ise **index** işlevi kullanılır.

.. code-block:: python

	a = [12, "hmm", 3.2]
	sayi = len(a)
	sayi2 = a.index(3.2)
	print(sayi,sayi2)
	-> 3
	-> 2

Dizilerin elemanlarını **+** kullanarak birleştirebiliriz. 

.. code-block:: python

	a = [1, 2, 3]
	b = [4, 5, 6]
	c = a + b
	print(c)
	-> [1, 2, 3, 4, 5, 6]

