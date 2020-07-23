Qemu-KVM Kullanımı
==================
Bu belgede qemu-kvm kullanımı anlatılmaktadır. İşin teknit detayından çok kullanmak isteyenlerin işini görmesi için basitleştirerek anlatmaya çalışacağız. O yüzden **sövmeyin** :)

Qemu kullanmak için gui uygulamalar da vardır. Örneğin gnome-boxes ile qemuyu grafik tabanlı olarak kullanabilirsiniz. Bu belgede buna değinmeyeceğiz. terminalden kullanımı üzerine anlatım olacak.

Disk imajı oluşturma
^^^^^^^^^^^^^^^^^^^^
**qemu-img** komutu ile kolay yoldan imaj açabiliriz. boyutunu G M gibi harfler ile ifade ediyoruz. Örneğin:
.. code-block:: shell

  $ qemu-img create deneme.img 30G
  
  
