#!/usr/bin/env bash
set -u
export LC_ALL=C

os_name=Unknown
if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    os_name=${PRETTY_NAME:-Unknown}
fi

server_ip=$(ip -4 route get 1.1.1.1 2>/dev/null |
    awk '{for (i=1; i<=NF; i++) if ($i=="src") {print $(i+1); exit}}')
if [[ -z "$server_ip" ]]; then
    server_ip=$(ip -o -4 addr show scope global 2>/dev/null |
        awk 'NR==1 {split($4,a,"/"); print a[1]}')
fi
server_ip=${server_ip:-Unavailable}

public_ip=$(curl -4 -fsS --connect-timeout 3 --max-time 5 \
    https://api.ipify.org 2>/dev/null || true)
public_ip=${public_ip:-Unavailable}

virt=$(systemd-detect-virt 2>/dev/null || true)
case "$virt" in
    oracle) virt=Oracle ;;
    vmware) virt=VMware ;;
    kvm) virt=KVM ;;
    none|'') virt='None detected' ;;
esac

timezone=$(timedatectl show --property=Timezone --value 2>/dev/null || true)
timezone=${timezone:-Unknown}
uptime_text=$(uptime -p 2>/dev/null || true)
uptime_text=${uptime_text#up }
uptime_text=${uptime_text:-Unavailable}

human_kib() {
    awk -v kib="$1" 'BEGIN {
        if (kib >= 1048576) printf "%.1f GiB", kib/1048576;
        else if (kib >= 1024) printf "%.0f MiB", kib/1024;
        else printf "%.1f KiB", kib;
    }'
}

read -r mem_total mem_available swap_total swap_free < <(
    awk '
        /^MemTotal:/ {mt=$2}
        /^MemAvailable:/ {ma=$2}
        /^SwapTotal:/ {st=$2}
        /^SwapFree:/ {sf=$2}
        END {printf "%.0f %.0f %.0f %.0f\n", mt,ma,st,sf}
    ' /proc/meminfo
)
mem_used=$((mem_total - mem_available))
swap_used=$((swap_total - swap_free))

printf 'System Information\n'
printf 'Executed By: %s\n' "$(id -un)"
printf 'Hostname: %s\n' "$(hostname)"
printf 'Server IP: %s\n' "$server_ip"
printf 'Public IP: %s\n' "$public_ip"
printf 'OS Type and Version: %s\n' "$os_name"
printf 'Kernel Version: %s\n' "$(uname -r)"
printf 'Architecture: %s\n' "$(uname -m)"
printf 'Virtualization: %s\n' "$virt"
printf 'Server Time: %s\n' "$(date '+%a %b %d %I:%M:%S %p %Z %Y')"
printf 'Timezone: %s (%s)\n' "$timezone" "$(date +%Z)"
printf 'Uptime: %s\n' "$uptime_text"
printf '\nResource Usage\n'
printf 'Total Memory: %s\n' "$(human_kib "$mem_total")"
printf 'Memory Usage: %s / %s\n' "$(human_kib "$mem_used")" "$(human_kib "$mem_total")"
printf 'Swap Usage: %s / %s\n' "$(human_kib "$swap_used")" "$(human_kib "$swap_total")"
printf 'CPU Cores: %s\n' "$(getconf _NPROCESSORS_ONLN)"
