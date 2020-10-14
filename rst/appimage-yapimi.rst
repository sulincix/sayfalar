AppImage paketleme
====================

Bu belgede bir **AppDir** oluşturup ardından **AppImage** dosyası üretmeyi anlatacağız.

AppDir oluşturma
********************
Proje dizinimize aşağıdakine benzer proje dizini açarak işe başlayalım.

.. code-block:: shell

	MyApp.AppDir/
	MyApp.AppDir/AppRun
	MyApp.AppDir/myapp.desktop
	MyApp.AppDir/myapp.png
	MyApp.AppDir/usr/bin/myapp
	MyApp.AppDir/usr/lib/libfoo.so.0

Bu doküman boyunca **MyApp.AppDir** dizinini proje dizini olarak kuıllanacağım.

Desktop Dosyası
^^^^^^^^^^^^^^^^^^^^^
Bu dosya uygulama ile ilgili bilgileri içerir. (Uygulama simgesi adı vb.) Deneme amaçlı bu dosyadan bir dane oluşturalım.

.. code-block:: shell

    $ cat > myapp.desktop << EOF
    > [Desktop Entry]
    > Name=MyApp
    > Exec=myapp
    > Icon=myapp
    > Type=Application
    > Categories=Utility;
    > EOF

Uygulama simgesi
^^^^^^^^^^^^^^^^^^^^^^
Bu dosyanın adı desktop dosyası ile aynı olmalıdır. Uygulama simgesini belirlemeye yarar. Deneme amaçlı boş dosya açsak işimizi görür :)

.. code-block:: shell

    $ touch myapp.png


AppRun Dosyası
^^^^^^^^^^^^^^^^^^^^^
AppRun dosyamız çalıştırılabilir dosya olmak zorunda ve **$PATH** değerini ayarlamak zorunda. AppImage dosyası çalıştırıldığında **$APPDIR** değişkeni ile ifade edilen dizinine bağlanır ve **AppRun** dosyası çalıştırılır. Deneme amaçlı AppRun dosyası oluşturalım. Ekrana çalıştırınca *Hello World* yazdırsın.

.. code-block:: shell

    $ cat > AppRun << EOF
    > #!/bin/bash
    > echo "Hello Word"
    > EOF

