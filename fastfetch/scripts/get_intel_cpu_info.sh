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
# # CPU_MAX_MHZ_RAW=$(lscpu | grep "CPU max MHz:" | awk '{print $4}' | xargs 2>/dev/null)
# CPU_MAX_MHZ_RAW=$(lscpu | awk -F: '/CPU max MHz/ { gsub(/^[ \t]+/, "", $2); print $2 }')
# echo "DEBUG: RAW MHZ: '${CPU_MAX_MHZ_RAW}'" # Debug line
# CPU_MAX_GHZ=$(awk "BEGIN { printf \"%.1f\", $CPU_MAX_MHZ_RAW / 1000  }")
# echo "CPU Max Frequency: ${CPU_MAX_GHZ} GHz"
# # Replace comma with dot for bc, then ensure it's a valid number for calculation
# CPU_MAX_MHZ_CLEANED=$(echo "${CPU_MAX_MHZ_RAW}" | sed 's/,/./g' | xargs)
# echo "DEBUG: CLEANED MHZ: '${CPU_MAX_MHZ_CLEANED}'" # Debug line

# Now, use the cleaned number for bc
# FIX: Prepend LC_NUMERIC=C to force bc to use dot as decimal separator
# CPU_FREQ_GHZ=$(LC_NUMERIC=C echo "scale=2; ${CPU_MAX_MHZ_CLEANED:-0} / 1000" | bc 2>/dev/null)
# echo "DEBUG: BC Output GHZ: '${CPU_FREQ_GHZ}'" # Debug line
# CPU_FREQ_GHZ=${CPU_FREQ_GHZ:-"N/A"}
# echo "DEBUG: FINAL GHZ: '${CPU_FREQ_GHZ}'" # Debug line

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
# Example: 13th Gen Intel(R) Core(TM) i9-13900HX (24C/32T) - 5.40 GHz (63.0°C) (XX%)
# echo -e "${CPU_NAME} (${ACTUAL_CORES}C/${TOTAL_THREADS}T) - ${CPU_FREQ_GHZ} GHz (${TEMP_COLOR}${CPU_TEMPERATURE}°C${COLOR_RESET}) (${UTIL_COLOR}${CPU_UTILIZATION}%${COLOR_RESET})"
echo -e "${CPU_NAME} (${ACTUAL_CORES}C/${TOTAL_THREADS}T) @ 5.40 GHz - CPU(${UTIL_COLOR}${CPU_UTILIZATION}%${COLOR_RESET}) (${TEMP_COLOR}${CPU_TEMPERATURE}°C${COLOR_RESET})"