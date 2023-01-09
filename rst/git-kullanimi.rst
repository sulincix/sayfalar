Git kullanımı
=============
Bu dokümanda sürüm kontrol sistemi olan git komutu nasıl kullanılır anlatılacakdır.

Git kurulumu
^^^^^^^^^^^^
git kurulumu debian tabanlı dağıtımlar için aşağıdaki komut kullanılarak kurulabilir.

.. code-block:: shell

	$ apt install git-core

Kaynak koddan derlemek için öncelikle git kaynak kodunu indirip bizine açalım.
Ardından aşağıdaki adımları uygulayarak derleyelim ve kuralım.

.. code-block:: shell

	./configure --prefix=/usr
	make
	make install

Git ne işe yarar
^^^^^^^^^^^^^^^^
Git yazdığımız kodların sürüm takibini yapmamızı sağlayan bir araçtır.
Bu sayede kod yazarken önceki değişiklikleri kaybetmeden düzenli bir şekilde kodda yaptığımız değişiklikleri görebilir ve ihtiyaç duyulduğunda eski sürümlere dönülebilir.
Ayrıca git sayesinde yazdığımız kodu git sunucuları (github, gitlab vb) kullanarak paylaşmak mümkündür.

Git kullanarak kaynak kodun indirilmesi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Git kullanarak kaynak kodu bilgisayarımıza indirmek için `git clone` komutundan faydalanılır.
Bu komut git sunucusundan yapılan tüm değişiklikler ile beraber indirir.
Eğer belli miktarda değişiklikle indirmek isterseniz **--depth=** parametresi eklenmelidir.

.. code-block:: shell

	# sadece son değişikliği almak için --depth=1 eklendi.
	$ git clone https://gitlab.com/sulincix/sayfalar.git --depth=1

İndrilen kodun istediğiniz bir dizine indirilmesini istiyorsanız komutun sonuna istenilen konumu yazmanız gereklidir.

.. code-block:: shell

	$ git clone https://gitlab.com/sulincix/sayfalar.git ~/Belgeler/sayfalar

Eski değişiklikleri görmek ve eski sürüme dönmek
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`git log` komutunu kullanarak eski değişiklikleri görebilirsiniz. Bu yapılan değişiklikler **commit** olarak adlandırılır.
Yazının bundan sonraki kısmında **commit** sözcüğü kullanılacaktır.

Her commitin bir id değeri bulunur. Bu değer kullanılarak eski sürüme dönülebilir.

.. code-block:: shell

	$ git log
	-> commit a983f37db618a06a53adb593dd97aa0282775ef5 (HEAD -> master, origin/master, origin/HEAD)
	-> Author: aliriza <aliriza.keskin@pardus.org.tr>
	-> Date:   Mon Oct 10 08:31:30 2022 +0000
	-> 
	->     commit 2
	-> 
	-> commit 180a8bcaf81485958fded6a69c97d15161fd1b75
	-> Author: aliriza <aliriza.keskin@pardus.org.tr>
	-> Date:   Tue Sep 27 10:11:12 2022 +0000
	-> 
	->     commit 1
	...

Burada eski sürüme dönmek için `git reset <commit-id>` komutu kullanılır.
Bu komut kodda yapılan değişiklikleri silmeyip git içerisinde eski sürüme dönmeyi sağlar.
Eğer git üzerinde yaptığınız değişiklikleri de geri almak isterseniz `--hard` parametresini kullanabilirsiniz.
Bu parametre tehlikelidir çünkü yazdığınız kodu geri dönülemez şekilde siler.

Ayrıca commit id yerine `HEAD~n` kullanarak **n** sayıda önceki commite geri dönebilirsiniz.

.. code-block:: shell

	# belirtilen commit-id değerine göre eski sürüme dönmek için (hard reset)
	$ git reset 180a8bcaf81485958fded6a69c97d15161fd1b75 --hard
	# belirtilen sayıda eski sürüme dönmek için (reset)
	$ git reset HEAD~2


Sunucudaki güncel değişiklikleri almak
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sunucudaki değişiklikleri `git pull` komutu ile alabiliriz.
Bu komut sunucu tarafında yapılan değişiklikleri yereldeki git deposuna ekleyecektir.

