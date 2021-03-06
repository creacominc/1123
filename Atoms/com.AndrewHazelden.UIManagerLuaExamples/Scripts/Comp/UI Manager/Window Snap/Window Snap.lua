_author = "Andrew Hazelden <andrew@andrewhazelden.com>"
_date = "2019-11-04"
_VERSION = "3.0"

--[[--
==============================================================================
Window Snap
==============================================================================
Created By : Andrew Hazelden[andrew@andrewhazelden]

==============================================================================
Overview
==============================================================================

A Lua script example that uses several ui:Button controls to quickly snap a UI Manager based window to the top/bottom/left/right/center edges of the Fusion window.

==============================================================================
Usage
==============================================================================

Step 1. Copy the "Window Snap" folder to the Fusion user prefs "Scripts:/Comp/Window Snap/" location.

Step 2. Open the Fusion Preferences. Switch to the "Global and Default Settings > Layout" Section. At the top of the window is a Program layout area. Click on the "Grab program layout" button. Then click the "Save" button to close the Preferences window. This saves out a "Global.Main.Window" preference entry.

Step 3. Run the script in Fusion by selecting the "Script > Window Snap > Window Snap" menu item.

==============================================================================
Development Notes
==============================================================================

The icon images displayed in the window are loaded relative to the Window Snap script's filepath location using the technique presented in the "GetScriptDir.lua" script:

-- Read the parent folder that holds the current "Window Snap.lua" script
local fileTable = GetScriptDir('Reactor:/Deploy/Scripts/Comp/UI Manager/Window Snap/Window Snap.lua')
print("[Lua Script Filename Table]")
dump(fileTable)

Result:

[Lua Script Filename Table]
table: 0x0d238800
	Path = /Users/andrew/Library/Application Support/Blackmagic Design/Fusion/Scripts/Comp/
	FullName = GetScriptDir.lua
	UNC = false
	CleanName = GetScriptDir
	SNum = 
	Extension = .lua
	Name = GetScriptDir
	FullPath = /Users/andrew/Library/Application Support/Blackmagic Design/Fusion/Scripts/Comp/GetScriptDir.lua



You can read the previously saved Fusion window position using:

mainWindow = fusion:GetPrefs("Global.Main.Window")
dump(mainWindow)
--	table: 0x534f6cb0
--		Left = 1542
--		Width = 1835
--		Top = 45
--		UseWindowsDefaults = false
--		Mode = 1
--		Height = 1214


An unset value for the Fusion window position preference looks like:

mainWindow = fusion:GetPrefs("Global.Main.Window")
dump(mainWindow)
table: 0x6f3e1770
	Left = -1
	Width = -1
	Top = -1
	UseWindowsDefaults = true
	Mode = 3
	Height = -1


The "CenterIconButton" ui:Button icon image is updated on the fly using:

-- Generate a table with the absolute filepaths for the icons
local icons = IconsTable()
	
-- Toggle the center icon to a collapse icon
itm.CenterIconButton:SetIcon(ui:Icon{
	ID = "CollapseIcon", 
	File = icons.collapse
})

--]]--

------------------------------------------------------------------------
-- Find out the current Fusion host platform (Windows/Mac/Linux)
platform = (FuPLATFORM_WINDOWS and "Windows") or (FuPLATFORM_MAC and "Mac") or (FuPLATFORM_LINUX and "Linux")


------------------------------------------------------------------------
-- Set up the initial window size

-- Read the previously saved window position + size from the Fusion user prefs "Profiles:/Default/Fusion.prefs" file.
mainWindow = fusion:GetPrefs("Global.Main.Window")
if not mainWindow or mainWindow.Width == -1 or mainWindow.Height == -1 then
	print("[Error] The Window preference is undefined. Please save a initial window position in the Layout Preference section.")
	app:ShowPrefs("PrefsLayout")

	return
end

-- Update the default window position
minWidth, minHeight = 300, 200
originX, originY = mainWindow.Left + (mainWindow.Width/2) - (minWidth/2), mainWindow.Top + (mainWindow.Height/2) - (minHeight/2)


