AppImage paketleme
====================

Bu belgede manuel olarak bir AppDir oluşturup ardından appimage dosyası üretmeyi anlatacağız.


AppDir oluşturma
^^^^^^^^^^^^^^^^^^^^
Proje dizinimize aşağıdakine benzer dizinler açarak işe başlayalım

.. code-block: shell

	MyApp.AppDir/
	MyApp.AppDir/AppRun
	MyApp.AppDir/myapp.desktop
	MyApp.AppDir/myapp.png
	MyApp.AppDir/usr/bin/myapp
	MyApp.AppDir/usr/lib/libfoo.so.0

AppRun Dosyası
^^^^^^^^^^^^^^^^^^^^^
AppRun dosyamız çalıştırılabilir dosya olmak zorunda ve :code:`$PATH` değerini ayarlamak zorunda. AppImage dosyası çalıştırıldığında :code:`$APPDIR` değişkeni ile ifade edilen dizinine bağlanır ve AppRun dosyası çalıştırılır. Deneme amaçlı AppRun dosyası oluşturalım. Ekrana çalıştırınca *Hello World* yazdırsın.

.. code-block: shell

    a@pardus:~/test/proj$ cat > AppRun << EOF
    > echo "Hello Word"
    > EOF
    a@pardus:~/test/proj$ chmod +x AppRun

Desktop Dosyası
^^^^^^^^^^^^^^^^^^^^^
Bu dosya appimage ile ilgili bilgileri içerir. (Uygulama simgesi adı vb.) Deneme amaçlı bu dosyadan bir dane oluşturalım.

.. code-block: shell

    a@pardus:~/test/proj$ cat > myapp.desktop << EOF
    > [Desktop Entry]
    > Name=MyApp
    > Exec=myapp
    > Icon=myapp
    > Type=Application
    > Categories=Utility;
    > EOF

Paketleme aşaması
^^^^^^^^^^^^^^^^^^^^^^
`appimagetool <https://github.com/AppImage/AppImageKit/releases>`_ indirin ve çalıştırılabilir yapın.
