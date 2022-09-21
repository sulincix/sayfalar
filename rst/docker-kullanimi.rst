Docker kullanımı
================
Bu yazıda sizlere docker kullanımı anlatılacaktır.

Docker kurulumu
^^^^^^^^^^^^^^^
Docker kurmak için debian tabanlı dağıtımlarda **docker.io** paketini kurmalısınız.

.. code-block:: shell

	$ apt install docker.io --no-install-recommends

Eğer debian dışında bir dağıtım kullanıyorsanız kendi sitesi üzerinden indirmeyi veya kaynak koddan derlemeyi deneyebilirsiniz.

.. code-block:: shell

	# docker binarylerini indirmek için https://download.docker.com/linux/static/stable/
	# indirdikten sonra arşivden çıkatrıp containerd ve dockerd çalıştıralım. (root kullanarak)
	$ tar -xf docker-xxx.tgz
	$ cd docker
	$ export PATH=$PATH:$(pwd) # path içine mevcut dizini de ekledik
	# containerd ve dockerd çalıştıralım. Bunlar daemon olduğu için sürekli arkada çalışması gerekmektedir.
	$ containerd
	$ dockerd

Docker çalışıyor mu diye kontrol etmek için **docker info** komutunu kullanabiliriz.

.. code-block:: shell

	$ docker info

Docker root kullanıcısı ile çalıştığı için root kullanmadan docker çalışmayacaktır. Bunun için /run/docker.sock dosyamızın aitliğini bir guruba verip kullanıcıyı da o guruba alabiliriz.

.. code-block:: shell

	# Bu aşama docker gurubu mevcut olmayanlar için geçerlidir.
	$ groupadd docker
	$ chgrp docker /run/docker.sock # bu işlem her yeniden başlatmada gerekebilir.
	# Bu aşama tüm dağıtımlarda gereklidir.
	$ usermod -aG docker username # oturumu kapatıp açmak gerekebilir.

Docker çalışma mantığı
^^^^^^^^^^^^^^^^^^^^^^
Docker linux çekirdeği üzerinde oluşturulmuş **container** yapısı üzerinde çalışır. Her container kendisine özel ayrılmış alanda kısıtlı kaynaklar ile çalışır. Bu sayede herhangi bir performans kaybı olmadan ana sistemden bağımsız şekilde istenilen uygulamalar çalıştırılabilir.

Docker containerlarını üretmek için öncelikle imaj gerekmektedir. İmajlara **dockerhub** üzerinden ulaşabiliriz. Öncelikle imaj kurulur. daha sonra bu imajdan container türetilir. İş bittikten sonra container kolaylıkla yok edilebilir. Veya containerların imajı alınarak yeni imaja dönüştürülebilir.

.. code-block:: text

	kernel (linux)
	  |
	system (gentoo)
	  |
	docker ----------------
	  |       |    |     |
	alpine debian arch ubuntu


İmajlar
^^^^^^^
Docker imajı indirmek için **docker pull** komutu kullanılır. **name:tag** şeklinde belirtilir. eğer tag belirtilmemişse latest olarak değerlendirilir.

.. code-block:: shell

	$ docker pull alpine:latest

Mevcut imajları listelemek için **docker images** kullanılır.

.. code-block:: shell

	$ docker images
	REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
	debian       latest    43d28810c1b4   8 days ago    124MB
	alpine       latest    9c6f07244728   6 weeks ago   5.54MB

Burada dikkat edilmesi gereken konu her imajın bir **ID** değeri bulunmasıdır. İmajlar ile ilgili işlemler yapılırken imajın adı veya bu id değeri kullanılır.

İmaj silmek için **docker rmi** kullanılır.

.. code-block:: shell

	$ docker rmi alpine
	# veya şu da kullanılabilir.
	$ docker rmi 9c6f07244728

Containerlar
^^^^^^^^^^^^
Containerlar içerisinde uygulama çalıştırdığımız alanlardır. imajlardan türetilirler. bir container üretmek için **docker run** komutu kullanılır. Bu komut aldığı parametreler ile containerın özelliklerini ayarlar.

