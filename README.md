# kbdfix
fix keyboard issue with lenovo S10-3C

I got the c code from: http://blog.yjl.im/2010/08/disable-laptop-ps2-at-keyboard-i8042.html

# usage
```
$ git clone https://www.github.com/azuer88/kbdfix.git
$ cd kbdfix
$ mkdir build && cd $_
$ cmake .. & sudo make install
```

this will install the kbdfix into the /usr/sbin and modify /etc/rc.local to call /usr/sbin/kbdfix.  it will also install /etc/pm/sleep.d so that when the machine resumes from sleep, it will reactivate the keyboard.

# contact
blue.cuenca@gmail.com

