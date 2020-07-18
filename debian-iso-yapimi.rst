İso yapımı
==========

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

4. chroot komutu ile oluşan chroot içerisine girelim. ve ardından sources.list dosyasını düzenleyelim. bu noktadan sonra chroot içerisinden devam edeceğiz. 

.. code-block:: shell

	$ chroot sid-chroot /bin/bash
	$ echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list
	$ apt-get update

5. kernel kuralım.

.. code-block:: shell

	$ apt-get install linux-headers-amd64 linux-image-amd64
	
6. grub kuralım.

.. code-block:: shell

	$ apt-get install grub-pc-bin grub-efi

7. live açılış için gereken paketleri kuralım.

.. code-block:: shell

	$ apt-get install live-config live-boot

Paketleme aşaması
^^^^^^^^^^^^^^^^^
