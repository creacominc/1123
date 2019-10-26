_VERSION = 'v4.1 2019-10-25'
--[[--
----------------------------------------------------------------------------
KartaVR - Export Point Cloud v4.1 2019-10-25
by Andrew Hazelden
www.andrewhazelden.com
andrew@andrewhazelden.com

Overview:
This script allows you to export PointCloud3D node based points to .xyz and .ply formatted point clouds that are saved to the "Temp:/KartaVR/" folder. This script works in Fusion v9-16.1+ and Resolve v15-16.1+.

Usage:
Step 1. Save your Fusion composite to disk.

Step 2. Select a PointCloud3D node in the Flow/Nodes view.

Step 3. Run the "Script > KartaVR > Geometry > Export Point Cloud" menu item. The point cloud data will be saved to the "Temp:/KartaVR/" folder.

----------------------------------------------------------------------------
--]]--

------------------------------------------------------------------------
-- Find out the current operating system platform.
-- The platform local variable should be set to either "Windows", "Mac", or "Linux".
local platform = (FuPLATFORM_WINDOWS and 'Windows') or (FuPLATFORM_MAC and 'Mac') or (FuPLATFORM_LINUX and 'Linux')

------------------------------------------------------------------------
-- Add the platform specific folder slash character
osSeparator = package.config:sub(1,1)

------------------------------------------------------------------------
-- Home Folder
-- Add the user folder path - Example: C:\Users\Administrator\
if platform == 'Windows' then
	homeFolder = tostring(os.getenv('USERPROFILE')) .. osSeparator
else
	-- Mac and Linux
	homeFolder = tostring(os.getenv('HOME')) .. osSeparator
end

------------------------------------------------------------------------
-- Set a fusion specific preference value
-- Example: SetPreferenceData('KartaVR.Version', '1.0', true)
function SetPreferenceData(pref, value, status)
	-- comp:SetData(pref, value)
	fusion:SetData(pref, value)

	-- List the preference value
	if status == 1 or status == true then
		if value == nil then
			print('[Setting ' .. pref .. ' Preference Data] ' .. 'nil')
		else
			print('[Setting ' .. pref .. ' Preference Data] ' .. value)
		end
	end
end

------------------------------------------------------------------------
-- Read a fusion specific preference value. If nothing exists set and return a default value
-- Example: GetPreferenceData('KartaVR.Version', 1.0, true)
function GetPreferenceData(pref, defaultValue, status)
	-- local newPreference = comp:GetData(pref)
	local newPreference = fusion:GetData(pref)
	if newPreference then
		-- List the existing preference value
		if status == 1 or status == true then
			if newPreference == nil then
				print('[Reading ' .. pref .. ' Preference Data] ' .. 'nil')
			else
				print('[Reading ' .. pref .. ' Preference Data] ' .. newPreference)
			end
		end
	else
		-- Force a default value into the preference & then list it
		newPreference = defaultValue
		-- comp:SetData(pref, defaultValue)
		fusion:SetData(pref, defaultValue)

		if status == 1 or status == true then
			if newPreference == nil then
				print('[Creating ' .. pref .. ' Preference Data] ' .. 'nil')
			else
				print('[Creating '.. pref .. ' Preference Entry] ' .. newPreference)
			end
		end
	end

	return newPreference
end

------------------------------------------------------------------------
-- Add a slash to the end of folder paths
function ValidateDirectoryPath(path)
	if string.sub(path, -1, -1) ~= osSeparator then
		path = path .. osSeparator
	end

	return path
end

------------------------------------------------------------------------
-- Find out the current directory from a file path
-- Example: print(Dirname('/Volumes/Media/pointcloud.xyz'))
function Dirname(mediaDirName)
	return mediaDirName:match('(.*' .. osSeparator .. ')')
end

------------------------------------------------------------------------
-- Open a folder window up using your desktop file browser
-- Example: openDirectory('/Volumes/Media/')
function openDirectory(mediaDirName)
	command = nil
	dir = Dirname(mediaDirName)

	if platform == 'Windows' then
		-- Running on Windows
		command = 'explorer "' .. dir .. '"'

		print('[Launch Command] ', command)
		os.execute(command)
	elseif platform == 'Mac' then
		-- Running on Mac
		command = 'open "' .. dir .. '" &'

		print('[Launch Command] ', command)
		os.execute(command)
	elseif platform == 'Linux' then
		-- Running on Linux
		command = 'nautilus "' .. dir .. '" &'

		print('[Launch Command] ', command)
		os.execute(command)
	else
		print('[Platform] ', platform)
		print('There is an invalid platform defined in the local platform variable at the top of the code.')
	end
