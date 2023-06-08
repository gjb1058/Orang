# Orang
ComputerCraft Operating System Suite w/ Systems

# Process
Uses the startup file to automatically boot the operating system.

.menu is the code that runs the menu system. The main menu is configured via .config

# Config Files
.config is always the default main menu configuration. Each line has four values.

Unselected Text, Selected Text, filepath, option

filepath can either be another menu config or a program path to be executed.
the option flag is either P or M.
    P for Program (executes the program located at the filepath)
    M for Menu, builds and displays the menu configurated by the filepath.

This allows for dynamic menu building, a nice easy terminal system.

#Pastebins
startup : https://pastebin.com/uvvtyu65 , pastebin get uvvtyu64
.menu : https://pastebin.com/sHsjwp0A , pastebin get sHsjwp0A
.config : https://pastebin.com/rf1Ny4NF , pastebin get rf1Ny4NF
