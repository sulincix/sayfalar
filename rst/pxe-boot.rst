PXE boot
========
Bu yazıda bilgisayarı ağ üzerinden (pxe) ile başlatmayı anlatacağız. Bu yazıyı debian üzerinde atlatacağız fakat diğer dağıtımlarda da benzer şekilde uygulayabilirsiniz.

Hazırlık
+++++++++
Öncelikle dnsmasq ve grub kuralım. ve tftp için gereken dizinleri oluşturalım.

.. code-block:: shell

	$ apt install dnsmasq grub-common
	$ mkdir -p /srv/tftp
	$ grub-mknetdir --net-directory=/srv/tftp

**Not:** Eğer x86_64 dışı bir mimari ile (örneğin raspberry pi) çalışıyorsanız tftp dosyalarını başka bir yerde oluşturup kopyalayarak kullanabilirsiniz.

Yapılandırma
++++++++++++
**/etc/dnsmasq.d/pxe** dosyamızı aşağıdaki gibi uygun şekilde dolduralım.

.. code-block:: shell

	interface=eth0
	domain=localdomain
	# dhcp ayarı
	dhcp-range=192.168.0.3,192.168.0.253,255.255.255.0,1h
	dhcp-boot=tag:efi-x86_64,boot/grub/x86_64-efi/core.efi
	dhcp-boot=tag:bios,boot/grub/i386-pc/core.0
	# gateway için
	dhcp-host=aa:bb:cc:dd:ee:ff,192.168.0.1
	dhcp-option=3,192.168.0.1 # gateway
	dhcp-option=6,192.168.0.1 # dns
	# tftp ayarı
	enable-tftp
	tftp-root=/srv/tftp
	# log tutmak için
	log-dhcp

**Not:** Ağda başka dhcp sağlayan aygıt bulunmamalı.

Ardından dnsmasq servisini yeniden başlatalım.

.. code-block:: shell

	$ service dnsmasq restart

Ardından boot etmek istediğimiz çekirdeği ve initramfs imajını kopyalayalım.
Debian için https://ftp.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/ adresinden ulaşabilirsiniz. 

.. code-block:: shell

	$ cp -f netboot/debian-installer/amd64/linux /srv/tftp/linux
	$ cp -f netboot/debian-installer/amd64/linux /srv/tftp/initrd.img

Ardından grub.cfg dosyamızı aşağıdaki gibi doldurabiliriz.

.. code-block:: shell

	linux /linux quiet
	initrd /initrd.img
	boot

Kullanım:
+++++++++
pxe boot için sunucu olarak ayarladığımız cihazı bir switch yardımı ile (veya doğrudan) bağlayarak diğer bilgisayarı ağ üzerinden başlatabilirsiniz.

**Not:** Ip adresini dnsmasq ayarlarında belirttiğimiz aralığa uygun şekilde sabitlememiz gerekmektedir.

**Not:** 

Hata ayıklama:
++++++++++++++
Öncelikle **syslogd** başlatmalıyız.

.. code-block:: shell

	$ busybox syslogd

Ardından **/var/log/messages** dosyasını dinleyebiliriz.

.. code-block:: shell

	$ tail -f /var/log/messages

