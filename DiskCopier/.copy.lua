term.clear()
term.setCursorPos(1,1)
print("Copying Disk...")
shell.run("cp disk/* disk2")
local src = disk.getLabel("right")
local dst = disk.getLabel("left")
write(src.." ")
textutils.slowWrite("##########")
print(" "..dst)
print("Copied Successfully.")
print("")
print("Press up or down to continue.")
