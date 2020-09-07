#!/bin/sh

set -e -u

lightdm_setup()
{
  if [ "${desktop}" == "xfce" ] ; then
    sed -i '' "s@#user-session=default@user-session=xfce@" ${release}/usr/local/etc/lightdm/lightdm.conf
    if [ -f ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf ] ; then
      echo "indicators=~host;~spacer;~clock;~spacer;~session;~language;~a11y;~sound;~power" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
      echo "background=/usr/local/share/backgrounds/ghostbsd/Arizona_Desert_Monument.jpg" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
      echo "theme-name=Vimix-Dark" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
      echo -e "icon-theme-name=Vivacious-Colors-Full-Dark\n" >> ${release}/usr/local/etc/lightdm/lightdm-gtk-greeter.conf
    fi
  elif [ "${desktop}" == "mate" ] ; then
    sed -i '' "s@#greeter-session=example-gtk-gnome@greeter-session=slick-greeter@" ${release}/usr/local/etc/lightdm/lightdm.conf
    sed -i '' "s@#user-session=default@user-session=mate@" ${release}/usr/local/etc/lightdm/lightdm.conf
    cp extra/dm/slick-greeter.conf ${release}/usr/local/etc/lightdm/slick-greeter.conf
  elif [ "${desktop}" == "kde" ] ; then
    sed -i '' "s@#greeter-session=example-gtk-gnome@greeter-session=slick-greeter@" ${release}/usr/local/etc/lightdm/lightdm.conf
    sed -i '' "s@#user-session=default@user-session=plasma@" ${release}/usr/local/etc/lightdm/lightdm.conf
    cp extra/dm/slick-greeter.conf ${release}/usr/local/etc/lightdm/slick-greeter.conf
  fi
  setup_xinit

}

gdm_setup()
{
  echo 'gdm_enable="YES"' >> ${release}/etc/rc.conf
  setup_xinit
}

setup_xinit()
{
  if [ "${desktop}" == "mate" ] ; then
    echo "exec marco &" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec feh --bg-fill /usr/local/share/backgrounds/ghostbsd/Arizona_Desert_Monument.jpg &" >> ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec sudo install-station" >> ${release}/usr/home/${liveuser}/.xinitrc
    chmod 765 ${release}/usr/home/${liveuser}/.xinitrc
    # echo "exec ck-launch-session mate-session" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec marco &" > ${release}/root/.xinitrc
    echo "exec feh --bg-fill /usr/local/share/backgrounds/ghostbsd/Arizona_Desert_Monument.jpg &" >> ${release}/root/.xinitrc
    echo "exec install-station" >> ${release}/root/.xinitrc
    chmod 765 ${release}/root/.xinitrc
    # echo "exec ck-launch-session mate-session" > ${release}/root/.xinitrc
  elif [ "${desktop}" == "xfce" ] ; then
    echo "exec ck-launch-session startxfce4" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec ck-launch-session startxfce4" > ${release}/root/.xinitrc
  elif [ "${desktop}" == "cinnamon" ] ; then
    echo "exec ck-launch-session cinnamon-session" > ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec ck-launch-session cinnamon-session" > ${release}/root/.xinitrc
  elif [ "${desktop}" == "kde" ] ; then
    echo "exec ck-launch-session startplasma-x11"> ${release}/usr/home/${liveuser}/.xinitrc
    echo "exec ck-launch-session startplasma-x11" > ${release}/root/.xinitrc
  fi
}
