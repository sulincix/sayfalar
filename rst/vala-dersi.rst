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

Bir fonksiyon sadece bir kez tanımlanabilir. Fakat fonksiyonu isim olarak oluşturup daha sonra tanımlamak mümkündür.

.. code-block:: vala

	...
	void fff(); // isim olarak tanımlanabilir.
	void fff(){
	    stdout.printf("hmmm");
	}
	...

Ayrıca fonksiyonu isim olarak tanımlayıp **C** programlama dili ile yazılmış bir fonksiyon kullanabiliriz. Bu sayede kaynak kod C ve Vala karışımından oluşmuş olur. Bunun için **extern** ifadesi kullanılır.

.. code-block:: vala

	// main.vala dosyası
	extern void fff(string msg);
	int main(string[] args){
	    fff("Hello World");
	}

.. code-block:: C

	// util.c dosyası
	#include <stdio.h>
	void fff(char* msg){
	    fputs(msg,stdout);
	}

Yukarıdaki örnekteki 2 dosyayı derlemek için aşağıdaki gibi bir komut kullanılmalıdır.

.. code-block:: shell

	$ valac main.vala util.c

C kaynak kodunun gerektirdiği parametreleri **-X** kullanarak ekleyebiliriz. Bu sayede doğrudan gccye parametre eklenebilir.

.. code-block:: shell

	$ valac main.vala util.c -X "-lreadline" # C ile readline kütüphanesini kullanmak için -lreadline gerekir.

Vala içinde C kullanabildiğimiz gibi tam tersi de mümkündür. Bunun için C tarafında fonksiyon için isim tanımlamamız yeterlidir.

.. code-block:: C

	void fff(char* message);
	int main(int argc, char *argv[]){
	    fff("Hello world");
	}

.. code-block:: vala

	public void fff(string message){
	    print(message);
	}

Yukarıdaki örnekte C kodu içerisinde vala ile yazılmış bir fonksiyon kullanılmıştır.

Bir fonksiyon normal şartlarda başka bir fonksiyona parametre olarak verilemez. Bu gibi durumlar için **delegate** ifadesinden yararlanılır. Önce delegate ifadesi ile fonksiyonun nasıl tanımlanacağı belirtilir daha sonra bu yeni oluşturulmuş tür parametre olarak kullanılır.

.. code-block:: vala

	delegate void fff(string message);
	
	// delegate ile kullanıma uygun fonksiyon tanımladık.
	void f1(string message){
	    stdout.printf(message);
	}
	
	// delegate çağırmaya yarayan fonksiyon yazdık
	void f2(fff function, string message){
	    function(message);
	}
	
	// main fonksiyonu
	void main(string[] args){
	    f2(f1,"Hello World");
	}

Sınıf kavramı
=============
Vala nesne yönelimli bir programlama dilidir. Bu sebeple sınıflar oluşturabiliriz. Sınıflar **Gtk** gibi arayüz programlamada kullanışlı olmaktadırlar. Sınıf oluşturmak için **class** ifadesi kullanılır.

.. code-block:: vala

	public class test {
	    public void write(){
	        stdout.printf("test123");
	    }
	}
	int main(string[] args){
	    test t = new test();
	    t.write();
	}

Yukarıdaki örnekte sınıf tanımlanmıştır. Daha sonra bu sınıftan bir nesne türetilmiştir ve ardıntan nesneye ait fonksiyon çalıştırılmıştır.

Sınıf içerisinde bulunan bazı fonksiyonların dışarıdan erişilmesini istemiyorsanız **private**, erişilmesini istiyorsanız **public** ifadesi ile tanımlamanız gerekmektedir.

Sınıf içerisinde tanımlanmış değişkenlere ulaşmak için **this** ifadesi kullanılır.

.. code-block:: vala

	...
	public class test {
	    private int i;
	    private int j;
	    
	    public void set(int i, int j){
	        this.i = i;
	        this.j = j;
	    }
	}
	...

Super sınıf
===========
Bir sınıfı başka bir sınıftan türetebiliriz. Bunun için sınıf tanımlanırken `class xxx : yyy` yapısı kullanılır.

