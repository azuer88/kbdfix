#!/bin/sh -e

echo "** PostInstall script"
INSERT_TEXT="${DESTDIR}/usr/bin/kbdfix"
TARGET_FILE="${DESTDIR}/etc/rc.local"

# modify TARGET_FILE, insert INSERT_TEXT before the last line.
#awk '{new=$0; print old; old=new}END{print "'${INSERT_TEXT}'"; print old}' $TARGET_FILE > `basename $TARGET_FILE`
#NEW_FILE=`basename $TARGET_FILE`
echo "-- Installing $TARGET_FILE"
mkdir -p `dirname $TARGET_FILE`
head $TARGET_FILE -n -1 > $TARGET_FILE
echo "$INSERT_TEXT\nexit 0" >> $TARGET_FILE
chmod +x $TARGET_FILE

TARGET_FILE="${DESTDIR}/etc/pm/sleep.d/99-kbdfix"
echo "-- Installing $TARGET_FILE"
mkdir -p `dirname $TARGET_FILE`
(
cat <<EOF 
#!/bin/bash

case "${1}" in
    resume|thaw)
        /usr/sbin/kbdfix
    ;;
esac
EOF
) > $TARGET_FILE
chmod +x $TARGET_FILE

echo "** PostInstall script done."
