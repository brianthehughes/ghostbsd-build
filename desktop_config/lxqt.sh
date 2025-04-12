#!/bin/sh

set -e -u

. "${cwd}/common_config/autologin.sh"
. "${cwd}/common_config/base-setting.sh"
. "${cwd}/common_config/finalize.sh"
. "${cwd}/common_config/setuser.sh"

lightdm_setup()
{
  sed -i '' "s@#greeter-session=example-gtk-gnome@greeter-session=slick-greeter@" "${release}/usr/local/etc/lightdm/lightdm.conf"
  sed -i '' "s@#user-session=default@user-session=startlxqt@" "${release}/usr/local/etc/lightdm/lightdm.conf"
}

setup_xinit()
{
  chroot "${release}" su "${live_user}" -c "echo 'exec lxqt-session' > /home/${live_user}/.xinitrc"
  echo "exec dbus-launch --exit-with-x11 ck-launch-session startlxqt" > "${release}/root/.xinitrc"
  echo "exec dbus-launch --exit-with-x11 ck-launch-session startlxqt" > "${release}/usr/share/skel/dot.xinitrc"
}

patch_etc_files
community_setup_liveuser
community_setup_autologin
lightdm_setup
setup_xinit
final_setup
