_VERSION = [[Version 1.0 - January 22, 2018]]
--[[
==============================================================================
Reactor Installer - v1.0 2018-01-22
==============================================================================
Requires    : Fusion 9.0.1+
Created By  : Andrew Hazelden[andrew@andrewhazelden]

==============================================================================
Overview
==============================================================================
The Reactor Installer script can be dragged from a folder on your desktop into the Fusion Console tab and it Reactor will be installed automatically. Alternatively, you could paste the Reactor Installer Lua script code into the Fusion Console tab text input field manually and the installer script will be run.

==============================================================================
Reactor Installer Usage
==============================================================================

Step 1. Drag the Reactor-Installer.lua script from your desktop into the Fusion Console tab to run it. Alternatively, you can also copy/paste the script into the Console text entry area to run it. An Install Reactor window will open. 

Step 2. Click the "Install and Relaunch" button.

A Reactor.fu file will be downloaded from GitLab and saved into the "Config:/Reactor.fu" folder.

When the installer finishes, Fusion will restart automatically and the Reactor Package Manager is ready for use. :D

==============================================================================
Environment Variables
==============================================================================

The `REACTOR_BRANCH` environment variable can be set to a custom value like "dev" to override the default master branch setting for syncing with the GitLab repo:

export REACTOR_BRANCH=dev

Note: If you are using macOS you will need to use an approach like a LaunchAgents file to define the environment variables as Fusion + Lua tends to ignore .bash_profile based environment variables entries.

The `REACTOR_INSTALL_PATHMAP` environment variable can be used to change the Reactor installation location to something other then the default PathMap value of "AllData:"

export REACTOR_INSTALL_PATHMAP=AllData:
]]--

-- Add the Reactor Public ProjectID to Reactor.cfg
local reactor_project_id = "5058837"

-- Check the "REACTOR_BRANCH" environment variable to find out which GitLab branch should be used (master/dev/)
local branch = os.getenv("REACTOR_BRANCH")
if branch == nil then
	branch = "master"
end

