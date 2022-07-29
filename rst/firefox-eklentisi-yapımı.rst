Firefox eklentisi yapımı
^^^^^^^^^^^^^^^^^^^^^^^^
**Not:** Bu yazı https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Your_first_WebExtension adresinden yararlanılarak oluşturulmuştur.

Bu yazıda sizlere basit firefox eklentisi yapmayı ve paketlemeyi anlatacağım.

1. Aşama: proje dizini
======================

Eklentimizin paketlenmesi için öncelikle bir proje dizini gerekmektedir.

.. code-block:: shell

	$ mkdir eklenti
	$ cd eklenti

Proje dizinimizde eklentinin özelliklerini belirten **manifest.json** dosyası ve eklentinin kodunu içeren javascript kodu yer almaktadır.

.. code-block:: shell

	$ tree eklenti
	eklenti/
	    ├── main.js
	    ├── icon.png
	    └── manifest.json

2. Aşama: manifest hazırlanması
===============================
Manifest dosyası eklentinin adı açıklaması sürümü ve bunun gibi bilgiler içerir. Aşağıdakine benzer formattadır.

.. code-block:: json

	{
	
	  "manifest_version": 1,
	  "name": "Eklenti deneme",
	  "version": "1.0",
	
	  "description": "Örnek eklenti",
	
	  "icons": {
	    "48": "icon.png"
	  },
	
	  "content_scripts": [
	    {
	      "matches": ["*://*.localhost/*"],
	      "js": ["main.js"]
	    }
	  ],
	  "browser_specific_settings": {
	    "gecko": {
	      "id": "test@example.org",
	      "strict_min_version": "63.0"
	    }
	  }

	}


Burada **manifest_version** eklentinin sürüm numarasını, **name** eklentinin adını, **version** gözüken sürüm numarasını, **description** eklentinin açıklamasını belirtir. **icons** kısmında eklentinin simgesi belirtilir. **content_scrippt** bölümünde ise eşleşen alan adlarında kullanılacak javascript kodları belirtilir.

**browser_specific_settings** bölümünde ise eklentinin tarayıcıya özel bölümü yer alır. Burada **id** eklentiye özel bir belirteçtir. **strict_min_version** ise gerekli olan en düşük sürümü belirtir.

Manifest ile ilgili tüm detaylara mozillanın dokümanlarından ulaşabilirsiniz.

3. Aşama: javascript kodlama
============================
Her ne kadar javascript yazmaktan nefret etsem de firefox eklentileri javascript ile yazıldığı için burada kullanmamız gereklidir.

Örnek manifestte belirttiğimiz **main.js** dosyasının içeriğini aşağıdaki gibi yazabiliriz.

.. code-block:: javascript

	document.body.textContent = "Hello World";

Yukarıdaki örnekte sayfanın body kısmını *Hello World* ile değiştirdik. Burada yazacağımız kodları firefoxta **f12** tuşuna basınca açılan konsolda yazabilirsiniz. Bu kodlar sayfa yüklendikten sonra çalıştırılır ve sayfada değişiklik yapmamıza imkan tanır.

4. Aşama: paketleme
===================
Firefox eklentileri **xpi** uzantılıdır. Bu eklentiler basit zip dosyalarıdır. proje dizinimizi ziplememiz yeterli olacaktır.

.. code-block:: shell

	$ cd eklenti
	$ zip eklenti.xpi manifest.json main.js icon.png

5. Aşama: Eklentiyi yükleme
===========================
Eklentiler güvenlik sebebi gereği normal yoldan tarayıcıya sürükle bırak yapılarak yüklenemez. Bu sebeple adres çubuğuna **about:debugging** yazarak hata ayıklama bölümünden oluşturduğumuz xpi dosyasını seçerek kurulum yapabilirsiniz.

6. Aşama: Eklenti mağazasında paylaşma
======================================
Eklentiniz tamamlandıktan sonra https://addons.mozilla.org/developers/addons adresinden firefox hesabı ile giriş yapıp eklentinizi yayınlayabilirsiniz. Eklentiler mozilla tarafından onaylandıktan sonra indirilebilir olacaktır.

