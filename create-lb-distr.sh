#!/bin/sh

# ПРИ СБОРКЕ НОВОГО ДИСТРА С CLS НУЖНО УКАЗАТЬ ДВА ФЛАГА -lb-add-linuxbuh и -lb-base-desktop

#Убираем лишние языки
#echo 'LINGUAS="en ru"' >> /etc/portage/make.conf/custom
#или
#echo 'L10N="en ru"' >> /etc/portage/make.conf/custom
#emerge -uDNa world

#Скрипт создания дистров LinuBuh

echo
while [ -n "$1" ]
do
case "$1" in

-lb-add-linuxbuh)
#Подключаем репозиторий linuxbuh
eselect repository add linuxbuh git https://github.com/linuxbuh/linuxbuh.git
emaint sync -r linuxbuh && eix-sync && eix-update
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
touch /etc/portage/package.accept_keywords/custom
touch /etc/portage/package.use/custom
ln -f /var/db/repos/linuxbuh/profiles/sets/* /etc/portage/sets/
#cp -r /var/db/repos/linuxbuh/profiles/sets/* /etc/portage/sets/

;;

-lb-base-desktop)

#Внести правки из репы https://github.com/linuxbuh/linuxbuh.git для desktop

cat /var/db/repos/linuxbuh/profiles/package.accept_keywords.lb-base-desktop | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh/profiles/package.use.lb-base-desktop | tee -a /etc/portage/package.use/custom

#установливаем пакеты
emerge @lb-base-desktop

emerge sys-apps/calculate-utils

rc-update add NetworkManager default
rc-update add acpid default
rc-update add bluetooth default
rc-update add sshd default
rc-update add display-manager boot
rc-update add calculate-core boot

;;

-lb-w10)

emerge -C app-office/libreoffice mail-client/claws-mail media-gfx/calculate-wallpapers x11-themes/claws-mail-theme-calculate www-client/chromium

emerge x11-themes/kali-undercover

;;

#для lb-tde-base-live
-lb-tde-base-live)
#Подключаем репозиторий tde
eselect repository add trinity-official git https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo.git
#Внести правки из репы https://github.com/linuxbuh/linuxbuh-tde.git
eselect repository add linuxbuh-tde git https://github.com/linuxbuh/linuxbuh-tde.git
#Синкаем репозиторий tde
emaint sync -r trinity-official && emaint sync -r linuxbuh-tde && eix-sync && eix-update

#Копируем файл
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
cat /var/db/repos/trinity-official/Documentation/trinity.live.keywords | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.accept_keywords/custom-live | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.use/custom-live | tee -a /etc/portage/package.use/custom
cp -r /var/db/repos/linuxbuh-tde/trinity-base/tdebase-pam/tdebase-pam-7.ebuild /var/db/repos/trinity-official/trinity-base/tdebase-pam/tdebase-pam-7.ebuild
cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-base /etc/portage/sets/lb-tde-base
#cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-meta-live /etc/portage/sets/lb-tde-meta-live

#для tde-base
emerge @lb-tde-base

#Создаем шаблон /etc/conf.d/display-manager.clt чтобы не затерлось при обновлении #кальки
cp -r /var/db/repos/linuxbuh-tde/profiles/etc/conf.d/display-manager.clt /etc/conf.d/display-manager.clt

#Копируем шаблон /etc/conf.d/display-manager.clt в /etc/conf.d/display-manager
cp -r /etc/conf.d/display-manager.clt /etc/conf.d/display-manager

#Добавить в файл /etc/init.d/display-manager после строк 
#kdm|kde)
#			EXE=/usr/bin/kdm
#			PIDFILE=/run/kdm.pid
#			;;
#
#Кусок
#tdm|tde)
#			EXE=/usr/trinity/14/bin/tdm
#			PIDFILE=/run/tdm.pid
#			;;
#или патчим
cp -r /var/db/repos/linuxbuh-tde/profiles/etc/init.d/display-manager /etc/init.d/display-manager 

rc-update add NetworkManager default
rc-update add acpid default
rc-update add bluetooth default
rc-update add sshd default
rc-update add display-manager boot
rc-update add calculate-core boot

#Правим файл /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser
cp -r /var/db/repos/linuxbuh-tde/profiles/usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser

rm -fR /var/calculate/distfiles/git3-src
;;

#для tde-meta
-lb-tde-meta-live)

emerge @lb-tde-meta

#Необходимо разобраться с trinity-base/tdemultimedia-meta-9999, не #собираются пакеты trinity-base/tdemultimedia-tdeioslaves-9999 и #trinity-base/tdemultimedia-arts-9999

#Необходимо разобраться с trinity-base/tdewebdev-meta-9999, не #собирается пакет trinity-base/quanta-9999

#Необходимо разобраться с trinity-apps/k3b-9999 trinity-apps/k3b-#i18n-9999

;;

-lb-tde-update-live)
#При обновлении tde запустить 
emerge -av1 tqt tqtinterface dbus-1-tqt arts tdelibs && emerge -av1 `equery depends tdelibs|awk '{print " ="$1}'`
;;

-lb-tde-update-lang-live)
#При обновлении tde запустить 
emerge --oneshot =tde-i18n-9999
;;

#для lb-tde-base
-lb-tde-base)
#Подключаем репозиторий tde
#eselect repository add trinity-official git https://github.com/linuxbuh/trinity-official.git
eselect repository add trinity-official git https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo.git
#Внести правки из репы https://github.com/linuxbuh/linuxbuh-tde.git
eselect repository add linuxbuh-tde git https://github.com/linuxbuh/linuxbuh-tde.git
#Синкаем репозиторий tde
emaint sync -r trinity-official && emaint sync -r linuxbuh-tde && eix-sync && eix-update

#Копируем файл
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.accept_keywords/custom | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.use/custom | tee -a /etc/portage/package.use/custom
cp -r /var/db/repos/linuxbuh-tde/trinity-base/tdebase-pam/tdebase-pam-7.ebuild /var/db/repos/trinity-official/trinity-base/tdebase-pam/tdebase-pam-7.ebuild
cp -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-base /etc/portage/sets/lb-tde-base
#cp -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-meta /etc/portage/sets/lb-tde-meta

#для tde-base
emerge @lb-tde-base

#Создаем шаблон /etc/conf.d/display-manager.clt чтобы не затерлось при обновлении #кальки
cp -r /var/db/repos/linuxbuh-tde/profiles/etc/conf.d/display-manager.clt /etc/conf.d/display-manager.clt

#Копируем шаблон /etc/conf.d/display-manager.clt в /etc/conf.d/display-manager
cp -r /etc/conf.d/display-manager.clt /etc/conf.d/display-manager

#Добавить в файл /etc/init.d/display-manager после строк 
#kdm|kde)
#			EXE=/usr/bin/kdm
#			PIDFILE=/run/kdm.pid
#			;;
#
#Кусок
#tdm|tde)
#			EXE=/usr/trinity/14/bin/tdm
#			PIDFILE=/run/tdm.pid
#			;;
#или патчим
cp -r /var/db/repos/linuxbuh-tde/profiles/etc/init.d/display-manager /etc/init.d/display-manager

rc-update add NetworkManager default
rc-update add acpid default
rc-update add bluetooth default
rc-update add sshd default
rc-update add display-manager boot
rc-update add calculate-core boot

#Правим файл /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser
cp -r /var/db/repos/linuxbuh-tde/profiles/usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser

rm -fR /var/calculate/distfiles/git3-src
;;

#для tde-meta
-lb-tde-meta)

emerge @lb-tde-meta

;;

-lb-tde-update)
#При обновлении tde запустить 
emerge -av1 tqt tqtinterface dbus-1-tqt arts tdelibs && emerge -av1 `equery depends tdelibs|awk '{print " ="$1}'`
;;

-lb-tde-update-lang)
#При обновлении tde запустить 
emerge --oneshot tde-i18n
;;

#Устанавливаем добро

-lb-apps-network)
eselect repository enable torbrowser
emaint sync -r torbrowser && eix-sync && eix-update

echo "
net-im/rambox-bin
net-misc/anydesk
www-client/torbrowser-launcher
net-misc/yandex-disk
www-client/yandex-browser-beta
www-client/microsoft-edge-beta
" >> /etc/portage/package.accept_keywords/custom

echo "
app-crypt/gpgme python
" >> /etc/portage/package.use/custom

emerge @lb-apps-network
rc-update add anydesk default
eselect fontconfig enable 60-liberation.conf

echo "
rc_hotplug="pcscd"
" >> /etc/rc.conf

;;

-lb-apps-1c)

echo "
sys-apps/hasp
" >> /etc/portage/package.accept_keywords/custom

echo "
sys-apps/hasp usb demo net_hasp wine
" >> /etc/portage/package.use/custom

emerge @lb-apps-1c =net-libs/webkit-gtk-linuxbuh-bin-2.4.11-r1 hasp
rc-update add aksusbd default
rc-update add hasplm default
rc-update add hasplmd default
rc-update add multipath boot
;;

-lb-apps-office)

echo "
app-office/onlyoffice-bin
media-gfx/vuescan
app-office/joplin-desktop-bin
" >> /etc/portage/package.accept_keywords/custom

emerge @lb-apps-office
;;

-lb-apps-rucrypto)

echo "
www-plugins/IFCPlugin
" >> /etc/portage/package.accept_keywords/custom

echo "CONFIG_PROTECT_MASK = /etc/portage" >> /etc/portage/make.conf/custom

echo "app-crypt/cryptoprocsp" >> /etc/portage/package.accept_keywords/custom
echo "www-plugins/cades" >> /etc/portage/package.accept_keywords/custom


emerge @lb-apps-rucrypto
;;

-lb-deepin)

eselect repository enable gnome-next
eselect repository add deepin git https://github.com/zhtengw/deepin-overlay.git


mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
echo "dde-*/*" >> /etc/portage/package.accept_keywords/custom
echo "dev-qt/*" >> /etc/portage/package.accept_keywords/custom

