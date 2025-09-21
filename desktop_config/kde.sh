#!/bin/sh

set -e -u

. "${cwd}/common_config/autologin.sh"
. "${cwd}/common_config/base-setting.sh"
. "${cwd}/common_config/finalize.sh"
. "${cwd}/common_config/setuser.sh"

lightdm_setup()
{
  sed -i '' "s@#greeter-session=example-gtk-gnome@greeter-session=slick-greeter@" "${release}/usr/local/etc/lightdm/lightdm.conf"
  sed -i '' "s@#user-session=default@user-session=startplasma-x11@" "${release}/usr/local/etc/lightdm/lightdm.conf"

# kde messaging
  cat "${cwd}/desktop_config/patches/etc/kde-sysctl.extra" >> "${release}/etc/sysctl.conf"
}

setup_xinit()
{
  # Disable screen locking in KDE for live_user
  chroot "${release}" su "${live_user}" -c "
    mkdir -p /home/${live_user}/.config
    kwriteconfig5 --file /home/${live_user}/.config/kscreenlockerrc --group Daemon --key Autolock false
    kwriteconfig5 --file /home/${live_user}/.config/kscreenlockerrc --group Daemon --key LockOnResume false
    echo 'exec dbus-launch --exit-with-x11 ck-launch-session startplasma-x11' > /home/${live_user}/.xinitrc
  "

  # Set the same .xinitrc for root and skel
  echo "exec dbus-launch --exit-with-x11 ck-launch-session startplasma-x11" > "${release}/root/.xinitrc"
  echo "exec dbus-launch --exit-with-x11 ck-launch-session startplasma-x11" > "${release}/usr/share/skel/dot.xinitrc"
}

patch_etc_files
community_setup_liveuser
community_setup_autologin
lightdm_setup
setup_xinit
final_setup
