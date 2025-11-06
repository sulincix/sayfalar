Sulincixin gizlilik rehberi
===========================
Kolay seviye
------------
Linux dağıtımı kullanın
+++++++++++++++++++++++
Linux dağıtımları kaynak kodu erişiyebilir olduğu için ve gereksiz şeyler barındırmadığı için gizlilik olarak daha iyidir. Bunun dışında eğer farklı bir şeye ihtiyacınız varsa sanallaştırın veya sadece bu iş için ayrı bir cihaz kullanın ve bu cihazda kişisel veri tutmayın.

Özgür olmayan yazılımları kullanmayın. Eğer kullandığınız uygulama özgür değilse siz de özgür olamazsınız. 

Tarayıcı seçimi
+++++++++++++++
Tarayıcı olarak firefox üzerine ublock origin kurabilirsiniz. Veya librewolf kullanabilirsiniz. Chromium tabanlı tarayıcılar gizlilik açısından firefox kadar etkili değildir.

Bununla birlikte tarayıcı kimliğinizi değiştirerek internette hangi işletim sistemini ve tarayıcıyı kullandığınız bilgisini ifşa etmemiş olursunuz.

Chromium tabanlı tarayıcı olarak ungoogled-chromium tercih edebilirsiniz. 

Arama motoru olarak duckduckgo kullanın. Tarayıcınızı her kapattığınızda çerezleri ve geçmişi temizleyecek şekilde ayarlayın. 

DRM kapatın.

Dns over https açın. DNS kolaylıkla izlenebilir fakat https üzerinden dns izlemesi daha zordur.

Mobil cihaz seçimi
++++++++++++++++++
Android telefon alıp lineageos kurun. Google uygulamaları veya herhangi bir özgür olmayan uygulama yüklemeyin.

Telefonda tarayıcı olarak fennec fdroid kullanabilirsiniz. Ublock-origin desteği var.

Root için kernelsu, yoksa magisk kullanın. Root ile cihazda daha fazla kontrole sahip olursunuz. 

Orta seviye
-----------
Daha özgür linux dağıtımı
+++++++++++++++++++++++++
Özgür olmayan paketlerden kurtulun. Desteklenmeyen donanımları değiştirin. Örneğin wifi kartınızı firmware gerektirmeyen bir kart ile değiştirin.

Uygulama çalıştırırken sandbox ortamlarını tercih edin. Flatpak bu noktada iyi iş görebilir fakat ayarlamalar gerekebilir.

Docker / podman gibi ortamlardan faydalanın. Bu sayede ana sisteminizde çalışmadığı için istediğiniz gibi açıp kapatabilirsiniz ve sadece sizin izin verdiğiniz kadarı ile çalışır.

Sisteminizi şifreleyin. Bütün sistemi şiflemeye gerek yok ev dizinini şifrelemek yeterli olur. Bios parolayı koyabilirsiniz fakat sıfırlaması basit olduğu için bir anlamı olmayabilir. 

Ekranınızı kilitlemeden başından ayrılmayın. Evde tek başınıza bile olsanız bunu alışkanlık haline getirin.

Donanımsal gizlilik
+++++++++++++++++++
Herkese açık ağlara bağlanmayın. Ağ üzerinde oturum açmanızı gerektiren yerleri kullanmayın. Bağlanacağınız cihazın mac adresi ifşalanmaması için rastgele mac adresi ile bağlanın.

Her önünüze gelen cihazı bilgisayara bağlamayın. Laptop kullanıyorsanız içini açıp web kamerasının kablosunu sökün.

Mümkünse intel MEI (Malware engine) kapatın. Veya intel işlemcili cihaz almayın. Amd için ise PSP (Platform Security Processor) özelliğini mümkünse kapatın.

Kablosuz klavye/mouse kullanmayın. Bu sinyaller dinlenip kolayca hangi tuşlara bastığınız tespit edilebilir. Kablolu klavye/mouse ile sinyal yaymadığı için sorun oluşmaz.
Ayrıca bazı klavyeler tuş başına farklı ses çıkartabildiği için sesi analiz ederek ne yazdığınız anlaşılabilir. Sessiz bir klavye tercih edebilir veya klavyeyi farklı bir düzende kullanabilirsiniz. (Türkçe için F klavye önerebilirim. Tuşların yerini söküp değiştirin)

Telefonda parmak izi veya yüz tanıma ile ekran kilit açma kullanmayın. Bu kilit açma senaryoları kandırılabilirliğe sahiptir. Pin ile veya desen ile kilit açma ise kandırılamaz.

Sosyal medya - Gündelik
+++++++++++++++++++++++
Bütün sosyal medya hesaplarınızı kapatıp sahte hesap kullanın. Telefonunuzda uygulama olarak yüklemeyin tarayıcı üzerinden gizli sekme ile kullanın.

Email olarak rastgele isimde ve kişisel bilgi içermeyen hesaplar kullanın. Hatta mümkünse sadece 1 kere kullanın.

Ciddi amaçla kullandığınız bir adet email adresi olsun ve o email adresini biryerlere üyelik açmak için kullanmayın.

Telefonunuzdaki arama yönlendirme kısmından ulaşılamadığında yönlendirilecek numarayı geçersiz bir numara ile değiştirin. (örneğin +900000000000 olabilir) Bu sayede sizi arayan şüpheli numaralara cevap vermediğinizde karşı tarafa numara geçersiz dediği için tekrar rahatsız etmemiş olurlar.

VPN kullanın. Fakat VPN sizin tarafınızdan barındırılan bir sunucuda bulunmalı. Hazır vpn servisleri ağınızı izler ve gizlilik açısından bir fayda sağlamaz. Wireguard veya OpenVPN önerebilirim.