emaint sync -r deepin && emaint sync -r gnome-next && eix-sync && eix-update
cl-update -o

emerge -av dde-meta
dispatch-conf

#надо вичистить
echo "x11-libs/gsettings-qt
sys-apps/lshw
dev-go/go-dbus-generator
dev-go/dbus-factory
dev-go/go-gir-generator
dev-go/go-x11-client
dev-go/go-dbus-factory
dev-go/deepin-go-lib
x11-apps/xcur2png
media-video/deepin-movie-reborn
media-gfx/blur-effect
gnome-base/libgnome-keyring
dev-cpp/htmlcxx
dev-libs/dde-wayland
x11-wm/dde-kwin
app-accessibility/onboard
dev-libs/disomaster
virtual/dde-wm
#зависимость для dtkcore
dev-cpp/gtest
#зависимость для dde-kwin
kde-frameworks/extra-cmake-modules
#нужен для dde-control-center-5.4.9-r1
net-libs/libnma
#нужен для dde-control-center-5.4.9-r1
dev-qt/qdbusviewer
" >> /etc/portage/package.accept_keywords/custom

echo "x11-misc/lightdm qt5
dev-libs/libxslt python
virtual/dde-wm kwin
dde-base/dde-meta -terminal
#Возможно нужно персобрать для сборки dde-kwin
#dev-util/cmake qt5
" >> /etc/portage/package.use/custom

