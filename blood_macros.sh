#!/bin/bash

# Make sure xdotool is installed
if ! command -v xdotool &> /dev/null; then
    echo "xdotool is not installed. Please install it with:"
    echo "sudo apt-get install xdotool  # For Debian/Ubuntu"
    echo "sudo dnf install xdotool  # For Fedora"
    echo "sudo pacman -S xdotool  # For Arch"
    exit 1
fi

# Find the Dominions 6 window ID
DOM6_WINDOW_ID=$(xdotool search --name "Dominions 6" | head -n 1)

if [ -z "$DOM6_WINDOW_ID" ]; then
    echo "Error: Could not find Dominions 6 window. Make sure the game is running."
    exit 1
fi

echo "Found Dominions 6 window ID: $DOM6_WINDOW_ID"

# Activate the window
xdotool windowactivate --sync $DOM6_WINDOW_ID --sync  windowfocus

# Get window dimensions
WINDOW_INFO=$(xdotool getwindowgeometry $DOM6_WINDOW_ID)
WINDOW_POS=$(echo "$WINDOW_INFO" | grep Position | sed 's/.*Position: \([0-9]*\),\([0-9]*\).*/\1 \2/')
WINDOW_SIZE=$(echo "$WINDOW_INFO" | grep Geometry | sed 's/.*Geometry: \([0-9]*\)x\([0-9]*\).*/\1 \2/')

WINDOW_X=$(echo $WINDOW_POS | awk '{print $1}')
WINDOW_Y=$(echo $WINDOW_POS | awk '{print $2}')
WINDOW_WIDTH=$(echo $WINDOW_SIZE | awk '{print $1}')
WINDOW_HEIGHT=$(echo $WINDOW_SIZE | awk '{print $2}')

echo "Window position: $WINDOW_X,$WINDOW_Y"
echo "Window size: ${WINDOW_WIDTH}x${WINDOW_HEIGHT}"

# Function to calculate position relative to Dominions 6 window from percentage
calculate_position() {
    local percentage_x=$1
    local percentage_y=$2
    
    local pos_x=$(( WINDOW_X + (WINDOW_WIDTH * percentage_x / 100) ))
    local pos_y=$(( WINDOW_Y + (WINDOW_HEIGHT * percentage_y / 100) ))
    
    echo "$pos_x $pos_y"
}

# Initial left offset percentage
LEFT_OFFSET=32

# Main loop
while true; do
    # Click on the middle of the screen at 30% height (gems line)
    position=$(calculate_position 50 38)
    x=$(echo $position | awk '{print $1}')
    y=$(echo $position | awk '{print $2}')
    xdotool mousemove $x $y sleep 0.1 click 1
    sleep 0.3
    
    # Click on the middle of the screen at 30% height (gems line)
    position=$(calculate_position 52 28)
    x=$(echo $position | awk '{print $1}')LEFT_OFFSET
    y=$(echo $position | awk '{print $2}')
    xdotool mousemove $x $y sleep 0.1 click 1
    sleep 0.3
    
   # 1) Click on LEFT_OFFSET% from the left and 40% height
   position=$(calculate_position $LEFT_OFFSET 35)
   x=$(echo $position | awk '{print $1}')
   y=$(echo $position | awk '{print $2}')
   xdotool mousemove $x $y click 1
   sleep 0.3                                                                                                   

   
#   # 2) Click 2 times at 50% from the left and 50% height
   position=$(calculate_position 45 52)
   x=$(echo $position | awk '{print $1}')
   y=$(echo $position | awk '{print $2}')
   xdotool mousemove $x $y  keydown shift click 1 click 1 keyup shift
   sleep 0.3
#   
#   # 3) Send ESC key
   xdotool key Escape
   sleep 0.3
#   
#   # Increase LEFT_OFFSET by 5%
   LEFT_OFFSET=$((LEFT_OFFSET + 5))
   
   echo $LEFT_OFFSET
#   
#   # If LEFT_OFFSET exceeds 95%, reset it to 40%
   if [ $LEFT_OFFSET -gt 65 ]; then
       LEFT_OFFSET=32
       exit
   fi
#   
#   echo "Current LEFT_OFFSET: $LEFT_OFFSET%"
#   
#   # Optional: add a delay between cycles
#   sleep 2
done