-- The Install & Relaunch button was pressed
function Install()
	-- ==============================================================================
	-- Setup the installation variables
	-- ==============================================================================
	local fuURL = "https://gitlab.com/api/v4/projects/" .. reactor_project_id .. "/repository/files/Reactor%2Efu/raw?ref=" .. branch
	local fuDestFile = app:MapPath("Config:/Reactor.fu")
	local reactor_pathmap = os.getenv("REACTOR_INSTALL_PATHMAP") or "AllData:"
	local sysPath = app:MapPath(tostring(reactor_pathmap) .. "Reactor/System/")
	local cfgDestFile = sysPath .. "Reactor.cfg"

	-- Save a copy of the Reactor.lua script to be autorun on the first boot of Reactor
	local luaURL = "https://gitlab.com/api/v4/projects/" .. reactor_project_id .. "/repository/files/System%2FReactor%2Elua/raw?ref=" .. branch
	
	local tempPath = app:MapPath("Temp:/Reactor/")
	bmd.createdir(tempPath)
	local autorunLuaDestFile = tempPath .. "AutorunReactor.lua"

	-- ==============================================================================
	-- Create the installer progress window
	-- ==============================================================================
	
	-- Number of steps in the HTML progress bar
	totalSteps = 10
	
	-- Show the intital progress window
	local msgwin,msgitm = ProgressWinCreate()

	statusMsg = "[Downloads Started]\n"
	ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 1, totalSteps, 1)

	-- ==============================================================================
	-- Access the FFI and cURL Libraries
	-- ==============================================================================
	ffi = require "ffi"
	curl = require "lj2curl"
	ezreq = require "lj2curl.CRLEasyRequest"

	-- ==============================================================================
	-- Download Reactor.fu
	-- ==============================================================================
	local req = ezreq(fuURL)
	local body = {}
	req:setOption(curl.CURLOPT_SSL_VERIFYPEER, 0)
	req:setOption(curl.CURLOPT_WRITEFUNCTION, ffi.cast("curl_write_callback", function(buffer, size, nitems, userdata)
		table.insert(body, ffi.string(buffer, size*nitems))
		return nitems
	 end))

	statusMsg = "[Download URL]\n" .. tostring(fuURL) .. "\n"
	ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 2, totalSteps, 1)

	ok, err = req:perform()
	if ok then
		-- Write the output to the terminal
		if os.getenv("REACTOR_DEBUG_FILES") == "true" then
			comp:Print(table.concat(body))
			comp:Print("\n")
		end

		-- Check if the Reactor.fu file was downloaded correctly
		if table.concat(body) == [[{"message":"404 File Not Found"}]] then 
			statusMsg = "[Error]\nThe main Reactor GitLab file has been renamed. Please download and install a new Reactor Bootstrap Installer script or you can try manually installing the latest Reactor.fu file.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		elseif table.concat(body) == [[{"message":"401 Unauthorized"}]] then 
			statusMsg = "[Error]\nThe GitLab repository is private.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		elseif table.concat(body) == [[{"message":"404 Project Not Found"}]] then 
			statusMsg = "[Error]\nThe GitLab repository is private.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		end

		-- Save the Config:/Reactor.fu file to disk
		local fuFile = io.open(fuDestFile, "w")
		if fuFile ~= nil then 
			fuFile:write(table.concat(body))
			fuFile:close()

			statusMsg = "[Reactor.fu Saved]\n" .. fuDestFile .. "\n"
			ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 3, totalSteps, 2)
		else
			statusMsg = "[Reactor.fu Write Error]\n" .. fuDestFile .. "\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		end
		
		-- ==============================================================================
		-- Download Reactor.lua and save it as AutorunReactor.lua + AutorunReactor.comp
		-- The comp file triggers AutorunReactor.lua to run in Fusion (Free) / Fusion Studio
		-- ==============================================================================
		statusMsg = "[Download URL]\n" .. tostring(luaURL) .. "\n"
		ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 4, totalSteps, 1)
		
		local req = ezreq(luaURL)
		local body = {}
		req:setOption(curl.CURLOPT_SSL_VERIFYPEER, 0)
		req:setOption(curl.CURLOPT_WRITEFUNCTION, ffi.cast("curl_write_callback", function(buffer, size, nitems, userdata)
			table.insert(body, ffi.string(buffer, size*nitems))
			return nitems
		 end))

		ok, err = req:perform()
		if ok then
			-- Write the output to the terminal
			if os.getenv("REACTOR_DEBUG_FILES") == "true" then
				comp:Print(table.concat(body))
				comp:Print("\n")
			end

			-- Check if the Reactor.lua file was downloaded correctly
		if table.concat(body) == [[{"message":"404 File Not Found"}]] then 
			statusMsg = "[Error]\nThe main Reactor GitLab file has been renamed. Please download and install a new Reactor Installer script or you can try manually installing the latest Reactor.fu file.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		elseif table.concat(body) == [[{"message":"401 Unauthorized"}]] then 
			statusMsg = "[Error]\nThe GitLab repository is private.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		elseif table.concat(body) == [[{"message":"404 Project Not Found"}]] then 
			statusMsg = "[Error]\nThe GitLab repository is private.\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			msgwin:Hide()
			errwin:Hide()
			exit()
			return
		end
	
			-- Save the Temp:/Reactor/AutorunReactor.lua file to disk
			local luaFile = io.open(autorunLuaDestFile, "w")
			if luaFile ~= nil then 
				luaFile:write(table.concat(body))
				luaFile:close()

				statusMsg = "[AutorunReactor.lua Saved]\n" .. autorunLuaDestFile .. "\n"
				ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 5, totalSteps, 2)
			else
				statusMsg = "[AutorunReactor.lua Write Error]\n" .. autorunLuaDestFile .. "\n"
				errwin,erritm = ErrorWin("Installation Error", statusMsg)
				errwin:Hide()
				exit()
				return
			end
			
			-- Save the Temp:/Reactor/AutorunReactor.comp file to disk
			local autorunComp = tempPath .. "AutorunReactor.comp"
			local compFile = io.open(autorunComp, "w")
			if compFile ~= nil then 
				compFile:write("Composition {}")
				compFile:close()

				statusMsg = "[AutorunReactor.comp Saved]\n" .. autorunComp .. "\n"
				ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 6, totalSteps, 2)
			else
				statusMsg = "[AutorunReactor.comp Write Error]\n" .. autorunComp .. "\n"
				errwin,erritm = ErrorWin("Installation Error", statusMsg)
				msgwin:Hide()
				errwin:Hide()
				exit()
				return
			end
			
			-- ==============================================================================
			-- Create Reactor.cfg
			-- ==============================================================================
			local cfgFile = io.open(cfgDestFile, "w")
			if cfgFile ~= nil then
				cfgFile:write([[
{
	Repos = {
		GitLab = {
			Projects = {
				Reactor = "]] .. reactor_project_id .. [[",
			},
		},
	},
	Settings = {
		Reactor =
		{
			Token = "",
		},
	},
}]])

				cfgFile:close()
				
				statusMsg = "[Reactor.cfg Saved]\n" .. tostring(cfgDestFile) .. "\n"
				ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 7, totalSteps, 2)
			else
				statusMsg = "[Reactor.cfg Write Error]\n" .. cfgDestFile .. "\n"
				errwin,erritm = ErrorWin("Installation Error", statusMsg)
				msgwin:Hide()
				errwin:Hide()
				exit()
				return
			end
			
			statusMsg = "[Reactor]\nAll Downloads Completed\n"
			ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 8, totalSteps, 2)

			-- statusMsg = "[Showing Reactor Folder]\n" .. tostring(sysPath) .. "\n"
			-- ProgressWinUpdate(msgwin, msgitm, "Installation Status", statusMsg, 9, totalSteps, 2)

			-- Open Reactor:/System/ folder in a desktop file browser window
			-- bmd.openfileexternal("Open", sysPath)

			-- ==============================================================================
			-- Restart Fusion
			-- ==============================================================================
			-- Show a Restarting Fusion dialog and eait a few seconds so you can look at the Console tab output
			ProgressWinUpdate(msgwin, msgitm, "Installation Complete", "Restarting Fusion in 4 seconds...", 10, totalSteps, 4)
			
			-- Get the Fusion program path:
			-- /Applications/Blackmagic Fusion 9/Fusion.app/Contents/MacOS/Fusion
			fusionApp = fusion:GetAttrs().FUSIONS_FileName

			-- Create the Fusion launching command
			if platform == "Windows" then
				command = "start \"\" " .. "\"" .. fusionApp .. "\" \"" .. autorunComp .. "\" 2>&1 &"
			else
				command = "\"" .. fusionApp .. "\" \"" .. autorunComp .. "\" 2>&1 &"
			end
			comp:Print("[Launch Command] " .. tostring(command) .. "\n")

			-- Start up a new instance of Fusion
			os.execute(command)
			
			-- Hide the progress window
			msgwin:Hide()

			-- Quit the current Fusion session
			fusion:Quit()
		else
			statusMsg = "There was an error downloading:" .. tostring(destFile) .. "\n"
			errwin,erritm = ErrorWin("Installation Error", statusMsg)
			return
		end 
	else
		statusMsg = "There was an error downloading:" .. tostring(destFile) .. "\n"
		errwin,erritm = ErrorWin("Installation Error", statusMsg)
		return
	end 
