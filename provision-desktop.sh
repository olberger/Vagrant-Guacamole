#!/bin/sh

# Provision the Desktop CentOS 8 machine

yum groupinstall "Xfce" -y

adduser testuser
echo testuser:testuser | chpasswd testuser

# Honor locale before starting XFCE4 session
echo '#!/bin/bash
# xrdp X session start script (c) 2015, 2017 mirabilos
# published under The MirOS Licence
if test -r /etc/profile; then
    . /etc/profile
fi
if test -r /etc/locale.conf; then
    . /etc/locale.conf
    test -z "${LANG+x}" || export LANG
    test -z "${LANGUAGE+x}" || export LANGUAGE
    test -z "${LC_ADDRESS+x}" || export LC_ADDRESS
    test -z "${LC_ALL+x}" || export LC_ALL
    test -z "${LC_COLLATE+x}" || export LC_COLLATE
    test -z "${LC_CTYPE+x}" || export LC_CTYPE
    test -z "${LC_IDENTIFICATION+x}" || export LC_IDENTIFICATION
    test -z "${LC_MEASUREMENT+x}" || export LC_MEASUREMENT
    test -z "${LC_MESSAGES+x}" || export LC_MESSAGES
    test -z "${LC_MONETARY+x}" || export LC_MONETARY
    test -z "${LC_NAME+x}" || export LC_NAME
    test -z "${LC_NUMERIC+x}" || export LC_NUMERIC
    test -z "${LC_PAPER+x}" || export LC_PAPER
    test -z "${LC_TELEPHONE+x}" || export LC_TELEPHONE
    test -z "${LC_TIME+x}" || export LC_TIME
    test -z "${LOCPATH+x}" || export LOCPATH
fi
if test -r /etc/profile; then
    . /etc/profile
fi

#echo "mode:             blank" > $HOME/.xscreensaver

#xfconf-query -c xfwm4 -p /general/workspace_count -s 1
#xfconf-query -c xfce4-session -np "/shutdown/ShowSuspend" -t "bool" -s "false"
#xfconf-query -c xfce4-session -np "/shutdown/ShowHibernate" -t "bool" -s "false"

#test -x /etc/X11/Xsession && exec /etc/X11/Xsession
#exec /bin/sh /etc/X11/Xsession
exec /bin/sh /usr/bin/startxfce4
' > /home/testuser/startwm.sh.test

echo "PREFERRED=xfce4-session
" > /etc/sysconfig/desktop

chown testuser:testuser /home/testuser/startwm.sh
chmod +x /home/testuser/startwm.sh

yum install -y xrdp
yum install -y xorgxrdp

echo 'allowed_users = anybody
' > /etc/X11/Xwrapper.config

systemctl enable xrdp
systemctl start xrdp

