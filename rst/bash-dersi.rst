Bash dersi
^^^^^^^^^^^^^^^^^^^
Bu yazıda bash betiği yazmayı hızlıca anlatacağım. Bu yazıda karıştırılmaması için girdilerin olduğu satırlar *<-* ile çıktıların olduğu satırlar *->* ile işaretlenmiştir.

Açıklama satırı ve dosya başlangıcı
===================================

Açıklamalar **#** ifadesiden başlayıp satır sonuna kadar devam eder. Dosyanın ilk satırına **#!/bin/bash** eklememiz gerekmektedir. Bash betikleri genellikle **.sh** uzantılı olur.
Bash betikleri girintilemeye duyarlı değildir. Bash betiği yazarken girintileme için 4 boşluk veya tek tab kullanmanızı öneririm.

Bash betiklerinde alt satıra geçmek yerine **;** kullanabiliriz. Bu sayede kaynak kod daha düzenli tutulabilir.

.. code-block:: shell

	#!/bin/bash
	#Bu bir açıklama satırıdır.
	
Bash betiklerini çalıştırmak için öncelikle çalıştırılabilir yapmalı ve sonrasında aşağıdaki gibi çalıştırılmalıdır.

.. code-block:: shell
	
	chmod +x ders1.sh
	./ders1.sh

**:** komutu hiçbir iş yapmayan komuttur. Bu komutu açıklama niyetine kullanabilirsiniz. **true** komutu ile aynı anlama gelmektedir.

Çoklu açımlama satırı için aşağıdaki gibi bir ifade kullanabilirsiniz.

.. code-block:: shell

	: "
	Bu bir açıklama satıdırıdır.
	Bu da diğer açıklama satırıdır.
	Bu da sonunca açıklama satırıdır.
	"


Ekrana yazı yazalım
===================
Ekrana yazı yazmak için **echo** ifadesi kulanılır.

.. code-block:: shell

	echo Merhaba dünya
	-> Merhaba dünya

Ekrana özel karakterleri yazmak için **-e** parametresi kullanmamız gerekmektedir.

.. code-block:: shell

	echo -e "Merhaba\ndünya"
	-> Merhaba
	-> dünya


Parametreler
============
Bir bash betiği çalıştırılırken verilen parametreleri **$** ifadesinden sonra gelen sayı ile kullanabiliriz.
**$#** bize kaç tane parametre olduğunu verir.
**$@** ifadesi ile de parametrelerin toplamını elde edebiliriz.

.. code-block:: shell

	echo "$1 - $# - $@"
	
	./ders1.sh merhaba dünya
	-> merhaba - 2 - merhaba dünya
	

Değişkenler ve Sabitler
=======================
Değişkenler ve sabitler programımızın içerisinde kullanılan verilerdir. Değişkenler tanımlandıktan sonra değiştirilebilirken sabitler tanımlandıktan sonra değiştirilemez.

Değişkenler sayı ile başlayamaz, Türkçe karakter içeremez ve `/*[[($` gibi özel karakterleri içeremez. 

Normal Değişkenler aşağıdaki gibi tanımlanır.

.. code-block:: shell

	sayı=23
	yazi="merhaba"
	
**+=** ifadesi var olan değişkene ekleme yapmak için kullanılır. Değişkenin türünü belirlemeden tanımlamışsak yazı olarak ele alır.

.. code-block:: shell

	typeset -i a # Değişkeni sayı olarak belirttik.
	a=1 ; b=1
	a+=1 ; b+=1
	echo "$a $b"
	-> 2 11

Çevresel değişkenler tüm alt programlarda da geçerlidir. Çevresel değişken tanımlamak için başına **export** ifadesi yerleştirilir.

.. code-block:: shell

	export sayi=23
	export yazi="merhaba"

Sabitler daha sonradan değeri değiştirilemeyen verilerdir. Sabit tanımlamak için başına **decrale -r** ifadesi yerleştirilir.

.. code-block:: shell

	declare -r yazi="merhaba"
	declade -r sayi=23
	
