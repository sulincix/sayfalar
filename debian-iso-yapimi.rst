İso yapımı
==========
Bu dokümanda **debian sid** kullanarak özelleşmiş bir **live** iso yapımı anlatılacaktır. debian **sid** yerine **stable** kullanmak isterseniz yapmanız gereken dokümanda **sid** yerine **stable** yazmaktır. Şimdiden kolay gelsin :D

Hazırlık
^^^^^^^^

1. Gerekli paketleri kuralım.

.. code-block:: shell

	$ apt install debootstrap xorriso squashfs-tools
	
2. **Debootstrap** ile debian chroot ortamı oluşturalım.

.. code-block:: shell

	$ mkdir sid-chroot
	$ debootstrap sid sid-chroot https://deb.debian.org/debian

3. **dev sys proc run** bind bağlayalım.

.. code-block:: shell

	$ for i in dev dev/pts proc sys;do mount -o bind /$i sid-chroot/$i;done
	
Özelleştirme
^^^^^^^^^^^^

1. Chroot komutu ile oluşan **chroot** içerisine girelim. ve ardından **sources.list** dosyasını düzenleyelim. Bu noktadan sonra chroot içerisinden devam edeceğiz.

.. code-block:: shell

	$ chroot sid-chroot /bin/bash
	$ echo 'deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list
	$ apt-get update

2. Kernel kuralım.

.. code-block:: shell

	$ apt-get install linux-headers-amd64 linux-image-amd64
	
3. Grub kuralım.

.. code-block:: shell

	$ apt-get install grub-pc-bin grub-efi

4. Live açılış için gereken paketleri kuralım.

.. code-block:: shell

	$ apt-get install live-config live-boot

Paketleme aşaması
^^^^^^^^^^^^^^^^^
1.  Öncelikle chroot içerisinden çıkalım. ve ardından **bind** bağlarını kaldıralım.

.. code-block:: shell

	$ umount -lf -R sid-chroot 2>/dev/null
	
2. İso taslağı dizini açalım ve **squashfs** imajı alalım. aldığımız imajı daha sonra iso taslağı içinde **live** adında bir dizin açarak içine atalım.

.. code-block:: shell
	
	$ mkdir isowork
	$ mksquashfs sid-chroot filesystem.squashfs -comp xz -wildcards
	$ mkdir -p isowork/live
	$ mv filesystem.squashfs isowork/live/filesystem.squashfs

3. Ardından **vmlinuz** ve **initrd** dosyalarını isowork/boot içerisine atalım.

.. code-block:: shell

	$ ls sid-chroot/boot/
	    config-5.7.0-1-amd64  grub  initrd.img-5.7.0-1-amd64  System.map-5.7.0-1-amd64  vmlinuz-5.7.0-1-amd64
	$ cp -pf sid-chroot/boot/initrd.img-5.7.0-1-amd64 isowork/live/initrd.img
        $ cp -pf sid-chroot/boot/vmlinuz-5.7.0-1-amd64 isowork/live/vmlinuz

4. **grub.cfg** dosyası oluşturalım.

.. code-block:: shell

	$ mkdir -p isowork/boot/grub/
	$ echo 'menuentry "Start Debian 64-bit" --class debian {' > isowork/boot/grub/grub.cfg
	$ echo '    linux /live/vmlinuz boot=live live-config live-media-path=/live quiet splash --' >> isowork/boot/grub/grub.cfg
	$ echo '    initrd /live/initrd.img' >> isowork/boot/grub/grub.cfg
	$ echo '}' >> isowork/boot/grub/grub.cfg

5. İso dosyası üretelim.

.. code-block:: shell

	$ grub-mkrescue isowork -o debian-live.iso