.. code-block:: shell

	$ git pull

Yeni commit oluşturma
^^^^^^^^^^^^^^^^^^^^^
Kaynak kodda yaptığımız değişiklikleri yeni bir commit olarak oluşturmak için `git commit` komutu kullanılır.
Bunun için öncelikle hangi dosyaları değiştirdiysek `git add` komutu ile belirtemiz gerekir.
Daha sonra `git checkout` komutu ile yapılan değişikliklerin düzgün bir şekilde algılandığından emin olunur.
Son olarak `git commit` komutu ile yeni commit oluşturulur.

git commit komutu doğrudan çalıştırıldığında metin düzenleyici ile commit mesajı düzenleme ekranı çalıştırılır.
Eğer bu ekranı kullanmak yerine parametre ile belirtmek istereniz **-m** parametresi eklemelisiniz.

.. code-block:: shell

	$ git add rst/git-kullanimi.rst
	$ git checkout
	-> M	rst/git-kullanimi.rst
	$ git commit -m "commit mesajı"

commit mesajı düzenleyici **EDITOR** çevreler değişkeni ile belirlenir. Genellikle varsayılan olarak vim kullanılır.
Bunu değiştirmek için **~/.bashrc** içerisinde aşağıdaki gibi tanımlama yapabilirsiniz.

.. code-block:: shell

	export EDITOR=nano

Commit mesajını değiştirmek için `git commit --amend` komutunu kullanabilirsiniz. 

Yeni commit oluşturduktan sonra **HEAD** ve **origin** artık aynı committe olmayacaktır. 
Burada HEAD sizin yerel olarak bulundurduğunuz halini origin ise git sunucusundaki halini gösterir.

.. code-block:: shell

	$ git log
	-> commit 03d5176f5e5b46e43dd688fd7b884a58e60afcd4 (HEAD -> master)
	-> Author: aliriza <aliriza.keskin@pardus.org.tr>
	-> Date:   Mon Jan 9 11:09:02 2023 +0300
	-> 
	->     commit 2
	-> 
	-> commit 913d993457d7b07e81746088fbc7cf6aaf9bc01a (origin/master, origin/HEAD)
	-> Author: aliriza <aliriza.keskin@pardus.org.tr>
	-> Date:   Tue Dec 27 16:44:49 2022 +0300
	-> 
	->     commit 1

Git sunucusuna gönderme
^^^^^^^^^^^^^^^^^^^^^^^
Yaptığımız değişiklikleri git sunucusuna göndermek için `git push` komutu kullanılır.
Sunucu sizden kullanıcı adı ve parola ile doğrulama isteyebilir.
Sunucuya ssh anahtarı eklediyseniz ve ssh üzerinden kullanıyorsanız genellikle doğrulama yapılırken parolaya gerek duyulmaz.

**Not:** github 13 Ağustos 2021 tarihinde https üzerinden commit göndermeyi engellemeye başladı.
Parolanız yerine githubdan sağlayacağınız token değerini girmeniz gerekmektedir.
Github kullanıyorsanız ssh anahtarı ile kullanmanızı öneririm.

.. code-block:: shell

	$ git push
	-> Username for 'https://gitlab.com': sulincix
	-> Password for 'https://sulincix@gitlab.com': 
	-> Enumerating objects: 3, done.
	-> Counting objects: 100% (3/3), done.
	-> Writing objects: 100% (3/3), 205 bytes | 205.00 KiB/s, done.
	-> Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
	-> remote: . Processing 1 references
	-> remote: Processed 1 references in total
	-> To https://gitlab.com/sulincix/git-dersi.git
	->    1ac2e12..2742a1f  master -> master

Eğer sunucusunda daha önceden yaptığınız değişiklikler varsa ve sizin yaptığınız değişiklikler ile çakışıyorsa `git push` komutu hata verecektir.
Bu duruma **conflict** adı verilir. Conflict çözmek için öncelikle **git pull --rebase** komutu kullanılır.