------------------------------------------------------------------------
-- Add the platform specific folder slash character
osSeparator = package.config:sub(1,1)


------------------------------------------------------------------------
-- Return a string with the directory path where the Lua script was run from
-- If the script is run by pasting it directly into the Fusion Console define a fallback path
-- fileTable = GetScriptDir('Reactor:/Deploy/Scripts/Comp/UI Manager/Window Snap/Window Snap.lua')
function GetScriptDir(fallback)
	if debug.getinfo(1).source == '???' then
		-- Fallback absolute filepath
		return parseFilename(app:MapPath(fallback))
	else
		-- Filepath coming from the Lua script's location on disk
		return parseFilename(app:MapPath(string.sub(debug.getinfo(1).source, 2)))
	end
end

------------------------------------------------------------------------------
-- parseFilename() from bmd.scriptlib
--
-- this is a great function for ripping a filepath into little bits
-- returns a table with the following
--
-- FullPath : The raw, original path sent to the function
-- Path		: The path, without filename
-- FullName : The name of the clip w\ extension
-- Name			: The name without extension
-- CleanName: The name of the clip, without extension or sequence
-- SNum		: The original sequence string, or "" if no sequence
-- Number		: The sequence as a numeric value, or nil if no sequence
-- Extension: The raw extension of the clip
-- Padding	: Amount of padding in the sequence, or nil if no sequence
-- UNC		: A true or false value indicating whether the path is a UNC path or not
------------------------------------------------------------------------------
function parseFilename(filename)
	local seq = {}
	seq.FullPath = filename
	string.gsub(seq.FullPath, "^(.+[/\\])(.+)", function(path, name) seq.Path = path seq.FullName = name end)
	string.gsub(seq.FullName, "^(.+)(%..+)$", function(name, ext) seq.Name = name seq.Extension = ext end)

	if not seq.Name then -- no extension?
		seq.Name = seq.FullName
	end

	string.gsub(seq.Name, "^(.-)(%d+)$", function(name, SNum) seq.CleanName = name seq.SNum = SNum end)

	if seq.SNum then
		seq.Number = tonumber(seq.SNum)
		seq.Padding = string.len(seq.SNum)
	else
		 seq.SNum = ""
		 seq.CleanName = seq.Name
	end

	if seq.Extension == nil then seq.Extension = "" end
	seq.UNC = (string.sub(seq.Path, 1, 2) == [[\\]])

	return seq
end

------------------------------------------------------------------------
-- The Main Function
function Main()
	print(string.format("[Window Snap] - v%s %s ", _VERSION, _date))
	print(string.format("[Created By] %s\n\n", _author))
	
	-- Check if the Fusion GUI is running
	if fusion == nil then
		print("[Fusion] Error: Please open up the Fusion GUI before running this tool.\n")
	else
		-- Display the progress dialog
		ui = app.UIManager
		disp = bmd.UIDispatcher(ui)

		-- Show the progress window
		local msgwin,msgitm = WinCreate()
		WinUpdate(msgwin, msgitm, "Window Snap")
	end
end


------------------------------------------------------------------------
-- Get the Icons Table
-- Example: icons = IconsTable()
function IconsTable()
	-- Read the parent folder that holds the current "Window Snap.lua" script
	local fileTable = GetScriptDir('Reactor:/Deploy/Scripts/Comp/UI Manager/Window Snap/Window Snap.lua')

	-- Generate a table with the absolute filepaths for the icons
	local iconFolderPath = fileTable.Path .. "icons" .. osSeparator
	local icons = {
		left = iconFolderPath .. "arrange-left.png",
		right = iconFolderPath .. "arrange-right.png",
		top = iconFolderPath .. "arrange-top.png",
		bottom = iconFolderPath .. "arrange-bottom.png",
		center = iconFolderPath .. "arrange-center.png",
		collapse = iconFolderPath .. "arrange-collapse.png",
	}

	-- print("[Icons Filename Table]");
	-- dump(icons)
	
	return icons
end


