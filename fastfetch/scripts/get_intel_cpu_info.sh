# --- Get CPU Information ---

# CPU Name
CPU_NAME=$(lscpu | grep "Model name:" | cut -d':' -f2 | xargs 2>/dev/null)
CPU_NAME=${CPU_NAME:-"Unknown CPU"}

# Core and Thread Count
PHYSICAL_CORES=$(lscpu | grep "Core(s) per socket:" | awk '{print $4}' | xargs 2>/dev/null)
SOCKETS=$(lscpu | grep "Socket(s):" | awk '{print $2}' | xargs 2>/dev/null)
TOTAL_THREADS=$(lscpu | grep "CPU(s):" | awk '{print $2}' | xargs | awk '{print $1}' 2>/dev/null)

# Calculate physical cores if available, otherwise default
if [[ -n "$PHYSICAL_CORES" && -n "$SOCKETS" ]]; then
    ACTUAL_CORES=$((PHYSICAL_CORES * SOCKETS))
else
    ACTUAL_CORES="N/A"
fi
TOTAL_THREADS=${TOTAL_THREADS:-"N/A"}

# CPU Frequency (Max frequency)
CPU_MAX_MHZ_RAW=$(lscpu | grep "CPU max MHz:" | awk '{print int($4)}' | xargs)
CPU_MAX_GHZ=$(awk "BEGIN { printf \"%.1f\", $CPU_MAX_MHZ_RAW / 1000  }")
CPU_AVG_FREQ_RAW=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_avg_freq)
CPU_AVG_FREQ=$(awk "BEGIN { printf \"%.1f\", ($CPU_AVG_FREQ_RAW / 1000) / 1000  }")

# CPU Temperature (requires lm_sensors)
# Grep for "Package id 0:" or "Package 0:" depending on sensors output
CPU_TEMPERATURE_RAW=$(sensors 2>/dev/null)
CPU_TEMPERATURE=$(echo "$CPU_TEMPERATURE_RAW" | grep -E "Package id 0:|Package 0:" | awk '{print $4}' | tr -d '+' | cut -d'.' -f1 | xargs)
CPU_TEMPERATURE=${CPU_TEMPERATURE:-"N/A"} # Default if not found

# Get idle percentage and subtract from 100
CPU_IDLE_RAW=$(top -bn1 | grep '%Cpu' | tail -1 | grep -P '(....|...) id,'| awk '{print int($8)}' | xargs)
CPU_UTILIZATION=$((100-CPU_IDLE_RAW))

# --- ANSI Color Codes ---
COLOR_RED='\e[31m'
COLOR_YELLOW='\e[33m'
COLOR_GREEN='\e[32m'
COLOR_RESET='\e[0m'
# ------------------------

# --- Conditional Coloring for Temperature ---
TEMP_COLOR="${COLOR_RESET}" # Default to no color
if [[ "$CPU_TEMPERATURE" =~ ^[0-9]+$ ]]; then
    if (( CPU_TEMPERATURE >= 80 )); then
        TEMP_COLOR="${COLOR_RED}"
    elif (( CPU_TEMPERATURE > 60 )); then
        TEMP_COLOR="${COLOR_YELLOW}"
    else
        TEMP_COLOR="${COLOR_GREEN}"
    fi
fi

# --- Conditional Coloring for Utilization ---
UTIL_COLOR="${COLOR_RESET}" # Default to no color
if [[ "$CPU_UTILIZATION" =~ ^[0-9]+$ ]]; then
    if (( CPU_UTILIZATION >= 80 )); then
        UTIL_COLOR="${COLOR_RED}"
    elif (( CPU_UTILIZATION >= 45 )); then # Adjust threshold as needed
        UTIL_COLOR="${COLOR_YELLOW}"
    else
        UTIL_COLOR="${COLOR_GREEN}"
    fi
fi

# --- Assemble the final string ---
echo -e "${CPU_NAME} (${ACTUAL_CORES}C/${TOTAL_THREADS}T) @ ${CPU_AVG_FREQ}/${CPU_MAX_GHZ} GHz - CPU(${UTIL_COLOR}${CPU_UTILIZATION}%${COLOR_RESET}) (${TEMP_COLOR}${CPU_TEMPERATURE}°C${COLOR_RESET})"