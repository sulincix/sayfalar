Vala dersi
^^^^^^^^^^
Bu yazıda vala programlama dilini anlatacağım. Örneklende **...** bulunan satırlar üstünde ve altında başka kodların bulunabileceğini belirtir. Çalıştırılan komutların başında **$** işareti kullanılmıştır.

Vala programlama dili derlemeli bir dil olup yazmış olduğunuz kod valanın çeviricisi yardımı ile önce **C** koduna çevrilir ve ardından **gcc** veya **clang** gibi bir derleyici kullanılarak derlenir. Vala kaynak kodunu derlemek için **valac** kullanılır. Örneğin aşağıda basit bir derleme örneği verilmiştir.

.. code-block:: shell

	$ valac main.vala

Vala programlarını main fonksiyonu ile başlar. Bu fonksiyon aşağıdaki gibi yazılır:

.. code-block:: vala

	int main(string[] args){
	   ...
	   return 0;
	}

Burada **int** fonksiyonun çıktı türünü **main** adını **string[] args** ise parametresini ifade eder. **return 0** ise çıkış kodunu bildirir. Vala programlama dilinde her satırın sonunda **;** bulunmak zorundadır.

Girintileme
===========
Vala girintilemeye dikkat eden bir dil değildir fakat kodun okunaklı olması açısından girintilemeye dikkat etmenizi öneririm.
Girintileme ile ilgili aşağıdaki kuralları takip edebilirsiniz. Bu kurallar zorunluluk oluşturmadığı gibi kendinize göre farklılaştırabilirziniz.