------------------------------------------------------------------------
-- UI Manager Window Creation
-- Example: local msgwin,msgitm = WinCreate()
function WinCreate(icons)
	-- Generate a table with the absolute filepaths for the icons
	local icons = IconsTable()

	local win = disp:AddWindow({
		ID = "WindowSnap",
		TargetID = "WindowSnap",
		WindowTitle = "Window Snap",
		Geometry = {originX, originY, minWidth, minHeight},

		-- Resize Window Controls group
		ui:HGroup{
			ID = "ResizeHGroup",
			Weight = 0.1,
			ui:HGap(0, 1),
			ui:VGroup{
				ID = "ResizeVGroup",
				Weight = 0.1,
				ui:VGap(0, 1),
				-- Top row button
				ui:HGroup{
					Weight = 0.1,
					ui:HGap(0, 1),
					ui:Button{
						ID = "TopIconButton", 
						-- Flat = true,
						IconSize = {48,48},
						Icon = ui:Icon{
							ID = "TopIcon", 
							File = icons.top
						},
						Checkable = false,
					},
					ui:HGap(0, 1),
				},

				-- Middle row buttons
				ui:HGroup{
					Weight = 0.1,
					ui:Button{
						ID = "LeftIconButton", 
						-- Flat = true,
						IconSize = {48,48},
						Icon = ui:Icon{
							ID = "LeftIcon", 
							File = icons.left
						},
						Checkable = false,
					},
					ui:Button{
						ID = "CenterIconButton", 
						-- Flat = true,
						IconSize = {48,48},
						Icon = ui:Icon{
							ID = "CenterIcon", 
							File = icons.center
						},
						Checkable = false,
					},
					ui:Button{
						ID = "RightIconButton", 
						-- Flat = true,
						IconSize = {48,48},
						Icon = ui:Icon{
							ID = "RightIcon", 
							File = icons.right
						},
						Checkable = false,
					},
				},

				-- Lower row button
				ui:HGroup{
					Weight = 0.1,
					ui:HGap(0, 1),
					ui:Button{
						ID = "BottomIconButton", 
						-- Flat = true,
						IconSize = {48,48},
						Icon = ui:Icon{
							ID = "BottomIcon", 
							File = icons.bottom
						},
						Checkable = false,
					},
					ui:HGap(0, 1),
				},
				ui:VGap(0, 1),
			},
			ui:HGap(0, 1),
		},

	})

	-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the window instead of closing the foreground composite.
	app:AddConfig('WindowSnap', {
		Target {
			ID = 'WindowSnap',
		},

		Hotkeys {
			Target = 'WindowSnap',
			Defaults = true,

			CONTROL_W = 'Execute{cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]]}',
			CONTROL_F4 = 'Execute{cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]]}',
		},
	})

	win:Show()

	-- Add your GUI element based event functions here:
	itm = win:GetItems()

	return win,itm
end