.. code-block:: vala

	public class hello {
	    public void write_hello(){
	        stdout.printf("Hello");
	    }
	}
	public class world : hello {
	    public void write_world(){
	        stdout.printf("World");
	    }
	    public void write(){
	        write_hello();
	        write_world();
	    }
	}
	int main(){
	    world w = new world();
	    w.write();
	    return 0;
	}

Eğer var olan bir fonksiyonun üzerine yazmak istiyorsak **override** ifadesini kullanabiliriz.

.. code-block:: vala

	...
	public class hello {
	    public void write(){
	        stdout.printf("hello");
	    }
	}
	public class world : hello {
	    public override void write(){
	        stdout.printf("world");
	    }
	}
	...

Bir sınıfı birden fazla sınıfın birleşiminden türetebiliriz. 

.. code-block:: vala

	...
	public class hello {
	    public void write_hello(){
	        stdout.printf("Hello");
	    }
	}
	public class world {
	    public void write_world(){
	        stdout.printf("World");
	    }
	}
	public class helloworld : hello, world {
	    public void write(){
	        write_hello();
	        write_world();
	    }

	}
	...

Signal kavramı
==============
Valada sinyal tanımlayarak bir sınıftaki bir işlevin nasıl çalışması gerektiği ayarlanabilir. Bunun için isim olarak tanımlanan fonksiyonun başına **signal** ifadesi yerleştirilir.

.. code-block:: vala

	public class test {
	    public signal void sig1(int i);
	    
	    public void run(int i){
	        this.sig1(i);
	    }
	}
	int main(string[] args){
	    test t1 = new test();
	    t1.sig1.connect((i)=>{
	        stdout.printf(i.to_string());
	    });
	    t1.run(31);
	    return 0;
	}

Namespace kavramı
=================
Valada kodları alan adlarına bölerek yazmamız mümkündür. Bu sayede alan adı içine tanımladığımız fonksiyonları alan adı ile beraber çağırarak kullanabiliriz. Bunun için **namespace {}** ifadesi kullanılır.

.. code-block:: vala

	namespace test {
	    void print(){
	        stdout.printf("Test");
	    }
	}
	...
	int main(string[] args){
	    test.print();
	}

Namespace iç içe tanımlanabilir.

.. code-block:: vala

	namespace test1 {
	    namespace test2 {
	        void print(){
	            stdout.printf("Test");
	        }
	    }
	}
	...
	int main(string[] args){
	    test1.test2.print();
	}

Bir namespace alanını kaynak kodda içeri aktararak kullanmak için **using** ifadesi kullanılır.
Bu ifade sayesinde belirtilen alan adındaki tüm fonksiyonlar kaynak kodda doğrudan kullanılabilir hale gelir.

.. code-block:: vala

	using Gtk;
	
	int main(string[] args){
	    // İsterseniz yine de namespace adı ile kullanabiliriz.
	    Gtk.init (ref args);
	    // Gtk.Window yerine Window kullanabiliriz.
	    var win = new Window();
	    // Şununla aynı anlama gelir
	    // var win = new Gtk.Window();
	    ...
	    // Aynı isimde var olan bir fonksiyonu namespace adı olmadan kullanmak mümkün değildir.
	    Gtk.main ();
	    return 0;
	}

Sınıfları tanımlarken namespace belirterek tanımlamak mümkündür.
Bunun için sınıfın adının başına namespace adını belirtmek yeterlidir.

.. code-block:: vala

	public class test.cls {
	    public void print(){
	        stdout.printf("Test");
	    }
	}
	...
	int main(string[] args){
	    var tcls = new test.cls();
	    tcls.print();
	    return 0;
	}

Kütüphane oluşturma
===================
Vala kaynak kodu kullanarak kütüphane oluşturabiliriz. Bunun için kodu aşağıdaki gibi derleyebiliriz.

.. code-block:: vala

	// library.vala dosyası
	public int test(){
	    stdout.printf("Hello World");
	    return 0;
	}

Vala kaynak kodunu önce C koduna çevirmemiz gerekmektedir. Daha sonra gcc ile derleyebiliriz. Vala programlama dili **glib-2.0** kullanarak çalıştığı için bu kütüphaneyi derleme esnasında eklememiz gerekmektedir. Ayrıca glib-2.0 derlenirken **-fPIC** parametresine ihtiyaç duyar.