Akıllı saat vb cihazlar kullanmayın. Bu cihazlar sizi izler ve özgür olmayan 3. taraf yerlere istek atabilir. Saat lazımsa klasik saat tercih edin. Hem pili bitti derdi yok rahat.

GSM üzerinden sesli iletişim yerine internet üzerinden iletişimi tercih edin. GSM üzerinden konuştuklarınız şifrelenmez fakat internetten konuştuklarınıza operatörünüz erişemez.

Google maps yerine OpenStreetMap kullanın. Offline harita olarak kullanmanızı öneririm.

Parolalar
+++++++++
Kendi sunucunuz dışında parola saklama uygulaması kullanmayın. Ya kendi sunucunuzda barındırın yada bütün parolalarınızı ezberleyin. Ezberlemek zor gelebilir ama alışılıyor.

Parolanızın ne olduğundan çok tahmin edilebilirliği önemlidir. Parolanızı tahmin edilemez veya tamamen rastgele oluşturun ve gerekmediği sürece değiştirmeyin. Bir parolayı birden çok yerde kullanmayın.

Önemli olmayan yerlere üye olurken rastgele bir email ve rastgele bir kullanıcı oluşturup işinizi hallettikten sonra bir daha kullanmama yolunu tercih edebilirsiniz.

Sms ile doğrulama güvenli değildir. Sms kolayca ele geçirilebilir. Onun yerine TOTP gibi 2 aşamalı doğrulama yollarını kullanın. Totp uygulaması olarak offline çalışabilen özgür yazılımlar tercih edin.

Hardcore seviye
---------------
Sistem seçimi
+++++++++++++
Bir linux dağıtımı kullanacaksanız ana dağıtımı tercih edin ve minimal kurulum yapın. Bu sayede kontrol tamamen sizde olur. Hazır bir dağıtım kullanmak yerine kendi dağıtımınızı oluşturmayı veya buildroot gibi yollarla derlemeyi deneyebilirsiniz. Sistemi güncel tutun ve gerekmedikçe bir şey kurmayın.

Hardened dağıtım kullanın. Sudo komutu yerine su komutu ile root alın. Bu sayede root ile çalıştırdıklarınız root kullanıcısının history kısmında yer alır ve daha kolay takip edilir. Ayrıca diski nosuid olarak bağlayıp gerektiğinde yeniden başlatıp bu özelliği kapatarak roota geçebilirsiniz. 

X11 yerine Wayland tercih edebilirsiniz. X11 üzerinde çalışan uygulamalar tüm ekrana hükmedebilir fakat wayland üzerinde bu mümkün olmadığı için daha kısıtlı yetki ile çalışır. Bununla birlikte Xephyr ve Xpra alternatif olarak düşünülebilir.

Kullandığınız android custom romunu kendiniz derleyin. Bu sayede kontrol sizde olur. Romu istediğiniz gibi özelleştirebilir veya istemediğiniz kısımları çıkartabilirsiniz.

Internet servis sağlayıcısının verdiği modemi kullanmayın. Onun yerine OpenWRT uyumlu bir cihaz alıp içine OpenWRT yükleyip onunla kullanın. Bu sayede servis sağlayıcısı ağınıza erişim sağlayamaz ve özgür olmayan bir modem kullanmak zorunda kalmamış olursunuz. 

Eğer uyumlu ise bilgisayarınıza Coreboot gibi alternatif firmware yükleyin.

Gündelik
++++++++
Mümkün olduğunca sadece nakit para kullanın. Bankalar harcamalarınızı görebilir. Kripto paralar da aynı şekilde borsada tutuyorsanız takip edilebilirdir. Yatırım yapacaksanız fiziksel karşılığı olan ve 3. tarafa bağlı olunmadan elde edilebilen yolları tercih edin. Veya yatırım yapmayın dümdüz paranızı yiyin :D

Belediye otobüslerine binerken kişiselleştirilmemiş kart kullanın. Veya dolmuşa binin. Bu sayede nereye gittiğinizi gizlemiş olursunuz. Ayrıca Eğer otomobil kullanıyorsanız kalabalık yerlerden yakıt alın.

Akıllı sistem içenen otomobil kullanmayın. Araçta müzik açmak için telefonunuzu bluetooth ile bağlayıp kullanabilirsiniz. Carplay gibi özellikleri kullanmayın çünkü özgür değiller.

Bir yerden bir yere giderken rotayı haritalardan bakabilirsiniz fakat GPS açıp takip ederek harita kullanmayın. Çünkü konumunuzu ifşa etmiş oluyorsunuz. 

LLM serislerini kullanmayın. Eğer lazım olduğunu düşünüyorsanız kendiniz barındırabilirsiniz. Veya en temizi doküman okuyup araştırma yaparak birşeyler öğrenin.

Iş hayatınızdaki arkadaşlarınız ile özel hayatınızdaki arkadaşlarınızı birbirinden ayırın. Etrafınızdaki kişiler sadece sizin onların bilmesini istediğiniz kadarı ile birşeyler bilsin. 

Kafe gibi yerlerde adınız sorulduğunda sahte isim kullanın. Nasılsa doğrulama yapmayacaklar.

Sizin isminizi taşıyan fakat hatalı bilgi içeren birsürü sosyal medya hesabı açın ve içini sahte görsellerle doldurun. Bu sayede sizi araştırmak isteyenler sizin hakkınızda doğru bilgiye erişemezler. Internette size ait bir fotograf paylaşmayın. Paylaştığınız görsellerin metadatalarını silerek paylaşın.

Kullanıcı hesap adınızda aramaya çıkmayı zorlaştırmak için emoji, latin alfasi olmayan karatker vb kullanın. Arayarak bulunmanız daha zor hale gelecektir.

