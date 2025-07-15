# Get Intel GPU Name and Type
INTEL_GPU_FULL_LINE=$(lspci -vnn | grep -i "vga\|3d\|display" | grep -i "intel" | head -n 1 2>/dev/null)

INTEL_GPU_NAME=""
if [[ -n "$INTEL_GPU_FULL_LINE" ]]; then
    # Attempt to extract the name using sed (more precise for common Intel names)
    INTEL_GPU_NAME=$(echo "$INTEL_GPU_FULL_LINE" | sed -n 's/.*Intel Corporation \([^\[]*\)\s*\[[0-9a-fA-F:]\+\] (rev [0-9a-fA-F]\+).*/\1/p' | xargs)
    # Fallback for simpler names if sed fails or doesn't match the exact pattern
    if [ -z "$INTEL_GPU_NAME" ]; then
        INTEL_GPU_NAME=$(echo "$INTEL_GPU_FULL_LINE" | awk -F': ' '{print $2}' | awk -F' \\[8086' '{print $1}' | xargs)
    fi
fi

# Determine type (Integrated for Intel graphics)
GPU_TYPE="Integrated"

# If no Intel GPU name was found, exit with an error so Fastfetch can use errorFormat
if [ -z "$INTEL_GPU_NAME" ]; then
    echo "Intel GPU not found or name could not be parsed." >&2
    exit 1
fi

# --- Get Intel GPU Utilization ---
INTEL_GPU_UTILIZATION=$(timeout 1.2s intel_gpu_top -l 1 | sed -n '4p' | awk '{print int($7)}' | xargs)

# --- ANSI Color Codes ---
COLOR_RED='\e[31m'
COLOR_YELLOW='\e[33m'
COLOR_GREEN='\e[32m'
COLOR_RESET='\e[0m'
# ------------------------

GPU_COLOR=""
if (( INTEL_GPU_UTILIZATION >= 80 )); then
    GPU_COLOR="${COLOR_RED}"
elif (( INTEL_GPU_UTILIZATION >= 40 )); then
    GPU_COLOR="${COLOR_YELLOW}"
else
    GPU_COLOR="${COLOR_GREEN}"
fi

# --- Assemble the final string ---
echo -e "Intel - ${INTEL_GPU_NAME} [${GPU_TYPE}] GPU(${GPU_COLOR}${INTEL_GPU_UTILIZATION}%${COLOR_RESET})"