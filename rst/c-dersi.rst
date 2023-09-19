C Dersi
=======
Bu derste C programlama dersi anlatılacaktır.
Bu dersin düzgünce anlaşılabilmesi için temel düzey gnu/linux bilmeniz gerekmektedir.

Derleme işlemi
^^^^^^^^^^^^^^

**C** derlemeli bir programlama dilidir.
Yani yazılan kodun derleneek bilgisayarın anlayacağı hale getirilmesi gerekmektedir.
Derleme işlemini **gcc** veya **clang** kullanarak yapabiliriz.

.. code-block:: shell

	# koddan .o dosyası üretelim
	$ gcc -c main.c
	# .o dosyasından derlenmiş dosya üretelim.
	$ gcc -o main main.o
	# kodu çalıştıralım
	$ ./main
	-> Hello World

Yukarıdaki örnekte öncelikle **.o** uzantılı object dosyamızı ürettik.
Bu dosya kodun derlenmiş fakat henüz kullanıma hazır hale getirilmemiş halidir.
Bu sebeple **.o** dosyalarını linkleme işleminden geçirerek son halini almasını sağlamalıyız.

**Not:** derleyicimiz **.o** üretmeden de doğrudan derleme yapabilir.

.. code-block:: shell

	$ gcc -o main main.c

Açıklama satırı
^^^^^^^^^^^^^^^
C kodlarında 3 farklı yolla girintileme yapılabilir.

1. **//** kullanarak satırın geri kalanını açıklama satırı yapabiliriz.

.. code-block:: C

	// bu bir açıklama satırıdır.

2. **/*** ile başlayıp ***/** ile biten alanlar açıklamadır.

.. code-block:: C

	/* Bu
	   bir
	   açıklama
	   satırıdır */

3. **#if 0** ile başlayan satırdan **#endif** satırına kadar olan kısım açıklama satırıdır.

.. code-block:: C

	#if 0
	bu bir
	açıklama
	satırıdır
	#endif

Girintileme
^^^^^^^^^^^
C programlama dilinde blocklar **{}** karakterleri ile belirtilir.
Kodun okunalı olması için girintilenmesi gereklidir fakat şart değildir.
Girintileme için 4 boşluk veya 1 tab kullanabilirsiniz.

Bir block aşağdaki gibi bir yapıya sahiptir.

.. code-block:: C

	aaaa (bbbb) {
		cccc;
	  ddd;
	}

**Not:** Her satırın sonunda ; işareti bulunmalıdır.

İlk program
^^^^^^^^^^^
C programları çalıştırıldığında **main** fonsiyonu çalıştırılır.
Aşağıda örnek main fonksiyonu bulunmaktadır.

.. code-block:: C

	int main(int argc, char** argv) {
	    return 0;
	}

* **int main** kısmında  int döndürülecek değer türü main adıdır.
* **int argc** parametre sayısını belirtir.
* **char **argv** parametre listesini belirtir.
* **return 0** komutu 0 ile çıkış yapar.

Burada **main** fonksiyonunu türünün bir önemi yoktur. **void** olarak da tanımlanabilir. Ayrıca kullanmayacaksak arguman tanımlamaya da gerek yoktur. Kısaca Şu şekilde de yazabilirdik.

.. code-block:: C

	void main(){}


Ekrana yazı yazma
^^^^^^^^^^^^^^^^^
Öncelikle **stdio.h** kütüphanesine ihtiyacimiz olduğu için onu eklemeliyiz.
Ardından **printf** fonksiyonu ile ekrana yazı yazabiliriz.

**printf** fonksiyonunun 1. parametresi yazdirma şablonunu diğerleri ise yazdırılacak verileri belirtir.

.. code-block:: C

	#include <stdio.h>

	int main(int argc, char** argv) {
	    printf("%s\n", "Merhaba Dünya!");
	    return 0;
	}

* **include** ile belirttiğimiz dosyalar sistemde **/usr/include** içerisinde bulunur.
* **printf** fonksiyonundaki **%s** yazılar için, **%c** karakterler için, **%d** sayılar için kullanılır.

Değişkenler
^^^^^^^^^^^
C dilinde değişkenler aşağıdaki gibi tanımlanır.

.. code-block:: C

	...
	int sayi = 12;
	char* yazi = "test";
	char karakter = 'c';
	float sayi2 = 12.42;
	...

Bununla birlikte **#define** kullanarak derlemeden önce koddaki alanların karşılığı ile değiştirilmesini sağlayabilirsiniz.
Bu şekilde tanımlanan değerler derlemeden önce yerine yazıldığı için değişken olarak işlem görmezler.

.. code-block:: C

	#define sayi 12
	...
	printf("%d\n",sayi);
	...

Diziler
^^^^^^^
Diziler iki şekilde tanımlanabilir.

