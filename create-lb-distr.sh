#!/bin/sh

#Убираем лишние языки
echo 'LINGUAS="en ru"' >> /etc/portage/make.conf/custom

#Скрипт создания дистров LinuBuh

echo
while [ -n "$1" ]
do
case "$1" in
-lb-base-desktop)
#Подключаем репозиторий linuxbuh

eselect repository add linuxbuh git https://github.com/linuxbuh/linuxbuh.git
emaint sync -r linuxbuh && eix-sync && eix-update

#Внести правки из репы https://github.com/linuxbuh/linuxbuh.git
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
touch /etc/portage/package.accept_keywords/custom
touch /etc/portage/package.use/custom
cp -f /var/db/repos/linuxbuh/profiles/sets/* /etc/portage/sets/
cat /var/db/repos/linuxbuh/profiles/package.accept_keywords.lb-base-desktop | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh/profiles/package.use.lb-base-desktop | tee -a /etc/portage/package.use/custom

#установливаем пакеты
emerge @lb-base-desktop

emerge sys-apps/calculate-utils

rc-update add NetworkManager default
rc-update add acpid default
rc-update add bluetooth default
rc-update add sshd default
rc-update add xdm boot
rc-update add calculate-core boot

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
#cp -f -r /var/db/repos/linuxbuh-tde/trinity-apps/* /var/db/repos/trinity-official/trinity-apps/
#cp -f -r /var/db/repos/linuxbuh-tde/trinity-base/* /var/db/repos/trinity-official/trinity-base/
cp -f -r /var/db/repos/linuxbuh-tde/trinity-base/tdebase-pam/tdebase-pam-7.ebuild /var/db/repos/trinity-official/trinity-base/tdebase-pam/tdebase-pam-7.ebuild
cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-base-live /etc/portage/sets/lb-tde-base-live
cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-meta-live /etc/portage/sets/lb-tde-meta-live

#для tde-base
emerge @lb-tde-base-live

#Создаем шаблон /etc/conf.d/xdm.clt чтобы не затерлось при обновлении #кальки
cp -f /var/db/repos/linuxbuh-tde/profiles/etc/conf.d/xdm.clt /etc/conf.d/xdm.clt

#Копируем шаблон /etc/conf.d/xdm.clt в /etc/conf.d/xdm
cp -f /etc/conf.d/xdm.clt /etc/conf.d/xdm

#Добавить в файл /etc/init.d/xdm после строк 
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
patch /etc/init.d/xdm < /var/db/repos/linuxbuh-tde/profiles/etc/init.d/xdm.patch

#Правим файл /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser
cp -f /var/db/repos/linuxbuh-tde/profiles/usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser

;;

#для tde-meta
-lb-tde-meta-live)

emerge @lb-tde-meta-live

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
eselect repository add trinity-official git https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo.git
#Внести правки из репы https://github.com/linuxbuh/linuxbuh-tde.git
eselect repository add linuxbuh-tde git https://github.com/linuxbuh/linuxbuh-tde.git
#Синкаем репозиторий tde
emaint sync -r trinity-official && emaint sync -r linuxbuh-tde && eix-sync && eix-update

#Копируем файл
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.accept_keywords/custom-14.0.8 | tee -a /etc/portage/package.accept_keywords/custom
cat /var/db/repos/linuxbuh-tde/profiles/etc/portage/package.use/custom-14.0.8 | tee -a /etc/portage/package.use/custom
cp -f -r /var/db/repos/linuxbuh-tde/trinity-base/tdebase-pam/tdebase-pam-7.ebuild /var/db/repos/trinity-official/trinity-base/tdebase-pam/tdebase-pam-7.ebuild
cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-base-14.0.8 /etc/portage/sets/lb-tde-base
cp -f -r /var/db/repos/linuxbuh-tde/profiles/etc/portage/sets/lb-tde-meta-14.0.8 /etc/portage/sets/lb-tde-meta

#для tde-base
emerge @lb-tde-base

#Создаем шаблон /etc/conf.d/xdm.clt чтобы не затерлось при обновлении #кальки
cp -f /var/db/repos/linuxbuh-tde/profiles/etc/conf.d/xdm.clt /etc/conf.d/xdm.clt

#Копируем шаблон /etc/conf.d/xdm.clt в /etc/conf.d/xdm
cp -f /etc/conf.d/xdm.clt /etc/conf.d/xdm

#Добавить в файл /etc/init.d/xdm после строк 
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
patch /etc/init.d/xdm < /var/db/repos/linuxbuh-tde/profiles/etc/init.d/xdm.patch

#Правим файл /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser
cp -f /var/db/repos/linuxbuh-tde/profiles/usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser

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
emerge @lb-apps-network
rc-update add anydesk default
;;

-lb-apps-1c)
emerge @lb-apps-1c
rc-update add aksusbd default
rc-update add hasplm default
rc-update add hasplmd default
rc-update add multipath boot
;;

-lb-apps-office)
emerge @lb-apps-office
;;

*) echo "$1 is not an option" ;;
esac
shift
done