#gnome-base/libgnome-keyring-3.12.0-r3
#меняем строку python3_ добавляем 8

emerge dde-meta lightdm

rc-update add dbus default
rc-update add display-manager default
rc-update add NetworkManager default
rc-update add elogind boot

rc-update del dhcpcd default

glib-compile-schemas /usr/share/glib-2.0/schemas/

emerge -av dde-extra/deepin-editor dde-extra/deepin-compressor dde-extra/deepin-calculator

;;

-lb-pantheon)

echo "x11-misc/plank
pantheon-base/pantheon-settings
" >> /etc/portage/package.accept_keywords/custom
;;

-lb-xfce)

#Делаем на основе CLDX
emerge -C chromium libreoffice x11-themes/claws-mail-theme-calculate media-gfx/calculate-wallpapers mail-client/claws-mail
emerge x11-themes/kali-undercover x11-themes/linuxbuh-backgrounds-micro mousepad

;;

-lb-lxde)

emerge lxde-base/lxde-meta media-gfx/lxdm-themes-calculate lxde-base/lxdm app-editors/leafpad media-gfx/gpicview x11-misc/obconf x11-misc/pcmanfm

#Копируем шаблон /etc/conf.d/display-manager.clt в /etc/conf.d/display-manager
cp -r /etc/conf.d/display-manager /etc/conf.d/display-manager.clt
rc-update add display-manager boot
;;

-lb-icewm)

emerge app-editors/leafpad media-gfx/gpicview x11-misc/obconf x11-misc/pcmanfm gnome-extra/nm-applet x11-themes/iceicons gnustep-apps/terminal app-misc/mc media-gfx/lightdm-themes-calculate

#Копируем шаблон /etc/conf.d/display-manager.clt в /etc/conf.d/display-manager
cp -r /etc/conf.d/display-manager /etc/conf.d/display-manager.clt
rc-update add display-manager boot
;;

*) echo "$1 is not an option" ;;
esac
shift
done

