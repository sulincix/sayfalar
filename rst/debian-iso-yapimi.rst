Iso yapımı
==========
Bu dokümanda **debian sid** kullanarak özelleşmiş bir **live** iso yapımı anlatılacaktır.

Debian **sid** yerine **stable** kullanmak isterseniz yapmanız gereken dokümanda **sid** yerine **stable** yazmaktır. 

  **Not:** Bu dokümanla ilgili soru ve önerileriniz için : https://t.me/iso_calismalari

  **Not: Biraz mizah içerir.** Şimdiden **ALLAH** sabır versin :D

========  ========
Temel kavramlar
------------------
Terim     Anlamı
========  ========
chroot    Oluşturulacak live isonun taslağıdır. içerisine **chroot sid-chroot** komutu ile içerisine girebiliriz. çıkmak için ise **exit** komutu kullanılmalıdır.
squashfs  Sıkıştırılmış haldeki kök dizin dosyasıdır. Oluşturulması donanıma bağlı olarak uzun sürmektedir. **Debian** tabanlı dağıtımlarda **gzip** formatında sıkıştırma önerilir.
iso       Kurulum medyası dosyasıdır. Bu dosya son üründür ve bunu yayınlayabilirsiniz.
live      Kurulum yapmadan çalışan sisteme **live** adı verilir.
17g       Dağıtımdan bağımsız canlı sistem kurulum aracıdır.
========  ========


Hazırlık
^^^^^^^^

1. Gerekli paketleri kuralım.

.. code-block:: shell

	☭ apt-get install debootstrap xorriso squashfs-tools mtools grub-pc-bin grub-efi
	
2. Kurulum aracını derleyelim. (İsteğe bağlı)

Öncelikle kurulum aracını deb paketi yapmak için gerekli olan paketleri kuralım:

.. code-block:: shell

	☭ apt-get install devscripts

Daha sonra kaynak kodu bir dizine çekip **deb** paketi haline getirelim.

.. code-block:: shell

	☭ git clone https://gitlab.com/ggggggggggggggggg/17g
	☭ cd 17g
	☭ mk-build-deps --install
	☭ debuild -us -uc -b

Bir üst dizinde kurulum aracına ait **deb** paketi oluşacakdır.
	
Chroot oluşturulması
^^^^^^^^^^^^^^^^^^^^
	
1. **Debootstrap** ile debian chroot ortamı oluşturalım.

.. code-block:: shell

	☭ mkdir sid-chroot
	☭ debootstrap --arch=amd64 --no-merged-usr sid sid-chroot https://deb.debian.org/debian

Eğer debian yerine devuan kullanmak istiyorsanız depo adresi olarak *https://pkgmaster.devuan.org/merged* koymalısınız.

Eğer "Unpacking the base system..." sırasında sorun yaşıyorsanız **chroot** dizininin sahibini **root** olarak değiştirip tekrar denemenizi öneriririz.

.. code-block:: shell

	☭ chown root sid-chroot
	
2. Eğer apt ile ilgili **sandbox** hatası alırsanız aşağıdaki komutu kullanın.

.. code-block:: shell

	☭ echo "APT::Sandbox::User root;" > sid-chroot/etc/apt/apt.conf.d/99sandboxroot
	
Eğer sıfırdan debootstrap kullanarak chroot oluşturmak yerine mevcut bir debian tabanlı isoyu açmak istiyorsak aşağıdaki adımları uygulayın.

1. Iso dosyamızı bir dizine bağlayalım.

.. code-block:: shell

	☭ mount -o loop debian-live-orijinal.iso /mnt
	
2. Iso içerisindeki **live/filesystem.squashfs** dosyasını açalım. ve adını **sid-chroot** olarak değiştirelim.

.. code-block:: shell

	☭ unsquashfs /mnt/live/filesystem.squashfs
	☭ mv squashfs-root sid-chroot

3. Iso dosyamızın bağını sökelim.

.. code-block:: shell

	☭ umount -f /mnt

Chroot içine girmek için ön hazırlık
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **dev sys proc run** bind bağlayalım. Bu işlem her chroot ile **sid-chroot** içerisine girileceğinde yapılmalıdır. **sid-chroot** içerisinden çıkıldığında ise  bind bağının sökülmesi gerekmektedir. 