1. Pointer kullanarak tanımlanabilir. Bu konunun detaylarına ilerleyen kısımda değinilecektir.
Bu şekilde tanımlanan dizilerde başta uzunluk belirtilmek zorunda değildir.

.. code-block:: C

	int *dizi = {12, 22, 31};


2. Uzunluk belirterek tanımlanabilir. Bu şekilde tanımlanan dizilerin uzunluğu sabittir.

.. code-block:: C

	int dizi[3] = {12, 22, 31};

C dilinde string kavramı bulunmaz. Onun yerine karakter dizileri kullanılır.

.. code-block:: C

	char *txt = "deneme123";

Dizinin bir elemanına erişmek için aşağıdaki gibi bir yol kullanılır.

.. code-block:: C

	int *dizi = {12, 22, 31};
	int c = dizi[1]; // dizinin 2. elemanı

**Not:** Dizi indisleri 0dan başlar.

Bir dizinin uzunluğunu dizinin bellekteki boyutunu birim boyutuna bölerek buluruz.
Bunun  için **sizeof** fonksiyonu kullanılır.

.. code-block:: C

	int *dizi = {11, 22, 31};
	int l = sizeof(dizi) / sizeof(int);

Klavyeden değer alma
^^^^^^^^^^^^^^^^^^^^
Klavyeden değer almak için **scanf** kullanılır. İlk parameter şablonu diğerleri ise değişkenlerin bellek adresini belirtir.

.. code-block:: C

	int sayi;
	scanf("%d\n", &sayi);

**Not:** Bu şekilde değer alma yaptığımızda formata uygun olmayan şekilde değer girilebilir.
Eğer böyle bir durum oluşursa değişken **NULL** olarak atanır. yani değeri bulunmaz.
Buda kodun işleyişinde soruna yol açabilir. Bu yüzden değişkeni kullanmadan ince **NULL** olup olmadığını kontrol etmelisiniz.

Koşullar
^^^^^^^^
Koşullar için **if** bloğu kullanılır. Block içindeki ifade **0** veya **NULL** olursa koşul sağlanmaz. Bu durumda varse **else** bloğu çalıştırılır.

.. code-block:: C

	if (koşul1) {
	    block 1
	} else if (koşul2) {
	  block 2
	} else {
	  block 3
	}

Örnek olarak girilen sayının çift olup olmadığını yazan uygulama yazalım.

.. code-block:: C

	#include <stdio.h>

	int main(int argc, char** argv) {
	    int sayi;
	    scanf("%d",&sayi);
	    if (sayi == NULL) {
	        printf("%s\n", "Geçersiz sayı girdiniz.");
	    } else if(sayi % 2) {
	        printf("%d tektir.\n", sayi);
	    } else {
	        printf("%d çifttir.\n", sayi);
	    }
	    return 0;
	}

Burada **%** operatörü 2 ile bölümden kalanı bulmaya yarar.
Sayı tek ise 1 değilse 0 sonucu elde edilir.
Bu sayede tek sayılar için koşul sağlanır çift sayılar için sağlanmaz.

Tek satırdan oluşan koşullarda **{}** kullanmaya gerek yoktur.

.. code-block:: C

	if (i < 32)
	  printf("%s\n","32den küçüktür");

Koşul ifadeleri aşağıdaki gibi listelenebilir.

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

Switch - Case
^^^^^^^^^^^^^
Bir sayıya karşılık bir işlem yapmak için **switch - case** yapısı kullanılır.

.. code-block:: C

	switch(sayi) {
	  1:
	    // sayı 1se burası çalışır.
	    // break olmadığı için alttan devam eder.
	  2:
	    // sayı 1 veya 2 ise burası çalışır.
	    break;
	  3:
	    // sayı 3 ise burası çalışır.  
	  default:
	    // sayı eşleşmezse burası çalışır.
  }



Döngüler
^^^^^^^^
Döngüler koşullara benzer fakat döngülerde koşul sağlanmayana kadar block içi tekrarlanır.
Döngü oluşturmak için **while** kullanılır.

.. code-block:: C

	int i=10;
	while(i<0){
	    printf("%d\n", i);
	    i--;
	}

Yukarıdaki örnekte 10dan 0a kadar geri sayan örnek verilmiştir.
En son i değişkeni 0 olduğunda koşul sağlanmadığı için döngü sonlanır.

Aynı işlemi **for** ifadesi ile de yapabiliriz.

.. code-block:: C

	for(int i=10;i<0;i--){
	    printf("%d\n", i);	    
	}

Burada for içerisinde 3 bölüm bulunur.
İlkinde değer atanır.
İkincinde koşul yer alır.
Üçüncüsünde değişkene yapılacak işlem belirtilir.

goto
^^^^
C dilinde kodun içerisindeki bir yere etiket tanımlanıp **goto** ile bu etikete gidilebilir.

