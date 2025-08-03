godot --headless --export-release "Windows Desktop"
godot --headless --export-release "Linux"

butler push ./builds/win SurWeaver/3r:win --userversion-file ./builds/version.txt --if-changed --ignore '*.txt'
butler push ./builds/linux SurWeaver/3r:linux --userversion-file ./builds/version.txt --if-changed --ignore '*.txt'