end


-- Open a Webpage
-- Example: OpenURL("We Suck Less", "https://www.steakunderwater.com/")
function OpenURL(siteName, path)
	if platform == "Windows" then
		-- Running on Windows
		command = "explorer \"" .. path .. "\""
	elseif platform == "Mac" then
		-- Running on Mac
		command = "open \"" .. path .. "\" &"
	elseif platform == "Linux" then
		-- Running on Linux
		command = "xdg-open \"" .. path .. "\" &"
	else
		comp:Print("[Error] There is an invalid Fusion platform detected\n")
		return
	end
	
	os.execute(command)
	
	-- comp:Print("[Launch Command] " tostring(command) .. "\n")
	comp:Print("[Opening URL] [" .. tostring(siteName) .. "] " .. tostring(path) .. "\n")
end


-- Create the "Install Reactor" dialog
function InstallReactorWin()
	-- Configure the window Size
	local originX, originY, width, height = 450, 300, 525, 150
	
	-- Create the new UI Manager Window
	local win = disp:AddWindow({
		ID = "InstallReactorWin",
		TargetID = "InstallReactorWin",
		WindowTitle = "Install Reactor",
		WindowFlags = {
			Window = true,
			WindowStaysOnTopHint = true,
		},
		Geometry = {
			originX,
			originY,
			width,
			height,
		},

		ui:VGroup {
			ID = "root",
			
			-- Add your GUI elements here:
			ui:HGroup{
				Weight = 1,
				
				ui:VGroup{
					Weight = 0.25,
					
					-- Add the Reactor Logo
					ui:TextEdit{
						Weight = 1,
						ID = "Logo",
						ReadOnly = true,
						HTML = ReactorLogo(),
						MinimumSize = {
							100,
							80,
						},
					},
					
					ui:VGap(40),
				},
				ui:VGroup{
					Weight = 1,
					
					-- Ready to Install label
					ui:Label{
						ID = "InstallLabel",
						Weight = 0,
						Text = "Ready to Install",
						ReadOnly = true,
						Alignment = {
							AlignHCenter = true, 
							AlignVCenter = true,
						},
						Font = ui:Font{
							PixelSize = 18,
						},
					},

					ui:VGroup{
						Weight = 1,
						ui:Label{
							ID = "AboutLabel",
							Text = [[Reactor is a package manager for Fusion (Free) and Fusion Studio created by the < a href="https://www.steakunderwater.com/wesuckless/">We Suck Less Fusion Community</a>.]],
							OpenExternalLinks = true,
							WordWrap = true,
							Alignment = {
								AlignHCenter = true,
								AlignVCenter = true,
							},
							Font = ui:Font{
								PixelSize = 14,
							},
						},
					},

					ui:HGroup{
						Weight = 0,
						
						-- Add a horizontal spacer
						ui:HGap(0, 2.0),

						-- Install and Relaunch Button
						ui:Button{
							ID = "InstallButton",
							Text = "Install and Relaunch",
						},
					},

				},
			},
		},
	})

	-- Add your GUI element based event functions here:
	itm = win:GetItems()

	-- The window was closed
	function win.On.InstallReactorWin.Close(ev)
		disp:ExitLoop()
	end

	-- The Install and Relaunch Button was clicked
	function win.On.InstallButton.Clicked(ev)
		comp:Print("[Reactor] Installation Started\n")
		
		-- Run the installer
		win:Hide()
		Install()
	end

	-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the window instead of closing the foreground composite.
	app:AddConfig("InstallReactorWin", {
		Target {
			ID = "InstallReactorWin",
		},

		Hotkeys {
			Target = "InstallReactorWin",
			Defaults = true,

			CONTROL_W = "Execute{ cmd = [[ app.UIManager:QueueEvent(obj, 'Close', {}) ]] }",
			CONTROL_F4 = "Execute{ cmd = [[ app.UIManager:QueueEvent(obj, 'Close', {}) ]] }",
		},
	})

	-- Init the window
	win:Show()
	disp:RunLoop()
	win:Hide()
	
	return win,win:GetItems()