end


------------------------------------------------------------------------
-- Show the UI manager GUI
function ExportPointCloudWin()
	-- Load UI Manager
	ui = app.UIManager
	disp = bmd.UIDispatcher(ui)

	-- Read the last folder accessed from a ExportDirectory preference
	-- The default value for the first time the RequestDir is shown in the "$HOME/Documents/" folder.
	local exportDirectory = GetPreferenceData('KartaVR.ExportPointCloud.ExportDirectory', homeFolder, false)

	-- Load the Reactor icon resources PathMap
	local iconsDir = fusion:MapPath('Reactor:/System/UI/Images') .. 'icons.zip/'
	-- print('[Icons Folder] ' .. tostring(iconsDir))

	-- Create a list of the standard PNG format ui:Icon/ui:Button Sizes/MinimumSizes in px
	local tiny = 14
	local small = 16
	local medium = 24
	local large = 32
	local long = 110
	local big = 150

	-- Create Lua tables with X/Y defined Icon Sizes
	local iconsMedium = {large,large}
	local iconsMediumLong = {big,large}

	-- Track the current node selection
	local selectedNode = comp.ActiveTool
	local selectedNodeName = ''
	
	if selectedNode then
		selectedNodeName = selectedNode.Name
	end 
	------------------------------------------------------------------------
	-- Create the new window
	local epcwin = disp:AddWindow({
		ID = 'ExportPointCloud',
		TargetID = 'ExportPointCloud',
		WindowTitle = 'Export Point Cloud',
		Geometry = {200,100,600,140},
		MinimumSize = {600, 140},
		-- Spacing = 10,
		-- Margin = 20,

		ui:VGroup{
			ID = 'root',
			
			ui:HGroup{
				Weight = 0.01,
				ui:Label{
					ID = 'FormatLabel',
					Weight = 0.1,
					Text = 'Point Cloud Format',
				},
				ui:ComboBox{
					ID = 'FormatCombo',
				},
				ui:Label{
					ID = 'NodeLabel',
					Weight = 0.2,
					Text = 'Selected Node',
				},
				ui:LineEdit{
					ID = 'NodeNameText',
					PlaceholderText = '[Select a PointCloud3D Node]',
					Text = selectedNodeName,
					ReadOnly = true,
				},
			},

			-- pointcloud Working Directory
			ui:HGroup{
				Weight = 0,
				ui:Label{
					ID = 'ExportDirectoryLabel',
					Weight = 0.2,
					Text = 'Export Directory',
				},
				ui:HGroup{
					ui:LineEdit{
						ID = 'ExportDirectoryText',
						PlaceholderText = '',
						Text = exportDirectory,
					},
					ui:Button{
						ID = 'SelectFolderButton',
						Weight = 0,
						Text = 'Select Folder',
						IconSize = iconsMedium,
						Icon = ui:Icon{
							File = iconsDir .. 'folder.png'
						},
						MinimumSize = iconsMediumLong,
						Flat = true,
					},
				},
			},
			
			ui:VGap(5),

			ui:HGroup{
				Weight = 0,
				ui:Button{
					ID = 'CancelButton',
					Text = 'Cancel',
					IconSize = iconsMedium,
					Icon = ui:Icon{
						File = iconsDir .. 'close.png'
					},
					MinimumSize = iconsMedium,
					Flat = true,
				},
				-- ui:HGap(20),
				ui:HGap(150),
				ui:Button{
					ID = 'ContinueButton',
					Text = 'Continue',
					IconSize = iconsMedium,
					Icon = ui:Icon{
						File = iconsDir .. 'create.png'
					},
					MinimumSize = iconsMedium,
					Flat = true,
				},
			},
		}
	})

	-- Add your GUI element based event functions here:
	local epcitm = epcwin:GetItems()

	-- The window was closed
	function epcwin.On.ExportPointCloud.Close(ev)
		epcwin:Hide()

		pointcloudFile = nil
		pointcloudData = nil

		disp:ExitLoop()
	end

	-- The Continue Button was clicked
	function epcwin.On.ContinueButton.Clicked(ev)
		-- Read the Working Directory textfield
		workingDir = ValidateDirectoryPath(epcitm.ExportDirectoryText.Text)

		if workingDir == nil then
			-- Check if the working directory is empty
			print('[Working Directory] The textfield is empty!')
		else
			if bmd.fileexists(workingDir) == false then
				-- Create the working directory if it doesn't exist yet
				print('[Working Directory] Creating the folder: "' .. workingDir .. '"')
				bmd.createdir(workingDir)
			end

			-- Build the point cloud folder path
			pointcloudFolder = fusion:MapPath(workingDir .. osSeparator)

			-- Remove double slashes from the path
			pointcloudFolder = string.gsub(pointcloudFolder, '//', '/')
			pointcloudFolder = string.gsub(pointcloudFolder, '\\\\', '\\')

			-- Create the point cloud output folder
			bmd.createdir(pointcloudFolder)
			if bmd.fileexists(pointcloudFolder) == false then
				-- See if there was an error creating the pointcloud folder
				print('[pointcloud Folder] Error creating the folder: "' .. pointcloudFolder .. '".\nPlease select an export directory with write permissions.')
				disp:ExitLoop()
			else
				-- Success
				epcwin:Hide()

				-- Save a default ExportDirectory preference
				SetPreferenceData('KartaVR.ExportPointCloud.ExportDirectory', workingDir, false)

				-- List the selected Node in Fusion
				selectedNode = comp.ActiveTool
				if selectedNode then
					local nodeName = selectedNode.Name
					print('[Selected Node] ' .. tostring(nodeName))

					toolAttrs = selectedNode:GetAttrs()
					nodeType = toolAttrs.TOOLS_RegID

					-- Read data from either a the loader and saver nodes
					if nodeType == 'PointCloud3D' then
						-- Grab the settings table for the node
						local nodeTable = comp:CopySettings(selectedNode)
						-- print('[PointCloud3D Settings]')
						-- dump(nodeTable)

						-- Check for a non nil settings lua table
						if nodeTable and nodeTable['Tools'] and nodeTable['Tools'][nodeName] and nodeTable['Tools'][nodeName]['Positions'] then
							-- Grab the positions Lua table elements
							local positionsTable = nodeTable['Tools'][nodeName]['Positions'] or {}
							local positionsElements = tonumber(table.getn(positionsTable))

							-- Get the point cloud export format: "xyz", or "ply"
							local exportFormat = epcitm.FormatCombo.CurrentText

							-- List how many PointCloud3D positions were found in the table
							print('[PointCloud3D Positions] ' .. tostring(positionsElements))
							-- dump(positionsTable)

							-- The system temporary directory path (Example: $TEMP/KartaVR/)
							-- outputDirectory = comp:MapPath('Temp:\\KartaVR\\')

							-- Use the Export Directory from the UI Manager GUI
							outputDirectory = pointcloudFolder
							os.execute('mkdir "' .. outputDirectory ..'"')

							pointcloudFile = ''
							if exportFormat == 'xyz' or exportFormat == 'ply' then
								-- Save a copy of the point cloud in .xyz or .ply ASCII format to the $TEMP/KartaVR/ folder
								pointcloudFile = outputDirectory .. nodeName .. '.' .. exportFormat
								print('[PointCloud3D Format] "' .. tostring(exportFormat) .. '"')
							else
								-- Fallback option
								exportFormat = 'xyz'
								-- Save a copy of the point cloud in .xyz format to the $TEMP/KartaVR/ folder
								pointcloudFile = outputDirectory .. nodeName .. '.' .. exportFormat
								print('[PointCloud3D Format] Fallback Option "' .. tostring(exportFormat) .. '"')
							end

							-- Open up the file pointer for the output textfile
							outFile, err = io.open(pointcloudFile,'w')
							if err then
								print('[Point Cloud] [Error opening file for writing] ' .. tostring(pointcloudFile))
								disp:ExitLoop()
							end

							-- Handle array of by 1
							vertexCount = 0
							if positionsTable[0] then
								vertexCount = tonumber(positionsElements + 1)
							end

							-- Write a ply ASCII header entry
							if exportFormat == 'ply' then
								outFile:write([=[ply
format ascii 1.0
comment Created by KartaVR ]=] ..  _VERSION .. '\n' .. [=[
comment Created ]=] .. tostring(os.date('%Y-%m-%d %I:%M:%S %p')) .. '\n' .. [=[
obj_info Generated by KartaVR!
element vertex ]=] .. tostring(vertexCount) .. '\n' .. [=[
property float x
property float y
property float z
end_header
]=])
							end

							-- Scan through the positions table
							for i = 0, positionsElements do
								-- Check if there are 5+ elements are in the positions table element. We only need 4 of those elements at this time.
								local tableElements = table.getn(positionsTable[i] or {})
								if tableElements >= 4 then
									local x, y, z, name = positionsTable[i][1], positionsTable[i][2], positionsTable[i][3], positionsTable[i][4]

									-- Display the data for one point cloud sample
									print('[' .. tostring(i) .. '] [' .. tostring(name) .. '] [XYZ] ' .. tostring(x) .. ' ' .. tostring(y) .. ' ' .. tostring(z))

									-- Write the point cloud data
									if exportFormat == 'ply' then
										-- ply - Add a trailing space before the newline character
										outFile:write(tostring(x) .. ' ' .. tostring(y) .. ' ' .. tostring(z) .. ' ' .. '\n')
									else
										-- xyz
										outFile:write(tostring(x) .. ' ' .. tostring(y) .. ' ' .. tostring(z) .. '\n')
									end
								else
									print('[PointCloud3D Positions] Not enough table elements. Only ' .. tostring(tableElements) .. ' were found. 5 are expected.')
									disp:ExitLoop()
								end
							end

							-- File writing complete
							outFile:write('\n')

							-- Close the file pointer on our point cloud textfile
							outFile:close()
							print('[Export Point Cloud] [File] ' .. tostring(pointcloudFile))

							-- Show the output folder using a desktop file browser
							openDirectory(outputDirectory)
						else
							print('[PointCloud3D Positions] No points found on ' .. tostring(nodeName) .. ' node.')
							disp:ExitLoop()
						end
					else
						print('[Export Point Cloud] Error. No PointCloud3D node was selected. Please select a PointCloud3D node in the flow view and run the script again.')
						disp:ExitLoop()
					end
				else
					print('[Export Point Cloud] Error. No PointCloud3D node was selected. Please select a PointCloud3D node in the flow view and run the script again.')
					disp:ExitLoop()
				end

				disp:ExitLoop()
			end
		end
	end

	-- The Select Folder Button was clicked
	function epcwin.On.SelectFolderButton.Clicked(ev)
		selectedPath = fusion:RequestDir(exportDirectory)
		if selectedPath ~= nil then
			print('[Select Folder] "' .. tostring(selectedPath) .. '"')
			epcitm.ExportDirectoryText.Text = tostring(selectedPath)
		else
			print('[Select Folder] Cancelled Dialog')
		end
	end

	-- The Cancel Button was clicked
	function epcwin.On.CancelButton.Clicked(ev)
		epcwin:Hide()
		print('[Export Point Cloud] Cancelled')
		disp:ExitLoop()
	end

	-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the window instead of closing the foreground composite.
	app:AddConfig('ExportPointCloud', {
		Target {
			ID = 'ExportPointCloud',
		},

		Hotkeys {
			Target = 'ExportPointCloud',
			Defaults = true,

			CONTROL_W = 'Execute{ cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]] }',
			CONTROL_F4 = 'Execute{ cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]] }',
		},
	})

	-- Point Cloud Export format list:
	FormatTable = {
		{text = 'ply'},
		{text = 'xyz'},
	}

	-- Add the Format entries to the ComboControl menu
	for i = 1, table.getn(FormatTable) do
		if FormatTable[i].text ~= nil then
			epcitm.FormatCombo:AddItem(FormatTable[i].text)
		end
	end

	-- We want to be notified whenever the 'Comp_Activate_Tool' action has been executed
	local notify = ui:AddNotify('Comp_Activate_Tool', comp)

	-- The Fusion "Comp_Activate_Tool" command was used
	function disp.On.Comp_Activate_Tool(ev)
		-- Verify a PointCloud3D node was selected
		if ev and ev.Args and ev.Args.tool and ev.Args.tool:GetAttrs('TOOLS_RegID') == 'PointCloud3D' then
			-- Update the selected node
			selectedNode = ev.Args.tool:GetAttrs('TOOLS_Name')

			print('[Selected ' .. tostring(ev.Args.tool:GetAttrs('TOOLS_RegID')) .. ' Node] ' .. tostring(selectedNode or 'None'))
			epcitm.NodeNameText.Text = tostring(selectedNode or '')
		end
	end

	-- epcitm.NodeNameText.Text = 

	epcwin:Show()
	disp:RunLoop()
	epcwin:Hide()

	-- Cleanup after the window was closed
	app:RemoveConfig('ExportPointCloud')
	collectgarbage()

	return epcwin,epcwin:GetItems()
end

------------------------------------------------------------------------
-- Where the magic happens
function Main()
	-- Check if Fusion is running
	if not fusion then
		print('[Error] This script needs to be run from inside of Fusion.')
		return
	end

	-- Check if a composite is open in Fusion Standalone or the Resolve Fusion page
	if not comp then
		print('[Error] A Fusion composite needs to be open.')
		return
	end

	-- Show the UI Manager GUI
	ExportPointCloudWin()
end


-- Run the main function
Main()
print('[Done]')