.. code-block:: C

	yaz:
	printf("%s\n", "Hello World");
	goto yaz;

Yukarıdaki örnekte sürekli olarak yazı yazdırılır. Bunun sebebi her seferinde **yaz** etiketine gidilmesidir.

Bundan faydalanarak döngü oluşturulabilir.

.. code-block:: C

	int i = 10;
	islem:
	if(i < 0){
	    printf("%d\n",i);
	    i--;
	    goto islem;
	}

Burada koşul bloğunun en sonunda tekrar başa dönmesi için **goto** kullandık.

Fonksiyonlar
^^^^^^^^^^^^
C dilinde bir fonksiyon aşağıdaki gibi tanımlanır.

.. code-block:: C

	int yazdir(char* yazi){
	    if(yazi != NULL){
	        printf("%s\n",yazi);
	        return 0;
	    }
	return 1;
	}

Yukarıdaki fonksiyon verilen değişken değere sahipse ekrana yazdırıp 0 döndürür.
Eğer değeri yoksa 1 döndürür.


Basit işlemler için **#define** ile de fonksiyon tanımlanabilir.
Bu şekilde tanımlanan fonksiyonlar derleme öncesi yerine yazılarak çalışır.

.. code-block:: C

	#define topla(A,B) A+B

	int main(int argc, char** argv){
	    int sayi = topla(3, 5);
	    return 0;
	}

Fonksiyonlar yazılma sırasına göre kullanılabilirler.
Bu yüzden fonksiyonlar henüz tanımlı değilse kullanılamazlar.
Bu durumun üstesinden gelmek için **header** tanımlaması yapılır.

.. code-block:: C

    void yaz();
    int main(){
        yaz();
        return 0;
    }
    void yaz(){
        printf("%s\n","Hello World");
    }

Header tanımlamaları kütüphane yazarken de kullanılır.
Bunun için bu tanımlamaları **.h** uzantılı dosyalara yazmanız gereklidir.
Bu dosyayı **include** kullanarak eklemeliyiz.

yaz.h dosyası

.. code-block:: C

	void yaz();

main.c dosyası

.. code-block:: C

	#include "yaz.h"
	#include <stdio.h>

	int main(){
	    yaz();
	    return 0;
	}

	void yaz(){
	    printf("%s\n","Hello World");
	}

**Not:** **include** ifadesinde **<>** içine aldığımız dosyalar **/usr/include** **"** içine aldığımız ise mevcut dizinde aranır.


Pointer ve Address kavramı
^^^^^^^^^^^^^^^^^^^^^^^^^^
Pointerlar bir değişkenin bellekte bulunduğu yeri belirtir. ve ***** işareti ile belirtir.
Örneğin aşağıda bir metin pointer olarak tanımlansın ve 2 birim kaydırılsın.

.. code-block:: C

	char* msg = "abcde";
	printf("%s\n", msg + sizeof(char)*2 );

Bura 2 char uzunluğu kadar pointer kaydırıldığı için ekrana ilk iki karakteri silinerek yazdırılmıştır.

Adres ise bir değişkenin bellek adresini ifade eder. **&** işareti ile belirtilir. Örneğin rastgele bir değişken oluşturup adresini ekrana yazalım.

.. code-block:: C

	int i = 0;
	printf("%p\n" &i);

Konunun daha iyi anlaşılması için bir değişken oluşturup adresini bir pointera kopyalayalım. ve sonra değişkenimizi değiştirelim.

.. code-block:: C

	int i = 0; // değişken tanımladık.
	int *k = &i; // adresini kopyaladık.
	int l = i; // değeri kopyaladık.
	i = 1; // değişkeni değiştirdik.
	printf("%d %d\n", i, *k, l);

Bu örnekte ilk iki değer de değişir fakat üçüncüsü değişmez.
Bunun sebebi ikinci be birinci değişkenlerin adresi aynıyken üçüncü değişkenin adresi farklıdır.

Bir fonksiyon tanımlarken pointer olarak arguman aldırıp bu değerde değişiklik yapabilir. Buna örnek kullanım olarak **scanf** fonksiyonu verilebilir.

.. code-block:: C

	#include <stdio.h>
	void topla(int* sonuc, int sayi1, int sayi2){
	    *sonuc = sayi1 + sayi2;
	}
	void main(){
	    int i;
	    topla(&i, 12, 22);
	    printf("%d\n",i);
	}

Burada fonksiyona değişkenin adresi girilir. Fonksiyon bu adrese toplamı yazar. Daha sonra değişkenimizi kullanabilirsiniz.


Fonksiyonun kendisini de pointer olarak kullanmak mümkündür. Bunun için aşağıdaki gibi bir yapı kullanılabilir.

.. code-block:: C

	int topla(int i, int j){
	    return i + j;
	}

	void main(){
	    int (*topla_func)(int, int) = topla;
	    topla_func(3, 5);
	}

