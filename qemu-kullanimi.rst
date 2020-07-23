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
  