end


-- Reactor message dialog
-- Example: local msgwin,msgitm = ProgressWinCreate()
function ProgressWinCreate()
	local win = disp:AddWindow({
		ID = "MsgWin",
		WindowTitle = "Fusion Reactor",
		TargetID = "MsgWin",
		Geometry = {450,300,580,250},

		ui:VGroup{
			ui:Label{
				ID = "Title",
				Text = "",
				Alignment = {
					AlignHCenter = true,
					AlignVCenter = true,
				},
				Font = ui:Font{
					PixelSize = 18,
				},
				WordWrap = true,
			},

			ui:Label{
				ID = "Message",
				Text = "",
				Alignment = {
					AlignHCenter = true,
					AlignVCenter = true,
				},
				WordWrap = true,
			},

			ui:TextEdit{
				ID = "ProgressHTML",
				ReadOnly = true,
			},

		}
	})

	-- Add your GUI element based event functions here:
	itm = win:GetItems()

	win:Show()

	return win,itm
end


-- Update the Reactor progress dialog
-- Example: ProgressWinUpdate(msgwin, msgitm, "Initializing...", "Restarting Fusion", 1, 10, 1)
function ProgressWinUpdate(win, itm, title, text, progressLevel, progressMax, delaySeconds)
	-- Update the window title
	itm.MsgWin.WindowTitle = "Fusion Reactor - " .. tostring(title)

	-- Update the heading Text
	itm.Title.Text = title .. "\nStep " .. tostring(progressLevel) .. " of " .. tostring(progressMax)
	
	itm.Message.Text = text

	-- Print the error to the Console tab
	if comp ~= nil then
		comp:Print(text)
	end

	-- Add the webpage header text
	html = "<html>\n"
	html = html .."\t<head>\n"
	html = html .."\t\t<style>\n"
	html = html .."\t\t</style>\n"
	html = html .."\t</head>\n"
	html = html .."\t<body>\n"
	html = html .. "\t\t<div>"
	html = html .. "\t\t\t<div style=\"float:right;width:46px;\">\n"

	-- progressScale is a multiplier to adjust to the progressMax range vs number of bar elements rendered onscreen
	progressScale = 6

	-- Scale the progress values to better fill the window size
	progressLevelScaled = progressLevel * progressScale
	progressMaxScaled = progressMax * progressScale

	-- Update the activity monitor view - Turn the images into HTML <img> tags
	for img = 1, progressLevelScaled do
		-- These images are the progressbar "ON" cells
		html = html .. ProgressbarCellON()
	end

	for img = progressLevelScaled + 1, progressMaxScaled do
		-- These images are the progressbar "OFF" cells
		html = html .. ProgressbarCellOFF()
	end

	html = html .. "\t\t\t</div>\n"
	html = html .. "\t\t</div>\n"
	html = html .. "\t</body>\n"
	html = html .. "</html>"

	-- Refresh the progress bar
	-- print("[HTML]\n" .. html)
	itm.ProgressHTML.HTML = html

	-- Pause to show the message
	bmd.wait(delaySeconds)
