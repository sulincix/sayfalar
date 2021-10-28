debian kurulumu
===============

Bu dokümanda debianı **debootstrap** ile kurma konusu anlatılacaktır. **Bu dokümandaki komutları kendi kurulumunuza göre uyarlayarak yazın.**

Bu dokümanda **debian sid** kurulumu anlatılmıştır. **sid** yerine **stable** kullanmak isterseniz dokümanda *sid* gördüğünüz yerlere *stable* yazmanız gerekir.

Not: **Uefi** kurulum için **efi** bölümü **/dev/sda1**, her iki kurulum türü için **/dev/sda2** kök dizin olarak ele alıp anlatacağım.

Not: Bu dokümandaki yazılanları uygulamadan dolayı oluşabilecek zarar veya veri kayıplarından dokümanın yazarı sorumlu tutulamaz.

===========     ========
Temel kavramlar
------------------------
Terim            Anlamı
===========     ========
rootfs          Kurulumu yapılan sistemin taslağıdır. **chroot** komutu ile içerisine girebiliriz. çıkmak için ise **exit** komutu kullanılmalıdır.
debootstrap     **rootfs** oluşturmak için kullanılan komuttur. Debiana ait bir araçtır fakat debian dışında da kullanılabilir.
efi bölümü      Sadece **Uefi** kullanan sistemlerde bulunan ve açılış için gereken dosyaların bulunduğu bölümdür.
kök dizin       Kurulumu yapılan sistemin kurulacağı yerdir.
===========     ========

Gerekenler
^^^^^^^^^^
**Debian** tabanlı herhangi bir dağıtım isosu (*ubuntu debian pardus mint fark etmez*)


Eğer debian tabanlı olmayan bir dağıtım varsa ona debootstrap kurmalısınız. 

Kaynak kodu derlemeden önce bir tane yamaya ihtiyacınız olabilir. 

Kaynak kod: https://salsa.debian.org/installer-team/debootstrap

Yama: https://gitlab.com/sulinos/repositories/SulinRepository/-/raw/master/system/devel/debootstrap/files/0001-remove-dpkg-support.patch


Hazırlık aşaması
^^^^^^^^^^^^^^^^

Elinizdeki isoyu yazdırıp **live** olarak açın. Tüm işlemi **live** modda halleceğiz.
Tüm işlemi **root** yetkisi ile yapacağız. **sudo su** yazarak önce **root** yetkisi alın.


1. **debootstrap** paketini kurun:

.. code-block:: shell

	$ apt-get update
	$ apt-get install debootstrap

2. **Uefi** mi yoksa **legacy** mi kullandığınızı öğrenin:

Eğer **/sys/firmware/efi** adında bir dizin varsa **uefi** kullanıyorsunuzdur. Aşağıdaki komutun çıktısı da aynı bilgiyi verecektir.

.. code-block:: shell

	[ -d /sys/firmware/efi ] && echo UEFI || echo legacy

3. Kurulum yapılacak diski bölümlendirelim. **Uefi** için **100mb efi bölümü** ve bir **kök dizin** oluşturalım. (*ben sda1 efi sda2 kök olarak anlatacağım*) **legacy** için sadece **kök dizin** açmamız yeterlidir.

.. code-block:: shell

	$ cfdisk /dev/sda # Bunun yerine gparted gibi gui araçları da kullanabilirsiniz.

4. Diskleri biçimlendirelim:

.. code-block:: shell

	$ mkfs.ext4 /dev/sda2 # kök dizin
	$ mkfs.vfat /dev/sda1 # efi bölümü (sadece uefi kullananlar yapmalı)

Kurulum aşaması
^^^^^^^^^^^^^^^

Chroot dışındaki kurulum aşamaları
*****************************************

1. Diskleri hazırladıktan sonra kuruluma geçebiliriz. Bunun için ilk **kök dizin** olacak yeri **/mnt** içine bağlayalım. Bağlanıp bağlanmadığını **lsblk** veya **df** komutları ile kontrol edebilirsiniz.

.. code-block:: shell

	$ mount /dev/sda2 /mnt

