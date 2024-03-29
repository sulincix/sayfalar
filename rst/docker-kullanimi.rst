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

Rootless docker kurmak için

.. code-block:: shell

	$ curl -fsSL https://get.docker.com/rootless | bash


Docker çalışıyor mu diye kontrol etmek için **docker info** komutunu kullanabiliriz.

.. code-block:: shell

	$ docker info

Rootless olmayan docker root kullanıcısı ile çalıştığı için root kullanmadan docker çalışmayacaktır. Bunun için /run/docker.sock dosyamızın aitliğini bir guruba verip kullanıcıyı da o guruba alabiliriz. Bu işlem güvenlik sorunlarına sebep olabilir. Detaylı bilgi için: https://docs.docker.com/engine/security/#docker-daemon-attack-surface

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

İmajımızı bir dosyaya kaydetmek için **docker save** kullanırız.

.. code-block:: shell

	$ docker save debian:latest -o /home/backup/debian.tar

kaydedilmiş bir dosyadan imaj yüklemek için ise **docker load** kullanılız.

.. code-block:: shell

	$ docker load -i /home/backup/debian.tar

tarball dosyasından docker imajı oluşturmak için **docker import** kullanabiliriz.

.. code-block:: shell

	$ docker import rootfs.tar custom:new
	# veya bir dizinden üretebiliriz
	$ tar -c -C rootfs . | docker import - custom:new2

Docker imajını tarball olarak çıkartmak için ise **docker export** kullanabiliriz.

.. code-block:: shell

	$ docker export debian:stable > /home/user/debian-stable.tar
	# veya şu şekilde de kullanılabilir
	$ docker export -o /home/user/debian-stable.tar debian:stable

Containerlar
^^^^^^^^^^^^
Containerlar içerisinde uygulama çalıştırdığımız alanlardır. imajlardan türetilirler. bir container üretmek için **docker run** komutu kullanılır. Bu komut aldığı parametreler ile containerın özelliklerini ayarlar.

.. code-block:: shell

	#  docker run <seçenekler> <imajın idsi veya ismi> <çalıştırılacak komut>
	$ docker run -it -d -p 8000:80 --name deneme 43d28810c1b4 /bin/bash
	# -i stdin okumasına izin verir
	# -d komutu arkada çalıştır
	# -t pseudo-tty olarak çalıştırır. -it olarak kullanıp shell çalıştırabiliriz.
	# -p port yönlendirmesi yapar. 
	# --name container ismi ayarlar. Belirtilmemişse rastgele bir isim alır.

Eğer container çalıştıktan sonra silinmesini istiyorsanız **--rm** parametresi ekleyebiliriz. Bu sayede işlem bitimi otomatik olarak silinir.

.. code-block:: shell

	$ docker run --rm alpine echo hello world

İşlem başlatmayıp sadece container oluşturmak istiyorsanız **docker create** kullanabilirsiniz.

.. code-block:: shell

	$ docker create --name deneme2 debian
	
Container oluştururkenki seçenekler için **docker run --help** veya **docker create --help** yapabilirsiniz.

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

Çalışmayan tüm containerların silinmesi için **docker container prune** kullanılabilir.

.. code-block:: shell

	$ docker container prune
	WARNING! This will remove all stopped containers.
	Are you sure you want to continue? [y/N] y
	Total reclaimed space: 0B

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

Mevcut containerdan imaj elde etmek için **docker commit** kullanabiliriz.

.. code-block:: shell

	$ docker commit 40f84cb8e4e0 builder:1.0

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

Volume kavramı
^^^^^^^^^^^^^^
Docker üzerinde birden çok container ile çalıştığımızı farz edelim. Bu containerlar birbirleri ile dosya alışverişi yapmak isteyebilirler. Örneğin bir tanesi web server olarak çalışırken diğeri web serverda bulunan dosyaları farklı bir amaç için kullanabilir.

Bu gibi durumlar için **volume** bulunur. Volume container tarafından kullanılabilen depolama alanlarıdır. Volume oluşturmak için **docker volume create** kullanılır.

