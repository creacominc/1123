--[[--
----------------------------------------------------------------------------
Send Frame to Photoshop - v4.2 2019-11-05
by Andrew Hazelden
www.andrewhazelden.com
andrew@andrewhazelden.com

KartaVR
https://www.andrewhazelden.com/projects/kartavr/docs/
----------------------------------------------------------------------------
Overview:

The Send Frame to Photoshop script is a module from [KartaVR](https://www.andrewhazelden.com/projects/kartavr/docs/) that will send your currently selected file loader or saver node files to Adobe Photoshop. 

How to use the Script:

Step 1. Start Fusion and open a new comp. Select and activate a node in the flow view. Then run the "Script > KartaVR > Send Media to > Send Frame to Photoshop" menu item to load the media in Photoshop.

If a loader or saver node is selected in the flow, the existing media file will be opened up in the viewer tool. Otherwise if any other node is active in the flow, a snapshot of the current viewer image will be saved to the temporary image directory and sent to the viewer tool.

--]]--

function mediaViewerTool(mediaFileName)
	-- Choose one of the following media viewer tools:
	photoshopLauncher(mediaFileName)
end

-- Print out extra debugging information
local printStatus = false

-- Track if the image was found
local err = false

-- Find out if we are running Fusion v9-16.1 or Resolve v15-16.1
local fu_major_version = tonumber(app:GetVersion()[1])

-- Find out the current operating system platform. The platform local variable should be set to either "Windows", "Mac", or "Linux".
local platform = (FuPLATFORM_WINDOWS and 'Windows') or (FuPLATFORM_MAC and 'Mac') or (FuPLATFORM_LINUX and 'Linux')


-- Set a fusion specific preference value
-- Example: setPreferenceData('KartaVR.SendMedia.Format', 3, true)
function setPreferenceData(pref, value, status)
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


-- Read a fusion specific preference value. If nothing exists set and return a default value
-- Example: getPreferenceData('KartaVR.SendMedia.Format', 3, true)
function getPreferenceData(pref, defaultValue, status)
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


function photoshopLauncher(mediaFileName)
	-- Viewer Variables
	viewerProgram = nil
	command = nil
	
	-- Adobe Photoshop
	local defaultViewerProgram = ''
	if platform == "Windows" then
		-- Running on Windows
		photoshopVersion = getPreferenceData('KartaVR.SendMedia.PhotoshopVersion', 10, printStatus)
		
		if photoshopVersion == 0 then
			-- Adobe Photoshop CS3
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CS3\\Photoshop.exe'
		elseif photoshopVersion == 1 then
			-- Adobe Photoshop CS4
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CS4\\Photoshop.exe'
		elseif photoshopVersion == 2 then
			-- Adobe Photoshop CS5
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CS5\\Photoshop.exe'
		elseif photoshopVersion == 3 then
			-- Adobe Photoshop CS6
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CS6 (64 Bit)\\Photoshop.exe'
		elseif photoshopVersion == 4 then
			-- Adobe Photoshop CC
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC\\Photoshop.exe'
		elseif photoshopVersion == 5 then
			-- Adobe Photoshop CC 2014
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2014\\Photoshop.exe'
		elseif photoshopVersion == 6 then
			-- Adobe Photoshop CC 2015
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2015\\Photoshop.exe'
		elseif photoshopVersion == 7 then
			-- Adobe Photoshop CC 2015.5
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2015.5\\Photoshop.exe'
		elseif photoshopVersion == 8 then
			-- Adobe Photoshop CC 2017
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2017\\Photoshop.exe'
		elseif photoshopVersion == 9 then
			-- Adobe Photoshop CC 2018
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2018\\Photoshop.exe'
		elseif photoshopVersion == 10 then
			-- Adobe Photoshop CC 2019
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop CC 2019\\Photoshop.exe'
		elseif photoshopVersion == 11 then
			-- Adobe Photoshop CC 2020
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop 2020\\Photoshop.exe'
		else
			-- Fallback
			defaultViewerProgram = 'C:\\Program Files\\Adobe\\Adobe Photoshop 2020\\Photoshop.exe'
		end
		
		viewerProgram = '"' .. defaultViewerProgram .. '"'
		command = 'start "" ' .. viewerProgram .. ' "' .. mediaFileName .. '"'
		
		print('[Launch Command] ', command)
		os.execute(command)
	elseif platform == 'Mac' then
		-- Running on Mac
		photoshopVersion = getPreferenceData('KartaVR.SendMedia.PhotoshopVersion', 10, printStatus)
		
		if photoshopVersion == 0 then
			-- Adobe Photoshop CS3
			defaultViewerProgram = '/Applications/Adobe Photoshop CS3/Adobe Photoshop CS3.app'
		elseif photoshopVersion == 1 then
			-- Adobe Photoshop CS4
			defaultViewerProgram = '/Applications/Adobe Photoshop CS4/Adobe Photoshop CS4.app'
		elseif photoshopVersion == 2 then
			-- Adobe Photoshop CS5
			defaultViewerProgram = '/Applications/Adobe Photoshop CS5/Adobe Photoshop CS5.app'
		elseif photoshopVersion == 3 then
			-- Adobe Photoshop CS6
			defaultViewerProgram = '/Applications/Adobe Photoshop CS6/Adobe Photoshop CS6.app'
		elseif photoshopVersion == 4 then
			-- Adobe Photoshop CC
			defaultViewerProgram = '/Applications/Adobe Photoshop CC/Adobe Photoshop CC.app'
		elseif photoshopVersion == 5 then
			-- Adobe Photoshop CC 2014
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2014/Adobe Photoshop CC 2014.app'
		elseif photoshopVersion == 6 then
			-- Adobe Photoshop CC 2015
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2015/Adobe Photoshop CC 2015.app'
		elseif photoshopVersion == 7 then
			-- Adobe Photoshop CC 2015.5
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2015.5/Adobe Photoshop CC 2015.5.app'
		elseif photoshopVersion == 8 then
			-- Adobe Photoshop CC 2017
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app'
		elseif photoshopVersion == 9 then
			-- Adobe Photoshop CC 2018
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2018/Adobe Photoshop CC 2018.app'
		elseif photoshopVersion == 10 then
			-- Adobe Photoshop CC 2019
			defaultViewerProgram = '/Applications/Adobe Photoshop CC 2019/Adobe Photoshop CC 2019.app'
		elseif photoshopVersion == 11 then
			-- Adobe Photoshop 2020
			defaultViewerProgram = '/Applications/Adobe Photoshop 2020/Adobe Photoshop 2020.app'
		else
			-- Fallback
			defaultViewerProgram = '/Applications/Adobe Photoshop 2020/Adobe Photoshop 2020.app'
		end
		
		viewerProgram = defaultViewerProgram
		command = 'open -a "' .. viewerProgram .. '" "' .. mediaFileName .. '"'
					
		print('[Launch Command] ', command)
		os.execute(command)
	elseif platform == 'Linux' then
		-- Running on Linux
		print('Photoshop is not available for Linux yet.')
	else
		print('[Platform] ', platform)
		print('There is an invalid platform defined in the local platform variable at the top of the code.')
	end
end


-- Play a KartaVR "audio" folder based wave audio file using a native Mac/Windows/Linux method:
-- Example: playWaveAudio('trumpet-fanfare.wav')
-- or if you want to see debugging text use:
-- Example: playWaveAudio('trumpet-fanfare.wav', true)
function playDFMWaveAudio(filename, status)
	if status == true or status == 1 then 
		print('[Base Audio File] ' .. filename)
	end
	
	local audioFilePath = ''
	
	if platform == 'Windows' then
		-- Note Windows Powershell is very lame and it really really needs you to escape each space in a filepath with a backtick ` character or it simply won't work!
		audioFolderPath = comp:MapPath('Reactor:/Deploy/Bin/KartaVR/audio/')
		-- audioFolderPath = '$env:ProgramData\\Blackmagic Design\\Fusion\\Reactor\\Deploy\\Bin\\KartaVR\\audio\\'
		audioFilePath = audioFolderPath .. filename
		command = 'powershell -c (New-Object Media.SoundPlayer "' .. string.gsub(audioFilePath, ' ', '` ') .. '").PlaySync();'
		
		if status == true or status == 1 then 
			print('[Audio Launch Command] ', command)
		end
		-- Verify the audio files were installed
		if eyeon.fileexists(audioFilePath) then
			os.execute(command)
		else
			print('[Please install the KartaVR/KartaVR Audio Reactor Package]\n\t[Audio File Missing] ', audioFilePath)
			err = true
		end
	elseif platform == 'Mac' then
		audioFolderPath = comp:MapPath('Reactor:/Deploy/Bin/KartaVR/audio/')
		audioFilePath = audioFolderPath .. filename
		command = 'afplay "' .. audioFilePath ..'" &'
		
		if status == true or status == 1 then 
			print('[Audio Launch Command] ', command)
		end
		-- Verify the audio files were installed
		if eyeon.fileexists(audioFilePath) then
			os.execute(command)
		else
			print('[Please install the KartaVR/KartaVR Audio Reactor Package]\n\t[Audio File Missing] ', audioFilePath)
			err = true
		end
	elseif platform == 'Linux' then
		audioFolderPath = comp:MapPath('Reactor:/Deploy/Bin/KartaVR/audio/')
		audioFilePath = audioFolderPath .. filename
		command = 'xdg-open "' .. audioFilePath ..'" &'
		
		if status == true or status == 1 then 
			print('[Audio Launch Command] ', command)
		end
		
		-- Verify the audio files were installed
		if eyeon.fileexists(audioFilePath) then
			os.execute(command)
		else
			print('[Please install the KartaVR/KartaVR Audio Reactor Package]\n\t[Audio File Missing] ', audioFilePath)
			err = true
		end
	else
		-- Windows Fallback
		audioFolderPath = comp:MapPath('Reactor:/Deploy/Bin/KartaVR/audio/')
		-- audioFolderPath = '$env:ProgramData\\Blackmagic Design\\Fusion\\Reactor\\Deploy\\Bin\\KartaVR\\audio\\'
		audioFilePath = audioFolderPath .. filename
		command = 'powershell -c (New-Object Media.SoundPlayer "' .. string.gsub(audioFilePath, ' ', '` ') ..'").PlaySync();'
		
		if status == true or status == 1 then 
			print('[Audio Launch Command] ', command)
		end
		-- Verify the audio files were installed
		if eyeon.fileexists(audioFilePath) then
			os.execute(command)
		else
			print('[Please install the KartaVR/KartaVR Audio Reactor Package]\n\t[Audio File Missing] ', audioFilePath)
			err = true
		end
	end
	
	if status == true or status == 1 then 
		print('[Playing a KartaVR based sound file using System] ' .. audioFilePath)
	end
end


print ('Send Frame to Photoshop is running on ' .. platform .. ' with Fusion ' .. eyeon._VERSION)

-- Check if Fusion is running
if not fusion then
	print('This is a Blackmagic Fusion lua script, it should be run from within Fusion.')
end


-- This is the file format that will be used when a Fusion node is snapshotted in the viewer window and saved to disk 
imageFormat = getPreferenceData('KartaVR.SendMedia.Format', 3, printStatus)
local viewportSnapshotImageFormat = ''
if imageFormat == 0 then
	viewportSnapshotImageFormat = 'jpg'
elseif imageFormat == 1 then
	viewportSnapshotImageFormat = 'tif'
elseif imageFormat == 2 then
	viewportSnapshotImageFormat = 'tga'
elseif imageFormat == 3 then
	viewportSnapshotImageFormat = 'png'
elseif imageFormat == 4 then
	viewportSnapshotImageFormat = 'bmp'
elseif imageFormat == 5 then
	viewportSnapshotImageFormat = 'exr'
else
	viewportSnapshotImageFormat = 'png'
end


-- Lock the comp flow area
comp:Lock()

local mediaFileName = nil

-- List the selected Node in Fusion 
selectedNode = comp.ActiveTool
if selectedNode then
	print('[Selected Node] ', selectedNode.Name)
	toolAttrs = selectedNode:GetAttrs()

	-- Read data from either a the loader and saver nodes
	if toolAttrs.TOOLS_RegID == 'Loader' then
		-- Was the 'Use Current Frame' checkbox enabled in the preferences?
		useCurrentFrame = getPreferenceData('KartaVR.SendMedia.UseCurrentFrame', 0, printStatus)
		
		if useCurrentFrame == 1 then
			-- Expression for the current frame from the image sequence
			-- It will report a 'nil' when outside of the active frame range
			print('[Send Media - Use Current Frame] Enabled')
			print('Note: If you see an error in the console it means that you have scrubbed the timeline beyond the actual frame range of the media file.')
			mediaFileName = selectedNode.Output[comp.CurrentTime].Metadata.Filename
		else
			-- Get the file name directly from the clip
			print('[Send Media - Use Current Frame] Disabled')
			-- mediaFileName = comp:MapPath(toolAttrs:GetAttrs().TOOLST_Clip_Name[1])
			mediaFileName = comp:MapPath(selectedNode.Clip[fu.TIME_UNDEFINED])
			-- filenameClip = (eyeon.parseFilename(mediaFileName))
		end
		
		-- Get the file name from the clip
		print('[Loader] ', mediaFileName)
	elseif toolAttrs.TOOLS_RegID == 'Saver' then
		mediaFileName = comp:MapPath(toolAttrs.TOOLST_Clip_Name[1])
		print('[Saver] ', mediaFileName)
	else
		-- Write out a temporary viewer snapshot so the script can send any kind of node to the viewer tool
		
		-- Image name with extension.
		imageFilename = 'kvr_photoshop_' .. selectedNode.Name .. '.' .. viewportSnapshotImageFormat
		
		-- Find out the Fusion temporary directory path
		dirName = comp:MapPath('Temp:\\KartaVR\\')
		
		-- Create the temporary directory
		os.execute('mkdir "' .. dirName .. '"')
		
		-- Create the image filepath for the temporary view snapshot
		localFilepath = dirName .. imageFilename
		
		if fu_major_version >= 15 then
			-- Resolve 15 workflow for saving an image
			comp:GetPreviewList().LeftView.View.CurrentViewer:SaveFile(localFilepath)
		elseif fu_major_version >= 8 then
			-- Fusion 8 workflow for saving an image
			comp:GetPreviewList().Left.View.CurrentViewer:SaveFile(localFilepath)
		else
			-- Fusion 7 workflow for saving an image
			-- Save the image in the Viewer A buffer
			comp.CurrentFrame.LeftView.CurrentViewer:SaveFile(localFilepath)
		end
		
		-- Everything worked fine and an image was saved
		print('[Saved Image] ', localFilepath ,' [Selected Node] ', selectedNode.Name)
		
		mediaFileName = localFilepath
	end
	
	-- Launch the viewer tool with this media clip
	if mediaFileName ~= nil then
		if eyeon.fileexists(mediaFileName) then
			mediaViewerTool(mediaFileName)
		else
			print('[Media File Missing] ', mediaFileName)
			err = true
		end
	end
else
	print('[Send Frame to Photoshop] No media node was selected. Please select and activate a loader or saver node in the flow view.')
	err = true
end


-- Play a sound effect
soundEffect = getPreferenceData('KartaVR.SendMedia.SoundEffect', 1, printStatus)
if err == true or err == 1 then
	-- An error happend when trying to open the media file
	if soundEffect >= 1 then
		-- If the sound Effect mode is 1 or greater (not set to "None" ) than play a braam sound when an error happens
		local audioFile = 'cinematic-musical-sting-braam.wav'
		playDFMWaveAudio(audioFile)
	end
else
	if soundEffect == 0 then
		-- None
	elseif soundEffect == 1 then
		-- Braam Sound On Error Only
		-- Taken care of already
	elseif soundEffect == 2 then
		-- Steam Train Whistle Sound
		local audioFile = 'steam-train-whistle.wav'
		playDFMWaveAudio(audioFile)
	elseif soundEffect == 3 then
		-- Trumpet Sound
		local audioFile = 'trumpet-fanfare.wav'
		playDFMWaveAudio(audioFile)
	elseif soundEffect == 4 then
		-- Braam Sound
		local audioFile = 'cinematic-musical-sting-braam.wav'
		playDFMWaveAudio(audioFile)
	end
end

-- Unlock the comp flow area
comp:Unlock()

-- End of the script
print('[Done]')
return