Eğer script dili ile çalışan **AppRun** yazıyorsanız başına interpreter belirtecini **(#!/bin/bash)** eklemeyi unutmayın. Genellikle bash scriptleri tercih edilir.
   
.. code-block:: shell
   
   $ chmod +x AppRun

AppRun dosyasında en sona aşağıdaki ifadeyi eklerseniz desktop dosyasındaki **Exec** değerini kullanarak asıl uygulamayı başlatır.

.. code-block:: shell
   
    $ cat >> AppRun << EOF
    > EXEC=$(grep -e "^Exec=.*" "${HERE}"/*.desktop | head -n 1 | cut -d "=" -f 2 | cut -d " " -f 1)'
    > exec "${EXEC}" "$@"
    > EOF


Paketleme aşaması
************************
`appimagetool <https://github.com/AppImage/AppImageKit/releases>`_ indirin ve çalıştırılabilir yapın.

Ardından **appimagetool** ile projenizi örnekteki gibi paketleyin. 

Kullanımı *ARCH=x86_64 appimagetool [proje dizini]*

.. code-block:: shell

    $ ARCH=x86_64 ./appimagetool-x86_64.AppImage MyApp.AppDir/
    appimagetool, continuous build (commit effcebc), build 2084 built on 2019-05-01 21:02:41 UTC
    Using architecture x86_64
    /home/a/test/MyApp.AppDir should be packaged as MyApp-x86_64.AppImage
    Deleting pre-existing .DirIcon
    Creating .DirIcon symlink based on information from desktop file
    WARNING: AppStream upstream metadata is missing, please consider creating it
             in usr/share/metainfo/myapp.appdata.xml
             Please see https://www.freedesktop.org/software/appstream/docs/chap-Quickstart.html#sect-Quickstart-DesktopApps
             for more information or use the generator at http://output.jsbin.com/qoqukof.
    Generating squashfs...
    Parallel mksquashfs: Using 4 processors
    Creating 4.0 filesystem on MyApp-x86_64.AppImage, block size 131072.
    [===================================================================|] 2/2 100%
    
    Exportable Squashfs 4.0 filesystem, gzip compressed, data block size 131072
    	compressed data, compressed metadata, compressed fragments, compressed xattrs
    	duplicates are removed
    Filesystem size 0.46 Kbytes (0.00 Mbytes)
    	78.26% of uncompressed filesystem size (0.58 Kbytes)
    Inode table size 97 bytes (0.09 Kbytes)
    	49.74% of uncompressed inode table size (195 bytes)
    Directory table size 97 bytes (0.09 Kbytes)
    	87.39% of uncompressed directory table size (111 bytes)
    Number of duplicate files found 2
    Number of inodes 6
    Number of files 4
    Number of fragments 1
    Number of symbolic links  1
    Number of device nodes 0
    Number of fifo nodes 0
    Number of socket nodes 0
    Number of directories 1
    Number of ids (unique uids + gids) 1
    Number of uids 1
    	root (0)
    Number of gids 1
    	root (0)
    Embedding ELF...
    Marking the AppImage as executable...
    Embedding MD5 digest
    Success

    Please consider submitting your AppImage to AppImageHub, the crowd-sourced
    central directory of available AppImages, by opening a pull request
    at https://github.com/AppImage/appimage.github.io

Oluşan **AppImage** dosyamızı çalıştıralım.


.. code-block:: shell

    $ ./MyApp-x86_64.AppImage 
    Hello Word

AppImage paketi için önemli notlar
*************************************

Hardcoded konumlar
^^^^^^^^^^^^^^^^^^^^
İkili dosyalarda hardcoded konum bulunmamalı. Eğer bulunuyorsa yama atılmalı.

Aşağıdaki komutla hardcoded konum var mı öğrenebiliriz:

.. code-block:: shell

    $ strings MyApp.AppDir/usr/bin/myapp | grep /usr

Aşağıdaki komutla yama atabiliriz:

.. code-block:: shell

    $ sed -i -e 's#/usr#././#g' MyApp.AppDir/usr/bin/myapp

Burada ././ 4 karakterlidir (/usr ile aynı uzunlukta) ve burası anlamına gelmektedir. Farklı bir konumu tarif ettirmeyiniz.

GLib şemaları
^^^^^^^^^^^^^^^^
Uygulamanız eğer **glib şeması** içeriyorsa **AppRun** dosyanızda şema konumunu tanımlamalısınız. Ayrıca paketlemeden önce şemayı derlemeniz gerekmektedir.

Aşağıdaki ifadeyi **AppRun** içerisine yazın:

.. code-block:: shell

    $ cat >> AppRun << EOF
    > export GSETTINGS_SCHEMA_DIR="${HERE}/usr/share/glib-2.0/schemas/${GSETTINGS_SCHEMA_DIR:+:$GSETTINGS_SCHEMA_DIR}"
    > EOF

**glib şemasını** derlemek için aşağıdaki komutu kullanın:

.. code-block:: shell


    $ glib-compile-schemas MyApp.AppDir/usr/share/glib-2.0/schemas/

Bazı gerekli çevresel değişkenler
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Uygulamaların düzgün çalışabilmesi için **LD_LIBRARY_PATH** **PATH** **PYTHON_PATH** değişkenlerinin ayarlanması gerekir. Aşağıdaki ifadeyi **AppRun** içerisine yazın:

.. code-block:: shell

    $ cat >> AppRun << EOF
    > export SELF=$(readlink -f "$0")
    > export HERE=${SELF%/*}
    > export LD_LIBRARY_PATH="${HERE}/usr/lib/:${HERE}/usr/lib/i386-linux-gnu/:${HERE}/usr/lib/x86_64-linux-gnu/:${HERE}/usr/lib32/:${HERE}/usr/lib64/:${HERE}/lib/:${HERE}/lib/i386-linux-gnu/:${HERE}/lib/x86_64-linux-gnu/:${HERE}/lib32/:${HERE}/lib64/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"'
    > export PATH="${HERE}/usr/bin/:${HERE}/usr/sbin/:${HERE}/usr/games/:${HERE}/bin/:${HERE}/sbin/${PATH:+:$PATH}"
    > export PYTHONPATH="${HERE}/usr/share/pyshared/${PYTHONPATH:+:$PYTHONPATH}"
    > export PERLLIB="${HERE}/usr/share/perl5/:${HERE}/usr/lib/perl5/${PERLLIB:+:$PERLLIB}"
    > EOF

Xdg dizinleri
^^^^^^^^^^^^^^^^^
Uygulamanızın **xdg dizinleri** varsa onları da tanımlamanız gereklidir. (örneğin */usr/share*)

Aşağıdaki ifadeyi **AppRun** içine yazın:

.. code-block:: shell

    $ cat >> AppRun << EOF
    > export XDG_DATA_DIRS="${HERE}/usr/share/${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    > EOF

Qt plugin dizinleri
^^^^^^^^^^^^^^^^^^^^
Uygulamanız **qt** tabanlı ise **qt plugin** dizinlerini tanımlamalısınız.

Aşağıdaki ifadeyi **AppRun** içine yazın:

.. code-block:: shell

    $ cat >> AppRun << EOF
    > export QT_PLUGIN_PATH="${HERE}/usr/lib/qt4/plugins/:${HERE}/usr/lib/i386-linux-gnu/qt4/plugins/:${HERE}/usr/lib/x86_64-linux-gnu/qt4/plugins/:${HERE}/usr/lib32/qt4/plugins/:${HERE}/usr/lib64/qt4/plugins/:${HERE}/usr/lib/qt5/plugins/:${HERE}/usr/lib/i386-linux-gnu/qt5/plugins/:${HERE}/usr/lib/x86_64-linux-gnu/qt5/plugins/:${HERE}/usr/lib32/qt5/plugins/:${HERE}/usr/lib64/qt5/plugins/${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}"
    > EOF