end


-- Reactor message dialog
-- Example: local errwin,erritm = ErrorWin("Initializing...", "Restarting Fusion")
function ErrorWin(title, text)
	local win = disp:AddWindow({
		ID = "errWin",
		TargetID = "errWin",
		WindowTitle = "Fusion Reactor - " .. tostring(title),
		Geometry = {510,580,500,150},

		ui:VGroup
		{
			ui:Label{
				ID = "Title",
				Text = title or "",
				Alignment = {
					AlignHCenter = true,
					AlignVCenter = true,
				},
				Font = ui:Font{
					PixelSize = 18,
				},
			},

			-- ui:VGap(0),

			ui:Label{
				ID = "Message",
				Text = text or "",
				Alignment = {
					AlignHCenter = true,
					AlignVCenter = true,
				},
				WordWrap = true,
			},
			
			ui:HGroup{
				Weight = 0,
				-- Add a horizontal spacer
				ui:HGap(0, 2.0),

				-- OK Button
				ui:Button{
					ID = "OkButton",
					Text = "Ok",
				},
			},

		}
	})

	-- Add your GUI element based event functions here:
	itm = win:GetItems()

	-- The window was closed
	function win.On.errWin.Close(ev)
		win:Hide()
		disp:ExitLoop()
	end

	-- The OK Button was clicked
	function win.On.OkButton.Clicked(ev)
		disp:ExitLoop()
	end

	-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the window instead of closing the foreground composite.
	app:AddConfig("errWin", {
		Target {
			ID = "errWin",
		},

		Hotkeys {
			Target = "errWin",
			Defaults = true,

			CONTROL_W = "Execute{ cmd = [[ app.UIManager:QueueEvent(obj, 'Close', {}) ]] }",
			CONTROL_F4 = "Execute{ cmd = [[ app.UIManager:QueueEvent(obj, 'Close', {}) ]] }",
		},
	})

	-- Print the error to the Console tab
	if comp ~= nil then
		comp:Print(text)
	end

	win:Show()

	disp:RunLoop()
	win:Hide()

	return win,win:GetItems()
end


-- Close all of the Active Comps
function CloseComps()
	local openComps = "\n"
	
	local compList = fu:GetCompList()
	for i = 1, table.getn(compList) do
		-- Set cmp to the pointer of the current composite
		cmp = compList[i]
		

		-- Close the active comp
		if cmp:GetAttrs()["COMPS_FileName"] == "" then
			-- Print out the active composite name
			openComps = openComps .. "[Closing Comp] " .. tostring(cmp:GetAttrs()["COMPS_Name"]) .. " \n"
	
			-- Force close any unsaved comps that have no filename (do this to avoid a Fusion 9 crash issue)
			cmp:Lock()
			cmp:Close()
		else
			-- Print out the active composite name
			openComps = openComps .. "[Saving and Closing Comp] " .. tostring(cmp:GetAttrs()["COMPS_Name"]) .. " \n"
	
			-- Ask to save comps that have files open
			cmp:Lock()
			cmp:Save(cmp:GetAttrs()["COMPS_FileName"])
			cmp:Close()
		end
	end
	
	-- Add an extra newline
	openComps = openComps .. "\n"
	
	-- Unlock the comp flow area - This causes comp.Close() to ask if you want to save the current document
	cmp:Unlock()
	
	-- Re-update the comp variable
	new_comp = fusion:NewComp()
	composition = fusion.CurrentComp
	comp = composition
	
	return openComps
end