.. code-block:: shell

	# Önce C koduna çevirelim
	$ valac -C -H libtest.h --vapi libtest.vapi library.vala
	# Sonra gcc ile derleyelim.
	$ gcc library.c -o libtest.so -shared \
	    `pkg-config --cflags --libs glib-2.0` -fPIC

Alternatif olarak aşağıdaki gibi de derleyebilirsiniz. Bu durumda C kaynak koduna çevirmeye gerek kalmadan kütüphanemiz derlenmiş olur.

.. code-block:: shell

	$ valac -H libtest.h --vapi libtest.vapi \
	    -o libtest.so -X -shared -X -fPIC library.vala

Şimdi aşağıdaki gibi bir C kodu yazalım ve kütüphanemizi orada kullanalım. Oluşturulmuş olan **library.h** dosyamızdan yararlanabiliriz.

.. code-block:: C

	// main.c dosyası
	#include <libtest.h>
	int main(){
	    gint i = test(); // vala değişken türleri glib kütüphanesinden gelir.
	    return (int) i;
	}

Ve şimdi de C kodunu derleyemlim.

.. code-block:: shell

	$ gcc -L. -I. -ltest main.c `pkg-config --cflags --libs glib-2.0` -fPIC

Bununla birlikte **libtest.vapi** dosyamızı kullanarak kütüphanemizi vala ile kullanmamız da mümkündür.

.. code-block:: vala

	// main.vala dosyası
	int main(string[] args){
	    int i = test();
	    return i;
	}

Şimdi vala kodunu derleyelim.

.. code-block:: shell

	$ valac --vapidir ./ main.vala --pkg libtest

Gobject oluşturma
=================
Gobject kulanarak yazdığımız kütüphaneyi farklı dillerde kullanmamız mümkündür.
Bunun için önce aşağıdaki gibi bir kaynak kodumuz olsun. Burada bin namespace tanımlayalım.

.. code-block:: vala

	namespace hello{
	    public void print(){
	        stdout.printf("Hello World\n");
	    }
	}

Şimdi bu kodu aşağıdaki gibi derleyelim.

.. code-block:: shell

	# Önce C koduna çevirelim ve gir dosyası oluşturalım.
	$ valac -C main.vala \
	    --gir=hello-1.0.gir \
	    --library=hello \
	    -H libhello.h
	# C kodunu derleyelim.
	$ gcc main.c -o main -shared \
	    `pkg-config --cflags --libs glib-2.0` -fPIC

Gir dosyamızın içeriği aşağıdaki gibidir.

.. code-block:: xml

	<?xml version="1.0"?>
	<!-- hello-1.0.gir generated by valac 0.56.7, do not modify. -->
	<repository version="1.2" ...>
	<package name="hello"/>
	<c:include name="libhello.h"/>
	<namespace name="hello" version="1.0" c:prefix="hello" c:identifier-prefixes="hello" c:symbol-prefixes="hello">
		<function name="print" c:identifier="hello_print">
			<return-value transfer-ownership="full">
				<type name="none" c:type="void"/>
			</return-value>
		</function>
	</namespace>
	</repository>

Burada yazdığımız nameplace alanına ait fonksiyonları ve sınıfları parametreleri ile birlikte listeleyen şablonumuz oluşmuş oldu.
Şimdi bu şablondan typelib dosyası oluşturalım.

.. code-block:: shell

	$ g-id-compiler hello-1.0.gir --shared-library=libhello --output=hello-1.0.typelib

Son olarak dosyaları sistemimize kuralım.

.. code-block:: shell

	$ install libhello.so /usr/lib/
	$ install hello-1.0.typelib /usr/share/girepository-1.0/

Bunun yerine aşağıdaki 2 çevresel değişkeni ayarlayarak test etmemiz mümkün dür.

	$ export GI_REPOSITORY_PATH=/home/user/gobject-ornek
	$ export LD_LIBRARY_PATH=/home/user/gobject-ornek

Şimdi yazdığımız kütüphaneyi python ile çalıştıralım. Bunun için aşağıdaki gibi bir python kodu yazabiliriz.

.. code-block:: python

	import gi
	gi.require_version('hello', '1.0')
	from gi.repository import hello
	hello.print()