------------------------------------------------------------------------
-- Window Refresh
-- Example: WinUpdate(msgwin, msgitm, "Window Snap")
function WinUpdate(win, itm, title)
	-- Read the window position + size from the Fusion user prefs "Profiles:/Default/Fusion.prefs" file.
	local mainWindow = fusion:GetPrefs("Global.Main.Window")

	-- Set up the amount of window scaling in effect when the top/left/right/bottom view split buttons are used.
	local viewSplitRatio = 0.2

	-- Generate a table with the absolute filepaths for the icons
	local icons = IconsTable()

	-- Add your GUI element based event functions here:

	-- The window was closed
	function win.On.WindowSnap.Close(ev)
		disp:ExitLoop()
	end


	function win.On.TopIconButton.Clicked(ev)
		-- Snap the window to the top
		itm.WindowSnap.Geometry = {mainWindow.Left, 0, mainWindow.Width, mainWindow.Height * viewSplitRatio}

		-- Update the window title
		itm.WindowSnap.WindowTitle = title .. " - " .. "Top"

		-- Toggle the center button to a center icon
		itm.CenterIconButton:SetIcon(ui:Icon{
			ID = "CenterIcon", 
			File = icons.center
		})

		-- Print out the window placement details
		print(string.format("[Top Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))
		
		-- disp:ExitLoop()
	end


	function win.On.LeftIconButton.Clicked(ev)
		-- Snap the window size
		itm.WindowSnap.Geometry = {mainWindow.Left, mainWindow.Top, mainWindow.Width * viewSplitRatio, mainWindow.Height}

		-- Update the window title
		itm.WindowSnap.WindowTitle = title .. " - " .. "Left"

		-- Toggle the center button to a center icon
		itm.CenterIconButton:SetIcon(ui:Icon{
			ID = "CenterIcon", 
			File = icons.center
		})

		-- Print out the window placement details
		print(string.format("[Left Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))

		-- disp:ExitLoop()
	end
	

	function win.On.CenterIconButton.Clicked(ev)
		currentWidth = itm.WindowSnap.Geometry[3]
		currentHeight = itm.WindowSnap.Geometry[4]

		-- Figure out if the window needs to be centered or collapsed
		if (currentWidth < mainWindow.Width) or (currentHeight < mainWindow.Height) then
			-- Expand the window
			
			-- Toggle the center button to a collapse icon
			itm.CenterIconButton:SetIcon(ui:Icon{
				ID = "CollapseIcon", 
				File = icons.collapse
			})

			itm.WindowSnap.Geometry = {mainWindow.Left, mainWindow.Top, mainWindow.Width, mainWindow.Height}

			-- Update the window title
			itm.WindowSnap.WindowTitle = title .. " - " .. "Center"

			-- Print out the window placement details
			print(string.format("[Center Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))
		else
			-- Collapse the window
			
			-- Toggle the center button to a center icon
			itm.CenterIconButton:SetIcon(ui:Icon{
				ID = "CenterIcon", 
				File = icons.center
			})

			itm.WindowSnap.Geometry = {originX, originY, minWidth, minHeight}

			-- Update the window title
			itm.WindowSnap.WindowTitle = tostring(title) .. " - " .. "Collapsed"

			-- Print out the window placement details
			print(string.format("[Collapsed Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))
		end

		-- disp:ExitLoop()
	end
	

	function win.On.RightIconButton.Clicked(ev)
		-- Snap the window to the right
		itm.WindowSnap.Geometry = {mainWindow.Left + (mainWindow.Width - (mainWindow.Width * viewSplitRatio)), mainWindow.Top, mainWindow.Width * viewSplitRatio, mainWindow.Height}

		-- Update the window title
		itm.WindowSnap.WindowTitle = title .. " - " .. "Right"

		-- Toggle the center button to a center icon
		itm.CenterIconButton:SetIcon(ui:Icon{
			ID = "CenterIcon", 
			File = icons.center
		})

		-- Print out the window placement details
		print(string.format("[Right Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))
		-- disp:ExitLoop()
	end


	function win.On.BottomIconButton.Clicked(ev)
		-- Snap the window to the bottom
		titleBarHeight = 25
		itm.WindowSnap.Geometry = {mainWindow.Left, mainWindow.Top + (mainWindow.Height - (mainWindow.Height * viewSplitRatio)) - titleBarHeight, mainWindow.Width, mainWindow.Height * viewSplitRatio}

		-- Update the window title
		itm.WindowSnap.WindowTitle = title .. " - " .. "Bottom"

		-- Toggle the center button to a center icon
		itm.CenterIconButton:SetIcon(ui:Icon{
			ID = "CenterIcon", 
			File = icons.center
		})

		-- Print out the window placement details
		print(string.format("[Bottom Window Snap] [X] %d [Y] %d [Width] %d [Height] %d", itm.WindowSnap.Geometry[1], itm.WindowSnap.Geometry[2], itm.WindowSnap.Geometry[3], itm.WindowSnap.Geometry[4]))
		
		-- disp:ExitLoop()
	end

	win:Show()
	disp:RunLoop()
	win:Hide()
	
	app:RemoveConfig('MsgWin')
	collectgarbage()
end


-- Run the Main Function
Main()
print("[Done]")
