İso yapımı
==========

1. debootstrap kurun
::code-block: shell

	apt install debootstrap
	
2. debootstrap ile debian chroot ortamı oluşturalım
::code-block: shell

	mkdir sid-chroot
	debootstrap sid sid-chroot https://deb.debian.org/debian

