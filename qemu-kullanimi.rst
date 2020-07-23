Qemu-KVM Kullanımı
==================
Bu belgede qemu-kvm kullanımı anlatılmaktadır. İşin teknit detayından çok kullanmak isteyenlerin işini görmesi için basitleştirerek anlatmaya çalışacağız. O yüzden **sövmeyin** :)

Qemu kullanmak için gui uygulamalar da vardır. Örneğin gnome-boxes ile qemuyu grafik tabanlı olarak kullanabilirsiniz. Bu belgede buna değinmeyeceğiz. terminalden kullanımı üzerine anlatım olacak.

Disk imajı oluşturma
^^^^^^^^^^^^^^^^^^^^
**qemu-img** komutu ile kolay yoldan imaj açabiliriz. boyutunu G M gibi harfler ile ifade ediyoruz. Örneğin:

.. code-block:: shell

  $ qemu-img create deneme.img 30G
  Formatting 'deneme.img', fmt=raw size=32212254720
  
Bu disk imajı **raw** formattadır. yani disk imajını usb belleğe dd komutu ile yazıp daha sonra bunu kullanabilirsiniz.

Sanal makinanın başlatılması
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**qemu-system-x86_64** komutu ile başlatılır. **--enable-kvm** parametresi eklenerek **kvm** etkinleştirilmelidir. yoksa çok kasar. Örnek kullanım:

.. code-block:: shell

  $ qemu-system-x86_64 --enable-kvm
  
Ardından oluşturduğumuz disk imajını qemuya hard disk olarak bağlamamız gerekli. onun için de **-hda** parametresi kullanılır. Ayrıca **-m** parametresi ile bellek miktarını G M gibi semboller ile göstererek belirtmemiz gerekli. Örneğin:

.. code-block:: shell

  $ qemu-system-x86_64 --enable-kvm -hda deneme.img -m 2G # disk imajını hard disk yaptık ve 2gb ram verdik.
  WARNING: Image format was not specified for 'deneme.img' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.


Örnekteki gibi uyarı vermesinin sebebi raw disk imajı kullanmamızdan dolayı. Çok fantastik şeyler yapmayacaksak çokta önemli değil :D Ayrıca raw imaj yerine usb bellek hard disk gibi şeyleri de kullanabilirsiniz. imaj konumu olarak /dev/sdx vermeniz yeterlidir.

Şimdi sıra geldi sanal makinaya format atmaya. Bunun için iso imajını bağlamak gerekli. bunun için **-cdrom** parametresi kullanılmalıdır. Örneğin

.. code-block:: shell

  $ qemu-system-x86_64 --enable-kvm -hda deneme.img -m 2G -cdrom debian-live-10.4.0-amd64-gnome.iso 
  
