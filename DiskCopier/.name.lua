term.clear()
term.setCursorPos(1,1)
write("Enter Disk Name: ")
local name = read()
disk.setLabel("left",name)
local check = disk.getLabel("left")
print("Renamed Disk to "..check)
sleep(2)
print("Press up or down to continue.")