-- The Main function
function Main()
	-- Check if the Fusion GUI is running
	if fusion == nil then
		print("[Fusion] Error: Please open up the Fusion GUI before running this tool.\n")
	else
		-- Check what version of Fusion is active
		local fuVersion = math.floor(tonumber(eyeon._VERSION))
		if fuVersion < 9 then
			-- Fusion 7 or 8 was detected
			print("[UI Manager] Fusion 9.0.1 or higher is required. Detected Fusion " .. tostring(eyeon._VERSION) .. "\n")
		else
			-- Fusion 9+ is running
			
			-- Find out the current Fusion host platform (Windows/Mac/Linux)
			platform = (FuPLATFORM_WINDOWS and "Windows") or (FuPLATFORM_MAC and "Mac") or (FuPLATFORM_LINUX and "Linux")

			-- Close all of the active comps
			closedLst = CloseComps()
			
			-- Print out the script info
			comp:Print("\n\n[Reactor Installer] " .. tostring(_VERSION) .. "\n")
			comp:Print("[Created By] Andrew Hazelden <andrew@andrewhazelden.com>\n")
			comp:Print("[Reactor] Detected Fusion " .. tostring(eyeon._VERSION) .. " running on " .. platform .. "\n")

			-- Print out a list of the comps that were closed
			comp:Print(closedLst)
			
			comp:Print("[GitLab Branch] \"" .. tostring(branch) .. "\"\n")

			-- Check Reactor.cfg
			local reactor_pathmap = os.getenv("REACTOR_INSTALL_PATHMAP") or "AllData:"
			local sysPath = app:MapPath(tostring(reactor_pathmap) .. "Reactor/System/")
			local cfgDestFile = sysPath .. "Reactor.cfg"
			if eyeon.fileexists(cfgDestFile) == false then
				-- comp:Print("[Reactor.cfg] Does not exist yet")
				bmd.createdir(sysPath)
			end

			-- Display the "Install Reactor" dialog
			ui = app.UIManager
			disp = bmd.UIDispatcher(ui)
			InstallReactorWin()
		end
	end
end

