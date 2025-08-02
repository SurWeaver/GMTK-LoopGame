godot --headless --export-release "Windows Desktop"
godot --headless --export-release "Linux"
godot --headless --export-release "macOS"

butler push ./builds/win SurWeaver/3r:win --userversion-file ./builds/version.txt --if-changed --ignore '*.txt'
butler push ./builds/win SurWeaver/3r:linux --userversion-file ./builds/version.txt --if-changed --ignore '*.txt'
butler push ./builds/win SurWeaver/3r:mac --userversion-file ./builds/version.txt --if-changed --ignore '*.txt'