2. **Debootstrap** ile diskin içine **rootfs** oluşturalım. Debian tabanı dışındaki dağıtımlarda **--arch amd64** parametresini yazmak zorundasınız.

.. code-block:: shell

	$ debootstrap --arch amd64 --no-merged-usr sid /mnt https://deb.debian.org/debian

3. Oluşturduğumuz **rootfs** içine **dev sys proc run** dizinlerini bağlayalım.

.. code-block:: shell

        $ for i in dev dev/pts proc sys run; do mount -o bind /$i /mnt/$i; done

4. **Rootfs** içerisine **chroot** ile girelim. Bu aşamadan sonraki tüm adımlar **chroot** içerisinde yapılacaktır.

.. code-block:: shell

	$ chroot /mnt /bin/bash

Chroot içindeki kurulum aşamaları
*********************************

5. **Kerneli** ve **grubu** kuralım. **Uefi** kullananlar **efi** bölümünü **/boot/efi** dizinine bağlamalılar.

.. code-block:: shell

	# sadece uefi kullananların yapması gereken kısım
	$ mkdir -p /boot/efi
	$ mount /dev/sda1 /boot/efi
	$ mount -t efivarfs efivarfs /sys/firmware/efi/efivars
	# uefi ve legacy için ortak olan kısım
	$ apt-get update
	$ apt-get install grub-pc-bin grub-efi linux-image-amd64 linux-headers-amd64
	$ grub-install /dev/sda
	$ grub-mkconfig -o /boot/grub/grub.cfg

6. **Non-free** ve **Contrib** depolarını etkinleştirelim (*isteğe bağlı*)

.. code-block:: shell

	$ echo 'deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list

7. Sürücüleri kuralım (*isteğe bağlı*)

.. code-block:: shell

	$ apt-get install firmware-amd-graphics firmware-atheros \
	    firmware-b43-installer firmware-b43legacy-installer \
	    firmware-bnx2 firmware-bnx2x firmware-brcm80211  \
	    firmware-cavium firmware-intel-sound firmware-intelwimax \
	    firmware-ipw2x00 firmware-ivtv firmware-iwlwifi \
	    firmware-libertas firmware-linux firmware-linux-free \
	    firmware-linux-nonfree firmware-misc-nonfree firmware-myricom \
	    firmware-netxen firmware-qlogic firmware-realtek firmware-samsung \
	    firmware-siano firmware-ti-connectivity firmware-zd1211

8. **/etc/fstab** dosyasını düzenleyelim. Not: **Uefi** kullananlar **efi** bölümünü de ekleyebilirler. Ben şahsen gerekli görmüyorum.

içeriği şu şekilde olmalı:

.. code-block:: shell

	# UNCONFIGURED FSTAB FOR BASE SYSTEM
	/dev/sda2 / ext4 defaults,rw 0 0

9. Masaüstü ortamı kuralım (*isteğe bağlı*)

.. code-block:: shell

	$ apt-get install xorg xinit
	$ apt-get install lightdm # giriş ekranı olarak lightdm yerine istediğinizi kurabilirsiniz.

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

10. Yeni **kullanıcı** oluşturalım ve **parola** atayalım. Not: **Sudo** kurmadığınızda **root** yetkisi almak için **su** komutu kullanmanız gerekir. 

.. code-block:: shell

	$ useradd -m kullanıcıadı -G netdev,audio,video,plugdev,floppy -s /bin/bash
	$ passwd kullanıcıadı # kullanıcıya parola atamak için
	$ passwd root # root kullancısına parola atamak için

11. Network-manager kuralım.

.. code-block:: shell

	# Bunu tüm kullanıcılar kurmalıdır.
	$ apt-get install network-manager
	# Bunu kde ve gnome kullanıcılarının kurmasına gerek yok.
	$ apt-get install network-manager-gnome

Kurulumu sonrası aşama
^^^^^^^^^^^^^^^^^^^^^^

1. Temizlik yapalım:

.. code-block:: shell

	$ apt-get clean

2. **Chroot** içinden çıkalım ve artık yeniden başlatabiliriz. Eğer hatalı bir şey yapmadıysanız sisteminiz düzgünce açılacaktır.

