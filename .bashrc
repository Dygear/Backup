if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000 # Black
    echo -en "\e]P1B73F29 # Red
    echo -en "\e]P27D8E55 # Green
    echo -en "\e]P3F8EE81 # Yellow
    echo -en "\e]P43E4972 # Blue
    echo -en "\e]P5765A7A # Magenta
    echo -en "\e]P64F5E85 # Cyan
    echo -en "\e]P7DADADA # White
    echo -en "\e]P8181819 # Bright Black
    echo -en "\e]P9E23628 # Bright Red
    echo -en "\e]PA9BB861 # Bright Green
    echo -en "\e]PBF6E83F # Bright Yellow
    echo -en "\e]PC475495 # Bright Blue
    echo -en "\e]PD966A9D # Bright Magenta
    echo -en "\e]PE596DA9 # Bright Cyan
    echo -en "\e]PFFFFFFF # Bright White
    clear # Clears Background Artifacting
fi
