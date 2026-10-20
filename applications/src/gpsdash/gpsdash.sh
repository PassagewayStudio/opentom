#!/bin/sh
# Launcher for gpsdash: starts the TomTom GPS daemon (glgps), runs the
# dashboard, then stops the GPS again so it does not drain the battery.
cd /mnt/sdcard
ln -sf ttySAC1 /dev/gpsdata
mkdir -p /var/run/gl
[ -e /var/run/gpspipe ] || mknod /var/run/gpspipe p
if [ -z "`pidof glgps`" ]; then
	/mnt/sdcard/bin/glgps normal > /tmp/glgps.log 2>&1 &
	sleep 2
fi
/mnt/sdcard/opentom/bin/gpsdash
killall glgps 2>/dev/null
sleep 2
killall -9 glgps 2>/dev/null
exit 0
