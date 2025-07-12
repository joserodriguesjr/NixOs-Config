NVIDIA_SMI_PATH=$(which nvidia-smi)

if [ -z "$NVIDIA_SMI_PATH" ]; then
    echo "nvidia-smi not found. Please ensure NVIDIA drivers are installed and in PATH." >&2
    exit 1
fi

# Get raw data
GPU_NAME=$("$NVIDIA_SMI_PATH" --query-gpu=gpu_name --format=csv,noheader)
GPU_INDEX=$("$NVIDIA_SMI_PATH" --query-gpu=index --format=csv,noheader)
GPU_TEMPERATURE=$("$NVIDIA_SMI_PATH" --query-gpu=temperature.gpu --format=csv,noheader)
# GPU_CLOCK_MHZ=$("$NVIDIA_SMI_PATH" --query-gpu=clocks.gr --format=csv,noheader,nounits)
# GPU_MEM_USED_MIB=$("$NVIDIA_SMI_PATH" --query-gpu=memory.used --format=csv,noheader,nounits)
# GPU_MEM_TOTAL_MIB=$("$NVIDIA_SMI_PATH" --query-gpu=memory.total --format=csv,noheader,nounits)

# --- FIX FOR UTILIZATION ---
RAW_GPU_UTILIZATION=$("$NVIDIA_SMI_PATH" --query-gpu=utilization.gpu --format=csv,noheader)
# Strip '%' and leading/trailing spaces to get just the number
GPU_UTILIZATION=$(echo "$RAW_GPU_UTILIZATION" | tr -d '%' | xargs) # xargs trims whitespace
# ---------------------------
# --- FIX FOR UTILIZATION ---
RAW_MEM_UTILIZATION=$("$NVIDIA_SMI_PATH" --query-gpu=utilization.memory --format=csv,noheader)
# Strip '%' and leading/trailing spaces to get just the number
MEM_UTILIZATION=$(echo "$RAW_MEM_UTILIZATION" | tr -d '%' | xargs) # xargs trims whitespace
# ---------------------------

# Convert to desired units and format
# GPU_CLOCK_GHZ=$(awk "BEGIN {printf \"%.2f\", $GPU_CLOCK_MHZ / 1000}")
# GPU_MEM_USED_GIB=$(awk "BEGIN {printf \"%.2f\", $GPU_MEM_USED_MIB / 1024}")
# GPU_MEM_TOTAL_GIB=$(awk "BEGIN {printf \"%.2f\", $GPU_MEM_TOTAL_MIB / 1024}")

# --- ANSI Color Codes ---
# Black: \e[30m
# Red: \e[31m
# Green: \e[32m
# Yellow: \e[33m
# Blue: \e[34m
# Magenta: \e[35m
# Cyan: \e[36m
# White: \e[37m
# Bright versions (e.g., Bright Red): \e[91m
# Reset: \e[0m (important to reset color after the colored text)
# ------------------------

# Define color variables for easier use
COLOR_RED='\e[31m'    # For hot temperatures
COLOR_YELLOW='\e[33m' # For warm temperatures
COLOR_GREEN='\e[32m'  # For normal temperatures
COLOR_RESET='\e[0m'   # Resets color to default

# Determine color based on temperature (example thresholds, adjust as needed)
TEMP_COLOR=""
if (( GPU_TEMPERATURE >= 80 )); then
    TEMP_COLOR="${COLOR_RED}"
elif (( GPU_TEMPERATURE >= 60 )); then
    TEMP_COLOR="${COLOR_YELLOW}"
else
    TEMP_COLOR="${COLOR_GREEN}"
fi

# Determine color based on CPU utilization (example thresholds, adjust as needed)
CPU_COLOR=""
if (( GPU_UTILIZATION >= 80 )); then
    CPU_COLOR="${COLOR_RED}"
elif (( GPU_UTILIZATION >= 45 )); then
    CPU_COLOR="${COLOR_YELLOW}"
else
    CPU_COLOR="${COLOR_GREEN}"
fi

# Determine color based on memory utilization (example thresholds, adjust as needed)
MEM_COLOR=""
if (( MEM_UTILIZATION >= 80 )); then
    MEM_COLOR="${COLOR_RED}"
elif (( MEM_UTILIZATION >= 40 )); then
    MEM_COLOR="${COLOR_YELLOW}"
else
    MEM_COLOR="${COLOR_GREEN}"
fi

# example: NVIDIA GeForce RTX 4060 Laptop GPU (24) @ 2.37 GHz (7.63 GiB) [Discrete]

# Assemble the final string with colored temperature
# printf "${GPU_NAME} (${SM_COUNT}) @ ${GPU_CLOCK_GHZ} GHz (${GPU_MEM_USED_MIB} MiB / ${GPU_MEM_TOTAL_MIB} MiB) [Discrete] (${TEMP_COLOR}${GPU_TEMPERATURE}.0°C${COLOR_RESET})"
echo -e "${GPU_NAME} [Discrete] @ GPU(${CPU_COLOR}${GPU_UTILIZATION}%${COLOR_RESET}) MEM(${MEM_COLOR}${MEM_UTILIZATION}%${COLOR_RESET}) (${TEMP_COLOR}${GPU_TEMPERATURE}.0°C${COLOR_RESET})"