Ayrıca **typedef** yapısı ile de fonksiyon pointerları oluşturulabilir.
Bu konunun detaylarına ilerleyen kısımlarda yer verilmiştir.

.. code-block:: C


	typedef int (*topla_func)(char*);
	int topla(int i, int j){
	    return i + j;
	}

	void main(){
	    topla_func topla_fn = topla;
	    topla_fn(3, 5);
	}



Dinamik bellek yönetimi
^^^^^^^^^^^^^^^^^^^^^^^
Dinamik bellek yönetimi için **malloc**, **realloc**, **calloc**, **free** fonksiyonları kullanılır.
Bu fonksiyonlar **stdlib.h** ile sağlanmaktadır.

**malloc** fonksiyonu belirtilen boyut kadar boş alanı **void*** olarak tahsis eder.

.. code-block:: C

	// 10 elemanlı sayı dizisi oluşturmak için.
	int *sayilar = (int*) malloc(10 * sizeof(int));
	// şununla aynı anlama gelir.
	int sayilar[10];

**calloc** fonksiyonu malloc ile benzerdir fakat istenen block boyutunu da belirterek kullanılır.

.. code-block:: C

	// 10 elemanlı sayı dizisi oluşturmak için
	int *sayilar = (int*) calloc(10, sizeof(int));
	// şununla aynı anlama gelir
	int *sayilar = (int*) malloc(10 * sizeof(int));

**realloc** bir değişkenin yeniden boyutlandırılmasını sağlar.

.. code-block:: C

	// 5 elemanlı dizi tanımlayalım.
	int sayilar[5];
	// boyutu 10 yapalım
	sayilar = (int*) realloc(sayilar, 10*sizeof(int));

**free** fonksiyonu değişkeni bellekten siler.

.. code-block:: C

	// malloc ile bir alan tanımlayalım.
	void* alan = malloc(100);
	// bu alanı silelim.
	free(alan);


Konunun daha iyi anlaşılması için 2 stringi toplayan fonksiyon yazalım.

.. code-block:: C

	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	char* add(char *s1, char *s2){
	    int ss = strlen(s1); // ilk arguman uzunluğu
	    int sx = strlen(s2); // ikinci arguman uzunluğu
	    char* s3 = (char*)malloc(ss+sx*sizeof(char)); // uzunluklar toplamı kadar alan ayır.
	    for(int i=0;s1[i];i++) // ilkinin tüm elemanlarını kopyala
	        s3[i] = s1[i];
	    for(int i=0;s2[i];i++) // ikincinin tüm elemanlarını kopyala
	        s3[i+ss] = s2[i];
	    s3[ss+sx]='\0'; // stringler '\0' ile sonlanır
	    return s3;
	}

	void main(){
	    char *new_str = add( "hello", "world");
	    printf("%s\n", new_str);
	}

Struct
^^^^^^
**Structure** yapıları bellekte belli bir değişken topluluğu oluşturup kullanabilmek için kullanılır.
Bu yapılar sayesinde kendi veri türlerinizi tanımlayabilirsiniz.

.. code-block:: C

	struct test {
	    int num;
	    char* name;
	};

	void main(){
	    struct test t1;
	    t1.num = 12;
	    t1.name = "hello";
	}


Veri türü adına alias tanımlamak için **typedef** kullanılabilir.
Bu sayede değişken tanımlar gibi tanımlama yapmak mümkündür.

.. code-block:: C

	typedef struct Test {
	    int num;
	    char* name;
	} test;

	void main(){
	    test t1;
	    t1.num = 12;
	    t1.name = "hello";
	}

**typedef** kullanarak struct dışında değişken türü tanımlamak da mümkündür.

.. code-block:: C

	typedef char* my_string;

	void main(){
	    my_string str = "Hello World";
	}


C programlama dili nesne yönelimli bir dil değildir.
Bu yüzden sınıf kavramı bulunmaz.
Fakat **struct** kullanarak benzer işler yapılabilir.
Bunun için fonksiyon pointeri tanımlayıp struct yapımıza ekleyelim. Bir init fonksiyonu kullanarak nesnemizi oluşturalım.

.. code-block:: C

	// nesne struct yapısı tanımladık
	typedef struct Test {
	    // nesne fonksiyonunu tanımladık.
	    void (*yazdir)(char*);
	    int num;
	} test;

	// nesne fonksiyon işlevin tanımladık
	void test_yazdir(char* msg){
	    printf("%s\n",msg);
	}

	// nesneyi oluşturan fonsiyonu tanımladık.
	test test_init(){
	    test t1;
	    t1.num = 12;
	    t1.yazdir = test_yazdir;
	    return t1;
	}

	void main(){
	    test obj = test_init();
	    obj.yazdir("Hello World");
	}
