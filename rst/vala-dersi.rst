Vala dersi
^^^^^^^^^^
Bu yazıda vala programlama dilini anlatacağım. 

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


Fonksiyonlar ve parametreler
============================
Vala yazarken forksino tanımlarız ve bu fonksiyonları parametreler ile çağırabiliriz.

.. code-block:: vala

	int main(string[] args){
	    write("Hello world");
	    return 0;
	}
	void write(string message){
	    stdout.printf(message);
	}

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

