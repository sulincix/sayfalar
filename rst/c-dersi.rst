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

* **int main** kısmında  int döndürülecek derer türü main adıdır.
* **int argc** parametre sayısını belirtir.
* **char **argv** parametre listesini belirtir.
* **return 0** komutu 0 ile çıkış yapar.

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

Bununla birlikte **#define** kullanarak derlemeden önce koddaki alanların karşiliği ile değiştirlmasini sağlayabilirsiniz.
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
Döngüler koşullara benzer fakat döngülerde koşula sağlanmayana kadar block içi tekrarlanır.
Döngü oluşturmak için **while** kıllanılır.

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

