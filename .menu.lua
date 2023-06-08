--os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

-- Prints the text in the center of the display
function printCentered( y,s )
    local x = math.floor(( w - string.len(s)) / 2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write( s )
end
 
-- Splits the string based on a given separator
function splitStr (str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
 
local nOption = 1
local isMain = 1
local options = {}
local nOptionMax = 0

-- Parses the config files via commas (csv)
local function parseCommand(line)
    return splitStr(line,",")
end    

-- Loads a menu from a given path to a menu config csv
local function loadMenu(path)
    local commands = {}
    local command = yeet
    for line in io.lines(path) do
            command = parseCommand(line)
            table.insert(commands,command)
    end
    return commands
    --for --i,v in ipairs(commands) do
        --for ii, vv in ipairs(v) do
           --print(vv)
        --end
    --end
    --print(commands)
end
 
-- Draws Top Bar
local function drawTopMenu(cmds)
    term.clear()
    term.setCursorPos(1,1)
    term.write("Orang Alpha // ")
    term.setCursorPos(1,2)
    shell.run("id")
    
    term.setCursorPos(w-11,1)
    local curCmd = cmds[nOption]
    term.write(curCmd[1])
end 

--Draws the Menu, adds the given commands/options.
local function drawMenu(cmds)
    printCentered( math.floor(h/2) -3, "")
    if isMain
    then
        printCentered( math.floor(h/2) -2, "Start Menu")
    else
        printCentered( math.floor(h/2) -2, "Submenu")
    end
    local index = 0
    for i,v in ipairs(cmds) do
        printCentered( math.floor(h/2) +index, ((nOption == index+1) and v[2]) or v[1])
        index = index + 1
        nOptionMax = nOptionMax + 1
     end 
end

-- Hardcoded .config location. Initialize options to main.
-- Store main seperately so we can always return to the main menu.
main = loadMenu(".config")
options = loadMenu(".config")
drawTopMenu(main)
drawMenu(main)
 
while true do
    local event, key, isHeld = os.pullEvent("key")
    -- Navigating up the menu, stop the person from going up too far.
    if key == keys.up or key == keys.a then
        if nOption > 1 then
            nOption = nOption - 1
            drawTopMenu(options)
            drawMenu(options)
        end
    -- Navigating down the menu, stop the person from going down too far.
    elseif key == keys.down or key == keys.s then
        if nOption< nOptionMax then
            nOption = nOption + 1
            drawTopMenu(options)
            drawMenu(options)
        end
    -- Option selected, evaluate it to see what to do.
    else if key == keys.enter then
        -- exec is the path of the next file (menu config or program)
        local exec = options[nOption][3] 
        -- opt is the option flag, either P for program or M for menu config.
        local opt = options[nOption][4]
        if opt == 'P' then
            -- Execute that Program
            shell.run(options[nOption][3])
        elseif opt == 'M' then
            --Save the old counter, will implement in future
            local old = nOption
            -- Load new menu
            options = loadMenu(options[nOption][3])
            -- Set to top of options.
            nOption = 1
            -- Draw and return to the loop.
            drawTopMenu(options)
            drawMenu(options)      
        end 
    -- Return to Main Menu
    else if key == keys.backspace then
        -- Set option back to one
        nOption=1
        -- Draw saved main menu.
        drawTopMenu(main)
        drawMenu(main)
        -- Set options back to main.
        options=main
    else
    end
    end
    end
end
    term.clear()