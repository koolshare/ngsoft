#!/bin/sh
export KSROOT=/jffs/koolshare
source $KSROOT/scripts/base.sh

# stop kms first
enable=`dbus get kms_enable`
if [ "$enable" == "1" ];then
	restart=1
	dbus set kms_enable=0
	sh $KSROOT/scripts/kms.sh
fi

# cp files
cp -rf /tmp/kms/scripts/* $KSROOT/scripts/
cp -rf /tmp/kms/bin/* $KSROOT/bin/
cp -rf /tmp/kms/webs/* $KSROOT/webs/
cp -rf /tmp/kms/res/* $KSROOT/res/

# delete install tar
rm -rf /tmp/kms* >/dev/null 2>&1

chmod a+x $KSROOT/scripts/kms.sh
chmod 0755 $KSROOT/bin/vlmcsd

# re-enable kms
if [ "$restart" == "1" ];then
	dbus set kms_enable=1
	sh $KSROOT/scripts/kms.sh
fi