-- Progressbar ON cell encoded as Base64 content
-- Example: itm.Progress.HTML = ProgressbarCellON() 
function ProgressbarCellON()
	return [[<img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAkAAAAuCAIAAAB1WqTJAAABG2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIi8+CiA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgo8P3hwYWNrZXQgZW5kPSJyIj8+Gkqr6gAADB5pQ0NQRGlzcGxheQAASImlV3dYU8kWn1tSCAktEAEpoTdBepXei4B0EJWQBAglhISgYkcWFVwLKqJY0VURFdcCyFoRu4uAvS6IqKysiwUbKm9SQNf93vvnne+bmV/OnHPmd+aeezMDgLJPLjtPhKoAkMcvFMYE+zGTklOYpB5ABrpAGTgAVxZbJPCNjo4AUEbHf8q7WwCRjNetJbH+Pf8/RZXDFbEBQKIhLuSI2HkQtwGAa7IFwkIACA+g3mhmoQBiosReXQgJQqwuwZkybC7B6TI8SWoTF+MPMYxJprJYwkwAlFKhnlnEzoRxlOZCbMvn8PgQ74PYi53F4kA8APGEvLx8iJU1ITZP/y5O5j9ipo/FZLEyx7AsF6mQA3giQS5r9mieZBAAeEAEBCAXsMCY+v+XvFzx6JqGsFGzhCExkj2A+7gnJz9cgqkQH+enR0ZBrAbxRR5Hai/B97LEIfFy+wG2yB/uIWAAgAIOKyAcYh2IGeKceF85tmcJpb7QHo3kFYbGyXG6MD9GHh8t4udGRsjjLM3iho7iLVxRYOyoTQYvKBRiWHnokeKsuEQZT7StiJcQCbESxB2inNhwue+j4iz/yFEboThGwtkY4rcZwqAYmQ2mKa8+GB+zYbOka8HniPkUZsWFyHyxJK4oKWKUA4cbECjjgHG4/Hg5NwxWm1+M3LdMkBstt8e2cHODY2T7jB0UFcWO+nYVwoKT7QP2OJsVFi1f652gMDpOxg1HQQTwhzXABGLY0kE+yAa89oGmAfhLNhME60IIMgEXWMs1ox6J0hk+7GNBMfgLIi6spFE/P+ksFxRB/Zcxray3BhnS2SKpRw54CnEero174R54BOx9YLPHXXG3UT+m8uiqxEBiADGEGES0GOPBhqxzYRPCSv63LhyOXJidhAt/NIdv8QhPCZ2Ex4SbhG7CXZAAnkijyK1m8EqEPzBngsmgG0YLkmeX/n12uClk7YT74Z6QP+SOM3BtYI07wkx8cW+YmxPUfs9QPMbt217+uJ6E9ff5yPVKlkpOchbpY0/Gf8zqxyj+3+0RB47hP1piS7HD2AXsDHYJO441ASZ2CmvGrmInJHisEp5IK2F0tRgptxwYhzdqY1tv22/7+Ye1WfL1JfslKuTOKpS8DP75gtlCXmZWIdNXIMjlMkP5bJsJTHtbOxcAJN962afjDUP6DUcYl7/pCk4D4FYOlZnfdCwjAI49BYD+7pvO6DUs91UAnOhgi4VFMh0u6QiAAv9D1IEW0ANGwBzmYw+cgQfwAYEgDESBOJAMpsMdzwJ5kPNMMBcsAmWgAqwC68BGsBXsAHvAfnAINIHj4Aw4D66ADnAT3Id10QdegEHwDgwjCEJCaAgd0UL0ERPECrFHXBEvJBCJQGKQZCQNyUT4iBiZiyxGKpBKZCOyHalDfkWOIWeQS0gnchfpQfqR18gnFEOpqDqqi5qiE1FX1BcNR+PQaWgmWoAWo6XoCrQarUX3oY3oGfQKehPtRl+gQxjAFDEGZoBZY66YPxaFpWAZmBCbj5VjVVgtdgBrgc/5OtaNDWAfcSJOx5m4NazNEDweZ+MF+Hx8Ob4R34M34m34dbwHH8S/EmgEHYIVwZ0QSkgiZBJmEsoIVYRdhKOEc/C96SO8IxKJDKIZ0QW+l8nEbOIc4nLiZmID8TSxk9hLHCKRSFokK5InKYrEIhWSykgbSPtIp0hdpD7SB7IiWZ9sTw4ip5D55BJyFXkv+SS5i/yMPKygomCi4K4QpcBRmK2wUmGnQovCNYU+hWGKKsWM4kmJo2RTFlGqKQco5ygPKG8UFRUNFd0UpyjyFBcqViseVLyo2KP4kapGtaT6U1OpYuoK6m7qaepd6hsajWZK86Gl0AppK2h1tLO0R7QPSnQlG6VQJY7SAqUapUalLqWXygrKJsq+ytOVi5WrlA8rX1MeUFFQMVXxV2GpzFepUTmmcltlSJWuaqcapZqnulx1r+ol1edqJDVTtUA1jlqp2g61s2q9dIxuRPens+mL6Tvp5+h96kR1M/VQ9Wz1CvX96u3qgxpqGo4aCRqzNGo0Tmh0MzCGKSOUkctYyTjEuMX4NE53nO847rhl4w6M6xr3XnO8po8mV7Ncs0HzpuYnLaZWoFaO1mqtJq2H2ri2pfYU7ZnaW7TPaQ+MVx/vMZ49vnz8ofH3dFAdS50YnTk6O3Su6gzp6ukG6wp0N+ie1R3QY+j56GXrrdU7qdevT9f30ufpr9U/pf8nU4Ppy8xlVjPbmIMGOgYhBmKD7QbtBsOGZobxhiWGDYYPjShGrkYZRmuNWo0GjfWNJxvPNa43vmeiYOJqkmWy3uSCyXtTM9NE0yWmTabPzTTNQs2KzerNHpjTzL3NC8xrzW9YEC1cLXIsNlt0WKKWTpZZljWW16xQK2crntVmq84JhAluE/gTaifctqZa+1oXWddb99gwbCJsSmyabF5ONJ6YMnH1xAsTv9o62eba7rS9b6dmF2ZXYtdi99re0p5tX2N/w4HmEOSwwKHZ4ZWjlSPXcYvjHSe602SnJU6tTl+cXZyFzgec+12MXdJcNrncdlV3jXZd7nrRjeDm57bA7bjbR3dn90L3Q+5/e1h75Hjs9Xg+yWwSd9LOSb2ehp4sz+2e3V5MrzSvbV7d3gbeLO9a78c+Rj4cn10+z3wtfLN99/m+9LP1E/od9Xvv7+4/z/90ABYQHFAe0B6oFhgfuDHwUZBhUGZQfdBgsFPwnODTIYSQ8JDVIbdDdUPZoXWhg2EuYfPC2sKp4bHhG8MfR1hGCCNaJqOTwyavmfwg0iSSH9kUBaJCo9ZEPYw2iy6I/m0KcUr0lJopT2PsYubGXIilx86I3Rv7Ls4vbmXc/XjzeHF8a4JyQmpCXcL7xIDEysTupIlJ85KuJGsn85KbU0gpCSm7UoamBk5dN7Uv1Sm1LPXWNLNps6Zdmq49PXf6iRnKM1gzDqcR0hLT9qZ9ZkWxallD6aHpm9IH2f7s9ewXHB/OWk4/15NbyX2W4ZlRmfE80zNzTWZ/lndWVdYAz5+3kfcqOyR7a/b7nKic3TkjuYm5DXnkvLS8Y3w1fg6/LV8vf1Z+p8BKUCboLnAvWFcwKAwX7hIhommi5kJ1eMy5KjYX/yTuKfIqqin6MDNh5uFZqrP4s67Otpy9bPaz4qDiX+bgc9hzWucazF00t2ee77zt85H56fNbFxgtKF3QtzB44Z5FlEU5i34vsS2pLHm7OHFxS6lu6cLS3p+Cf6ovUyoTlt1e4rFk61J8KW9p+zKHZRuWfS3nlF+usK2oqvi8nL388s92P1f/PLIiY0X7SueVW1YRV/FX3VrtvXpPpWplcWXvmslrGtcy15avfbtuxrpLVY5VW9dT1ovXd1dHVDdvMN6wasPnjVkbb9b41TRs0tm0bNP7zZzNXVt8thzYqru1Yuunbbxtd7YHb2+sNa2t2kHcUbTj6c6EnRd+cf2lbpf2ropdX3bzd3fvidnTVudSV7dXZ+/KerReXN+/L3Vfx/6A/c0HrA9sb2A0VBwEB8UH//w17ddbh8IPtR52PXzgiMmRTUfpR8sbkcbZjYNNWU3dzcnNncfCjrW2eLQc/c3mt93HDY7XnNA4sfIk5WTpyZFTxaeGTgtOD5zJPNPbOqP1/tmkszfaprS1nws/d/F80PmzF3wvnLroefH4JfdLxy67Xm664nyl8arT1aO/O/1+tN25vfGay7XmDreOls5JnSe7vLvOXA+4fv5G6I0rNyNvdt6Kv3Xndurt7jucO8/v5t59da/o3vD9hQ8ID8ofqjyseqTzqPYPiz8aup27T/QE9Fx9HPv4fi+798UT0ZPPfaVPaU+rnuk/q3tu//x4f1B/x59T/+x7IXgxPFD2l+pfm16avzzyt8/fVweTBvteCV+NvF7+RuvN7reOb1uHoocevct7N/y+/IPWhz0fXT9e+JT46dnwzM+kz9VfLL60fA3/+mAkb2REwBKypEcBDDY0IwOA17sBoCXDs0MHABQl2V1MKojs/ihF4L9h2X1NKs4A7PYBIH4hABHwjLIFNhOIqXCUHL3jfADq4DDW5CLKcLCXxaLCGwzhw8jIG10ASC0AfBGOjAxvHhn5shOSvQvA6QLZHVAiRHi+32YjQR19L8GP8h+KMnBmRR2RSAAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAapJREFUOI11kM1uE0EQhKt6y5HjEAgSCILIAQWBI+BBuPPQvAIHDkiJokgRB34SO97p4rBra2e9zGlmSlX1dfPL5+dvzg6X5wsMzvJ8cXm91tmr+cd3i08XL4bao6cfjh//0LMTvT6dH528H2qLJ8vQoUqCQDRzsCEIEkDoqNGxJM5ExsHWEyQYMzYH6j7IwOhkK6KL4fCfITAUgQiCzVCLEBkCQNYuAAiAAkgCdR/ZgI0iQHLEwmhIikQTGPWRAhsRHWTdSBEUSExlgqF+uD0WggqCDGKPM7TzjfqCgLrAcV/HiR6x3icJcJoFCPacHG+UJBjb2f/D0r/qzG0fJzIDpGzYNjzU7IS9y6w0wIDl7uZacxqQDUxkGk7ZnS/rzLRT26o9H6zO5Npnt3DZZU6xpGGnMfIVZDvNYhfDQr+YWssC53b20V7cGpaNkoDLBGcmPJVpW9tB9zhdBGC8TQBIwMpEpkd9ma07zn7Eqq+FU6V407q0q1pbZ1lp/ZB396Vsfg+10v4t7R/d/txc3axPX34baqH5/a/vurp5mM3u7NuhdvH26+X16h/58eg07Jg0vAAAAABJRU5ErkJggg=='/>]]
end
	
-- Progressbar off cell encoded as Base64 content
-- Example: itm.Progress.HTML = ProgressbarCellOFF() 
function ProgressbarCellOFF()
	return [[<img src='data:image/png;base64,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'/>]]
end
	
-- Reactor logo encoded as Base64 content
-- Example: itm.Logo.HTML = ReactorLogo() 
function ReactorLogo()
	return [[<center><img width="68" height="68" src='data:image/png;base64,
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
'/></center>]]
end

-- ==============================================================================
-- Show the Reactor Install GUI
-- ==============================================================================
Main()