Değişkenler ve sabitler kullanılırken **${}** işareti içine alınırlar veya başına **$** işareti gelir. Bu doküman boyunca ilk kullanım biçimi üzerinden gideceğim.

.. code-block:: shell

	deneme="abc123"
	echo ${deneme}
	-> abc123

Sayı ve yazı türünden değişkenler farklıdır. sayıyı yazıya çevirmek için **"** işaretleri arasına alabiliriz. Birden fazla yazıyı toplamak için yan yana yazmamız yeterlidir.

.. code-block:: shell

	sayi=11
	yazi="karpuz"
	echo "${sayi}${karpuz} limon"
	-> 11karpuz limon

Sayı değişkenleri üzerinde matematiksel işlem yapmak için aşağıdaki ifade kullanılır. `(+-*/ işlemleri için geçerlidir.)`

.. code-block:: shell

	sayi=12
	sayi=$((${sayi}/2))
	echo ${sayi}
	-> 6


Değişkenlere aşağıdaki tabloda belirttiğim gibi müdahale edilebilir. Karakter sayısı 0'dan başlar. Negatif değerler sondan saymaya başlar.

.. list-table:: **Değişkene müdahale (var="Merhaba")**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Anlamı
     - Eşleniği
     
   * - ${var%aba}
     - sondaki ifadeyi sil
     - Merh
     
   * - ${var#Mer}
     - baştaki ifadeyi sil
     - haba
     
   * - ${var:1:4}
     - 1. 4. karakterler arası
     - erha

   * - ${var::4}
     - 4. karaktere kadar
     - Merha
     
   * - ${var:4}
     - 4. karakterden sonrası
     - aba

   * - ${var/erh/abc}
     - erh yerine abc koy
     - Mabcaba

Diziler
=======
Diziler birden çok eleman içeren değişkenlerdir. Bash betiklerinde diziler aşağıdaki gibi tanımların ve kullanılır.

.. code-block:: shell

	dizi=(muz elma limon armut)
	echo ${dizi[1]}
	-> elma
	echo ${#dizi[@]}
	-> 4
	echo ${dizi[@]:2:4}
	-> limon armut
	dizi+=(kiraz)
	echo ${dizi[-1]}
	-> kiraz

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
	

Koşul ifadeleri kısmında çalıştırılan komut 0 döndürüyorsa doğru döndürmüyorsa yalnış olarak değerlendirilir. **[[** veya **[** ile büyük-küçük-eşit kıyaslaması, dosya veya dizin varlığı vb. gibi sorgulamalar yapılabilir. Bu yazıda **[[** kullanılacaktır.

.. code-block:: shell

	read veri
	if [[ ${veri} -lt 10 ]] ; then
	    echo "Veri 10'dan küçük"
	else
	    echo "Veri 10'dan büyük veya 10a eşit"
	fi
	
	<- 9
	-> Veri 10'dan küçük
	<- 15
	-> Veri 10'dan büyük veya 10a eşit
	
**[[** komutu ile ilgili başlıca ifadeleri ve kullanımlarını aşağıda tablo olarak ifade ettim.

.. list-table:: **[[ ifadeleri ve kullanımları**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Anlamı
     - Kullanım şekli

   * - -lt
     - küçüktür
     - [[ ${a} -lt 5 ]]

   * - -gt
     - büyüktür
     - [[ ${a} -gt 5 ]]

   * - -eq
     - eşittir
     - [[ ${a} -eq 5 ]]

   * - -le
     - küçük eşittir
     - [[ ${a} -le 5 ]]

   * - -ge
     - büyük eşittir
     - [[ ${a} -ge 5 ]]

   * - -f
     - dosyadır
     - [[ -f /etc/os-release ]]

   * - -d 
     - dizindir
     - [[ -d /etc ]]

   * - -e
     - vardır (dosya veya dizindir)
     - [[ -e /bin/bash ]]

   * - -L 
     - sembolik bağdır
     - [[ -L /lib ]] 

   * - -n
     - uzunluğu 0 değildir
     - [[ -n ${a} ]]

   * - -z
     - uzunluğu 0dır
     - [[ -z ${a} ]]

   * - !
     - ifadenin tersini alır.
     - [[ ! .... veya ! [[ ....

   * - > 
     - alfabeti olarak büyüktür
     - [[ "portakal" > "elma" ]]

   * - < 
     - alfabetik olarak küçüktür
     - [[ "elma" < "limon" ]]

   * - ==
     - alfabetik eşittir
     - [[ "nane" == "nane" ]]

   * - != 
     - alfabetik eşit değildir
     - [[ "name" != "limon" ]]

   * - ||
     - mantıksal veya bağlacı
     - [[ .... || .... ]] veya [[ .... ]] || [[ .... ]]

   * - &&
     - mantıksal ve bağlacı
     - [[ .... && .... ]] veya [[ .... ]] && [[ .... ]]


**true** komutu her zaman doğru **false** komutu ile her zaman yanlış çıkış verir. 

Bazı basit koşul ifadeleri için if ifadesi yerine aşağıdaki gibi kullanım yapılabilir.

.. code-block:: shell

	[[ 12 -eq ${a} ]] && echo "12ye eşit." || echo "12ye eşit değil"
	#bunun ile aynı anlama gelir:
	if [[ 12 -eq ${a} ]] ; then
	    echo "12ye eşit"
	else
	    echo "12ye eşit değil"
	fi

case yapısı
===========
**case** yapısı case ile başlar değerden sonra gelen **in** ile devam eder ve koşullardan sonra gelen **esac** ile tamamlanır.
case yapısı sayesinde if elif else ile yazmamız gereken uzun ifadeleri kısaltabiliriz.

.. code-block:: shell

	case deger in 
	    elma | kiraz)
	        echo "meyve"
	        ;;
	    patates | soğan)
	        echo "sebze"
	        ;;
	    balık)
	        echo "hayvan"
	    *)
	        echo "hiçbiri"
	        ;;
	esac
	# Şununla aynıdır:
	if [[ "${deger}" == "elma" || "${deger}" == "kiraz" ]] ; then
	    echo "meyve"
	elif [[ "${deger}" == "patates" || "${deger}" == "soğan" ]] ; then
	    echo "sebze"
	elif [[ "${değer}" == "balık" ]] ; then
	    echo "hayvan"
	else
	    echo "hiçbiri"
	fi

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
	while [[ ${i} -le 10 ]] ; do
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

Buradaki özel kullanımları aşağıda tablo halinde belirttim.

.. list-table:: **küme parantezli ifadeler ve anlamları**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Anlamı
     - eşleniği

   * - {1..5}
     - aralık belirtir
     - 1 2 3 4 5

   * - {1..7..2}
     - adımlı aralık belirtir
     - 1 3 5 7
     
   * - {a,ve}li
     - kurala uygun küme belirtir
     - ali veli



Fonksiyonlar
============
Fonksiyonlar alt programları oluşturur ve çağırıldığında işlerini yaptıktan sonra tekrar ana programdan devam edilmesini sağlar. Bir fonksiyonu aşağıdaki gibi tanımlayabiliriz.

.. code-block:: shell

	isim(){
	    eylem
	    return sonuç
	}
	# veya
	function isim(){
	    eylem
	    return sonuç
	}
	
Burada **return** ifadesi kullanılmadığı durumlarda 0 döndürülür. return ifadesinden sonra fonksiyon tamamlanır ve ana programdan devam edilir.

Bu yazı boyunca ilkini tercih edeceğiz.
	
Fonksionlar sıradan komutlar gibi parametre alabilirler ve ana programa ait sabit ve değişkenleri kullanabilirler.

.. code-block:: shell

	sayi=12
	topla(){
	    echo $((${sayi}+$1))
	    return 0
	    echo "Bu satır çalışmaz"
	}
	topla 1
	-> 13

**local** ifadesi sadece fonksionun içinde tanımlanan fonksion bitiminde silinen değişkenler için kullanılır.
	
Fonksionların çıkış turumlarını koşul ifadesi yerine kullanabiliriz.

.. code-block:: shell

	read sayi
	teksayi(){
	    local i=$(($1+1)) # sayıya 1 ekledik ve yerel hale getirdik.
	    return $((${i}%2))  # sayının 2 ile bölümünden kalanı döndürdük
	}
	if teksayi ${sayi} ; then
	    echo "tek sayıdır"
	else
	    echo "çift sayıdır"
	fi
	
	<- 12
	-> çift sayıdır
	<- 5
	-> tek sayıdır

Bir fonksionun çıktısını değişkene **$(isim)** ifadesi yadımı ile atayabiliriz. Aynı durum komutlar için de geçerlidir.

.. code-block:: shell

	yaz(){
	    echo "Merhaba"
	}
	echo "$(yaz) dünya"
	-> Merhaba dünya
	
Tanımlı bir fonksionu silmek için **unset -f** ifadesini kullanmamız gereklidir.

.. code-block:: shell

	yaz(){
	    echo "Merhaba"
	}
	unset -f yaz
	echo "$(yaz) dünya"
	-> bash: yaz: komut yok
        -> dünya
        
Burada dikkat ederseniz olmayan fonksionu çalıştırmaya çalıştığımız için hata mesajı verdi fakat çalışmaya devam etti. Eğer herhangi bir hata durumunda betiğin durmasını istiyorsak **set -e** bu durumun tam tersi için **set +e** ifadesini kullanmalıyız.

.. code-block:: shell

	echo "satır 1"
	acho "satır 2" # yanlış yazılan satır fakat devam edecek
	echo "satır 3"
	set -e
	acho "satır 4" # yanlış yazılan satır çalışmayı durduracak
	echo "satır 5" # bu satır çalışmayacak
	-> satır 1
	-> bash: acho: komut yok
	-> satır 3
	-> bash: acho: komut yok

	
Dosya işlemleri
===============

Bash betiklerinde **stdout** **stderr** ve **stdin** olmak üzere 2 çıktı ve 1 girdi bulunur. Ekrana stderr ve stdout beraber yazılır.

.. list-table:: **dosya ifadeleri ve anlamları**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Türü
     - Anlamı

   * - stdin
     - Girdi
     - Klavyeden girilen değerler.
     
   * - stdout
     - Çıktı
     - Sıradan çıktılardır.
     
   * - stderr
     - Çıktı
     - Hata çıktılarıdır.

**cat** komutu ile dosya içeriğini ekrana yazdırabiliriz. Dosya içeriğini **$(cat dosya.txt)** kullanarak değişkene atabiliriz.

dosya.txt içeriğinin aşağıdaki gibi olduğunu varsayalım.

.. code-block:: shell

	Merhaba dünya
	Selam dünya
	sayı:123

Ayağıdaki örnekle dosya içeriğini önce değişkene atayıp sonra değişkeni ekrana yazdırdık.
	
.. code-block:: shell

	icerik=$(cat ./dosya.txt)
	echo "${icerik}"
	-> Merhaba dünya
	-> Selam dünya
	-> sayı:123

**grep "sözcük" dosya.txt** ile dosya içerisinde sözcük gezen satırları filitreleyebiliriz. Eğer grep komutuna **-v** paraketresi eklersek sadece içermeyenleri filitreler.
Eğer filitrelemede hiçbir satır bulunmuyorsa yanlış döner.

.. code-block:: shell

	grep "dünya" dosya.txt
	-> Merhaba dünya
	-> Selam dünya
	grep -v "dünya" dosya.txt
	-> sayi:123

Aşağıdaki tabloda bazı dosya işlemi ifadeleri ve anlamları verilmiştir.

.. list-table:: **dosya ifadeleri ve anlamları**
   :widths: 25 25 50
   :header-rows: 1

   * - İfade
     - Anlamı
     - Kullanım şekli

   * - >
     - çıktıyı dosyaya yönlendir (stdout)
     - echo "Merhaba dünya" > dosya.txt
     
   * - 2>
     - çıktıyı dosyaya yönlendir (stderr)
     - ls /olmayan/dizin 2> dosya.txt
   
   * - >>
     - çıktıyı dosyaya ekle
     - echo -n "Merhaba" > dosya.txt && echo "dünya" >> dosya.txt
       
   * - &>
     - çıktıyı yönlendir (stdout ve stderr)
     - echo "$(cat /olmayan/dosya) deneme" &> dosya.txt
     
Ayrıca dosyadan veri girişleri için de aşağıda örnekler verilmiştir:


.. code-block:: shell

	# <<EOF:
	# EOF ifadesi gelene kadar olan kısmı girdi olarak kullanır:
	cat > dosya.txt <<EOF
	Merhaba
	dünya
	EOF
	# < dosya.txt
	# Bir dosyayı girdi olarak kullanır:
	while read line ; do
	    echo ${line:2:5}
	done < dosxa.txt
	

**/dev/null** içine atılan çıktılar yok edilir. **/dev/stderr** içine atılan çıktılar ise hata çıktısı olur.

Boru hattı
==========

Bash betiklerinde **stdin** yerine bir önceki komutun çıktısını kullanmak için boru hattı açabiliriz. Boru hattı açmak için iki komutun arasına **|** işareti koyulur. Boru hattında soldan sağa doğru çıktı akışı vardır. Boru hattından sadece **stdout** çıktısı geçmektedir. Eğer **stderr** çıktısını da boru hattından geçirmek istiyorsanız **|&** kullanmalısınız.

.. code-block:: shell

	topla(){
	    read sayi1
	    read sayi2
	    echo $((${sayi1}+${sayi2}))
	}
	topla
	<- 12
	<- 25
	-> 37
	sayiyaz(){
	    echo 12
	    echo 25
	}
	 sayiyaz | topla
	-> 37

Kod bloğu
=========

**{** ile **}** arasına yazılan kodlar birer kod bloğudur. Kod blokları fonksionların aksine argument almazlar ve bir isme sahip değillerdir. Kod blokları tanımlandığı yerde çalıştırılırlar. Kod bloğuna boru hattı ile veri girişi ve çıkışı yapılabilir.

.. code-block:: shell

	cikart(){
	    read sayi1
	    read sayi2
	    echo $((${sayi1}-${sayi2}))
	}
	cikart
	<- 25
	<- 12
	-> 13
	{
	    echo 25
	    echo 12
	} | cikart
	-> 13
	# veya kısaca şu şekilde de yapılabilir.
	{ echo 25 ; echo 12 ; } | cikart
	-> 13

Birden çok dosya ile çalışmak
=============================

Bash betikleri içerisinde diğer bash betiği dosyasını kullanmak için **source** yada **.** ifadeleri kullanılır. Diğer betik eklendiği zaman içerisinde tanımlanmış olan değişkenler ve fonksionlar kullanılabilir olur.

Örneğin deneme.sh dosyamızın içeriği aşağıdaki gibi olsun:


.. code-block:: shell

	mesaj="Selam"
	merhaba(){
	    echo ${mesaj}
	}
	echo "deneme yüklendi"
	
Asıl betiğimizin içeriği de aşağıdaki gibi olsun.


.. code-block:: shell

	source deneme.sh # deneme.sh dosyası çalıştırılır.
	merhaba
	-> deneme yüklendi
	-> Selam
	
Ayrıca bir komutun çıktısını da betiğe eklemek mümkündür. Bunun için **<(komut)** ifadesi kullanılır. Aşağıda bununla ilgili bir örnek verilmiştir.


.. code-block:: shell

	source <(curl https://gitlab.com/sulincix/outher/-/raw/gh-pages/deneme.sh) # Örnekteki adrese takılmayın :D
	merhaba
	merhaba2
	echo ${sayi}
	-> Merhaba dünya
	-> 50
	-> 100
	

