# Get Intel GPU Name and Type
# lspci -vnn will give detailed info, then grep for Intel display controllers
# Example output: 00:02.0 VGA compatible controller [0300]: Intel Corporation Raptor Lake-S UHD Graphics [8086:a780] (rev 04)
# We want "Raptor Lake-S UHD Graphics" and infer "Integrated"

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

# Assemble the final string as requested: "Intel - Raptor Lake-S UHD Graphics [Integrated] ()"
echo "Intel - ${INTEL_GPU_NAME} [${GPU_TYPE}] ()"