# defaults write com.apple.finder QuitMenuItem -bool true
# killall Finder

# defaults write com.apple.finder AppleShowAllFiles -bool true 
# killall Finder

# http://apple.stackexchange.com/questions/30415/how-can-i-remove-the-finder-icon-from-my-dock#30429
# sudo defaults write /System/Library/CoreServices/Dock.app/Contents/Resources/DockMenus finder-running -array-add '<dict><key>command</key><integer>1004</integer><key>name</key><string>REMOVE_FROM_DOCK</string></dict>'