.. code-block:: shell

        ☭ for i in dev dev/pts proc sys; do mount -o bind /$i sid-chroot/$i; done

Gerekli paketlerin kurulması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Mevcut bir iso dosyasını düzenleyenler Bu aşamayı atlayabilirler. 

1. Chroot komutu ile oluşan **chroot** içerisine girelim. ve ardından **sources.list** dosyasını düzenleyelim. Bu noktadan sonra chroot içerisinden devam edeceğiz.

.. code-block:: shell

	☭ chroot sid-chroot /bin/bash
	☭ echo 'deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list
	☭ apt-get update

2. Kernel kuralım.

.. code-block:: shell

	☭ apt-get install linux-headers-amd64 linux-image-amd64

Kernel olarak depodaki kernel yerine liquorix kernelini de kurabilirsiniz. (isteğe bağlı)

.. code-block:: shell

	☭ bash <(https://liquorix.net/add-liquorix-repo.sh)
	☭ apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64
	
3. Grub kuralım.

.. code-block:: shell

	☭ apt-get install grub-pc-bin grub-efi-ia32-bin grub-efi

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
budgie       apt-get install budgie-desktop
========     =====

  **Not:** xfce, lxde, mate gibi bazı masaüstülerindeki ağ bağlantısı aracı için **network-manager-gnome** paketini kurmalısınız.

Bu aşamada kurulu gelmesini istediğiniz başka paketler varsa onları da kurabilirsiniz.

3. Sürücüleri ekleyebiliz.

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


4. Varsayılan kullanıcı ayarları yapmak için kullanıcı ev dizinine gelmesini istediğiniz dosyaları **/etc/skel** içerisine uygun hiyerarşiye göre dizmelisiniz.

Burada dikkat etmezin gerekek nokta ev dizinindeki bütün dosyaları olduğu gibi kopyalarsanız açık olan kullanıcı hesabı bilgileri de dahil edileceği için tehlikeli olabilir. Bu dosyaları tek tek kontrol ederek koymanızı şiddetle tavsiye ederim.

Yapmış olduğunuz duvar kağıdı simge teması gibi özelleştirmeler iso içerisinde de aynı konumda bulunmalıdır. Bu sebeple sadece iso içerisindeki görselleri ve temaları kullanmalısınız.

5. Daha önceden paketlemiş olduğumuz kurulum aracını kurabiliriz. Oluşturduğumuz **deb** dosyasını chroot içindeki **/tmp** dizinine kopyalayalım.

.. code-block:: shell

	☭ dpkg -i /tmp/17g-installer.deb # dosya adını uygun şekilde yazınız.
	☭ apt-get install -f # eksik bağımlılıkları tamamlaması için.

6. Network manager gvfs-backends gibi bazı paketlere ihtiyacımız olabilir. Bunları kuralbilirsiniz.

.. code-block:: shell

	☭ apt-get install network-manager-gnome gvfs-backends pavucontrol chromium vlc

Paketleme öncesi
^^^^^^^^^^^^^^^^
1. Öncelikle chroot içerisinden çıkalım. İşlemin bundan sonraki aşaması chrootun dışarısında gerçekleşecektir.

2. Chroot içerisindeki **bind** bağlarını kaldıralım.

.. code-block:: shell

	☭ umount -lf -R sid-chroot/* 2>/dev/null
	
Temizlik
^^^^^^^^
Squashfs yapmadan önce chroot içerisinde temizlik yapmak gerekebilir. Zorunlu değildir fakat yaptığınız zaman squashfs ve iso boyutunu küçültmektedir.

.. code-block:: shell

	☭ chroot sid-chroot apt-get autoremove # boşta kalan paketleri temizler
	☭ chroot sid-chroot apt-get clean # apt önbelleğini temizler
	☭ rm -f sid-chroot/root/.bash_history # iso yaparken oluşturduğunuz historyleri temizler
	☭ rm -rf sid-chroot/var/lib/apt/lists/* # index dosyalarını temizler
	☭ find sid-chroot/var/log/ -type f | xargs rm -f # logları siler
	
Paketleme aşaması
^^^^^^^^^^^^^^^^^

1. Iso taslağı dizini açalım ve **squashfs** imajı alalım. aldığımız imajı daha sonra iso taslağı içinde **live** adında bir dizin açarak içine atalım.

  **Not:** *-comp* parametresinden sonra *xz* veya *gzip* kullanabiliriz. *xz* kullanırsak daha yüksek oranda sıkıştırır fakat kurulum daha uzun sürer. *gzip* kullanırsak iso boyutu daha büyük olur fakat daha hızlı kurar.
  Debianda varsayılan sıkıştırma formatı *xz* olmasına ramen ben sizlere *gzip* kullanmanızı öneririm.

**Not:** Ubuntu tabanında **live** dizini yerine **casper** dizini blunmaktadır.

.. code-block:: shell
	
	☭ mkdir isowork
	☭ mksquashfs sid-chroot filesystem.squashfs -comp gzip -wildcards
	☭ mkdir -p isowork/live
	☭ mv filesystem.squashfs isowork/live/filesystem.squashfs

2. Ardından **vmlinuz** ve **initrd** dosyalarını isowork/live içerisine atalım.

.. code-block:: shell

	☭ ls sid-chroot/boot/ # dosyalarımızın adını öğrenmek için
	    config-5.7.0-1-amd64  grub  initrd.img-5.7.0-1-amd64  System.map-5.7.0-1-amd64  vmlinuz-5.7.0-1-amd64
	☭ cp -pf sid-chroot/boot/initrd.img-5.7.0-1-amd64 isowork/live/initrd.img
        ☭ cp -pf sid-chroot/boot/vmlinuz-5.7.0-1-amd64 isowork/live/vmlinuz

3. **grub.cfg** dosyası oluşturalım.

.. code-block:: shell

	☭ mkdir -p isowork/boot/grub/
	☭ echo 'menuentry "Start Debian 64-bit" --class debian {' > isowork/boot/grub/grub.cfg
	☭ echo '    linux /live/vmlinuz boot=live live-config live-media-path=/live --' >> isowork/boot/grub/grub.cfg
	☭ echo '    initrd /live/initrd.img' >> isowork/boot/grub/grub.cfg
	☭ echo '}' >> isowork/boot/grub/grub.cfg

4. Herşey tamamlandıktan sonra dizin yapısı şu şekilde olmalıdır. Ayrıca iso **isowork** dizini içerisine istediğiniz dosyaları ekleyebilirsiniz.

.. code-block:: shell

	☭ tree isowork
	    isowork/
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

Iso üzerinde düzenleme yapma
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Eğer paketlediğimiz isoda bir şeyleri eksik yaptığımızı düşünüyorsak veya birkaç ekleme daha yapmak istiyorsak Sırası ile şunları yapmalıyız.

1. **sid-chroot** dizinine tekrar bind bağı atalım.

.. code-block:: shell

	☭ for i in dev dev/pts proc sys; do mount -o bind /$i sid-chroot/$i; done
        
2. **sid-chroot** içine tekrar girelim.

.. code-block:: shell

	☭ chroot sid-chroot /bin/bash

3. Düzenlemek istediğimiz yapalım. Ve ardından chroot içinden çıkalım.

4. Chroot içerisindeki **bind** bağlarını kaldıralım.

.. code-block:: shell

	☭ umount -lf -R sid-chroot/* 2>/dev/null

5. Tekrar **squashfs** dosyası üretelim ve güncelleyelim.

.. code-block:: shell

	☭ mksquashfs sid-chroot filesystem.squashfs -comp gzip -wildcards
	☭ rm -f isowork/live/filesystem.squashfs
	☭ mv filesystem.squashfs isowork/live/filesystem.squashfs

6. Eğer kernelle ilgili bir değişiklik yaptıysak **isowork** içerisindeki live dizininde bulunan dosyaları güncelleyelim. 

.. code-block:: shell

	☭ rm -f isowork/live/initrd.img isowork/live/vmlinuz 
	☭ cp -pf sid-chroot/boot/initrd.img-5.7.0-1-amd64 isowork/live/initrd.img
        ☭ cp -pf sid-chroot/boot/vmlinuz-5.7.0-1-amd64 isowork/live/vmlinuz
        
7. Yeni iso dosyasını üretelim.

.. code-block:: shell

	☭ mv debian-live.iso debian-live-eski.iso
	☭ grub-mkrescue isowork -o debian-live.iso
