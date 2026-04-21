#!/bin/sh
# ACPI event handler - ThinkPad X230 / pataccone (Void Linux)
# Gestisce: power button, sleep button, AC adapter, batteria, lid, luminosità
#
# Comportamento coperchio (lid):
#   - Su batteria: suspend immediato
#   - Su AC/docking: sistema sveglio, LED standby acceso come indicatore

step_backlight() {
    for backlight in /sys/class/backlight/*/; do
        [ -d "$backlight" ] || continue
        step=$(( $(cat "$backlight/max_brightness") / 20 ))
        [ "$step" -gt "1" ] || step=1
        printf '%s' "$(( $(cat "$backlight/brightness") $1 step ))" >"$backlight/brightness"
    done
}

minspeed="/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq"
maxspeed="/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"
setspeed="/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger "PowerButton pressed: $2, shutting down..."
                shutdown -P now
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SBTN|SLPB)
                logger "Sleep Button pressed: $2, suspending..."
                zzz
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        # Su batteria: frequenza minima
                        cat "$minspeed" >"$setspeed"
                    ;;
                    00000001)
                        # Su AC: frequenza massima
                        cat "$maxspeed" >"$setspeed"
                    ;;
                esac
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000) ;;
                    00000001) ;;
                esac
                ;;
            CPU0) ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        # Coperchio chiuso: suspend su batteria, LED acceso su AC
        # Coperchio aperto: LED spento
        case "$3" in
            close)
                ac=$(cat /sys/class/power_supply/AC/online 2>/dev/null)
                if [ "$ac" = "0" ]; then
                    logger "LID closed on battery, suspending..."
                    echo 1 | tee /sys/class/leds/tpacpi::standby/brightness > /dev/null
                    zzz
                else
                    logger "LID closed on AC/docked, staying awake..."
                    echo 1 | tee /sys/class/leds/tpacpi::standby/brightness > /dev/null
                fi
                ;;
            open)
                logger "LID opened"
                echo 0 | tee /sys/class/leds/tpacpi::standby/brightness > /dev/null
                ;;
            *)  logger "ACPI action undefined (LID): $2" ;;
        esac
        ;;
    video/brightnessdown)
        step_backlight -
        ;;
    video/brightnessup)
        step_backlight +
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac
