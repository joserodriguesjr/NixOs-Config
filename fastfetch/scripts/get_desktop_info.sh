DESKTOP_ENV=$XDG_CURRENT_DESKTOP
PLASMA_VERSION=""

if [[ "$DESKTOP_ENV" == "KDE" ]]; then
    # Try to get plasmashell version. Suppress errors from plasmashell if it's not found/working.
    PLASMA_FULL_VERSION=$(plasmashell --version 2>/dev/null)

    if [[ -n "$PLASMA_FULL_VERSION" ]]; then
        # Check for the concise "plasmashell X.Y.Z" format
        if echo "$PLASMA_FULL_VERSION" | grep -q "^plasmashell "; then
            PLASMA_VERSION=$(echo "$PLASMA_FULL_VERSION" | awk '{print $2}')
        # Check for the verbose "KDE Plasma: X.Y.Z" format
        elif echo "$PLASMA_FULL_VERSION" | grep -q "KDE Plasma:"; then
            PLASMA_VERSION=$(echo "$PLASMA_FULL_VERSION" | grep "KDE Plasma:" | awk '{print $3}')
        fi
    fi

    if [[ -n "$PLASMA_VERSION" ]]; then
        echo "KDE Plasma ${PLASMA_VERSION}"
    else
        # Fallback if KDE version can't be found (e.g., if plasmashell isn't running or outputs something unexpected)
        echo "KDE Plasma (Version N/A)"
    fi
elif [[ -n "$DESKTOP_ENV" ]]; then
    # If not KDE, just display the desktop environment name
    echo "$DESKTOP_ENV"
else
    # Fallback if XDG_CURRENT_DESKTOP is not set
    echo "Desktop Environment N/A"
fi