#!/system/bin/sh
# Logging
#/sbin/busybox cp /data/user.log /data/user.log.bak
#/sbin/busybox rm /data/user.log
#exec >>/data/user.log
#exec 2>&1

mkdir /data/.archi
chmod 777 /data/.archi
 
. /res/customconfig/customconfig-helper

ccxmlsum=`md5sum /res/customconfig/customconfig.xml | awk '{print $1}'`
if [ "a${ccxmlsum}" != "a`cat /data/.archi/.ccxmlsum`" ];
then
  rm -f /data/.archi/*.profile
  echo ${ccxmlsum} > /data/.archi/.ccxmlsum
fi
[ ! -f /data/.archi/default.profile ] && cp /res/customconfig/default.profile /data/.archi
[ ! -f /data/.archi/battery.profile ] && cp /res/customconfig/battery.profile /data/.archi
[ ! -f /data/.archi/balanced.profile ] && cp /res/customconfig/balanced.profile /data/.archi
[ ! -f /data/.archi/performance.profile ] && cp /res/customconfig/performance.profile /data/.archi

read_defaults
read_config

#cpu min & max frequencies
echo "${scaling_min_freq}" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "${scaling_max_freq}" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

echo "${int_scheduler}" > /sys/block/mmcblk0/queue/scheduler
echo "${int_read_ahead_kb}" > /sys/block/mmcblk0/bdi/read_ahead_kb
echo "${ext_scheduler}" > /sys/block/mmcblk1/queue/scheduler
echo "${ext_read_ahead_kb}" > /sys/block/mmcblk1/bdi/read_ahead_kb

# apply STweaks defaults
export CONFIG_BOOTING=1
/res/uci.sh apply
export CONFIG_BOOTING=

##### CPU settings #####

case "$default_governor" in

  0)
        echo "pegasusq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo $pegasusq_cpu_down_freq > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_down_freq
        echo $pegasusq_cpu_down_rate > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_down_rate
        echo $pegasusq_cpu_up_freq > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_up_freq
        echo $pegasusq_cpu_up_rate > /sys/devices/system/cpu/cpufreq/pegasusq/cpu_up_rate
        echo $pegasusq_down_differential > /sys/devices/system/cpu/cpufreq/pegasusq/down_differential
        echo $pegasusq_freq_for_responsiveness > /sys/devices/system/cpu/cpufreq/pegasusq/freq_for_responsiveness
        echo $pegasusq_freq_step > /sys/devices/system/cpu/cpufreq/pegasusq/freq_step
        echo $pegasusq_hotplug_freq_1_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_1_1
        echo $pegasusq_hotplug_freq_2_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_2_0
        echo $pegasusq_hotplug_freq_2_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_2_1
        echo $pegasusq_hotplug_freq_3_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_3_0
        echo $pegasusq_hotplug_freq_3_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_3_1
        echo $pegasusq_hotplug_freq_4_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_freq_4_0
        echo $pegasusq_hotplug_rq_1_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_1_1
        echo $pegasusq_hotplug_rq_2_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_2_0
        echo $pegasusq_hotplug_rq_2_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_2_1
        echo $pegasusq_hotplug_rq_3_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_3_0
        echo $pegasusq_hotplug_rq_3_1 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_3_1
        echo $pegasusq_hotplug_rq_4_0 > /sys/devices/system/cpu/cpufreq/pegasusq/hotplug_rq_4_0
        echo $pegasusq_ignore_nice_load > /sys/devices/system/cpu/cpufreq/pegasusq/ignore_nice_load
        echo $pegasusq_io_is_busy > /sys/devices/system/cpu/cpufreq/pegasusq/io_is_busy
        echo $pegasusq_sampling_down_factor > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
        echo $pegasusq_sampling_rate > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
        echo $pegasusq_sampling_rate_min > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate_min
        echo $pegasusq_up_nr_cpus > /sys/devices/system/cpu/cpufreq/pegasusq/up_nr_cpus
        echo $pegasusq_up_threshold > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold       
        echo $pegasusq_up_threshold_at_min_freq > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold_at_min_freq
        echo $min_cpu_lock > /sys/devices/system/cpu/cpufreq/pegasusq/min_cpu_lock
        echo $max_cpu_lock > /sys/devices/system/cpu/cpufreq/pegasusq/max_cpu_lock
  ;; 
  1)
        echo "lulzactiveq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo $lulzactiveq_cpu_down_rate > /sys/devices/system/cpu/cpufreq/lulzactiveq/cpu_down_rate
        echo $lulzactiveq_cpu_up_rate > /sys/devices/system/cpu/cpufreq/lulzactiveq/cpu_up_rate
        echo $lulzactiveq_dec_cpu_load > /sys/devices/system/cpu/cpufreq/lulzactiveq/dec_cpu_load
        echo $lulzactiveq_inc_cpu_load > /sys/devices/system/cpu/cpufreq/lulzactiveq/inc_cpu_load
        echo $lulzactiveq_down_sample_time > /sys/devices/system/cpu/cpufreq/lulzactiveq/down_sample_time
        echo $lulzactiveq_up_sample_time > /sys/devices/system/cpu/cpufreq/lulzactiveq/up_sample_time
        echo $lulzactiveq_freq_table > /sys/devices/system/cpu/cpufreq/lulzactiveq/freq_table
        echo $lulzactiveq_hispeed_freq > /sys/devices/system/cpu/cpufreq/lulzactiveq/hispeed_freq
        echo $lulzactiveq_hotplug_freq_1_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_1_1
        echo $lulzactiveq_hotplug_freq_2_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_2_0
        echo $lulzactiveq_hotplug_freq_2_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_2_1
        echo $lulzactiveq_hotplug_freq_3_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_3_0
        echo $lulzactiveq_hotplug_freq_3_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_3_1
        echo $lulzactiveq_hotplug_freq_4_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_freq_4_0
        echo $lulzactiveq_hotplug_rq_1_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_1_1
        echo $lulzactiveq_hotplug_rq_2_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_2_0
        echo $lulzactiveq_hotplug_rq_2_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_2_1
        echo $lulzactiveq_hotplug_rq_3_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_3_0
        echo $lulzactiveq_hotplug_rq_3_1 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_3_1
        echo $lulzactiveq_hotplug_rq_4_0 > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplug_rq_4_0
        echo $lulzactiveq_hotplog_sampling_rate > /sys/devices/system/cpu/cpufreq/lulzactiveq/hotplog_sampling_rate
        echo $lulzactiveq_ignore_nice_load > /sys/devices/system/cpu/cpufreq/lulzactiveq/ignore_nice_load
        echo $lulzactiveq_pump_down_step > /sys/devices/system/cpu/cpufreq/lulzactiveq/pump_down_step
        echo $lulzactiveq_pump_up_step > /sys/devices/system/cpu/cpufreq/lulzactiveq/pump_up_step
        echo $lulzactiveq_screen_off_max_step > /sys/devices/system/cpu/cpufreq/lulzactiveq/screen_off_max_step
        echo $lulzactiveq_up_nr_cpus > /sys/devices/system/cpu/cpufreq/lulzactiveq/up_nr_cpus
        echo $min_cpu_lock > /sys/devices/system/cpu/cpufreq/lulzactiveq/min_cpu_lock
        echo $max_cpu_lock > /sys/devices/system/cpu/cpufreq/lulzactiveq/max_cpu_lock
  ;;
  2)  
        echo "pegasusqplus" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    ;;  
  3)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "1" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  4)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "2" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  5)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "3" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  6)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "4" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  7)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "5" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  8)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "6" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  9)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "7" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  10)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "8" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  11)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "9" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  12)
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "10" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
    ;;
  13)  
        echo "zzmoove" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
        echo $zzmoove_down_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold
        echo $zzmoove_down_threshold_hotplug1 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug1
        echo $zzmoove_down_threshold_hotplug2 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug2
        echo $zzmoove_down_threshold_hotplug3 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug3
        echo $zzmoove_down_threshold_hotplug_freq1 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq1
        echo $zzmoove_down_threshold_hotplug_freq2 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq2
        echo $zzmoove_down_threshold_hotplug_freq3 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq3
        echo $zzmoove_down_threshold_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_sleep
        echo $zzmoove_up_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold
        echo $zzmoove_up_threshold_hotplug1 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug1
        echo $zzmoove_up_threshold_hotplug2 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug2
        echo $zzmoove_up_threshold_hotplug3 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug3
        echo $zzmoove_up_threshold_hotplug_freq1 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq1
        echo $zzmoove_up_threshold_hotplug_freq2 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq2
        echo $zzmoove_up_threshold_hotplug_freq3 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq3
        echo $zzmoove_up_threshold_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_sleep
        echo $zzmoove_early_demand > /sys/devices/system/cpu/cpufreq/zzmoove/early_demand
        echo $zzmoove_grad_up_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/grad_up_threshold
        echo $zzmoove_ignore_nice_load > /sys/devices/system/cpu/cpufreq/zzmoove/ignore_nice_load
        echo $zzmoove_smooth_up > /sys/devices/system/cpu/cpufreq/zzmoove/smooth_up
        echo $zzmoove_smooth_up_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/smooth_up_sleep
        echo $zzmoove_sampling_rate > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate
        echo $zzmoove_sampling_rate_min > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_min
        echo $zzmoove_sampling_rate_sleep_multiplier > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_sleep_multiplier
        echo $zzmoove_sampling_down_factor > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_down_factor
        echo $zzmoove_sampling_down_max_momentum > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_down_max_momentum
        echo $zzmoove_sampling_down_momentum_sensitivity > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_down_momentum_sensitivity
        echo $zzmoove_freq_step > /sys/devices/system/cpu/cpufreq/zzmoove/freq_step
        echo $zzmoove_freq_step_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/freq_step_sleep
        echo $zzmoove_disable_hotplug > /sys/devices/system/cpu/cpufreq/zzmoove/disable_hotplug
        echo $zzmoove_hotplug_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_sleep
        echo $zzmoove_legacy_mode > /sys/devices/system/cpu/cpufreq/zzmoove/legacy_mode
        echo $zzmoove_hotplug_idle_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_idle_threshold
        echo $zzmoove_hotplug_block_cycles > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_block_cycles
        echo $zzmoove_disable_hotplug_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/disable_hotplug_sleep
        echo $zzmoove_freq_limit > /sys/devices/system/cpu/cpufreq/zzmoove/freq_limit
        echo $zzmoove_freq_limit_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/freq_limit_sleep
        
        echo $zzmoove_early_demand_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/early_demand_sleep
        echo $zzmoove_grad_up_threshold_sleep > /sys/devices/system/cpu/cpufreq/zzmoove/grad_up_threshold_sleep
        echo $zzmoove_hotplug_block_up_cycles > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_block_up_cycles
        echo $zzmoove_hotplug_block_down_cycles > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_block_down_cycles
        echo $zzmoove_hotplug_idle_freq > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_idle_freq
        echo $zzmoove_sampling_rate_idle > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_idle
        echo $zzmoove_sampling_rate_idle_delay > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_idle_delay
        echo $zzmoove_sampling_rate_idle_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_idle_threshold
        echo $zzmoove_scaling_block_cycles > /sys/devices/system/cpu/cpufreq/zzmoove/scaling_block_cycles
        echo $zzmoove_scaling_block_freq > /sys/devices/system/cpu/cpufreq/zzmoove/scaling_block_freq
        echo $zzmoove_scaling_block_threshold > /sys/devices/system/cpu/cpufreq/zzmoove/scaling_block_threshold
        echo $zzmoove_scaling_block_force_down > /sys/devices/system/cpu/cpufreq/zzmoove/scaling_block_force_down
    ;;
esac;