.. code-block:: shell

	git push
	-> Username for ...
	-> Password for ...
	-> To https://gitlab.com/sulincix/git-dersi.git
	->  ! [rejected]        master -> master (fetch first)

Yukarıdaki örnekde `git push` komutunu sunucudaki değişiklikleri almadan çalıştırdığımız için bize önce `git pull` komutu kullanarak değişiklikleri almamız söyleniyor.

.. code-block:: shell

	$ git pull --rebase
	...
	-> From https://gitlab.com/sulincix/git-dersi.git
	->    61e3643..e2fe24f  master     -> origin/master
	-> Auto-merging commit 3
	-> CONFLICT (add/add): Merge conflict in commit 3
	-> error: could not apply abaf641... commit 3
	...

Conflict durumunda **rebase** moduna geçilir. Bu modda çakışan dosyalarda hangisinin seçileceğine karar verilir. 
Çakışan dosyalar aşağıdaki gibi hal alır. Burada çakışma giderildikten sonra yeni bir commit oluşturmanız gerekmektedir.

.. code-block: python

	...
	<<<<<<< HEAD
	print("hello world")
	=======
	print("hi world")
	>>>>>>> abaf641 (aaa)
	...

Burada iki değişiklikten hangisinin kalması isteniyorsa o tutulur diğerleri silinir.
Daha sonrasında yeni commit oluşturulur Yukarıdaki örnekte son hali aşağıdaki gibi olmalıdır.

.. code-block: python 

  ...
	print("hello world")
	...

Çakışma giderildikten sonra yeni commit oluşturup gönderebiliriz.

.. code-block:: shell

	$ git add main.py
	$ git commit -m "Çakışma giderildi"

Çakışma giderildikten sonra rebase durumundan çıkmak için `git rebase --continue` komutu kullanılır.

.. code-block: shell

	$ git rebase --continue
	-> Successfully rebased and updated refs/heads/master.

Ardından git push komutu ile sunucuya gönderilir.

.. code-block: shell

	$ git push
	-> To https://gitlab.com/sulincix/git-dersi.git
	->    e2fe24f..19361f6  master -> master

Eğer rebase yapmaktan vazgeçmek istiyorsanız `git rebase --abort` kullanmanız gerekir. Bu sayede rebase işleminden çıkılır.

.. code/block:: shell

	$ git rebase --abort

Eğer sunucuya değişiklikleri zorla göndermek için **--force** parametresi kullanılır.
Bu işlem sunucudaki değişiklikleri silip yerine yereldeki değişikliklerin atılmasını sağlar.

**Not:** Bu işlem sonucunda sunucuda bulunan değişiklikler silindiği için tehlikelidir. **Daha önemlisi arkadaşlarınız size küfür edebilir :D**
Mümkünse hiç force push yapmayın.



Branch kavramı
^^^^^^^^^^^^^^
Git üzerinde birden çok dal ile çalışmak mümkündür. Bu dallar **branch** sözcüğü ile ifade edilir.
Bu sadece koda yeri bir özelliği geliştirirken farklı bir dal kullanıp kodun stabil çalışan halini kullancak kişiler için korumanız mümkündür.

Mecut branchları görüntülemek için `git branch` komutu kullanılır. Varsayılan branch adımız genellikle **master** olarak tanımlıdır.

.. code-block:: shell

	$ git branch
	-> * master

Yeni bir branch oluşturmak için `git branch <dal-adı>` komutu kullanılır.

.. code-block:: shell

	# yeni branch oluşturalım
	$ git branch development
	# branch listeleyelim
	$ git branch
	->   development
	-> * master

Yukarıdaki örnekte mevcut bulunduğumuz branch başında * işareti bulunmaktadır.
Bulunduğumuz branchı değiştirmek için `git switch <dal-adı>` komutu kullanılır.

.. code-block:: shell

	$ git switch development
	-> Switched to branch 'development'
	$ git branch
	-> * development
	->   master

Dallarda yapılan değişiklikleri birleştirmek için `git merge <dal1> <dal2>` komutu kullanılır.

.. code-block:: shell

	$ git merge development master

