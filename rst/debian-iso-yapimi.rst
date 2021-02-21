Iso yapımı
==========
Bu dokümanda **debian sid** kullanarak özelleşmiş bir **live** iso yapımı anlatılacaktır. debian **sid** yerine **stable** kullanmak isterseniz yapmanız gereken dokümanda **sid** yerine **stable** yazmaktır. 

  **Not: Biraz mizah içerir.** Şimdiden **ALLAH** sabır versin :D

========  ========
Temel kavramlar
------------------
Terim     Anlamı
========  ========
chroot         Oluşturulacak live isonun taslağıdır. içerisine **chroot sid-chroot** komutu ile içerisine girebiliriz. çıkmak için ise **exit** komutu kullanılmalıdır.
squashfs       Sıkıştırılmış haldeki kök dizin dosyasıdır. Oluşturulması donanıma bağlı olarak uzun sürmektedir. **Debian** tabanlı dağıtımlarda xz formatında sıkıştırma önerilir.
iso            Kurulum medyası dosyasıdır. Bu dosya son üründür ve bunu yayınlayabilirsiniz.
live           Kurulum yapmadan çalışan sisteme **live** adı verilir.
========  ========


Hazırlık
^^^^^^^^

1. Gerekli paketleri kuralım.

.. code-block:: shell

	☭ apt-get install debootstrap xorriso squashfs-tools
	
Chroot oluşturulması
^^^^^^^^^^^^^^^^^^^^
	
1. **Debootstrap** ile debian chroot ortamı oluşturalım.

.. code-block:: shell

	☭ mkdir sid-chroot
	☭ debootstrap --no-merged-usr sid sid-chroot https://deb.debian.org/debian

Eğer "Unpacking the base system..." sırasında sorun yaşıyorsanız **chroot** dizininin sahibini **root** olarak değiştirip tekrar denemenizi öneriririz.

.. code-block:: shell

	☭ chowm root sid-chroot

Chroot içine girmek için ön hazırlık
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **dev sys proc run** bind bağlayalım. Bu işlem her chroot ile **sid-chroot** içerisine girileceğinde yapılmalıdır. **sid-chroot** içerisinden çıkıldığında ise  bind bağının sökülmesi gerekmektedir. 

.. code-block:: shell

        ☭ for i in dev dev/pts proc sys; do mount -o bind /$i sid-chroot/$i; done

Gerekli paketlerin kurulması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Chroot komutu ile oluşan **chroot** içerisine girelim. ve ardından **sources.list** dosyasını düzenleyelim. Bu noktadan sonra chroot içerisinden devam edeceğiz.

.. code-block:: shell

	☭ chroot sid-chroot /bin/bash
	☭ echo 'deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list
	☭ apt-get update

2. Kernel kuralım.

.. code-block:: shell

	☭ apt-get install linux-headers-amd64 linux-image-amd64
	
3. Grub kuralım.

.. code-block:: shell

	☭ apt-get install grub-pc-bin grub-efi

4. Live açılış için gereken paketleri kuralım.

.. code-block:: shell

	☭ apt-get install live-config live-boot

Özelleştirme
^^^^^^^^^^^^

1. Dağıtım adını değiştirmek için **/etc/os-release** ve **/etc/lsb-release** dosyalarını düzenleyebilirsiniz.

* /etc/os-release

.. code-block:: shell
	
	PRETTY_NAME="Custom debian (sid)"
	NAME="CUSTOM"
	VERSION_ID="1"
	VERSION="1 (sid)"
	ID=customdebian
	ID_LIKE=debian
	HOME_URL="https://www.example.com/"
	SUPPORT_URL="https://forums.example.com/"
	BUG_REPORT_URL="https://example.com/issues/"
	PRIVACY_POLICY_URL="https://www.example.com/privacy/"
	VERSION_CODENAME=custom
	DEBIAN_CODENAME=sid

* /etc/lsb-release

.. code-block:: shell

	DISTRIB_ID=CustomDebian
	DISTRIB_RELEASE=1
	DISTRIB_CODENAME=sid
	DISTRIB_DESCRIPTION="Custom Debian sid"
	
	
2. Masaüstü ortamı kurabiliriz.

.. code-block:: shell

	☭ apt-get install xorg xinit
	☭ apt-get install lightdm # giriş ekranı olarak lightdm yerine istediğinizi kurabilirsiniz.

========     =====
Masaüstü     Komut
========     =====
xfce         apt-get install xfce4
lxde         apt-get install lxde
cinnamon     apt-get install cinnamon
plasma       apt-get install kde-standard
gnome        apt-get install gnome-core
mate         apt-get install mate-desktop-environment-core
========     =====

3. Kurulum aracı ekleyebiliz.

* Öncesinde git, make ve gettext paketini kuralım.

.. code-block:: shell

	☭ apt-get install git make gettext

