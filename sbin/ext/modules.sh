#!/sbin/busybox sh

mount -t tmpfs tmpfs /system/lib/modules
ln -s /lib/modules/* /system/lib/modules
ln -s /lib/modules/prima_wlan.ko /system/lib/modules/wlan.ko