.. code-block:: shell

	#  docker run <seçenekler> <imajın idsi veya ismi> <çalıştırılacak komut>
	$ docker run -it -d -p 8000:80 -v /home/user/docker-share:/shared --name deneme 43d28810c1b4 /bin/bash
	# -i stdin okumasına izin verir
	# -d komutu arkada çalıştır
	# -t pseudo-tty olarak çalıştırır. -it olarak kullanıp shell çalıştırabiliriz.
	# -p port yönlendirmesi yapar. 
	# -v paylaşılan dizin belirlemeye yarar.
	# --name container ismi ayarlar. Belirtilmemişse rastgele bir isim alır.

Çalışan containerları listelemek için **docker ps** kullanılır. **-a** parametresi eklenirse tüm containerlar listelenir. **-q** parametresi ile sadece id değerleri yazdırılır.

.. code-block:: shell

	$ docker ps -a
	CONTAINER ID   IMAGE     COMMAND   CREATED          STATUS                     PORTS     NAMES
	e1e2983bfa34   debian    "bash"    8 seconds ago    Exited (0) 5 seconds ago             test
	b91e04ab5dcc   debian    "bash"    23 seconds ago   Up 22 seconds                        deneme

Çalışan bir containera bağlanmak için **docker attach** kullanılır.

.. code-block:: shell

	# ctrl-k kısayolu ile bağlantı kesilmesi için ek parametre ekleyelim.
	$ docker attach b91e04ab5dcc --detach-keys="ctrl-k"

Çalışan bir container **docker kill** kullanılarak kapatılabilir. kapatılmış bir container docker start kullanılarak tekrar başlatılabilir.

.. code-block:: shell

	$ docker kill b91e04ab5dcc
	$ docker ps -q | grep b91e04ab5dcc # çıktı boşsa container çalışmıyor demektir
	$ docker start b91e04ab5dcc

Container ile işimiz bittiğinde silmek için **docker rm** kullanılır. Silme işleminden önce kapatmamız gerekir. Eğer zorla kapatılmasını isterseniz **-f** parametresi ekleyebiliriz.

.. code-block:: shell

	$ docker rm b91e04ab5dcc 
	Error response from daemon: You cannot remove a running container ...
	$ docker rm -f b91e04ab5dcc
	# Aşağıdaki komutla tüm containerları silebiliriz.
	$ docker rm -f $(docker ps -a -q)

Çalışan containerlar ile ilgili kullanım istatistiklerine ulaşmak için **docker stats** kullanılır. **docker top** ise container içinde çalışan süreçler ile ilgili bilgi almaya yarar.

Container ile ilgili bilgi almak için **docker inspect** kullanılır.

.. code-block:: shell

	$ docker stats
	CONTAINER ID   NAME             CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O   PIDS
	40f84cb8e4e0   deneme2          0.00%     808KiB / 31.15GiB   0.00%     1.87kB / 0B   0B / 0B     1
	$ docker top 40f84cb8e4e0
	UID            PID              PPID      C                   STIME    TTY            TIME        CMD
	root           7432             7396      0                   10:42    pts/0          00:00:00    bash
	$ docker inspect 40f84cb8e4e0
	...
	  "Id": "40f84cb8e4e0...",
	  "Created": "2022-09-21T07:42:18.337126911Z",
	...

Çalışan bir container içerisinde bir komut çalıştırmak için **docker exec** kullanılır.

.. code-block:: shell

	$ docker exec -it 40f84cb8e4e0 /bin/bash

Containerları duraklatıp devam ettirmek için **docker pause** ve **docker unpause** kullanılır.

.. code-block:: shell

	$ docker pause 40f84cb8e4e0
	$ docker unpause 40f84cb8e4e0

Uzak sunucuda çalışmak
^^^^^^^^^^^^^^^^^^^^^^
**DOCKER_HOST** çevresel değişkenini ayarlayarak ssh üzerinden uzaktaki bir makinadaki container ve imajları yönetebilirsiniz.

.. code-block:: shell

	$ export DOCKER_HOST=ssh://user@server
	$ docker info

Bağlantı için ssh anahtarınızı sunucuya atmış olmanız gerekmektedir. Bunun için **ssh-copy-id** kullanabilirsiniz veya anahtarınızı **~/.ssh/authorized_keys** içerisine yazmalısınız.

.. code-block:: shell

	$ ssh-copy-id user@server
	user@server's password:

