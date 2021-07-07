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

.. code-block:: python

	f = 12 # f sayısını 12ye eşitledik
	if f == 12: # f sayısı 12ye eşit mi diye sorguladık
	    print("eşit") # ekrana yazı yazdırık

Girintileme için 4 boşluk, 2 boşluk veya tek tab kullanabilirsiniz. Bu yazıda 4 boşluğu tercih edeceğiz.

Yazı yazdırma
=============

Pythonda ekrana yazı yazmak için **print** işlevini kullanıyoruz. 

.. code-block:: python

	print("Merhaba Dünya")
	-> Merhaba Dünya

Birden çok ifadeyi yazdırmak için **print** işlevine birden çok girdi verebilirsiniz. Bu şekilde aralarına birer boşluk koyarak yazdırır.

.. code-block:: python

	# Yazılar tırnak içine alınır.
	# Sayılar tırnak içine alınmaz.
	# True ve False doğruluk belirtir.
	print("Merhaba",12,"Dünya",True)
	-> Merhaba 12 Dünya True

Değişkenler
===========
Değişkenler içerisinde veri bulunduran ve ihtiyaç durumunda bu veriyi düzenleme imkanı tanıyan kavramlardır. 
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

String türünden bir değişkenin içerisindeki bir bölümü başka bir şey ile değiştirmek için **replace** işlevi kullanılınabilir.

.. code-block:: python

	veri = "Merhaba"
	veri2 = veri.replace("rha","123")
	print(veri2)
	-> Me123ba

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
	    eylem
	elif koşul:
	    eylem
	else:
	    eylem

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

	koşul and eylem
	""" Şununla aynıdır:
	if koşul:
	    eylem
	"""
	koşul or eylem
	""" Şununla aynıdır:
	if not koşul:
	    eylem
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
	    eylem

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
	-> 3 7
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

Dizilerin bir bölümünü aşağıdakine benzer yolla kesebiliriz:

.. code-block:: python

	a = [1, 3, 5, 7, 9, 12, 44, 31, 16]
	b = a[:2] # baştan 3. elemana kadar.
	c = a[4:] # 4. elemandan sonrası
	d = a[3:6] # 4. elemandan 6. elemana kadar (dahil)

String türünden bir değişkeni belli bir harf veya harf öbeğine göre bölmek için **split** işlevini kullanırız. Ayrıca string türünden bir değişkenin başındaki ve sonundaki boşlukları temizlemek için **strip** işlevini kullanırız.

.. code-block:: python

	veri="   Bu bir yazıdır   "
	veri2 = veri.strip()
	print(len(veri),len(veri2))
	liste = veri2.split(" ")
	print(liste)
	-> 20 14
	-> ['Bu', 'bir', 'yazıdır']

For döngüsü
===========

For döngüsü while ile benzerdir fakat koşul aranmak yerine iteration yapar. Bu işlemde bir dizinin bütün elemanları tek tek işleme koyulur. Aşağıdaki gibi bir kullanımı vardır:

.. code-block:: python

	for eleman in dizi:
	    eylem
	# Şununla aynıdır
	i = 0
	toplam = len(dizi)
	while i < toplam: # eleman yerine dizi[i] kullanabilirsiniz.
	    eylem
	    i += 1

Örneğin bir integer değişkenlerden oluşan dizi oluşturalım ve elemanlarını 2ye bölerek ayrı bir diziye ekleyelim.

.. code-block:: python

	a = [2, 4, 6, 8, 10] # dizi tanımladık
	b = [] # diğer diziyi tanımladık
	for i in a: # a elemanları i içine atılacak
	    b.append(i/2) # b içine elemanın yarısını ekledik.
	print(b)
	-> [1, 2, 3, 4, 5]

Eğer dizi yerine string türünden bir değişken verirsek elemanlar bu stringin harfleri olacaktır. Aşağıdaki örnekte string içerisinde kaç tane a veya e harfi bulunduğunu hesaplayalım.

.. code-block:: python

	veri = "Merhaba Dünya"
	toplam = 0
	for i in veri:
	    if i == "a" or i == "e":
	        toplam += 1
	print(toplam)
	-> 4
	
Şimdiye kadarki anlatılanların daha iyi anlaşılması için asal sayı hesaplayan bir python kodu yazalım:

.. code-block:: python

	asallar = [2] # ilk asal sayıyı elle yazdık.
	i = 2 # Şu anki sayı
	while i < 60: # 60a kadar say
	    hmm = True # asal sayı mı diye bakılan değişken
	    for e in asallar: # asal sayılar listesi elemanları
	        if i % e == 0: # tam bölünüyor mu
	            hmm = False # asal sayı değildir
	    if hmm: # Asal sayıysa diziye ekleyelim
	        asallar.append(i)
	    i += 1 # mevcut sayımızı 1 arttıralım.
	print(asallar) # 60a kadar olan asal sayılar dizisini yazalım.
	-> [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59]
	
İşlevler
========

Python programlarken işlev tanımlayıp daha sonra bu işlevi kullanabiliriz. İşlevler aşağıdaki gibi tanımlanırlar:

.. code-block:: python

	def islev(girdi1,girdi2):
	    eylem

işlevlerde çıktı sonucu olarak bir değişken döndürmek için **return** ifadesi kullanılır. Örneğin girdideki sayıları toplayan işlev yazalım.

.. code-block:: python

	def topla(sayi1,sayi2):
	    return sayi1 + sayi2
	    print("Merhaba") # bu satır çalıştırılmaz
	toplam = topla(3,5)
	print(toplam)
	-> 8

Eğer bir değişken sadece işlevin içerisinde tanımlanırsa o değişken işlevin dışında tanımsız olur.

.. code-block:: python

	def yazdir():
	    yazi = "Merhaba"
	    print(yazi)
	yazdir()
	print(yazi)
	-> Merhaba
	-> Traceback (most recent call last):
	->   File "ders.py", line 5, in <module>
	->     print(yazi)
	-> NameError: name 'yazi' is not defined

Bir işlevin ne işe yaradığını öğrenmek için **help** işlevi kullanılır. işlevin ne işe yaradığını tanımlamak için ise ilk satıra **"""** içerisine yazabiliriz. Bunu tanımlamak programınızı inceleyen diğer insanlar için yararlı olacaktır. 

.. code-block:: python

	def abc(sayi):
	    """Girilen sayıyı 10dan çıkartır"""
	    return 10-sayi
	help(abc)
	->  Help on function abc in module __main__:
	->
  	->  abc(sayi)
	->      Girilen sayıyı 10dan çıkartır

Bir işlevin birden çok çıktısı olabilir. Bunun için **return** ifadesini virgülle ayrılmış olarak birden çok değişken ile kullanmalıyız.

.. code-block:: python

	def yer_degistir(a,b):
	    """Girilen değişkenlerin yerini değiştirir"""
	    return b,a
	c = 12
	d = 31
	c,d = yer_degistir(c,d)
	# Bunun yerine doğrudan c,d = d,c kullanılabilirdi.
	print(c,d)
	-> 31 12

Sınıflar
========

Sınıf kavramı işlevlerin ve değişkenlerin guruplanarak nesneler haline getirilmesinden meydana gelir. Yani bir sınıf ona bağlı işlevlerden ve değişkenlerden oluşur. Sınıflar aşağıdaki gibi tanımlanırlar.

.. code-block:: python

	class sinif:
	    def __init__(self,girdi):
	        eylem
	    def islev(self,girdi):
	        eylem

Burada **__init__** işlevi sınıfı oluştururken çalıştırılan ilk eylemleri tanımlamak için kullanılır. sınıf işlevleri tanımlanırken ilk girdi olarak **self** kullanılmalıdır. Bu ifade sınıfın kendisi anlamına gelir. Örneğin bir sınıf tanımlayalım ve bu sınıftaki işlevler ile girdideki sayılara toplama ve çıkartma işlemi uygulayalım.

.. code-block:: python

	class sayi_isle:
	    def __init__(self,ilk,ikinci):
	        self.sayi1 = ilk
	        self.sayi2 = ikinci
	    def topla():
	        return self.sayi1 + self.sayi2
	    def cikart():
	        return self.sayi1 - self.sayi2
	        
	nesne = sayi_isle(12,3)
	a = nesne.topla()
	b = nesne.cikart()
	print(a,b)
	-> 15 9