**Volume** diskte **/var/lib/docker/volumes/** içerisinde depolanır.

.. code-block:: shell

	$ docker volume create data

Var olan **volume** listesi için **docker volume ls** kullanılır.

.. code-block:: shell

	$ docker volume ls
	DRIVER    VOLUME NAME
	local     data


Bir **volume** silmek için **docker volume rm** kullanılır. Silmeden önce bu alanı kullanan containerları kapatmalısınız.

.. code-block:: shell

	$ docker volume rm data

Bir container başlatılırken ona volume eklemek için **--mount** parametresi eklenir.

.. code-block:: shell

	$ docker run -d --name webserver --mount source=data,target=/var/www/http/ nginx:latest

Bağlanacak dizine yazılmasını istemiyorsak **readonly** eklemeliyiz.

.. code-block:: shell

	docker run --mount source=data,target=/app,readonly test321 alpine

Container içine bir dizine tmpfs bağlamak için **type** belirtilir.

.. code-block:: shell

	$ docker run --mount type=tmpfs,target=/app/temp/ --name apptest debian
	# Şu şekilde de kullanılabilir.
	$ docker run --tmpfs /app/temp/ --name apptest debian

Ayrıca volume yerine ana sistemdeki bir dizini de bağlayabiliriz.

.. code-block:: shell

	docker run --mount type=bind,source=/home/shared,target=/shared --name test123 alpine

Dizinleri aşağıdaki gibi de bağlayabiliriz.

.. code-block:: shell

	# yazılmasını istemiyorsanız ro istiyorsanız rw
	# Hiçbir şey eklemezseniz rw kabul edilir.
	docker run -v /mnt:/mnt:ro -v /shared:/shared:rw test456 alpine

Dockerfile
^^^^^^^^^^
**Dockerfile** docker kullanarak belli işleri gerçekleştirmeye yarayan bir talimat dosyasıdır. Bu talimatların sonucunda yeni bir imaj dosyası oluşturulur. Örneğin aşağıda bir Dockerfile dosyası verilmiştir.

.. code-block:: shell

	FROM alpine
	RUN echo hello world

Bir Dockerfile dosyası aşağıdaki gibi çalıştırılır.

.. code-block:: shell

	$ docker build -f ./builder/Dockerfile ./

Burada **-f** parametresi dosyadan oku anlamına gelir. **./** ise çalışma dizinini belirtir. Eğer **-f** verilmemişse çalışma dizininde dockerfile dosyası aranır.

Ayrıca doğrudan git üzerinden de çalıştırılabilir.

.. code-block:: shell

	$ docker build git://gitserver.com/username/repository.git

Veya bir tarball indirilerek istenen dockerfile ile çalıştırılması sağlanabilir.

.. code-block:: shell

	$ docker build -f builder/Dockerfile https://example.org/source.tar.gz

**stdin** okunarak çalıştırılabilir.

.. code-block:: shell

	$ cat Dockerfile | docker build -

Dockerfile yapısı
^^^^^^^^^^^^^^^^^
Dockerfile dosyaları komutlar yardımı ile çalışır. Aşağıda komut ve kullanım şekli belirtilmiştir.

.. code-block:: yaml

	FROM <imaj| scratch>    : hedef imajı kullan veya boş imajla başla
	COPY <src> <trgt>       : Çalışma dizinindeki dosyayı kopyalar.
	ADD <src> <trgt>        : COPY ile benzerdir fakat arşivleri açarak kopyalar.
	RUN <command>           : Komut çalıştırır.
	USER <name>             : varsayılan kullanıcı adı belirler
	WORKDIR <dir>           : Container içindeki çalışma dizinini belirler.
	CMD <command>           : Varsayılan çalıştırılacak olan komutu belirler.
	ENV <name> <value>      : Çevresel değişken belirler.
	LABEL <key=value>       : Metadata tanımlamak için kullanılır.
	EXPOSE <port/protocol>  : Port açmak için kullanılır. protocol kısmı tcp veya udp olabilir.
	ARG <name=value>        : ENV ile benzerdir fakat sadece imaj oluşturulurken kullanılabilir.

Örneğin aşağıda bir dockerfile dosyası ile kaynak kod derleyelim.

.. code-block:: yaml

	FROM alpine
	RUN apk add --no-cache build-base
	ADD bash-5.0.tar.gz /build
	WORKDIR /build/bash-5.0
	RUN ./configure --prefix=/usr
	RUN make
	RUN make install

Şimdi bu dosyayı derleme yapmak için kullanalım. Burada **-t** yeni oluşacak imaja isim tag eklemek için kullanılır.

.. code-block:: shell

	$ wget https://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
	$ docker build -t build-bash:5.0 .