Sunucuya değişikliklerimizi istenilen dalda göndermek için `git push <remote-adı> <dal-adı>` kullanılır.

.. code-block:: shell

	# master branchına geçelim
	$ git switch master
	# development branchını sunucuya yollayalım.
	$ git push origin development

Branch silmek için `git branch -d <dal-adı>` komutunu kullanabilirsiniz. Bulunduğunuz dalı silemezsiniz. ( Bindiğiniz dalı kesemediğiniz gibi:D )

.. code-block:: shell

	# önce diğer brancha geçelim
	$ git switch master
	# development branchını silelim
	$ git branch -d development


Bir branchı yeniden adlandırmak için `git branch --move <eski-ad> <yeni-ad>` komutu kullanılır.

.. code-block:: shell

	# bir branch oluşturalım.
	$ git branch dev
	# yeniden adlandıralım.
	$ git branch --move dev development

Remote kavramı
^^^^^^^^^^^^^^
Git üzerinde birden çok sunucu tanımlanabilir ve bunlardan istenilene veri alınıp verilebilir. Bu sunucular **remote** sözcüğü ile ifade edilir.

Mevcut remote listesi için `git remote` komutu kullanılır. varsayılan remote adı genellikle **origin** olarak tanımlanır.

.. code-block:: shell

	$ git remote
	-> origin

Bir remotenin hangi adreste olduğunu öğrenmek için `git remote get-url <remote-adı>` komutu kullanılır.

.. code-block:: shell

	$ git remote get-url origin
	-> https://gitlab.com/sulincix/sayfalar.git

Remotenin adresini değiştirmek için ise `git remote set-url <remote-adı> <yeni-adres>` kullanılır.

.. code-block:: shell

	$ git remote set-url origin https://gitlab.com/sulincix/git-dersi.git

Yeni bir remote eklemek için ise `git remote add <remote-adı> <adres>` kullanılır.

.. code-block:: shell

	$ git remote add github https://github.com/sulincix/sayfalar.git
	$ git remote
	-> origin
	-> github

Remote üzerinden değişiklikleri alıp vermek için `git pull <remote-adı>` ve `git push <remote-adı>` kullanılır.

.. code-block:: shell

	# Değişiklikleri alalım
	$ git pull github
	# diğer remote üzerine gönderelim.
	$ git push origin

Bir remoteyi silmek için `git remote remove <remote-adı>` komutu kullanılır.
Yeniden adlandırmak için ise `git remote rename <eski-ad> <yeni-ad>` komutu kullanılır.

.. code-block:: shell

	# yeniden adlandıralım.
	$ git remote rename github git
	# remote silelim
	$ git remote remove git


Squash commit kavramı
^^^^^^^^^^^^^^^^^^^^^
Bazen git üzerinde farklı bir branch üzerinde geliştirme yaparken çok fazla miktarda commit ürettiğinizde bunları ana branch üzerine birleştirirken birsürü committen oluşması yerine tek bir commit haline getirmek isteyebilirsiniz.
Bu gibi durumlarda commitleri birleştirerek **squash commit** elde edebilirsiniz. Bunun için rebase module geçmemiz gerekmektedir.

İlk olarak `git rebase -i <commit-id>` komutu ile rebase moduna geçelim. burada **-i** parametresi commitleri birleştirmemiz için metin düzenleyicimizde bir ekran açacaktır.

.. code-block:: shell

	# rebase moduna geçelim.
	$ git rebase -i HEAD~5
	# metin düzenleyicimizde aşağıdaki gibi metin bulunur.
	pick aa34d35 commit 5
	pick 879917e commit 4
	pick 864dc97 commit 3
	...

Yukarıdaki örnekte **pick** ile belirtilen commitleri **squash** olarak değiştirirseniz commit bir önceki commit ile birleştirilmiş olur.
Diğer komutlar düzenleyicide altta açıklama satırı olarak yer almaktadır.

Düzenleyicide kaydedip çıktıktan sonra bu sefer commit mesajı ekranı ile karşılaşırız. Burada birleştirilmiş commit mesajını yazıp kaydettikten sonra commitler birleştirilmiş olur.