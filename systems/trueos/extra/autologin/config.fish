
if not test -f /tmp/.xstarted
  touch /tmp/.xstarted
  set tty (tty)
  if test $tty = "/dev/ttyv0"
    exec startx
  end
end
