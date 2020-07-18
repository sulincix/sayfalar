İso yapımı
==========
Bu dokümanda debian sid kullanarak özelleşmiş bir live iso yapımı anlatılacaktır. debian sid yerine stable kullanmak isterseniz yapmanız gereken dokümanda sid yerine stable yazmaktır. Şimdiden kolay gelsin :D

Hazırlık
^^^^^^^^

1. debootstrap kurun

.. code-block:: shell

	$ apt install debootstrap
	
2. debootstrap ile debian chroot ortamı oluşturalım

.. code-block:: shell

	$ mkdir sid-chroot
	$ debootstrap sid sid-chroot https://deb.debian.org/debian

3. dev sys proc run bind bağlayın

.. code-block:: shell

	$ for i in dev dev/pts proc sys;do mount -o bind /$i sid-chroot/$i;done
	
Özelleştirme
^^^^^^^^^^^^

1. chroot komutu ile oluşan chroot içerisine girelim. ve ardından sources.list dosyasını düzenleyelim. bu noktadan sonra chroot içerisinden devam edeceğiz. 

.. code-block:: shell

	$ chroot sid-chroot /bin/bash
	$ echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list
	$ apt-get update

2. kernel kuralım.

.. code-block:: shell

	$ apt-get install linux-headers-amd64 linux-image-amd64
	
3. grub kuralım.

.. code-block:: shell

	$ apt-get install grub-pc-bin grub-efi

4. live açılış için gereken paketleri kuralım.

.. code-block:: shell

	$ apt-get install live-config live-boot

Paketleme aşaması
^^^^^^^^^^^^^^^^^
1.  Öncelikle chroot içerisinden çıkalım. ve ardından bind bağlarını kaldıralım.

.. code-block:: shell

	$ umount -lf -R sid-chroot 2>/dev/null
	
2. iso taslağı dizini açalım ve squashfs imajı alalım.

.. code-block:: shell
	
	$ mkdir isowork
	$ mksquashfs sid-chroot filesystem.squashfs -comp xz -wildcards
