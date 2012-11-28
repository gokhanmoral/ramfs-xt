#!/sbin/busybox sh

# remount partitions with noatime
for k in $(mount | grep relatime | cut -d " " -f3);
do
mount -o remount,noatime,nodiratime,noauto_da_alloc,barrier=0 $k
done;

#enable kmem interface for everyone
echo 0 > /proc/sys/kernel/kptr_restrict

# replace kernel version info for repacked kernels
#cat /proc/version | grep infra && (k=15;for i in 83 105 121 97 104 45 49 46 54 98 49 48;do kmemhelper -t char -n linux_proc_banner -o $k $i;k=`expr $k + 1`;done;)
cat /proc/version | grep BuildUser && (kmemhelper -t string -n linux_proc_banner -o 15 `cat /res/version`)

# from /system/etc/init.qcom.post_boot.sh
echo 1 > /sys/module/rpm_resources/enable_low_power/L2_cache
echo 1 > /sys/module/rpm_resources/enable_low_power/pxo
echo 1 > /sys/module/rpm_resources/enable_low_power/vdd_dig
echo 1 > /sys/module/rpm_resources/enable_low_power/vdd_mem
echo 0 > /sys/module/pm_8x60/modes/cpu0/standalone_power_collapse/suspend_enabled
echo 0 > /sys/module/pm_8x60/modes/cpu1/standalone_power_collapse/suspend_enabled
echo 0 > /sys/module/pm_8x60/modes/cpu0/standalone_power_collapse/idle_enabled
echo 0 > /sys/module/pm_8x60/modes/cpu1/standalone_power_collapse/idle_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu0/power_collapse/suspend_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu1/power_collapse/suspend_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu0/power_collapse/idle_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu1/power_collapse/idle_enabled
echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 85 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
echo 30000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
chown system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chown root.system /sys/devices/system/cpu/mfreq
chmod 220 /sys/devices/system/cpu/mfreq
chown root.system /sys/devices/system/cpu/cpu1/online
chmod 664 /sys/devices/system/cpu/cpu1/online

chown system /sys/devices/platform/rs300000a7.65536/force_sync
chown system /sys/devices/platform/rs300000a7.65536/sync_sts
chown system /sys/devices/platform/rs300100a7.65536/force_sync
chown system /sys/devices/platform/rs300100a7.65536/sync_sts

start mpdecision