Burada işlevlere **nesne.islev()** ifadesi ile erişebiliyoruz. Aynı zamanda değişkenlere de **nesne.degisken** ifadesi ile erişmemiz ve değiştirmemiz mümkündür. Sınıf içerisinden ise **self.islev()** ve **self.degisken** şeklinde bir ifade kullanmamız gerekmektedir. 

Dosya işlemleri
===============

Bir dosyayı açmak için **open** işlevi kullanılır. Açılan dosyadan satır okumak için **readline** işlevi, tamamını okumak için **read** işlevi, tüm satırları okuyup dizi haline getirmek için ise **readlines** işlevi kullanılır.

deneme.txt adında içeriği aşağıdaki gibi olan bir doysamız olsun:

.. code-block:: text

	Merhaba dünya
	Selam dünya
	sayı:123

Aşağıdaki örnekte bu dosyayı açıp okuyup ekrana basalım.

.. code-block:: python

	dosya = open("dosya.txt","r") # okumak için r kullanılır.
	ilksatir = dosya.readline()
	tumu = dosya.read()
	satirlar = dosya.readlines()
	print(len(satirlar))
	-> 3

Dosyaya yazmak için ise **write** işlevi kullanılır. Okuma ve yazma işlemleri bittikten sonra **close** işlevi ile dosya kapatılmalıdır. Dosyayı kapatmadan değişiklikleri diske işletmek için **flush** işlevi kullanılır.

.. code-block:: python

	dosya = open("dosya.txt","w") # yazmak için w eklemek için a kullanılır.
	dosya.write("Merhaba dünya\n")
	dosya.write("Selam dünya\n")
	dosya.write("sayı:123\n")
	dosya.close()

Modüller
========

Python programlarında kodların markaşıklaşmasını önlemek ve daha kullanışlı hale getirmek amacıyla modüller bulunur. Modüller **import** ifadesi ile çağırılır. Modüller aslında birer Birer python kütüphanesidir ve sınıf sayılırlar. Örneğin deneme.py dosyamızda aşağıdaki kodlar bulunsun:

.. code-block:: python

	yazi = "Merhaba"
	sayi = 12
	def yazdir():
	    print(yazi)
	class sinif:
	    def islev(self):
	        print("selam")

Şimdi bu modülümüzü çağırıp içerisindeki işlevleri ve değişkenleri kullanalım.

.. code-block:: python

	import deneme # deneme modülünü çağırdık
	print(deneme.yazi) # değişkeni kullandık
	deneme.yazdir() # işlevi kullandık.
	deneme.sayi = 76 # değişkeni değiştirdik
	nesne = deneme.sinif() # sınıftan nesne oluşturduk
	nesne.islev() # nesneyi kullandık
	-> Merhaba
	-> selam

Şimdiye kadar anlatılanların daha iyi anlaşılması için aşağıda ini parser örneği yapalım. Örnek bir ini dosyası aşağıdaki gibidir:

.. code-block:: ini

	[bölüm1]
	veri1=deger1
	veri2=deger2
	[bölüm2]
	veri3=deger3
	veri4=deger4

Bir adet modül yazıp bu modül ile ini dosyası okuyup istenilen bölümdeki değeri bulalım ve döndürelim. 

.. code-block:: python

	[Merhaba]
	dünya=12
	selam=44
	[hmm]
	veri=abc123x
	sayı=44
	

.. code-block:: python

	# iniparser.py içeriği
	dosya = None # boş dosya nesnesi
	class inidosya: 
	    def __init__(self,yol):
	        self.icerik = open(yol,"r").read() # dosya içeriğini okuduk
	def deger_al(bolum,veri): 
	    etkin = False # istenilen yere gelene kadar etkisiz kal
	    for satir in dosya.icerik.split("\n"):
	        if "[" + bolum + "]" in satir: # okunan satırda istenilen bölümün başı mı
	            etkin = True # etkinleştir
	        if etkin:
	            if satir.split("=")[0] == veri: # = işaretine göre 0. eleman aranan mı
	                return satir.split("=")[0].strip() # = işaretine göre böl . elemanı al

.. code-block:: python

	# main.py dosyası içeriği
	import iniparser # modülü yükle
	test.dosya = test.inidosya("dosya") # ini dosyasını yükle
	deger=test.deger_al("hmm","veri") # değeri al
	print(deger) # değeri yazdır
	-> abc123x