* Koşullar döngüler ve fonksiyonlarda 4 boşluk veya tek tab ile girintileyin.
* Virgülden sonra bir boşluk bırakın.
* Koşullar döngüler ve fonksiyonlarda **{** işaretini satır sonuna koyun.
* **else** ve **else if** ifadelerinde **}** ve **{** işaretini satırın başında ve sonunda kullanın.
* İşleyicilerin başına ve sonuna birer boşluk ekleyin.

Örneğin bu kurala uygun girintilenmiş bir kod:

.. code-block:: vala

	int main(string[] args){
	    int i = int.parse(stdin.read_line());
	    int[] liste = {12, 22, 55, 27};
	    if(i == 12){
	        i = 33 / 3;
	    }else if(i >= 44){
	        i = 0;
	    }
	    return 0;
	}

Burada da aynı kodun kötü girintilenmiş hali bulunmaktadır.

.. code-block:: vala

	int main(    string[] args ){
	int i=int.parse(  stdin.read_line() );
	int[] liste={12,22,55,27};
	if (i== 2)
	  {i=33/3;}
	    else if    (i>=44){i=0;
	        }return 0;
	            }

Her ikisi de aslında tamamen aynı kod fakat ilk örnek daha okunaklı ve düzenli gözükmektedir.

Açıklama satırı
===============
Açıklamalar 2 şekilde yapılır. Açıklama bölümleri derleme esnasında dikkate alınmaz. 

*  **\\** ifadesinden sonra satır sonuna kadar olan kısım açıklamadır.
* **\\\*** ile başlayıp **\*\\** ile biten yazılar açıklamadır. 
 
.. code-block:: vala
 
 	// bu bir açıklamadır
 	/* bu bir açıklamadır */

Ekrana yazı yazdırma
====================
Ekrana yazı yazmak için **printf** kullanılır. normal çıktı için **stdout.printf**, hata çıktısı için ise **stderr.printf** kullanılır.

.. code-block:: vala

	int main(string[] args){
	    stdout.printf("Merhaba Dünya");
	    return 0;
	}

Değişken türleri
================
Değişkenler türleri ile beraber tanımlanırlar veya **var** ifadesi kullanılarak tanımlanırlar.

.. code-block:: vala

	...
	int num = 0;
	val text = "Hello world";
	string abc = "fff";
	...

Bununla birlikte değişkenlere başta değer atamayıp sonradan da değer atama işlemi yapılabilir.

.. code-block:: vala

	...
	int num;
	num = 31;
	...

Değişkenler arası tür dönüşümü işlemi için **parse** ve **to_string** kulanılır.

.. code-block:: vala

	...
	int num = 15;
	string txt = num.to_string(); // int -> string dönüşümü
	int ff = int.parse("23"); // string -> int dönüşümü
	...

Başlıca veri türleri şunlardır:

* **int** tam sayıları tutar
* **char** tek bir karakter tutar.
* **float** virgüllü sayıları tutar.x
* **double** büyük bellek boyutu gerektiren sayıları tutar.
* **bool** doğru veya yanlış olma durumu tutar.
* **string** yazı tutar.


Diziler
=======
Diziler birden çok eleman tutan değişkenlerdir. tanımlanırken **xxx[] yy** şeklinde tanımlanırlar.

.. code-block:: vala

	...
	int[] nums = {12,22,45,31,48};
	stdout.printf(num[3].to_string()); // Ekrana 31 yazar.
	...

Yukarıda **{}** kullanılarak dizi elemanları ile beraber tanımlanmıştır. Bir altındaki satırda ise dizinin 4. elemanı çekilmiştir ve string türüne çevirilip ekrana yazılmıştır. Burada 3 olarak çekilme sebebi dizilerin eleman sayılarının 0dan başlamasıdır.

Diziye aşağıdaki gibi eleman ekleyebiliriz.

.. code-block:: vala

    ...
	int nums = {14,44,12};
	nums += 98;
    ...

Dizinin boyutunu aşağıdaki gibi öğrenebiliriz.

.. code-block:: vala

    ...
	string[] msgs = {"Hello", "World"};
	int ff = msgs.length;
    ...

Vala programlama dilinde diziler basit işler için yeterli olsa da genellikle yetersiz kaldığı için **libgee** kütüphanesinden faydalanılır. Öncelikle kodun en üstüne `Using gee;` eklenir. bu sayede kütüphane içerisindeki işlevler kullanılabilir olur. Bu ifade detaylı olarak ilerleyen bölümlerde anlatılacaktır. **libgee** kullanılırken derleme işlemine `--pkg gee-0.8` eklenir. Bu sayede derlenen programa libgee kütüphanesi dahil edilir.

.. code-block:: shell

	$ valac main.vala --pkg gee-0.8

Liste tanımlaması ve eleman ekleyip çıkarılması aşağıdaki gibidir:

.. code-block:: vala

	Using gee;
	
	void test(){
	    var liste = new ArrayList<int>();
	    liste.add(12);
	    liste.add(18);
	    liste.add(3);
	    liste.remove(18);
	}
	...

Yukarıdaki örnekde **ArrayList** tanımlanmıştır. **add** ile eleman eklemesi **remove** ile eleman çıkarılması yapılır.

Listenin belirtilen index sayılı elemanı aşağıdaki gibi getirilir.

.. code-block:: vala

	...
	int num = liste.get(3); // 4. eleman değeri getirilir.
	...

Listenin istenen bir elemanı aşağıdaki gibi değiştirilebilir.

.. code-block:: vala

	...
	liste.set(3,144); // 4. eleman değiştirilir.
	...

Listenin eleman sayısı aşağıdaki gibi bulunur.

.. code-block:: vala

	...
	int boyut = liste.size;
	...

Klavyeden değer alma
====================
Klavyeden string türünden değer almak için **stdin.read_line()** kullanılır.

.. code-block:: vala

	...
	var text = stdin.read_line();
	stdout.printf(text);
	...

Koşullar
========
Koşul tanımlamak için **if** kullanılır. Bu ifade parametre olarak **bool** türünden değişken alır.  Koşulun gerçekleşmediği durumda **else if** kullanılarak diğer koşul karşılanıyor mu diye bakılır. Hiçbiri gerçekleşmiyorsa **else** kullanılarak bu durumda yapılacaklar belirtilir.

.. code-block:: vala

	...
	if(koşul){
	   ...
	}else if(diğer-koşul){
	   ...
	}else{
	   ...
	}
	...

Örneğin klavyeden değer alalım ve bu değerin eşit olma durumuna bakalım.

.. code-block:: vala 

	...
	string parola = stdin.read_line();
	if(parola == "abc123"){
	    stdout.printf("doğru parola");
	}else{
	    stderr.printf("hatalı parola");
	}
	...

Koşullarda kullanılan işleyiciler ve anlamları aşağıda liste halinde verilmiştir.

.. list-table:: **Koşul işleyicileri**
	:widths: 20 40 40
	:header-rows: 1

	* - ifade
	  - anlamı
	  - örnek

	* - >
	  - büyüktür
	  - 121 > 12

	* - <
	  - küçüktür
	  - 12 < 121

	* - ==
	  - birbirine eşittir
	  - 121 == 121

	* - !
	  - karşıtlık bildirir.
	  - !(12 > 121)

	* - &&
	  - logic and
	  - "fg" == "aa" && 121 > 12

	* - ||
	  - logic or
	  - "fg" == "aa" || 121 > 12

	* - !=
	  - eşit değildir
	  - "fg" != "aa"

	* - >=
	  - büyük eşittir
	  - 121 >= 121

	* - <=
	  - küçük eşittir
	  - 12 <= 12

	* - in
	  - eleman içerme kontrolü
	  - 12 in {12, 121, 48, 94}

Koşullar için alternatif olarak şu şekilde de kullanım mevcuttur.

.. code-block:: vala

	koşul ? durum : diğer-durum;

Burada **?** işaretinden sonra ilk durum **:** işaretinden sonra da gerçekleşmediği durum belirtilir.

.. code-block:: vala

	...
	string parola = stdin.read_line();
	parola == "abc123" ? stdout.printf("Doğru parola") : stderr.printf("yanlış parola");
	...

Döngüler
========
Döngüler aşağıdaki gibi tanımlanır. döngüde koşul sağlandığı sürece sürekli olarak içerisindeki kod çalıştırılır.

.. code-block:: vala

	while(koşul){
	    ...
	}

Örneğin ekrana 0dan 10a kadar olan sayıları yazdıralım.

.. code-block:: vala

	...
	int sayi = 0;
	while (sayi <=10){
	    stdout.printf(sayi.to_string());
	    sayi += 1; // sayi = sayi + 1 ile aynı anlama gelir.
	}
	...

Yukarıdaki örnekte **while** ifadesi sayı 10dan küçük ve eşitse çalışır. sayı 11 olduğunda bu sağlanmadığı için işlem sonlandırılır.

**for** ifadesi kulanılarak benzer bir döngü yapılabilir. Örneğin:

.. code-block:: vala

	...
	for(int i=0; i<=10; i++){ // i += 1 ile aynı anlama gelir
	    stdout.printf(sayi.to_string());
	}
	...

Bu örnek while örneğindeki ile aynı işlemi gerçekleştirir. 

Bir listenin tüm elemanları ile döngü oluşturmak için ise **foreach** kullanılır. 

.. code-block:: vala

	...
	int[] i = {31, 44, 78, 84, 27};
	foreach(int sayi in i){
	    stdout.printf(sayi.to_string());
	}
	...

Burada **sayi** değişkeni her seferinde listenin bir sonraki elemanı olarak tanımlanır ve işleme koyulur.

Döngüden çıkmak için **break** döngünün alt satırlarının çalışmayıp sonraki koşul için başa dönülmesi için ise **continue** kullanılır.

.. code-block:: vala

	...
	while(true){
	    int txt = stdin.read_line();
	    if(txt == "abc123"){
	        stdout.printf("Doğru parola");
	        break;
	    }else{
	        stderr.printf("Hatalı parola");
	        continue;
	    }
	    stdout.printf("test 123"); // bu satır çalıştırılmaz.
	}
	...

Fonksiyonlar ve parametreler
============================
Vala yazarken forksiyon tanımlarız ve bu fonksiyonları parametreler ile çağırabiliriz.

.. code-block:: vala

	int main(string[] args){
	    write("Hello world");
	    return 0;
	}
	void write(string message){
	    stdout.printf(message);
	}

