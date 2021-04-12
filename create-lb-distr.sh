#!/bin/sh

#Скрипт создания дистров LinuBuh

echo
while [ -n "$1" ]
do
case "$1" in
-lb-base-de)
#Подключаем репозиторий linuxbuh

eselect repository add linuxbuh git https://github.com/linuxbuh/linuxbuh.git
emaint sync -r linuxbuh && eix-sync && eix-update

#Внести правки из репы https://github.com/linuxbuh/linuxbuh.git
mkdir -p /etc/portage/package.accept_keywords
mkdir -p /etc/portage/package.use
touch /etc/portage/package.accept_keywords/custom
touch /etc/portage/package.use/custom
cp -f /var/db/repos/linuxbuh/profiles/sets/* /etc/portage/sets/

#установливаем пакеты
emerge @lb-base-de

#Добавляем в /etc/portage/package.use флаги сборки для sys-apps/#calculate-utils
echo "sys-apps/calculate-utils backup client console dbus desktop gpg install qt5" >> /etc/portage/package.use/custom
emerge sys-apps/calculate-utils

rc-update add NetworkManager default
rc-update add acpid default
rc-update add bluetooth default
rc-update add sshd default
rc-update add xdm boot
rc-update add calculate-core boot

;;

#для tde
-tde)
#Подключаем репозиторий tde
eselect repository add trinity-official git https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo.git

#Синкаем репозиторий tde
emaint sync -r trinity-official && eix-sync && eix-update

#Копируем файл
cat /var/db/repos/trinity-official/Documentation/trinity.live.keywords | tee -a /etc/portage/package.accept_keywords/custom

#Внести правки из репы https://github.com/linuxbuh/tde.git
cd /tmp
git clone https://github.com/linuxbuh/tde.git
cat /tmp/tde/etc/portage/package.accept_keywords/custom | tee -a /etc/portage/package.accept_keywords/custom
cat /tmp/tde/etc/portage/package.use/custom | tee -a /etc/portage/package.use/custom
cp -f -R /tmp/tde/trinity-apps/* /var/db/repos/trinity-official/trinity-apps
cp -f -R /tmp/tde/trinity-base/* /var/db/repos/trinity-official/trinity-base

#для tde-base
emerge @lb-tde-base

#Создаем шаблон /etc/conf.d/xdm.clt чтобы не затерлось при обновлении #кальки
cp -f /tmp/tde/etc/conf.d/xdm.clt /etc/conf.d/xdm.clt

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
patch /etc/init.d/xdm < /tmp/tde/etc/init.d/xdm.patch

#Правим файл /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser
cp -f /tmp/tde/usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser /usr/trinity/14/share/apps/kdesktop/Desktop/Web_Browser

;;

#для tde-meta
-tde-meta)

emerge @lb-tde-meta

#Необходимо разобраться с trinity-base/tdemultimedia-meta-9999, не #собираются пакеты trinity-base/tdemultimedia-tdeioslaves-9999 и #trinity-base/tdemultimedia-arts-9999

#Необходимо разобраться с trinity-base/tdewebdev-meta-9999, не #собирается пакет trinity-base/quanta-9999

#Необходимо разобраться с trinity-apps/k3b-9999 trinity-apps/k3b-#i18n-9999

;;

-tde-update)
#При обновлении tde запустить 
emerge -av1 tqt tqtinterface dbus-1-tqt arts tdelibs && emerge -av1 `equery depends tdelibs|awk '{print " ="$1}'`
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