.. code-block:: shell

	☭ git clone https://gitlab.com/ggggggggggggggggg/17g
	☭ cd 17g
	☭ make & make install
	☭ rm -rf 17g

4. Sürücüleri ekleyebiliz.

.. code-block:: shell

	☭ apt-get install firmware-amd-graphics firmware-atheros \
	    firmware-b43-installer firmware-b43legacy-installer \
	    firmware-bnx2 firmware-bnx2x firmware-brcm80211  \
	    firmware-cavium firmware-intel-sound firmware-intelwimax \
	    firmware-ipw2x00 firmware-ivtv firmware-iwlwifi \
	    firmware-libertas firmware-linux firmware-linux-free \
	    firmware-linux-nonfree firmware-misc-nonfree firmware-myricom \
	    firmware-netxen firmware-qlogic firmware-realtek firmware-samsung \
	    firmware-siano firmware-ti-connectivity firmware-zd1211 


5. Varsayılan kullanıcı ayarları yapmak için kullanıcı ev dizinine gelmesini istediğiniz dosyaları **/etc/skel** içerisine uygun hiyerarşiye göre dizmelisiniz.

Paketleme öncesi
^^^^^^^^^^^^^^^^
1.  Öncelikle chroot içerisinden çıkalım. ve ardından **bind** bağlarını kaldıralım.

.. code-block:: shell

	☭ umount -lf -R sid-chroot/* 2>/dev/null
	
Temizlik
^^^^^^^^
Squashfs yapmadan önce chroot içerisinde temizlik yapmak gerekebilir. Zorunlu değildir fakat yaptığınız zaman squashfs ve iso boyutunu küçültmektedir.

.. code-block:: shell

	☭ chroot sid-chroot apt-get clean # apt önbelleğini temizler
	☭ rm -f sid-chroot/root/.bash_history # iso yaparken oluşturduğunuz historyleri temizler
	☭ rm -rf sid-chroot/var/lib/apt/lists/* # index dosyalarını temizler
	☭ find sid-chroot/var/log/ -type f | xargs rm -f # logları siler
	
Paketleme aşaması
^^^^^^^^^^^^^^^^^

1. Iso taslağı dizini açalım ve **squashfs** imajı alalım. aldığımız imajı daha sonra iso taslağı içinde **live** adında bir dizin açarak içine atalım.

  **Not:** *-comp* parametresinden sonra *xz* veya *gzip* kullanabiliriz. *xz* kullanırsak daha yüksek oranda sıkıştırır fakat kurulum daha uzun sürer. *gzip* kullanırsak iso boyutu daha büyük olur fakat daha hızlı kurar.
  Debianda varsayılan sıkıştırma formatı *xz* olmasına ramen ben sizlere *gzip* kullanmanızı öneririm.

.. code-block:: shell
	
	☭ mkdir isowork
	☭ mksquashfs sid-chroot filesystem.squashfs -comp gzip -wildcards
	☭ mkdir -p isowork/live
	☭ mv filesystem.squashfs isowork/live/filesystem.squashfs

2. Ardından **vmlinuz** ve **initrd** dosyalarını isowork/boot içerisine atalım.

.. code-block:: shell

	☭ ls sid-chroot/boot/
	    config-5.7.0-1-amd64  grub  initrd.img-5.7.0-1-amd64  System.map-5.7.0-1-amd64  vmlinuz-5.7.0-1-amd64
	☭ cp -pf sid-chroot/boot/initrd.img-5.7.0-1-amd64 isowork/live/initrd.img
        ☭ cp -pf sid-chroot/boot/vmlinuz-5.7.0-1-amd64 isowork/live/vmlinuz

3. **grub.cfg** dosyası oluşturalım.

.. code-block:: shell

	☭ mkdir -p isowork/boot/grub/
	☭ echo 'menuentry "Start Debian 64-bit" --class debian {' > isowork/boot/grub/grub.cfg
	☭ echo '    linux /live/vmlinuz boot=live live-config live-media-path=/live quiet splash --' >> isowork/boot/grub/grub.cfg
	☭ echo '    initrd /live/initrd.img' >> isowork/boot/grub/grub.cfg
	☭ echo '}' >> isowork/boot/grub/grub.cfg

4. Herşey tamamlandıktan sonra dizin yapısı şu şekilde olmalıdır. Ayrıca iso **isowork** dizini içerisine istediğiniz dosyaları ekleyebilirsiniz.

.. code-block:: shell

	☭ tree isowork
	    iso-work/
	    ├── boot
	    │   └── grub
	    │       └── grub.cfg
	    └── live
    	    ├── filesystem.squashfs
    	    ├── initrd.img
    	    └── vmlinuz

5. Iso dosyası üretelim. 

.. code-block:: shell

	☭ grub-mkrescue isowork -o debian-live.iso
