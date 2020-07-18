İso yapımı
==========

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
	
4. chroot komutu ile oluşan chroot içerisine girelim. ve ardından sources.list dosyasını düzenleyelim.

.. code-block:: shell

	$ chroot sid-chroot /bin/bash
	# echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list
	# apt-get update
