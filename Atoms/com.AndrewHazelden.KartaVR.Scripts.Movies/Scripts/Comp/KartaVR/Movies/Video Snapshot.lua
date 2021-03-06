_VERSION = 'v4.3 2019-12-10'
--[[--
KartaVR Video Snapshot - v4.3 2019-12-10
by Andrew Hazelden
Email: andrew@andrewhazelden.com
Web: www.andrewhazelden.com


Overview

The "KartaVR Video Snapshot" script allows you to capture imagery from an HDMI/SDI/USB/Thunderbolt video capture device using the MacOS (AV Foundation) and Windows (DirectShow) libraries. The script has a UI Manager GUI and uses FFMPEG from the command line to do the capture task.

The script is compatible with Fusion 9/16 and Resolve 15/16.


Usage

Step 1. Select the "Script > KartaVR > Movies > Video Snapshot" menu item in Fusion to launch the script.

Step 2. On the top row of the Video Snapshot window you can select the "Video Input Device", then you can select the captured "Media Type", "Resolution", "FPS" (Frame Rate), and image buffer "Format". Make sure to adjust the "Capture Duration" value to define if you want single frame or multi-frame recording.

Step 3. Click the "Capture Image" button to frame grab footage from your video input device. Or you could press the "Go" button to capture and automatically load the footage in.

GUI Controls

Video Input Device

On macOS, the "Video Input Device" list includes entries like "Capture screen 0", or possibly even "Capture screen 1" or "Capture screen 2" (if you have a multi-monitor setup). You can use these capture sources to perform a monitor based frame-grab which can then be loaded back into Fusion. This can be used as a simulated input device that will let you frame grab content shown on a 2nd display by another application.


Media Type

The "Media Type" list allows you to choose the image/movie format that will be saved to disk. Options include: "JPEG Image", "PNG Image", "TIFF Image", "TGA Image", "BMP Image", "JPEG2000 Image", "GIF Movie", "MP4 H.264 Movie", "MP4 H.265 Movie", "MOV H.264 Movie", "MOV ProRes 422 Movie", and "MOV ProRes 422 HQ Movie".


Resolution

The "Resolution" control allows you to set the captured image/movie's width and height.
Note: Some video sources are very picky about this setting so you may not get a successful capture if you set the Resolution control to a value outside of the bounds of your video input device's capabilites. In this case you will see an FFmpeg error message in the "Capture Log" window listing the issue.


FPS

The "FPS" control defines the video capture frame rate that is used when a movie is saved, or when an image sequence is captured.
Note: Some video sources are very picky about this setting so you may not get a successful capture if you set the FPS control to a value outside of the bounds of your video input device's capabilites. In this case you will see an FFmpeg error message in the "Capture Log" window listing the issue.


Format

The "Format" control allows you to customize the pixel format used in the video capture frame buffer. This is an advanced control you shouldn't need to adjust.


PathMap

The "PathMap" ComboBox menu allows you to choose a location where your media will be saved. You could choose to save your video framegrabs into the current "Comp:/" PathMap location, or to other places like your operating system's temporary folder using the "Temp:/" PathMap.


Image Prefix

The "Image Prefix:" text field allows you to customzie the starting part of the Screenshot filename. By default this setting is "Snapshot" and will result in the incrementing filename of "Snapshot_Take_1.0001.jpg" being written to disk.
Note: You can add intermediate folder names at the start of the "Image Prefix" field, and each of those folders will be created on-the-fly like "Project_77/Snapshot".


Take

The "Take" number field control allows you to auto-increment the filename captured to disk.


Cam Warmup Delay

The "Cam Warmup Delay" number field expects a value entered in seconds. It is used with self-powered cameras that need a few moments to adjust auto-exposure/auto white balance after they are turned on.

The default "Cam Warmup Delay" value is 0.5 seconds which means after you press the "Capture Image" button, the video source is powered up immediately and an image is recorded after only 0.5 seconds of initialization time.

If you are capturing footage from a self-powered USB webcam, you might need to set the "Cam Warmup Delay" to a value of 1 second or 2 seconds+ so a slight a recording delay happens before the image stream is snapshotted and saved. This delay allows the camera to adjust the auto-exposure so your stop-motion style of capture has a more consistent brightness between takes.


Capture Duration

The "Capture Duration" number field expects a value entered in frames. The is the length of the recording.


Capture Modes

The "Capture Mode" label is a heads up tip that summarizes how the footage will be captured based upon the combination of the "Media Type" and "Capture Duration" settings.

If the "Media Type" is set to an image format, and you set the "Capture Duration" field to a value of "1", the "Capture Mode: Stop-Motion Sequence" text will appear to the right of this field. The script will then capture video frame grabs in a stop-motion-esque way so each time you hit the "Capture Image" button a new frame is added to the end of the sequence. The "Take" control is used to represent the current sequence frame number like this: "Snapshot.0001.tif", "Snapshot.0002.tif", "Snapshot.0003.tif".

If the "Media Type" is set to an image format, and you set the "Capture Duration" field to a value of "2" or higher, the "Capture Mode: Multi-Frame Take" text will appear to the right of this field. The script will then capture a short burst of imagery and name it as an image sequence. The "Take" control is used to separate each of the image sequences uniquely like this: "Snapshot_Take_0001.[0001-0030].tif", "Snapshot_Take_0002.[0001-0030].tif", "Snapshot_Take_0003.[0001-0030].tif".

If the "Media Type" is set to a movie format, the "Capture Mode: Movie Take" text will appear to the right of this field.  The script will then capture a short burst of imagery and save it to an MP4 or MOV formatted video file. The frame length of the video recording is defined by the "Capture Duration" number field's value.


Overwrite Mode

The "Overwrite Mode" button has a "checked" status that allows it to stay pressed/unpressed to toggle the setting.
If the Overwrite mode is unpressed and disabled, each new capture you do will be saved to a unique filename that will auto-increment based upon the "Take" setting.
If the Overwrite mode is pressed down and enabled, each new capture you do will overwrite the example same file on disk.


Image Filename

The "Image Filename" textual label is non-editable and is used to provide a preview of the recorded image's folder location on disk along with the auto-generated filename.


Capture Image

The "Capture Image" button saves a new image or movie framegrab to your chosen PathMap location using the current "Video Input Device" as your video recording source.


Add Loader Node

The "Add Loader Node" button will create a new Fusion Loader node in your composite and set the clip to use the current filename of your captured image sequence. The new Loader node footage will be shown automatically on the left Fusion image viewer window. Also, the Loader clip and Fusion timeline frame range will be set to the number of screenshots saved in the current sequence.


Update Selected Loader

The "Update Selected Loader" button allows you to refresh an existing Loader node in your composite with the revised capture settings based filename and clip frame ranges. This button is used by first selecting the Loader node in the Nodes view, and then pressing the "Update Selected Loader".


Show Output Folder

The "Show Output Folder" button will open up the PathMap based folder where the screenshots are saved to using a new Windows Explorer/macOS Finder based folder browser window.


Edit
The "Edit" button loads the "Video Snapshot.lua" script in the default script editor program that is defined in the Fusion Preferences "Global and Default Settings > Script > Editor Path" section.


Help (?)
If you click the "?" button at the top right of the Video Snapshow window, a new HTML based help documentation window will be displayed.


Capture Log

The "Capture Log" region is updated when the "Capture Image" button is pressed. This read-only text field shows the captured results log from each time FFmpeg is run. If you press the "Capture Image" button, and no image/movie clip is saved to disk, you can troubleshoot the issue by scrolling down in the Capture Log to see diagnostic information that indicates if an invalid combination of the "Video Input Device", "Resolution", "FPS", and "Format" controls are selected.



Reactor Dependencies

On Windows, the Reactor "Bin" Category based "FFmpeg" atom package is required.

On macOS, the Reactor "Bin" Category based "FFmpeg" atom package is required.

On Linux, you need to install "FFmpeg" using your operating system's package manager like yum, apt-get, or pacman.


Notes

If you select an image size or frame rate that is not compatible with your current video input device, the "Capture Log" at the bottom of the view will list the compatible image capture formats.

If you are on macOS and use a "Facetime HD Camera" as the video source you would typically select "1280x720" as the frame size, and "30.000000" frames per second as your capture settings.


Tokens (Work in Progress)

This script supports the use of the following pre-defined token values in the "Filename Prefix" field. If any other value is written inside the ${} token format it will be looked up as if it was an environment variable.
${COMP} - The current Fusion comp name (Composition1)
${WIDTH} - The current video capture width (1080)
${HEIGHT} - The current video capture height (1920)
${FPS} - The current frame rate (24)
${FRAME} - The current unpadded frame number (1001)
${STARTFRAME} - The global start frame (1001)
${ENDFRAME} - The global end frame (1144)
${DURATION} - The global time duration (144)
${DATE} - The date in YYYY-MM-DD format (2019-10-04)
${TIME} - The time in HH.MM.SS format (14.59.05)
${HOME} - The Home folder name (/Users/andrew)
${USER} - The current user account name (andrew)
${HOSTNAME} - The computer's host name (Pine.local)
${SEP} - The file separator slash (/ or \)
${PLATFORM} - The OS Platform (Mac/Windows/Linux)
${FUHOST} - Is Fusion or Resolve the host package (Fusion/Resolve)
${FUVERSION} - The version of Fusion/Resolve that is running (9/15/16)


Filename Examples

Filename Token Example 1:
${COMP}/${DATE}_${TIME}_${COMP}_${WIDTH}x${HEIGHT}px_${FPS}fps

This would result in a rendered EXR image filename like:
Comp:/Capture/2019-10-04_14.59.05_Capture_1920x1080px_30fps.0000.tif


FFMPEG Command Prompt Based Video Capture Reference Docs

You can check the ffmpeg docs for more details on how the MacOS AV Foundation and Windows DirectShow based capture workflow works from the command prompt:

FFmpeg Devices Documentation
https://ffmpeg.org/ffmpeg-devices.html


macOS Capture

You can generate a ffmpeg list of supported AV Foundation video capture sources in a terminal window using:

# Generate an FFMPEG Video Input List:
ffmpeg -f avfoundation -list_devices true -i "" 2>&1 | /usr/local/bin/bbedit

# Result:
[AVFoundation input device @ 0x7fbc99e00320] AVFoundation video devices:
[AVFoundation input device @ 0x7fbc99e00320] [0] Cisco VTCamera3
[AVFoundation input device @ 0x7fbc99e00320] [1] Cisco VTCamera3 #2
[AVFoundation input device @ 0x7fbc99e00320] [2] FaceTime HD Camera
[AVFoundation input device @ 0x7fbc99e00320] [3] Capture screen 0
[AVFoundation input device @ 0x7fbc99e00320] [4] Capture screen 1
[AVFoundation input device @ 0x7fbc99e00320] AVFoundation audio devices:
[AVFoundation input device @ 0x7fbc99e00320] [0] Scarlett 2i2 USB
[AVFoundation input device @ 0x7fbc99e00320] [1] Cisco VTCamera3
[AVFoundation input device @ 0x7fbc99e00320] [2] Built-in Microphone
[AVFoundation input device @ 0x7fbc99e00320] [3] Cisco VTCamera3

You can use a terminal window with ffmpeg + AV Foundation to capture a still frame from a video source in using:

# Still frame FFmpeg capture
/usr/local/bin/ffmpeg -y -f avfoundation -framerate 30.000000 -video_size 1280x720 -pixel_format uyvy422 -vsync 2 -i "default" -f image2 -vcodec mjpeg -vframes 1 -qscale:v 2 $HOME/Desktop/Snapshot.0001.jpg 2>&1


Windows Capture

REM Generate an FFMPEG Video Input List:
"C:\ffmpeg\ffmpeg.exe" -f dshow -list_devices true -i dummy 2>&1 > device_list.txt

REM Generate an FFMPEG Video Resolution List:
"C:\ffmpeg\ffmpeg.exe" -f dshow -i video="Integrated Camera" -list_options true 2>&1 > device_options.txt

REM You can use a command prompt window with ffmpeg + DirectShow to capture a still frame from a video source in using:
"C:\ffmpeg\ffmpeg.exe" -y -f dshow -framerate 30 -video_size 1280x720 -vcodec mjpeg -vsync 2 -i video="Integrated Camera" -f image2 -ss 2 -pix_fmt rgb24 -compression_algo lzw -dpi 72 -vframes 1 -qscale:v 2 CAM1.%04d.tif 2>&1

or

"C:\ffmpeg\ffmpeg.exe" -y -f dshow -framerate 30 -video_size 1280x720 -vcodec mjpeg -vsync 2 -i video="Cisco VTCamera3" -f image2 -ss 2 -pix_fmt rgb24 -compression_algo lzw -dpi 72 -vframes 1 -qscale:v 2 CAM1.%04d.tif 2>&1</pre>



Todo List

- EXR Image - Add Rec709 BT to Linear color profile code from the ffmpeg intool encoding script? -colorspace bt709
- Add "Network" as an available Video Input Device - use cURL to power this (NetLoader.fuse like) HTTP/HTTPS/FTP stream capture featue. When "Network" is selected, display a normally hidden URL text entry field to define the capture URL
- Token naming support in the filename.
- PathMap: (Update the ComboBox menu list with all of the active PathMap locations for the output)
- Add a ui:Timer driven "[x] auto-recurring capture of [x] frames every [x] minutes [x] seconds"?
- Execute bg mode for hiding the command prompt during the FFmpeg capture process on Windows?
- Collapse-able "Capture History" ui:Tree - format, frame, time, video settings?
- For PNG format output - Show an optional preview window via a UI Manager driven HTML preview ui:TextEdit field?
- Naming template like the "Movies to Image Sequence" script has (####/Snapshot.mp4) or (Snapshot_Take_####.mp4):
# Put take image sequences into their own numbered folders (with frame padding too):
local framePadding = 4
local paddedImageNumber = string.format('%0' .. framePadding .. 'd', takeNumber)
local captureFolder = 'Temp:/KartaVR/' .. tostring(paddedImageNumber) .. /'

Add Capture Log based error notification detection:

Sample Error to detect:
AV Foundation
 Selected video size (1280x800) is not supported by the device

--]]--

print('[KartaVR Video Snapshot] ' .. _VERSION)
print('----------------------------------------')

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- Verify Fusion/Resolve's Fusion page is active and a comp scope is valid
if not comp then
	print('[Comp Error] Please run this script from inside the Fusion page.')

	return
end

-- Where should the frame captures be stored
local outputDirectory = comp:MapPath('Temp:/KartaVR/')
-- local outputDirectory = comp:MapPath('Temp:/Fusion/')
-- local outputDirectory = comp:MapPath('Comp:/Captures/')

-- What type of image should be saved to disk 
local outputImageFormat = 'tif'

-- Take number for the auto sequence filename system
local takeNumber = 1

-- Warmup - Camera recording start delay (in seconds)
-- Helps with auto-exposure levelling when a USB webcam is first powered up for recording
local warmupSeconds = 0.5

-- ----------------------------------------------------------------------------
-- Display the extra debugging verbosity detail in the console log
-- printStatus = true
printStatus = false

-- Track if the image was found
local err = false

-- Find out the current operating system platform. The platform local variable should be set to either "Windows", "Mac", or "Linux".
local platform = (FuPLATFORM_WINDOWS and 'Windows') or (FuPLATFORM_MAC and 'Mac') or (FuPLATFORM_LINUX and 'Linux')

if platform == 'Linux' then
	print('[Warning] This script only works with MacOS (AV Foundation) and Windows (DirectShow) capture libraries. Linux support will be added in time.')
	return
end

-- Add the platform specific folder slash character
osSeparator = package.config:sub(1,1)

-- Find out if we are running in Fusion 9/16+ or Resolve 15/16+
local ver = app:GetVersion()
appVersion = ver[1] + ver[2]/10 + ver[3]/100
appName = ver.App or (ver[1] < 15 and 'Fusion' or 'Resolve')

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


-- Find out the current directory from a file path
-- Example: print(Dirname("/Users/Shared/file.txt"))
function Dirname(mediaDirName)
-- LUA Dirname command inspired by Stackoverflow code example:
-- http://stackoverflow.com/questions/9102126/lua-return-directory-path-from-path
	return mediaDirName:match('(.*' .. osSeparator .. ')')
end

-- Open a folder window up using your desktop file browser
function OpenDirectory(mediaDirName)
	command = nil
	dir = Dirname(mediaDirName)

	-- Check if the folder exists and create it if required
	if not bmd.direxists(dir) then
		bmd.createdir(dir)
		print('[Created Folder] ' .. dir .. '\n')
	end

	-- Open the folder
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

function OpenDocument(title, appPath, docPath)
	if platform == 'Windows' then
		-- Running on Windows
		command = 'start "" "' .. appPath .. '" "' .. docPath .. '" &'
	elseif platform == 'Mac' then
		-- Running on Mac
		command = 'open -a "' .. appPath .. '" "' .. docPath .. '" &'
	 elseif platform == "Linux" then
		-- Running on Linux
		command = '"' .. appPath .. '" "' .. docPath .. '" &'
	else
		print('[Error] There is an invalid Fusion platform detected')
		return
	end

	comp:Print('[' .. title .. '] [App] "' .. appPath .. '" [Document] "' .. docPath .. '"\n')
	-- comp:Print('[Launch Command] ' .. tostring(command) .. '\n')
	os.execute(command)
end

-- Video Snapshot Window Image as Base64 content
-- Example: itm.HTMLPreview.HTML = VideoSnapshotWindowImage()
function VideoSnapshotWindowImage()
	return [[<center><img width='640' height='200' src='data:image/png;base64,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HCL9EwEREAEREAEREIELInCGAOjnFhsb5+L5cS9Kat24GphHT083fPRiLCMtFZsz9+M9ZESsHh5AsOiYmFin2RtA3D4e3AqH+6wyL3/f1YETiB0IczPDzXh7XQ64/fO43yt3n6yrrrLMqfmWnhBl23eWwwS91AaO92PxhwsJ6PLVPxEQAREQAREQAREQgYkTOKsAeLYs/b3kqCkM4uDKYO4DSIEvEYLluXchCaIEylMEREAEREAEREAE3t8EToWBibjPofdwte1x7BZCIROLiK0PGkYdIiACIiACIiACIiACEyfg5CrIVpHHmAIghbD3UgiMLKDei4AIiIAIiIAIiIAITIwA5bmkpCQXeznSejumAMhL0PfPN/dO7JI6SwREQAREQAREQARE4L0kQKFvLHlu7EDQKOlYid/LG9C1RUAEREAEREAEREAELg6BswqAFyd75SICIiACIiACIiACIhA2AhIAw1YjKo8IiIAIiIAIiIAIBExAAmDAgJW9CIiACIiACIiACISNgATAsNWIyiMCIiACIiACIiACAROQABgwYGUvAiIgAiIgAiIgAmEjIAEwbDWi8oiACIiACIiACIhAwAQkAAYMWNmLgAiIgAiIgAiIQNgISAAMW42oPCIgAiIgAiIgAiIQMAEJgAEDVvYiIAIiIAIiIAIiEDYCEgDDViMqjwiIgAiIgAiIgAgETEACYMCAlb0IiIAIiIAIiIAIhI2ABMCw1YjKIwIiIAIiIAIiIAIBE5AAGDBgZS8CIiACIiACIiACYSMgATBsNaLyiIAIiIAIiIAIiEDABCQABgxY2YuACIiACIiACIhA2AhIAAxbjag8IiACIiACIiACIhAwAQmAAQNW9iIgAiIgAiIgAiIQNgISAMNWIyqPCIiACIiACIiACARMQAJgwICVvQiIgAiIgAiIgAiEjYAEwLDViMojAiIgAiIgAiIgAgETkAAYMGBlLwIiIAIiIAIiIAJhIyABMGw1ovKIgAiIgAiIgAiIQMAEJAAGDFjZi4AIiIAIiIAIiEDYCEgADFuNqDwiIAIiIAIiIAIiEDABCYABA1b2IiACIiACIiACIhA2AhIAw1YjKo8IiIAIiIAIiIAIBExAAmDAgJW9CIiACIiACIiACISNgATAsNWIyiMCIiACIiACIiACAROQABgwYGUvAiIgAiIgAiIgAmEjIAEw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'/></center>]]
end


-- Image as Base64 content
-- Example: itm.HTMLPreview.HTML = Image()
function VideoInputDeviceImage()
	return [[<center><img width='295' height='239' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAScAAADvCAYAAACwlhIsAAABemlDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx38GmbxkMRYWFjdvqyFGTWajZiahLDQog82dO29qXm53rpCNhbJVlNh4W/AJ2Fgoa6UUKdn4BsRGup5jaAblqXOe33nOef495w8ur26amaoeyOZsKzIU0qai01rNI7VU4cZDQDcKZnBsbBSJ7/wzXm+oUPm6S2n9vf836uKJggEVbuEBw7Rs4WHhtgXbVKz0miwZSnhFcarIm4pjRT7+fDMRCQufCWtGWo8L3wt7jbSVBZfSb4+VvUmVcTYzb3zNo35Sn8hNjktuldVCgQhDhNAYYZAwfnoJyO6nCx/dcsJOLNqqOZw3l6y5VNrWguJEQhvJGd1ezdfTGwDl62+/SrX8HvS/QOV6qRbbgtM1aL4r1dp3oXEVTi5M3dI/S5WyXMkkPB1BQxQ8V1A7U0j2+Yo/qg9B9YPjPHdAzQa8rzvO277jvB9Is3h0nit69KXF4S1MLMPoJWzvQKdoN85+AB2oZy4vOJ0JAAAACXBIWXMAAAsTAAALEwEAmpwYAAAGUGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyI+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOkltYWdlV2lkdGg+NTg5PC90aWZmOkltYWdlV2lkdGg+CiAgICAgICAgIDx0aWZmOkltYWdlTGVuZ3RoPjQ3ODwvdGlmZjpJbWFnZUxlbmd0aD4KICAgICAgICAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPnNSR0IgSUVDNjE5NjYtMi4xPC9waG90b3Nob3A6SUNDUHJvZmlsZT4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjU4OTwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+NDc4PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxOS0xMC0wNFQwODoxODozNy0wMzowMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTktMTAtMDRUMDg6MTg6MzctMDM6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZmZpbml0eSBQaG90byAoQXVnIDE1IDIwMTkpPC9zdEV2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'/></center>]]
end


-- Video Snapshot MediaType Image as Base64 content
-- Example: itm.HTMLPreview.HTML = MediaTypeImage()
function MediaTypeImage()
	return [[<center><img width='269' height='288' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQ0AAAEgCAYAAACuICbgAAABemlDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx3/GaOQlCxYWFjdvqxkxIjbKTEJZaIwy2Ny55kWZcbv3CtlYKFtFiY23BZ+AjYWyVkqRko1vQGyk6zkujZfy1DnP7zznPP+e8wdfUDfNGX8r5PKOFeuPaGOJcS3wQBl+AnTQoRu22Ts8PITEV/4ZL9cUqXwVUlp/7/+N8qmUbUBRqXCPYVqO8IBww7xjKlZ6NZYMJbysOOPxhuKkx0cfb+KxqPCpsGZk9SnhO+GgkbVy4FP6jclvbzLfODczZ3zOo35SkcqPjkiul1WHTYx+ImgM0keUTtrolr2TEGFa5ISTWnBUc3TWXLSmM1lH6xUnUtpg3mgJauHWtm5Qvv72q1Cb3YWuZyheK9SSm3CyCrW3hVrjDlStwPG5qVv6R6lYli+dhsdDqExA9SWUTdjp9rD3o4oIlNy77lMTBNbhbc11X/dc921fmsWjs7zn0acWBzcQX4KhC9jahmbRrpp8B1jtZ0sUdJTnAAAACXBIWXMAAAsTAAALEwEAmpwYAAAGUGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyI+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOkltYWdlV2lkdGg+NTM4PC90aWZmOkltYWdlV2lkdGg+CiAgICAgICAgIDx0aWZmOkltYWdlTGVuZ3RoPjU3NTwvdGlmZjpJbWFnZUxlbmd0aD4KICAgICAgICAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPnNSR0IgSUVDNjE5NjYtMi4xPC9waG90b3Nob3A6SUNDUHJvZmlsZT4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjUzODwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+NTc1PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxOS0xMC0wNFQwNzo0ODoyMC0wMzowMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTktMTAtMDRUMDc6NDg6MjAtMDM6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZmZpbml0eSBQaG90byAoQXVnIDE1IDIwMTkpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnByb2R1Y2VkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTktMTAtMDRUMDc6NDg6MjAtMDM6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpTZXE+CiAgICAgICAgIDwveG1wTU06SGlzdG9yeT4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+ChiuA7IAAEAASURBVHgB7F0HYBVV1v6SV/LSeyW9kJCEjiC9CwgIdnRta+9ldXWrZdffsq5tda2rYu9rp4gFQXonCUkgIb33/vLq/515GXg0AQUVdq6SmTdz594759575txzzv2OR1ZWlhNaOi4UcDo10h4XwmqFHjUFPDw8jvqZQz2gP9QN7fqRU0BjDkdOKy3nL0OBQ43RH8NMNKbxI/vwUJ3wI4vTHtMo8ItQwH0cHykD0ZjGUXaVO5GP8lEtu0aBXzUF1LF9OOahMY0j7EaVoIfLfqT5DleOdl+jwPGiwOGYgjqGD5XP83g17GQqVyXiD72T5DmSfD9UhnZPo8DPQYEjHauHGs+apHGYXjoU4Q5H+EM9d5jqtNsaBY4bBfaXHNzHqNzb/740RPLsf11jGj/QRe5Edc9mt9vR29sLJ/YT1A6wsB5wwb0Y7VyjwM9Igf1Mrn0/5eAgYzDoPWEwGODpud+Y5v39GYfGNA7RbYdiGJLdarVBr9fB2+QBp4OM4RjawA/RHO2yRoFjTwEZumQSnR3NsNv9OKb1BzAItVJ3xqExDZUqR3DcSzgHObIJXgEZcDgcfFKTKI6AfFqWXyEFZOnh7+1AZ3MhGYaMZc9DMg61+RrTUCnhdjyYlKFeEydPhbgeOhj9+sFgCsB+gp9bSdqpRoFfPwXM3W3obi2m1NwL6Fzt3fuB3Nt+9ZrGNPbS5JBnKsPoI6dyEMbhdNrh5eVzgKLokAVpNzQK/MooIGO7p6uZrXJJy/JRVFfbKpPYv8k/A9MQraxLmbJ/5Sfa7wOJSJ2GUFlJctRkjj5iaIdfPQVc49U1fl3jVhSinsoSZd9x7G49kfxuTMMDBqORKxoHLBbrvqt0znoj73EBD4vVenTkYCOsdgd0VLjoqJ016Dxh6bXsW/5BSpS5qDfoodf1yUv75bFaLIrWd7/LP/nnXibgKurA34digPsSWp7W6zxIMifbSamP52oOeTfpIDlK8vT0AP/fJ6nPqRd1kqdPsa0831euel85sgw989ntLHufG9oPjQL7U8A14FSpQu6K9CzjTsaZyijcx796rY9psACK2lu3bFZKzsoeyN+iFJHEwe6wYMvmXJ77IDMrhVfUe0qGH/gjs0UPP5MOFpsdreU7UNFiRfqALDIPaeTBH5XrepqAaku3o77t4JliU9MRbDIcF8ZxsFbtJd7B23PAM3yJWr6rr48ePnoPNLVaYJbJzMfFvBXoo4OXgUondlJnlxXtvXtpSh6LYH8DfI3SsdI3TrR2WNDUZYeNV7z5XLAvyzW6mceYzWFzoJZ5gvisQR47oFHaBY0Ch6eAjHWVQahH96f0ytrBboXDGITf/eFueDva8PmnX8CqMym3YO+F3SsGd/7lQnh212Hx4iWwePpB50ExRey6ZFV2mxU2Gel9yZPSgZfJB00712Lc5ffj7AkpePLOC5B+7h34fVY43n/lRdSaveBt1JGr8R8HuN1u21OGMIyG+g7MOPcGZCTHwE7pxsb7HlQ+6mjq9HTasH3VN9hY2ghfch/5asvkEjOow2FnPpcGWNohEo7dJmXb1eYpZiaD3sAnnLCy7cJdJYmk5WQ9FppUD0asPQUcZjYK0T1Z1rzJMagpaUBeox3TxsUhwOQid3eXGflFzagiUzGQBkMGRiE2zETe4CpYJJSS4nrkVfeCbBFmhydOHdEPyTFCd6C704yi4iYU15uVdsrXwk6G4RPkhwmnBCAvpw4NFieMzKwOAKGxKr2oko36W30v9bo0Q+7teU0+K5IOD4rU5Dq6GKDULc/JNbs8s+chtVTteCJTQB0/7u+gl8nhsJmBkFCMmzYVMV42dFTtwL+WFmNEYgiKN+Zizq0XYe6c2TDX5mLll6+gAZkwepgpmWxRyoqITUZ0mD+sXNbIxOtua0TO9u3Kvck+PggIDIC9DYiMTUBmRhz8DBZYur3g2dWOwuJSJV9kbBIiQ/3JIOyKlFFT24qU1AEYMTQFvWYr/IOD4LD0oKubE8nTjrpty7B7VwuGDYqE2WLjwHWiqrwMPgEhgK0HOm9f1BcVoYulh7PsmLBAtq+XjM4L1p425OaUKPUm98+kyUmvMBZ5H8+gKGTGhnHSiKJz3xmg/Ca93KaTUob7H6GnnVKVkfVPHJOGHHTj27oujB6TCl8y53azHf5+3pg4ugdfL8vD85u68JvBiciMMaG5jUyAE5B8BI6Odiwv6ERGSiiunj0A0cFGtLZ0wWL3QHCGH9Jj/fDcOzvQS8ZNQYbvZkdAeBDGn5qEVjKqinobnGQkwpHNpB+FGQT76SmleKC13YIumxNBviLNcEHK95R36+q2o6OX9OcSUvIqcoy8L2nR0MY+c3hQamR+MgcjpR1fSpA29ldDq42sje2ihOMlbd+XbO7k0c5PAgrs0WlwbMFippejtw+GjBoPvLkMnsnBaEEyRg7OoCXGil4OEE8DJ19rK5rhhxt+dxeiAr2wY8savPfJGgwc1h/VOVuQNnk+Flx2LXobS9DG4WTjJPJLCMf6FV/DWRWKuh4TTB4ORCRmYua88xHoq8POnE345ptNiEyMobelDVmZMXj/rRew6F0HtpiDsPDhP6N79/e46tb7ccqYMUjrPwDzZ3gjp6AUPpyEZosOM8+Yj47maniaQtBVV4mps85AfJgfCreuw9sffYdBw7LQVLqVk24q7jrvEhidPVj77SKsL2pBZEQYbrr9TlgbSvH5stUICiOTYrsPGP8HXDjEKOAkFOlGJqRVnqEEtGNLIZ77pgnZKcG4YN4gnDo0Fq+tyFW+1FW7q/HU24UICqfEwVknjCfA14QzZ2Yi2teJLz7ZjFWFHfDkhI6K8AHnJyyUvChT8T9+6dl/8pzQmuyOyxgPZCX4o6O1B9HZkYjw9UThrkbsqLVi3CkxiPDXYzellR1VPfD15kyndJaRFoT4SF+Yu3qwJa8JvbzmwfJgMmLGxH7w0ztRU98FPTlDW0s3dpR0kk6+mHtKGCUiG3Jy61HR7qBEJYzoEHTRLp/wFHAxDQ5sTwMVnbZelJa1o19qNgdCPDaU7cTYs3+DpKhAlJdVws/oBV1vHRoDZuHJP12LlAg/dJltmDBxPJcR7+Cex17COVfcgcsvnAODtRtm6xCYfP3gYW1Gd1MDMqaMo8iehtJN76AkaC7u+P0V1JJY0OvQY+rUyUiNX4j7n/0aQ7Ii6HXJwcqlQndPF7+iJoXQ6hd+Q3Ebrr7lLEQ7qnDr5VejM8QXyROvxuWXnYGVi99B2KBZyIzyQVevlQpIIyZOnID+SbFK+2ZeeA2uu+Rc+OlEP6DH+DGj8PYLD+OV3YF48qyz4SjdgiWvvQdHRDgnEtvAwb+/xCHXjjaJAC9faDu/2u+srMWIYYkYGEx9Dyc/b3F5Zse2CjPSKTawO2Dk1O8/KAYJYV5Ys2wTXt/YioERBrR02JC/uxUOLruiArnEkrYIw+hrkEg6cq2T98dPHIDYQB26KT2Ii/CIIbFo6rRTijDC7vTEmFMS8O2yHPz7mxb87qKBGD0wHO1tPfAL8MWIrFq8/HYeekOCcPVZAxGgs6K124nRo3xh5cdlzeoC1NuMuPqcgfDxdMDOz8qpg/vhk89ysLmakiH1MRrjONpRcmLkd2nS5GtISVbW0kXbNsFhCsaEadNRW9eBqeNHQWduRGFFLZceBpTsAK6/6Cykhhvx/APX4/RZM7C5pJVLm+mI5vdm1qxpMFL38fifrsRVf3yUYnI7ByzlFK4TRPTW8UvpYQiDvbsSH775Cq6dPRtzTr8WlVy+ZA8cTjm7Fk6dzCTJT394MioYydvkUyqzAybEtORhw7YCBPZLway5E1BS1YWJpw6FztaGZV98BW9fX5bfhP/84/e49Jb7UMS1/8TTZlBmAuafMRfGzipcP30GZvzmPrQiEDNOPwfIWYYNa9Zg7abNsHKieFIykMl7YDroxQOzHeSKnnQI8Dbgd+ekYkj/ELS0dqGOyw07iR8VH4Xn/joad/x2OO68dAiSvD0RE833ICPP392J1BADlzwmTDm1H+aOj8WckRHwZ+/JxBSq7JN4QSwoOvaXrasLby5chyfe3YYenQ8ifYD33lqHBxZuRmOvDhmp4YjWO1BQWIWXX1+Hi+5ejneXlyIkOgIxdJMflB2NcEo677+zEdc8sxElDVwiNjbjlaX1lPQGwNDVigcf/BY3PrWOtPTGhJGxcMhaSERXLZ2UFNizPJE1vI7Kwc7qXJTUjsGAQZzAeA8D0+NRsWURmp0JivKziVfjwsMoCtsx4exbMeEsJ3UWXG74eWHC3NkICTSiYO0aLNpczQVMNVbnzkHC5PQ+a4lr7Sxfw515RRg/bgx+9/RzilgdSJG2metyyjvKZ1OGnHzhHWLFUT5Z6mQ1IyYzDe9/8S1mTxqG4adyKfVeBbL6x6Jq1xp8n1eO6w1O7C7cjo+/24EwlvP12m1ImnMKJp05HyFBPnD09OC2Z59VxHgTlaXe4VGgnhF333Er4BeBrEQOfOof3NMB0ob7zcOce/FlhClnDknHvdlOmLz0aKyswZKV5QiUdQaTjcretvYe6MkgPRxUxnLSC0cXM5jNKYzFBt+QAIwdlQIT9QnUwqC7dgM2NdkoBew3QUkqi3wEqOcpL2vAhioLgm3d6KBuo72qEZtLzej2caKpuReBZMyg7qOZ+oyxg2MxfnQivVx9lPpYbR/jZFsoAVEwYpmiXAZiIkwIZV87uoxYcOFg0pLsnDe8KfWF+FKPQiFNBpfaazzV0klCgT1MQxkdnMw6ewtWbStE5mmZuOtPdyHYy4ElSxcicPYD6gjiR9+TIiqtDlw+eHl788tTjY27m9BmpS8BTbcWSwcQlIlk3x2KqVXW9R59NYnA0NbShLsfehLThyehqqwUFXUt9OVgHn6dLPsQ1n0y7D3Xe1PXsuZz5BZdiJGpmVhwzTkI8fbA4nXL+XQWxXMyG6WcGMT1b6F4buWXl4OYG3LED8Vq7XUNck7QmrICtNSWwRmUgGSu3cUC45opUt+xGfI0ZHCyASWFZVhZ0A5PWmx2lnfD6OVJ0V7a5YnGmnpc/0gOBqd6s14PePEdwjqslP68EMvZurnZjrCmFrywcA36j0jG6cOjlPYx20FEDfUaJzsZiphmjZRyxOLVTYbkwXNfMgEd/zl67AhPDsWV5w2Dt92M0krSi8xbivWmonTtlmqMHRCJ888fiZlmfiC8nfhmTRXsNHcLLS20TEluE+uoq6pHW3MbnCzfpWthIVo66Sjgmsp989FBs6nRJwBvLv4OZ48fhFkzxqG5qhAvfdeEP8yTNaoo2EBdhUWxVvzfDTehyp0k/SfgSqceMQkZQOtL2N7K5UBkKLX7XP7QrV2SmETtgRnISE9GRd4qXHjdn5Xrb3y8lFNl/0mq/qaE4mbNEN1cMlUOK1avw9BL5uKCOZPQ2ViBlUuXAf1H88vsifAQmVTV2LITmHdjEkx6K0oryvnF53DuqMH11/1eqdf1x4Dk9DRkDcqCtaMWhbtr4eNN86syI92y9Z2qupUD77hd2cvjXG/FstpaO/D+lmaMDDdwQurpSyGSlOufPBntR6mHk89Gy4Y4we2m4rJjTALGTUlDQU0OCqq7kV/SjUvS6RynkqavSld1rrLklsLyKKFJPtc/l5QnzFTVNch1GyWY1PQwBFFt9OpTq/HS+2246p4RSI/3d+lgKCLRaI3SItKypAP1tW3YUm5GIBWgFhtr6erENddvAsI4lKhzGRplRBgtL26v39dC7XCyUMDFNGT0UEw1mbzoX+ELbH8fuyouwIxT07B+6UblXb1pSjVSvzCQKobPv/kOmVcvwMJFH6NgZymCouOg76jEFVfegvWbCjB/0li8/p9n0WbzQmZmBgyOZhg5KPVc/nibvKHvakRTUxuGZozAv554HKExSUiNDUVRLdf8UlvfiBPlocJIKCd7mUywcY0uycmvZWBMFpYu/gpnnDYBozJi8P2Sr7CmlmJzP73i0ZqWNhRvvvI8mnoNNMv2R8nmr/Dl2vVIW7UZF8wei0/eex0lNa2IjY9DRf5K3Hb3d3j8uVtgp3Xl9t/eCOegoVwmmA9gY0oDDvPHIF/xvjyKKoZv4eVlUJYlsbQUeVPCsJIxkH8p0pUnJbfYpGg8dLsPlwE6ZSm3Y1sJ3lrVgmWrdmPuxBTcdO0YlFS0cKI6ER4dQtOmizpCKyGX0oVcasnSh6sX9JJmRtZp5Q/xnxCTqJH0U3/LixnocetNiUF8YhyeBpx+9hAMn+lEWnIEvPSi2mSf8XkfXyN8E6PgFxmmLI2mVtTjnc9LsGZzFc6clIhP3/JDRYMZ0TGB9EupxEufV9J8TmUrpUctnXwU0EVERNwrXetBMTiKZsbigu3YvGM3vIIjYLB3YvmiRSgsr0NSagacXS3IqSjGzk2bUE1bf1h4OAID/OgPQGej3O2orMjD2pxSWkwCEB0dCZOnBevXrEVTSwt2UKqw+SXDl34LOeu/Qk6VGeHUjYSFBaO5chfWbMlDa3M9dm1YD2NouCJZqBNCzIdJ/SJQR2vOmvVVfMaXZj9vVBdtRebISUiO8sXnbz6HBqsf6ul4dvb0CWir2onGHh0iqMPYuX0tnvvPywiOiMOqb5fDovNGOK0jfj4m9Ha2YPvm9djY2IHRg1LRzPdbu3kVjIERrjb09bnoYVyShwclAS4b9F50pkokM/RXHKz2DA3O3oLKbuhIlylDI1FNqWV7VS8SuMSoKG9GLX0aFKervgdEXxjoI2XTVMrJbeNEE31RLRlaU6cDdVwulFS3wcfHSBMsmTqZQk9XNxWX1cjjl9+pKBwVtkGG46lYhYpKWtBDkTCSZtUGllPVZFH8KoJodm2k/0tVYy91y54IomTT2dKJ7zfVccniREiwD71XQf+bMtS0dqO4rANTpqUjVG/Drt3NaO+gLoTlZtIc7mtrx1NfVcHI5UkQaexDXxdLdw/yCxtQ377vO+6hjXbyq6RAb08HetpKOQbF30mn2BxkvKtJPd9zdAVLYgaHFXn5hYhK6o/IAOopmmtQxC9KSkYW/GiXbyjLQ3WrHQOyBipu0O0N5SitblHLpaQSgKysJOicFmzPzd97ve8sI2sQbG0VKOIkGJA9CPauJuws2WdxQytJELIz4smEODLdGu1JMT4ndwc8A/shOyGUuhQH2ipyUeE4FW+99Xd4txXgtxffhKTBA7Gl0wdvPn4f2nd+g+vu+MeedmRkZiuKQfEQrSjIodJ1zy0ERyWhX6gJRXn58AwLQ0JEFPUirnW9+xLFhZ0hzlJdlHwCEJYwCX6B0XuYhtz39vPB+KERiIwJQ3KkF/779nqsq7XRocxKBmOAP7Wi6vJAWiCv2UFrQ1O3OJO52kRhguZUI/xpvZCOMtOsLYpKAxmELGd6yVhM9AALUR2wlILYhVRo1tMkKwpKCjNookOWjnqbQFpiRLJoJqPf85vPtFFnYiM9wsg85FwYjUglJj7soJnWGBaAu68dhaptO3DlXUVAhp5m2Ujcd8VQFK7LxQvLmxBmdKKBbadwBTYToWyTOICp7+J6I+3vr5cCXDbTt6mpfDnnFZ0i6aIgY9IdwWsPs+ibk67liYwoiqdDhw2j1txCRaEV3sHRGB4Ry81lvQpSVVjCQEQle9DxykIzIB14wuK5fk1SvsZSgYOaRnnOTk41ZOhQl7wslUjRHLNSjj4kHsMiknhuhs4vlPXJ19zl585szEslJb1KlVa7UdlOUVvaJl9g8Qpt8AzFbQ++TCepWPoD2PDhu1+gMyJFYVhw+lHsNnKpRdsi06hTR7I+K9vm0gOIu3tc5hAksm0yecUFWnWD7z94MGcerRV8F3GYUhqvlHL4Pwo95SXocBUfH8YvthOrvy+kz4KFk18PHZd+IklIne5JJlcA/SaCuS5TJ5rUrCwpeE+YlkgXsfyS77kvGZhEKtmTeCqSRmyol7IskHrCgrmW5EOqh//+v4MDFFuVUleQvxFBUljfa+sCDGRUZuwsbcWQwel45+UIOpPpER0ZQOe+NmzMbUUo98+Ih2k8dbfSNqHBwd5xTxu1k5OCAn1MQ97FqUxsORPOIpYRM/+pv2Vi9f1UrsleEfm3T5JRw9EjO1CVEaSOciUT7zF/r/KMjC5aWfg163tkbzFyYb8kV4TpSGZPTkovuok31NWixNaCTauX4+NvcpDFL3svta1RBrq3b1iHLipwfYNiYO4xK16S7kWKeXO/liu3bSLh7Gmz24R0f/gQ5/KYeGuaOzvx7OubFAtOD11BxdtVJr4obw+VlInmMvccNMvhnt/zENvgzkj21ykc8NuNgwmTck/Cj6irxSef56BqcBQS6ODBt8OaoioyjEa0k7d7Ubxwr8/9ee385KWAx4kYy1XMeQV5O+jYToU995VEhfiTMbg2mclSJpdLmYDIeA70QF6nCvBAPnTQHnVfiqjn6lEe+OHliUw6tSLXufgzuCajev2g1f5KL6rv4+TyyabswpUrPlyqBlLxQaFGkSpU0fVX+hJasw5JAVf/yvhub/lRy5NDlvyrvCGWgMwh9ADds7QQicU1MR1cygzm8kh2q1qPgmH8uBd1La3Eb0Uktb1JbYtLatt7/UQ6UxmdB4ICvBDS91MkKpGM5G1laaelE5UC7n3nPnYP/z5uy5PDZ/415bBRR3GwJYa0UVke8XikEsaPeS9hFLJV32ox/5jHtWc0CvxqKCDjeK+UfPhmnbBM4/CvdrxyCFd2mUgtXbXooaPYvlLG8apXK1ejwLGngOIJJUOa1sIjZRwa0/hR/UDRzmmFuWUrrSGiwXQX9X5UgdpDGgV+EQrIyLXTKOF0qtKG66P4Q43RmMYPUecH75FH00nMQ6wOGs/4QUppN3+lFJChy7HrSWwbCBDXESaNaRwhoQ6eTbgyCS4HLWkUOAEpIIptJY7PUbRdYxpHQayjy9qH7t4nhShb3GkWFsuDiCaC7i57aCTEo6qxFeWqkftBLH2OaGp9Ou7ONfCfWIjERCZu7ILQtW9ylWm3UUHMOjThZ1/qaL+OHQU0pnHsaOlWEqcs/fi3bsl1uwakEqLQj3tIBKt0C+/pQ2ORFRuiMA7x+beb27A5txxpAzLpBs4yyEQEGKmhsoj7R4hi1Jd8QiKQGB3uxhi4VGJ9UmZkfCoiiW+iMQ6VWtrxWFPghHTuOtZEUMtzd+RSz9Wj5HE5d3GPhdlM124vuqqb9lxTyxApQhiG0xiIyZMnEpDGS+Y+Ogm2vGHN99iQV4XktDScNn0KemoL8cHiNYiLi6IVphkBCUMxaVgKNn77JaoIrWd09iI3vwRzL7iIOK0DiLyuh7m7A0WF+diwaTsc3NUqEoWTgEE27tuZOW0iGoo2Yvm2CmWjnkAIehIFTZzMZAu8OJpJLBnxbxFnOLvqX84yBLndFWNGJBlVIpK3Isp73zPy/qo4qzxLyUdQ3cVfQ6Qf9/LkSS2dGBSQfrXQi1vGuk7GFPv1CPaenBgvdyK0UoCEHOYeOIJTMO30WQQTNKOdO8H8/QNw+swZ+PiNF/DMVjMemDkLwZZTlI2Aa+uc8GktQ8SkSzFr5gS056+llELAZK8YPP7iQgzLSIC5ow0dPRYEBoVg1Mih6KL0sbKii1B8RFenhGIJSsP002eieEUL3iLIs39KJGzcuVy7M1dBZI9PSecGNwNBlreih4SMTkghYyHeJ5mJDJLO1kaUlFcrJE4hQrsvN62JK7l4fu7mM4RVgs43CP66Xnh4h6BfZLiy1ydn6xaibbA8kXCI2nWwvUNKodqfk4YC2vLkeHQlObbEPpIlQ87qT3HLk0swf/ZpuPzSCzF12kx8tOoVZeOfKTQG51x0FVZcfQe847m7kJKBSAcS3KSlqgo3PXY/Ts1OwNpln+KNdz4iNoiHAlGQ3C8IpW3d3KwnMV9YkUveUJ61iyhAVJLBI0airrQYE667FTFBBmxdtxJffFOCy6+7GTEh3sjfvA5frcpHYlIU9+d0Iyl7JM48rz90jh5KRF8rMVeiuJV+Z7UZ511zMxK5Ua2mogxmJ3UxPS3M8xUKeqNx+Y23ISrIC3mbV+O/S7Zi4MAkbpg+cNPh8SCzVuYvQwGNaRxHusvSwUZgYLSUUMJ4HqPGTMKQUB8Ec5IJ8nvOlhKkZY3ELbddgr8+/hqy5bPOr769l9/17NMxckgKircIQNAjSGfUu7bSHHxbvAvfsty4lAwEEeJQ4RFu7+ChMJEIzDz7IsQFcjnDTXNGLxMmjBuN86+0IiIkkMYeHaZNmYjkuJfwyAsf4oKb78Fv501huJh26L39MG3iOLz2zD/w5rc9eOK5hzAoPhT1ja1EN5/KTWuEKty8Al+uKMW/H/8rMqIDFXjAKVMmIzP5dTz+/BKkZvVTlkNuzdJOTyIKcJRq6bhQQD74og/Qy/bzRFx+8x8xnFJDS3MDcluI5EWci50r/ottZS2YOOtsTIshch4nuCwV7JZWDB+QAT8GhSou2EycEcYcYfCls66+AbfcfBNuuvF6DEoMZogGAU0R1qQmKkT5PDUo0BMawMPcjpceuAN/e/o19JrCERdswBtP3o1b738OLTYfwg2MVh6sKy3E2wufw+lz5uL2x16DLigaw4akIXoqmVxKP6xd9DoWLDgPq/JKqD/pwH/uuh8X33I1BkR7Y+FjdxEWcjrBmToxceZsZMcyXAVBUSXynpZOTgpoksZx6FeZuF46V1iIQePOwheL5hF5y5sIZQX44L3XEBKZwq+9B2H/7Pjryx/gw/uux6V/vJvxR9oVSUN8PwQI2EmlgsQYYbAZAvmGYCr1IOFEGxMc0dVLzfji648ZPyVhvz04wq0IGchYJLsLc/DxagIiJXqhlQGQWsvy8cbi9bxfj9r6NgRR6SWpqKAI2WfOwlNPPw2nB5kcTcE2voOPoDixpRZzt5JPoAYNjM3b4+/LHcSR1PdaMey0izFs2kUI4s5Xn6BApCQPQcnuLoIREZpRYZzKo9qfk4gCGtM4Dp0pWmgJYSirjZLctVi+tZSAIO1Y/e1KdBFkKDIrTQEf0psC0fbN61g6bTTmj5+Iea2MucIQk3qvIFQTYtFBq0VEXCLQ8xlMjg4sfPox4nQOxg1XzFVQxukALMLMQZIIkJyx1I1IkrCYAu7cSWQmJQX501LCPMpSxg933/cXpDKyWkVZGVq4DV7WPHqDD4q/+BA7L5qMqedfh4yJCxiFLhR5a79EXpsrdKOEgvSiv4kX47HYOhqxraYYnUSkl4DX+y+bXBVrf08GCmhM4zj1ouLDxUnZVLcLry18HclJifCJiIa3uZUBncV0yahkovSkz8XjL7yCAal/xbgJp6Cnp5PBovxR9v0GlNVdgMGjpuKCWavw9uKVrpbGBuDa35Ih9H3F90xOucQy1d+CiKaaiy2sz2Uu7XuIQVEENlCAlWKzZyE1LhTrPvk37nrkHeCU87DkoTTWJXlr+RwYmqAUK5ZvQEtTBd7+cJHSjl4+K4re2665VrHOuBpHX5SMTAUeUsrX0slJAY1pHJd+FeAfortTAent48caQhEWGoIe6iBkonpQ7Bd0dUEth4c/+tty8OYHS3DnDRcj0I8hA5QgMfn48KPPcc2l5+CGP/wD0+cXoqWzFwGh0QTBYfBsRWcgOhB5ATHVCJq8lClLDkIE8tzSh95uZkgHdzR3WoEVZHlv5qnMrURnrxODxs7Hw+EjkUYs1TDGxnXpSoIpRfgiPNAbY8YzIBaXWNMYme6DFx/CZ9+swICrzsd/P/sQeQW7iUgfz2hrVXj8r79Dd9RQ6B0HhlmQlmrpxKeAgkZ+4r/Gz/MG6pdbnJ8k8JL8U6+pLZA5LB9ZD50JCYQgLCW6+9qyRoRzja+C18hGt7ioUJTkb8HOujbibvbDquXrGMqBgMbWdkIYroHdLwx1hSuxqaiRvhnBCA0Jpa+HH60XFuzemY81a9YzOBUtI2QSUq6rvnCUMbLcmtwW4nomEL29EOvW7EIEUeaTY6NQX74TmzeVQs8YvOnJsehorMTXK96HPiCSS48IRIQGMOzmFsZ9qUZFUQ4GTV+AUelRDBRdRODhLrR3W5CaOQjx0VF4/OEHYfb0BdHsEUKLjJ5xb0sLGS4zZycMjJ0jcWq0dGJQQMawIvWyueLUJTo5l0Ld1X71fM/xRIT7O15d4c4A1HP1KHUemUeo5HS5defuKEBobAr6BXu7uXWTrXBbfd6OQsQkMzyAj0Hx1JR4t5UMA9HEFUsq3chNtIp4UunY29nMSVwhhe6TxFkrkHFhxS+DtSlLBVd9qYgL8cLW7XnwCo1DOn06BMUsh0jrppBYpMUGs34HinPy0O0VisEDYlFPBWlNy154dj6O5l5fvPTu+4i0lWPOb67dU/drH38JU2MezrvyNqSkxqO4qHzPPeiDkDUgXlGkCg20dGJQ4Gg9QjU3crd+dWcQ6rl6lGxHzjQktwQrYqxTLkesdNfedwodfHOZnijq4uJt4d4UVSUge1IkVKRatysuBa0qdKBybX6TuiSp9RFNnlYOI93c1Q1x8oWQQNrqb1nTCGK7+HRYWI6ci+VWZAN+Z5R4srnr83H93+7HGZOGoq6ilEsjC6L6xSHQ5MQX776If36wEcOSw5Q2SNvkCyXShZXvqzEM6Y8TJ2lM4yf0lTuDUM/VoxSrTtwf3nvyExrwA4+qoqF7e34g+9HfEpGUT7nKF9R3Oxo6nZg9ew4GZyQpwZbamuqwftVyrNq8m4GuAvfQQ9p23Np19G+iPXGUFNCYxlESzD27+8BXz9Wj5PslmYZ7O3+ec2EcTtSUF6KREdPUFJuYgpAAXyp0927pV+9pxxOTAkfLNDTryYnZzz9Dq13xX/slZSNO9ToVhRmh4RSlGaULLf1vUkBjGv+b/X5kb00mIVvetaRRwJ0C4jqoJY0CGgU0ChwxBTSmccSk0jJqFNAoIBTQmIY2DjQKaBQ4KgpoTOOoyKVl1iigUUBThB6PMUDLglGcpw5iYHDQO9POeLMCGCy4jBISz8A9Iu5ZnbRQWAjDZ+AO0n1wKaiYdEcqly1hLict+z6o5sfjlbQyNQqoFNCYhkqJY3UURycGntmSuy8S+Z7iuc8jwd+BsqpmZA3MJgJ5K6Pcl+257ToxIDMzjcheLvxN95sp3EXqzY1usotWT1NoGfeKdPtFIT02nN6nslXenf24P6mdaxQ4NhTQ3Mjd6OjuyKWeq0fJdljnLk5YB2H8vAJiMXniSJgoTbj8GhyQ2CV6Ine3VO5CRYcOKdF++Hrxh/COOxXjRmRy45lrpajsN2mvwzcrN2Hk+ElEMycmp1TOXawedjM2rPgW5W0W+Bg80Nhhx1SimnuZG7Hs69XwDw9VXMOdIskom+lcEojqii57TgRIWClPimSZkk/4jF0kIDd0ch33vaju6y4aiPmVTIlJx/cQPA55Rr2m3ND+nJAU0Jy7fsFuk0loJ9iOKaAfxk+YCB+id3noGerAy4Duzk7ouBW9aqsBIY5QTM6KxPfPvYCQiUMwd+5MShwdsBCpS2fwQk/DTqzZWoQZZ8xFqM6Gzh6rAi3vtPWgdts6bG/oQbC3HlWlNoyfcjoCOovw4uvvISs0EO0dDK/gYUFRCTe5eYdiUHo8ejuakFNcTi7hj6zsJDIWid1JmFJLN/JzixU08bikNHp6epOp2Lnk0aOtvgKlNc3kECaijPuhmwBisQy14MWNdQ2Vhahq7IFfWCxSYsNg5/4VlRH9guTXqv6ZKKAtT44hoUUXYeBE7ajNwVP/+hd6CMAz/KybMX9sMl5/9p+osXijeuUSnHX/85Ra7HBQuJAdH3ZrDz5/7XlsrO4kVoaJ4QrqUWdjiABO59w1X+CZ/25EEgF8bYy8Vl/ThnDubrX1bT2XTWIuRHIgODqREkwHGqx+mHfuheioL8d/Fr6NoeNn4ndnLWDA6hos+XQRgzRFQc+dtoaAKFx2zSwE+epQsH0DVq4pRkpaBPILcjBh1vlYMCAJrXXVaCKOh7fRgR3bt2Pj1lyccf6luCg5GtXFuXjjvc8xIHsQPIURHUNaakX9eimgMY1j3jeU9TkhayorUJBfjPTZsuXcgea6QuQ3BaGWiHvq5jNlW6lrmxixMxZh1aa93pdJY+Yqd7raarFj8yrs6GtnBkFy+lYye1tOCUdS2ogJOG/8YC6JGMuELMeX2+7HT5oGXwL3mJjFh9ieY0YNwv13/B6moRfgz7+/DIF6Llmgx+zTZyD7w4V4+Nn3cOs9j2IOJaD2piaY/CdTuvBEQ3URchi24E//eAbTR2ail9ilphmnETE9E/c+/Cz6JSa79qPsbZV2dpJSwDXaTtKX++Vei6DBRLmKYAMULE5OYYNXIII4afdJpD5B+chEdBg66zbcdOttuOsPf8DlF8yDtccsdxCVNAzX3nAT7rzrLtxy3eXw9jAr1hd3fad67uSJX2AgyraswBWX3oTv8yrQn0ymaeda3Pyby/HlukLE9x+K0SMHo6m9Gt8u/gR//8PVmHXpPWgwmzB0yAg2LxoTxg5H/a6NOOvc8/DuV+sVFK/1n7wK71GXYvqp2di45G3MZOCnL9YUYtDoaThzbAZKW3rIzLThtE//nqQ/NEnjOHWsolxi2aI7kOSk+K4qUl1XKHGQ+rK88NAZMWz8ZGTbHAos3+4tJnz03eewEaYvPmMYQhOyqGfgsqWxGBu//5gAwfFkJy6lpFqWHHWejHPS2Ygv/vsGahurkV9Rh1MH9MN3H7+LotZarN++G5MGJxJrwxtlm79D3eBMzP7NbZjNRpp0DrQThwOMCSeYHj1dbUrRjc0d1KfoYetuxbChibznhH90Bh57/FHGSPFheEpf4oKmon3R19ANieKySXlM+3MSU0BjGr9g53IVw684QxXQRLvo1eewvqYLwcT/7GiqQkBcDAzEtMhb8zl1GpuQTJ1Gb3cX2hyRMDIeigJcvH/bReTwcEAfGM471dRDGMiUGBbSwwv+7GkfKmRFGOgkdN8dDz6DuWMyCXxcjZqGNhpnqF1hW4ACbBAl7MgZeO/tbASER6OhPB/vLdqB304hZCG3xJsCAuBHPxRhhAUFeaiklOET4a2AFe/fJO33yUcBjWkcxz4VjwkxV4qiUpU4pDrXNX7VRf3B/+R+a2M5Vq2pRFq/ADgsnfCM7afkM3e3Y8em7+FMTwWNKPBluAD3wpSyVA7SV4+Kz6lgkvIacc9hlsgEojSV0I/eERgyaABqC9fh/KvvUijw6n+XMFaKtBgK+lZXWxO2bliDprY2fPrSa8QlJ7PpphWHksbSF67A22uUrMqfKMZxTYn0p+OZACrvva6dnZwU0JjGcetXDyoYqdMwGBRUcj0nm+goJImnp4lQgJJBororqOVE/Q6MCmGMEl+aSK0MC0AEcaKZS3R6IAh+DCCt7xWIP8r/nJmuyemC9TPZJYqb+E8wBgnLFZBzSRLdTcqQ8CfSFg/6V3iT6Rjo79HW1oWBSVl48P6/IzIxAxkJYdjd6NJJBND06k8w48whw+HBZdG4sWPx7Rfv46X3l2LC8AG47u9fYBStKPAORnSoAW8++wS2VjI4tbfEltVsKArxT+I/GtM4Tp0rJtWQIKCxupxWFH6le3WKWTKU9dWWlaLA6QM7NaXdzdUU8fPR0GZWlhAK9qenAQZLF3bm56OisoE8w78PE7RPYcB5qfhhBelQWlwI354q5S2aqsViY2d0eTuCyWsaq8r4m0GSzE7ERAaio4F6joJCdFLv8cEH/4Vp/lQqSjPRUluOJUt3w6OzGmNnX4YBiZGoLC1Fa3sXy+1CfGo6zllwAVYvuAKP/TsQF515GmISkhRJqKVuN+pbOhktzluRmo4TObVif0UU0DxC3TrD5fnouqCeq0e5qioyjwwjlHKFKCbb6lDEaGnpmVmKBODJUIittaWoqG+nGznNoz3NKCiqgOoe7vpQUzRgIKI8oplHxKUyKjsjmEmYAve28lxMr6V5eWj3Dccgxlztpi6kqKIB6QOylNAGPTTXFpXXI4O/9cxs62lV6pLYJo6uRhSX1TJCGtBLq7BvYBC62lrxp8dfxszB4bh5ylxs7avvHsaCnZjihb/edj7Ke5IYia1EzEL0DnMpYzP63k2TMdw66AQ6VZT23AclY13H8SkuAQIUrSbVRWDPUQthoJJGVAV7h716rh4l19ExDXnCxTgMnLBWhmNUSmcdnoobttuGNXpgWum45VY9nxUEcVE8Wg9gGFKyJCnPwOWPC1WcwaBp5dhTFwvzcP/NvOKxKt6eVtkox3tiJZF3kgEiruGtFVswaN7tuHbB6eilBFRe24xgKkLjokOw/fsluOdPDyFuGJcsVICKy7mUJ2oQQTTX0olLAY1p/IS+c2cQ6rl6lGKPnmn8hMb8LI+6dCPqO+q4n6S5rgmjZ87D2BED4WsyMPhzB3Zs3Ygvly2Hzj+EbmCimxEG5JJ71Gd/luZqlRwXCmhM4yeQ1X0CqOfqUYo9+ZjGgcQSqaOF7ueVjPymJu/gSCT3i3BthlMvaseThgJHyzQ0RehJ0/XH5kVkAIVEJSIsRsImMXGZIyZhQSDfu3g7NnVppZyYFNCYxonZb8e11RLT5EB/0+NapVb4CUSBvSrSE6jRWlM1CmgU+OUooDGNX472Ws0aBU5ICmhM44TsNq3RGgV+OQpoTOOXo71Ws0aBE5ICmiL0uHQb0cj7EMbdLQ7i2yBo5NY+T0oFu5POViriuIK56YbhKc5e4rwlgZhdDlTuPqFqww/vBKbm1I4aBY4FBTSmcSyo6F4GGYOT4MJbthwCjdw3FFnJ/WCgI5W5qxU5OaV7n/YJQ3pCJHeb0ieEDEOAfRvKt6O6LRADs+MUhiOeonsTnbPobr6VdcUkpiHU34t7UvZ1N9+bVzvTKHBsKKDtPXGjo7sjl3quHiXbYZ27FIZhgcEvGuPHDXehkctWdPo+iE+/IJJ31Fdi7bp13Di2G/1HTsa0iaMQyp2ttl4zgYJ3Ycu2XPTYiRLOralNje04dcp0RJnMWLrsG6Kch7ERqjGUzIMMw673J9LWKDSVbceGgloE+xPXgnWKS7knfbwlgLNskRckdPmtmFNlp2xfEmlH2W9ALwwbTa17dqnyXQx8hoc9763gmgo3I+PS90lI+5enlqsdTxwKaM5dv2BfyV4Mq6UVAUGjMHXqdPjoOcGIyuVl5Ma17m54Gr3QVLwVL776Nq7780OYM/kUIofbueu0B0Yff/hOnYzYD17AvS+twciMAFQRtXzu2ech2acDxeuXIt/qRKCERZB9JbJvpKcbvYEpmHPWfBSvMOPDRZvg2z8KDp2rHgKGI7n/AIIVG1C+cxuaup1ISElHkJ+XEspAvD8Fr2NXcSmp5on+AzJhkpgqPPd0WLFVtr8zRUZHw0ZMUL/AYAQE+PGuHaW5W9FGjI54lhfib1L21igcRnlC+3MyU0BbnhzD3lXQyE1h6KjLxfPPP4vepgoMPP1yzD01EW//5ynUEY28i/D/Z111F86dNRFNu7fh5ffex87yJoT1S8SAtARU7KhEamIw6oq2Y/75d6JfkBcZhAETZ56BJf94l5B7KQyTwNnqlhRpSFm1eCONE79qZz4Gn3sVYoIM2LpuJZav247zLr4csaE+yNu0Dqu2s46kCHS2tSCoXxquOW0OdI5ubFizDBWdvgjRdaLMGogrrrsJAUYnyssqYSBKeltTHXZya31xjRMXXnw1d996sbxVWLquDIMyYpVQBhrjcOuYk/RUYxrHumMVed6M4l07sauwAHGTzKzBQQyNzdhcZURDrQ3P3DEWjtYyPHTTtdigS0C8Vxu2bd/K4EmAKToB2f1CsLEDuGXMCPQ2lKKkxwcDR4xBPF5CL3FD3bUae5pPV28BBZ57/m/RL4DBDzwE3McL06ZMwIUtVu5UjeDyRIfTZ01D+tsv4V8LP8P5N/4Fl82bQoQeggITD2MWAy8tfPI+rOgdgqduvxIxAVxOEZsjMNCPkkY31q38HIuX1uOphX9FdkIEFboOlncaBr77Kl54dxWSUiMYZmFfhranfdrJSUMBzeR6XLrSE35+/ohk2aLwFB2AkZgXAUQojx8+CJER/igjeM4G7gkblBiOIWNm4aqrrsQVV1yBWUPT0Vqdi9QJC5AeH864J5/huSXr4Bsez2XIWOTVdfQhnLs3XHarCivpgskvAN6eNnzw3CN4cuGH8GC0t/SYAHz66pN44Kk30K0LwahR45WHW+oqsfTTD/CHa87CQ//5L/wiEjBiWCZmcpmUEuWLT155DOf9+QnUMKKbmVgd9zz0PG77v+sxODEUH738KE6bdSuKmxyYfsY8pAXXKHCE6u5X99Zp5ycXBTSmcZz6U5SGDEq2ByNDCepMTA1BDBfov17iZ0jaXm/DxNPmYsGC83HxJZdg7owpKKq2YuaU0QjwokI0IAWTEvyppzBh2NjJQE2RAtunPLzPnz4FpacDRflb8Opn3+Lzr1YwdGM3KnbtwLNvL8J3ny1FVU2Lgp0hj65fuRqtNgMuuPFvmD48jZg6VJpSGvE2eVGZ2ovdhd/Anv8tus0MrNSHIZgq2KWMzBabPQ4P3ncBt8rb4RcShbS0IWjrNiv4Gvs0S/tx0lFAW578jF3qRd+NotZmivxOhAUJ8B+QHemN7xa9j1W+gVhw8SUwmVxdMiwrRQHgST9lAjLFssFwiXGp2ZiWFYASogT7UiG61waivoSgiRPvQg5MwVGhNN860WXrdl0ICVekFKeylAH+7+H7kRUfirqaarR12RheCTCafPDCktWYPSoLt/7fR7iEytPocB9896kgCUcpTMFG605UVDTzGtnGbuo5atBr18OLjEV8S7R0clNAYxrHsX9lwSBKSpmkctQRPJiaQ5SUVmHasCG4/bK5eJS6hdxNrkbMOe9CYoOakT3jciRGBmD1Zwvx9ooihOq7ET7odFx3wRSMmzITXz31FYYPSyB8n1QgdexFO1fq63unHppexZymhm2EWUIfOLnN3YqYzHOQlRKNTYv+g9sfeBXImodFT95MpStZR341rSu9aC0vwtZdVajcuRnvL1rBUsNglS3y1i5ccullfbW4DqmEFAwwasDC+xDlJP2hMY3j1rH0kWDZOnp0CqK4nvFIJARBdloU3nv/IyTHX42zrrgd2WNmoqq+mSbXQCSGB6CsVI9LCPirYyT4z956GbWGdNj0Xfj22fdxBi0uoybMQOJT76HXkUxNCTkGzbxSvkEwO/nbSLOuF30oJJmpNDUSjdxKCUdJXC8ZFSR0L1QX1IMRCZA2ZDL+cncKBg49BZEBPgz/SPkl2Af+PDdFxSGLDmcjRgzD8BGj8PzfHsE3a9Yh8+L5+OyDN7E1dxdCYhNhMtfj3/ffie6IIdCTIWnChovcJ+tfjWkcp54VnUZQAAifV4miXTp0EY2cccqg8wlHV8laPPhAO36z4GykxUdjAAMyS/7KXbnYmFOIhKFhWLdqE3Kr9EgZ5kslpy/8sQ0rqYMYMyAECcOSUcUw7iZGpNdbu7F7VxEqJcI7aygtLkJ3RQ3PdYhkoKTSol0wV9Xyji8cYTSflhTDv7eOBp0V+HTRN5g8MhsjhmajoiQHlSVeqGow4483nAFnTzvqmtoY5Y1LI0Mwxk6bBUtbBe5+8h+gJRfTxo9AZnYWJBRk6fY8dDq94QqkcJwIqhX7q6GA5hHq1hWKv0Pfb/VcPcrlw3qEupUlX30R9XvbG7GrrAYqYrcsDwTE12ZuR/7OEpjoVh4WaEBltYQjotYgNg7tDB5tDoqmviFciWgmjuGCJt5aX0Kw304MyMomS+iLo9KHWh4Zn4aoQCMKcvLgHZmAOC5vnFxKFOftgIm/YyPIwbiMqSomerkpCplxEajZnYsGWwCCDd1o6XApZpF1Gr74919Rsfp9XPunf7neKGsulvz7DhR++yZuue89pMYCRZWtCA0LodcqmZUhCFkZcSSQeKvKokxLJxIFjtYjVGMabr3rziDUc/Uo2Y6OacgTwjhoLaHZ1UbEbnexXRiKXFcingkj4W8B9hW3bPqA0+uS0dz7NrZJSZIkpqogy1v38YWguzeXI7IRTsIcyAY3mbw2CarK+SvBmsRyI+jhShniGk7mIWUreSXGLBsmLu6yhNrZ5GQApXuRFeOLwoKdsDCkY1JyMoy2Vrz61MP4elcHYgK9Fdd4B8uUkAyskPUJw9DSiUgBjWn8hF5zZxDquXqUYo+eaRy+Me5+De51Hf7JY5NDrV/qFucvC93KvSPSMG/ODMQzdIHYaJpqK7Dy26+wqaAKIcE0/yrhC/ZKFL9Eu4/N22ulCAU0pvETxoH74FfP1aNKXDkeWbCkn9CQX+xR15LK1tuJAi6d3FNsUpqyx0QkCpXRuN/Xzk9cChwt09AUoSduXx+HltMeQxOt3ssfQ4YM2ad8UdS6AiTtlTD2yaD9+J+hgMY0/me6+shfVHQgVv7TkkaBg1FAcyM/GFW0axoFNAockgIa0zgkabQbGgU0ChyMAhrTOBhVtGsaBTQKHJICGtM4JGm0GxoFNAocjAKaIvRgVDkm18TpyoWxqRRHPwiJhyp4oUrinhEjnbIUpeN+jlEe9OBSHLbo6CVOWIrjleJEJU/2ldPnrOUqzPVX4AYNBp0CvefuSOaeRzvXKPBTKaAxjZ9KwYM+T7MkPS2LcnPRKbvW+lJ8chqBf31czMPShS25uxEUHY+4sEA62LisFeIpajd3IjenBKEx8egXHozO5nrsVvaTuAqKiU9GeEgAvUfpZdrHHYRh2C18LrdEwfo0EkNUYxwq5bXjsaSA5kbuRk13Ry71XD1KtiPzCHUxDKfel7tDhxPU10hXcg9YCJdXUrgdX2/eiZSYSPiFxmEkUbLaa3ZjPUMQePn6ixABOx2rfGPSMHJQOlqqdmPlig3IHD0eaQkxCpaFgOOUFxfgs6Xfcz9LpgLoI3tT7JYe+EWmYnhmPHZsWIs6wvSZFEnGAQ+6n9ND3YU2Tp9xkVx0bJOdUsweyYfvJy7hOvFTJycSZPI9TIeb0vR8Rtaykl9AwsQrVPbRCLOSe8Ki9kEzF4Jp6YSggObc9Qt3k4ISTgbhDErCGeedSywMBzrNFniZTNA5z8H0VV/irnsfw4zLzsS5580jBmghyravQL0jEP5E6tpESeEPV9yB+VNPQcHab/H2f7/ARROm4PTRg9DR2kZwcy8YdU7MmLoCj/3zBeijoqDz0ClgxinjL8A550zAexW52J5bj0gDkbSI/dlamYfaVitS0zPhT2Ty6pJdqGvtRlJaBiEIjcpeFmEWXW2N2F1WDd+gKG7dJ1gh97Mo+2C4KW7n1q0Q+I5+sbGwEYHMm0xOsEMdVjNytuYQv0uPjKxMeLFtgh0qjEVLJycFtOXJ8ehXfoF7ndRp8NOcv/FLvLFkO2IiwzBz/vk4ZdwEjEt9jGA28rW2ISAiHhMmn4YHXl+HU/r7IChrMgamp5DBEOyGX3FJngYjd8vWYuGzT6FTH40Zc+dh5KlTMGfSavxrZSmGRQe7NpdSNFDmKh9rd+oxOi2RyOQ7cOqs36Afd9JuXb8SqzZvw5kLLka/EGJnbF6HDYUNSEkIQ31dHVKyRmD6rPnoaq3B1x8vQUByKjx7mrGzxxvnX3ktAg1OlJVXwuhtIgNrJJ7QWvQGZ+Diq66DiSxl1defoNoahphgYnjI/pTjQVutzF+cAhrTOC5d4FR2jsp6o72hBKuXf6nUEjdkPEF+E2HkpJbdp+aOJnRxF+ngUWMQ8MIHqN4NzL3iIoT6OFFT06QEJJIHCRtMBmPB7pwV2FQOLK7W4csHr0R4BJlFXT48Y3hUkmyXZ35KBk5iYJx5EcMY+HvCqTfBm0A9M6ZPQmWzBUlxXOpQd3IGN6V9+vYLePr1JfjzA//ClFN0LU/gAABAAElEQVSz0NtjhokAyNMnjsZjBNbpiJuNZ2++HHHBXpSYHARM5g5XLoXWLv8U+R2+ePLO6xAdxABNXLzMYvkLn38c60qtCPfhzl7ZPqulk44Crk/ZSfdav+wLKVYMYnPaKW2kjyCk32OP48VXXifuZn/krl2FZTsBb6JpORlrZGthMSISMzB36gBUdegx5pRsRc9R0djVh8blehfZJGZtJ95G+kjcf+lp8PEiv6hrgC7Sp49BST63bztBerz9g+BPDvXZwqfx3FufwhDC8AiUKha/8wIee+FdWBijZfSYSUoFNZXF+OKjd3HTZbPx2ff5SKbUMSAcmDJ9Gvr3C8Sit54hEvmzaOhyoLe5Gvc9QpjA669ApJcZz9z3O/z18VfhGZyIM+efi+riHcTYoC5HKVn7c7JRQGMax6FH5fsqhBXLhpdvAMLDw+FHkV4imvkEBiKF90R8NxB6b/PadTATmWvk2PHEApyPlH7ByNm0HjZPI8twfantNupEAmPx94Uf4aUn/o7x2fHYuuZrLP4uhxObMUlY1gGJ4Vb0RCbflb8JL76/CB9+8iXq23tQTnSwfzG0wdIPPkZFlSCTm5RHF3+/Bj26IFx6472I5fLCQswO0Uv4+lKKIBhp7rpFKNu4GO2dZupQpF1JiO8XpkSHGzT5TJx2Sgp6e+2I6ReHocRMJoD5PjzsgPZpF05YCmjLk+PRdaLTcNDiQGkjb81H+P2Dryu1XHbHg7hq/licd+lYrCBAp4Dq1G56B0VVZyN5wFDccV4v9JY2fPrUq7juzXMIuediGmKGtfW0YfO61bCQlZTtzMMXHy5FTHa6oqx06g8CtKfoQ7hcYRskhRKpy0Am0sXwA0oKi+kDAbIiOGUyHr3v94jy16G2phZWvZ/C8bzDMvHld+sxdcjFuP2RD3AZNaFxUf747pN1wIAkeDhsMBAsOTUjnVIRTb5dDSiuraL0E6Xc00QNF6lPtr8a0ziOPSrmWgeBdtVU2dDGJYsnvH0oHbS6TJb+Xlas2rAdGfPGYgYxPCsKVxMNlJIKv+ZqMGZZ7lh7WvHKg4+AKg2ERcUiYUgWLRcuNDBlGSB/WJ/U6dJsqOeu2jvpWCamNflPSd0uk6qN6OenzZ2KOIYpePVvV+I/XxZh9tX34Hfnj6Op2IB8WlN6Lb1cMlVge3E1FhdtxZsfLYNx0BTWo0NL5Q5cdMNfXWX2/c0aOJBhHlk+l2daOvkooDGN49KnhN2jH4Se5tH+Q6bh/geGEN07SPGr6O2oxZplSxE6aaziMepP/M53Pl+OM2dMQEqIE5+vWs4WRdFb1Mh/LhRx8Sz1MnkjMRvw8xwBL08rlw97mZG8AnWftI4y9oiXUakbNkZ14/LHqKCUQwnnaKQy1ErfDSUREtTAOgTJvLW5gRKJEafOuQqRYxwYM3Y0FaeUUMjwDL6+DPrszaVHBJI9/ZCZOQADGK7gLw88gXWbz8X8iZPx6vNPopDxaJPTUtBYuhV/uPdxDBk6xBUU2lWb9vckooDGNI51Z3KueTBSvJFBhHYXlyIqIABpKf6KPqNyJ+O1fv4xvi0CJo5oQGlJGXrsdOravREbN29GNxWPa9auJ2eIQ1VFKXx7qpXWNTKYUQl1Dz0WP9j1Flg9Xd6je5pOzE8DQw50t0uZpWhl4CMQR7iytBTd1fVKtnBHLxHHS2CuaeBvalHJoKrKS+BnbsHS117D+KHJyE4egLC4XhRuXguvoEC0mE244/zT4OztIvCwmcsZmpG9AzBxxlzc216Je//wIPQP3IZhXKqMCI+j1caKohax+tDHgxKPlk5OCmgeoW796u79qZ6rR8l2ZB6hkpNiOT/9JTsK0KdBkItKiopLRkSIPyxdLSgoqkX6gDQlMllTzU5UNXoyLECaAvBbU5aPbmMUFaPhNNtWobSml1/5RJZ8EKUnS5YljK23AwW7SqljyIQPo52V7siDMTIR0WH+yh6X8vwd8OLvKP7mBdSW56PHFIPECD/k5RYgOjYB1u4KNDS76vAdNgvvPfonVKwlMvkf+5DJ+5+OJS/ciZ3L38bN9z6PCH8PNOrDFdNuZXktgsg84qKD6BemOXj1dfmv/nC0HqEa03DrUncGoZ6rR8l25EzDVahekL+Ff/Crq+JqCpyeuFuLclNFH5dvsoo0LlHXZcrqudQQBqFsWOO5eHcfFvGbjEMCTivu3FIG3bvZ6D2u4uI+vs9vlssL3AsjKOaMyiJLHnqX6nnObW/Y0azDYw/ci4wII3aQAVo8TEhOTWUElU689vTDWFrQjtggOnLxOTHg6GQpRGakIp+zcC2dABTQmMZP6CR3BqGeq0cp9miZxk9oyi/y6B7GRiYn+1B6O1oREJuN+XNnIDYyiEzMieb6SqwiMvnqbbsRFkqJggpW9TlyDG1V8ov03E+rVGMaP4F+7gxCPXc/qucnLxq5G/FEOiLjsHS3YWex2Gz2pkgusSKDaQESiUlEKS2d0BQ4GNOQflX7dv+jXr1wQr/1z9z4/wmacdDIUsrLJ4jI5CGksEgRMpBkBcIl1j4Sxs/cAVp1x4UCMq73/ycVqeNdPeplPaolToT9tP3qb/ejei5fWDFn/i8kwflQsT7+F973f/kdFV0YPwjujEPooTIL9aiXjFraSwGVMahX1N9yVM9lHa8ljQInGwVkmSJjXLY7SFKZhHpU31djGiol+ojkzhzklvwWorlf15iGG9G005OGAqqiX44y5tVx78405Fxsblrqo4A7Y3AnyqGuu+fRzjUKnOgUkHEuSWUWB3sfyeOSQw5293/0mjtXdSfBoa6759HONQqc6BRQx7l63P995LomaexHFZXb7nf5R/wUNHI9/RjorEUwGgHdEQ6t8HJya7E+qHWJY5c4eqm/2S8uBy03EBt3RHInHahcSivXl0H2nOjpWCXGTwEbdt8qL/cMyv4TwvBR6S1tUdMP3RPHNFeb6GDG5/o+Quqjynso2KDyLoKmrlle99DmZD6RMaoxjePSw5xBDivyt+chKrk/Akw6BceiRfaEMPkERiAxLpLemwT3pStlc30FKmub92lJHKO0B/kaCflHD006WjZWl6Kyvm1PnuS0dAL5CLPQo7O1DsVltcq9qIRURAb5KpvFDNy81t1aj5xS1x6WlPQs+BGH1EKsQeOh7tH924vMrr48B9UtLoVv1qDB8KQVxc4Bo/IGASpuqCqB1RiE6FBBUz+4e/ueBmsnJw0FPBISEvZ+ek6a1/rxL6J+7dUS3H+r5729vQgKCoKJYMEHThbxb7DB0xSMEcOyUF+cg/y6XiJyDYO/tyCTO4mv2YB1q75Hm90HwQF+BOQd1LcfxFWrIIVXFOdxW3oTt5b1IK+wBLPOvABZaXHcl0L8T+Jz7ti+DY0E1dmVtwPDp8/D6KEDYPSwo2DLanyxMo/7VJJRk5ePpHHTMeGUgfC0dWH18sXYVmVFSlQAKncUInn/e9U2pHKL/LYd+Zh11sUYlBaLruYaLH7vVdjC+sOHzEsEFTYPnT0ODDtlBAyWFmzYtINgxK79LQI/JBKKGmVeRTiX+C7uEpCIuTo6j8lRlcZUmu95hkzKRXOJ9eJiSiId6chsHZTU1Gvqc9rxx1FAxrDFYkFPT88eBaj78sT9XGrQJI0fR+dDPiV7SqxdVfCPG43f/OYCbF1mxaI3SvDPCy9EsN7OnaoOMhsvnHPWfHz81stY+FEVbvz9WRiSEorObsJtcf+Il96Jtct68dmXKzFw7Ew8fef9GJAcw/AGPcTd9ISfvx+aSrbhxktuwHV3P4bZE4fwHhHQdSZMnzoJ/ZPfwMPPvY0ZC67Gdb89D36E7nHovDFu1DC88NSj+GpdCcbPuwjXXX7+PvdefPpRfLK8AFf9/j6cP3sc36MDJqKODxuYjof/+AfY47IVicOgc6Ck2Io//O0c+HcW4Z3/fo4B/llcU3EJ1NuKopJKxFHCCqPE09FSz99ViElIQXgQvUjFL0hMegROrqkoQX2zoKSnwNdkUFDRZbt+D7FTd+6uQHBEFALJaLkdB4FBAUpwqY5mSlXlNYiJT1E2/ml+RoccisfthqYIPcakFfHdyQnB76hi7yYP4WRiNDWKCDs3fY0H/vkvfLT4O/hGpGDO7Hm8uYtYGV6oLy3Es48/gdffeB0vvfIalq/L471kXHXlFRjevx+2rFiMRx56CA//8zG8+d5HWL0xB1XM4enB8ALb1+KRu+/CHX97AvVmI8aPn8A7wBlz5yDQ0YYn/nIp7vnXW9CHJeHss89Gt7kN886YiwC3e4awZJw5bz6fysKc08ahvXw7Lps9B28tXoPkgaNw/sXnUrqp3YPPIeXLzlqJBicpMjqOSx4bwpMG4+qrr0J2fBC2bN6CsKShuPqaazAiPQa7ykrhQZQxh7UbjZ0OjJ92Jq64/AJE+nmilHgcXlxulRA+IDA+G9defz1mjB/NwE9ZGE6JTUIjbGUYhZiMkbjmumswPCOav/NZvxBYSz8nBTRJ4xhTW1nriSazT7RWxGtelGNnez1WfbNY+dcvOQNDwwP7avdAV0czPv1y6T6tmX7RHRiUGoMNX72FO+77NxKTE1G2uxTffeNCNxeErDceuxP1HZzqgwYib+PnKKu6EAOD9IgKHcBNZgHYsf4TfL5BMDRexOYZk3BKfALSM4YhJsIf+Rs+3Xtv5mQMS0jAnAVj4a+z44slH6COi6MXH1mIiWOHKXCEwDuUWGKho7JVSXwneVVJ008/C1lJEXxRD8ZE8YXTcjpDNlQgMSVVYQYGz/kYvvRjMs3nMWjSubj75kuIuq6Hw5ND8Kwz8MX7C/HUq5/hqjv+hvnTRsHG2DF6o7eyFGprKicc4W24+e5/YPaE4ZR2iH3ucSbGjvgUD/z7HSQlximKYVdLtL/HmwKapHFcKSwzShiIfJWVM6W20xdciSwyg64OwoszSaSzyIQMPP7oY3j638/g6aeewJQ4oH9GPKWUTqz+dhmiUjMRQZSv8xZcgAsuuBALzjmTsUYcCE8chBEjR8HZsgMpk87DwIw41FYTfCdqALwJ1tPRQoYRmQZi/aKD4R49GDwpMbE/TB4M4kTdyD73jCbEJ0ZRV2BFU0Mn0qgXoXICHe1mLh/8iCfG5ohqQV5rv2Tw8kF0ZDDy1i3Fo/9+BU1WH4weNQS7Nn+NB//5DCr5qmPGjcMAbmOxOXqQv20DXnvhCdz9yIvoMRIV/dSxLDGQy6txMNfvwj03XI0vNxTAh7DrW5d9DMfgS3HGlFNRQmntxqtvxdrCOoyeOhfzTiFgUTuxVUXRoqWfhQKapHGMyXzQocsgQ1a7BwaNPwcffDgPQSHBsHbW4/Mln7H2ZCpOac3w9qGIz2hpNHV6EmWLoUeUsIoOhwUdvUbYG3MRMvp2XHzhDIrqVARSxH/ryQexrIyhDiwV2GEZgVduvAymnjq88/L/ISH2aiJpsV5zr+gmqU51JQnR6M0JrtxjjBP1nkhIcs9E3QKNqOgRM2uf8pG+gQpWBpvkFi6hr8C+gygoGyt24YmHnoHINZOmzWSENw8897dHUUQjzMjpMxCdxZAK5DwrV3zO+CleGD14BPqxAXYqlh3ETgVi2TYdqhgAZmtVA0w5u3HmxKHoaSjGqNEzGVmOjK7XgHMuOgNOSiIGL38MyMrA618tR/yQSDIjl7Vn35Zpv441BTSmcYwpqixP9i+TY1lMlI1lu2n+bGCA5zas/vprlNe3MKcfxXA9anbl4MLrfk9dB1HDqZ8mT0FERzdxLXwQF2rEF4hDT20h3n+7DklDJ2DS0BRumtOhtb4I1SFDGNrgj0jlV/z1Z57B8p1+yI5q49TnUiGQuH/kGzLhqYGA09qLltZaqlkOfq+5pYOiv5ExaAkJSGbHEGtkJh7o7bZAjLqp8kU/yNykeoOhDpyIJ2RhQ0OksiTp6eiEP1csqIGixBSJq3EHcMs9j2HupKEKXkdDczt8GRqStTBjHrbllWP8qNl47ZUshMQkobOxDMsWFVLK4FKGppu49Awk0edFGG1VVRmazWxMEPUkByU8i9TSMaeAxjSOOUlZIL/wyhxQXKB4LlvK6ZBVvnMNHvjH24oonZA2AJFRodRB0OrB/A7el9TVQkbCr7xEIynIKYTltNGYdOaFeHnRHfhuWQW+4/UZ/qkYNzgZDks7uj0H4Ll7bkd8oAVP3X0d3vueIQSYZ3PhbrSbnYjulwI0v4QmXouPjoatqxbffbcY1/Xejij3e4wJa6PVJ2frLuDM6UgiDGHRoreAzJmIZmyVhpwGRVrRc1mjzk9pt6KzYdnKOY9c2TB1833kHn93y2+RUPgclzqd8f/P3nWAV1Um7TflpvfeOwkEEkggEEKv0kFAQYqAir2uvbu6ll11dddV1g4WLIiKSBGV3qQlpAMhvfd208v/zrm5pBiUEv9//+V8POSe9pUz53xzZuabeccdw4dHojIzFgtX3aece595WcwVBzQOtaqKWd5skUejaVJSPH769iOQz+AqrjoRkx2fv3AdvhG49o7i7tcPYd62aKKK16uUp79Q/e0zCqhMo89IqWtI1rRNCb6r17GVNW5+hiUxkoWVHS9yYzZ5L9TVN9GWIc5ehPKjA5ebTz+8+Pzz0BB1XPKlnIrbgzXr3sWumAga/0Zhw5ef0n8iFfVMSOQXOgjmGiMmJDLHK399ECOYKT4p9igiZ9+DMYtM+cVvwobXX8GRuFTMHz8af3/ucdRZMbuavz0Ofr+VfbYjNp5f7zE9zm3+Hsf3fI7TeYsxasZSPG7gAl9KNQ5Gjdi6fxc0Xv0IfUofFOVWCREoaOctesT0DvR0opyT6ylI6wqaekcQtYZql4kpr60tQEN9I1xdvPHAPXfDh5ncxICaXp6qtOpE/FRz6mYOlLgcPHxww52PwX/Ll/hmy15MGDYQdzz/FcIPHYWBhTOZoAU2rn0biflNigOdPuWD0pD65w+jgMo0+pK0ZBhtLY1ISs2lzk4JgsJDKyc5k5YgPycHRSWUIpgmsbGRDENZAeC30c2Y57Lg1M8N/UJCOJ2ZeoDLi6WZTFhk4Y61r76IiuJVGD8yAhGRUcoXW5yhkuKOI6fWCEP4KT+bng4NvUz7Och0pgrS0gC/YF+8+vIa2FvchcERMZR0WnB011b8++31GDx4EN56622mbLyt27l3PvgKIcEBeOedd3HryqWIGT+FfhX12PrNeny84xRC6SsimKWKKMP7KCrIJfPToZ2XFjHbfFUtWiw5hDprlBTlwUrbgDZqRxotUFZchBxLqitkIlu2bMe1M6liTZmK6rICBYG9pbwY4aPmI8DLGeXllQT/sabxmMw0MAreXOk5suRWrPnQAYvnTMJQ5r4VOtWUZqK6RksPVrNz0k9fPk61rd4poHqE9qCLXtzWH+66r9/u1SO0g2FYOvghakg/+A4YhtFD/LHxX8/htd1n4crJpXH0gj0NgN3iP8g3ykvzkFdYqe9S+XX3CYKTrTmnBlMrJiRRNbBG6AAfai5MjZCVQTXAgKsrISg9mwr6R/2qBNG/wZw+HAn0/AzsPwCaZiKVny2g4XAA0yrycuoRiSndz/XnOQEmbqytoHNVoXJtTVEOChqMFIYhWe71Sydi2igtyEQ9E037uDqgvCgXZU0mCPBwpuTUjoqSAq6gaBDgLvsUMLiKk1XaRK9WT7rNZynpEXyIWn469TTaKJmhvhqPvPoeZkS44k8TZ+NYxx09/o+1mBxigafuvxbxBa6oKq+Cf7A3Hc/KkJtXTjT3gRyzTiPsqKL+XCQFLtYjVGUaPQisZwz6w1339du9MQ0D+hs01ebDIWg6Hrr7OtiYG3KyH8Ybr74JA3t3qhzU6+n63JsILRncDTmzlPbJfGROn7uW+yLat9E1XRIkGVLVkeA1cTWXoDVxbjLkNd2K2BI4wdtFLWLHTVydkBgWUyadbqGPhdgaxDHLuJdzwtCkfZnocp9GdMYSRtLcC1iTuHvLKowE30nQnQGZhd61W+6p6744gRlxnPprxSNUpBbxAJU4mMKEoxjLzG43zp+EkqxTSM8rhaObN4IDvZF+Yjceu+9puA8dxvXaJro8Nyv3LUF6ouLpbSzdaKDuXDAFVKZxwaTq/UI9Y9Cf7bqv3+6Naeiup0GTGr+ruycXHupxdPdhuIb0Y8azy/8Sim1E/tG8qHSlH4t+nL/1KwxC7Bi91Tn/OYNzjKy3er/V34WcOxfPIAZT3hf5D1ddtJh17XWIHhKirL60MO9sWvJJbPluM2oNrGBGZbqtA6dU+vgjxnUhY/9vu0ZlGpf5RHu+iF339dvnZxrSeTvqtbVcldTA1taKEoPkNL3MQV0h1UWtyUxORo1uIencXYfQ8GtC47C6rHqOJH26cbFMQzWE9in5pTEDWDJvq8gEutWRPu/gv7ZBcfAKCB+iqDw6Pktph2qSgh2iMt7/mOeuMo0/4FGIPUItl0IB2kckClYt/9EUEGVXLSoFVAqoFLhgCqhM44JJpV6oUkClgFBAZRrqe6BSQKXARVFAZRoXRS71YpUCKgVUQ+j/wjugRxuXrmTZVsHEZNi5hJML8JWC5s1zggDe3U9LDIPdnZekLXEE0ztpdR2+3imrZ52u1/zetsSTtHOZuJnAGd3H8ns11fNXCgVUpvEHPmnx1jSmz3ZFST6jWQVlgsXQAkFBPsSN0KCOaF1ltS3wdGM8OT0+C3LPoqxKYla4viiBKxorBAX60EdBnMlZlcuPlaX5yC9vQGCALzT0a9CvRIpXaCVdufOr2xDk56EAEOvPKf3+7h+JxG1FfGwsHNz94O5kTR8T9trD2fR3m1Ev+K+ngOpG3uMR6x249Ie77uu3f9u5S2rSx5Fu5W1NtUhmiPrkWQsQGtSJJJ6alIg8piPwHxAOd1sN4uNOoIUxHGGDQmFFt0c6PXKuUgQhGM+phHiU1jHhNJlPfVM7kcvD4GJrgpQTR1HeYkTGwe7IMBroWt0/LAIuxNtMiotHVXOb4rYt7txK/hIGyIkLtxQlVyclnk6Xdnpk0nmqvs0ck6eMYyBqKnYdSIG9PWH7eL0x3TV1uVbUpWSFgP9lf1Tnrv+AB6owjMYqNFgH4rW3n0YYUw+0NzcRrNsAFsTPLEuPw/Ur7sSiux7B+CAr/Pkg8Tg9Z2Lh8uVwNhUGwPBzTna01OPzgnScOl0GfzsNEs4Cdz60ENEDnLFjoyGe+vsmREYGMMCsBIbOkVhxww2s34K1Bc9hE+sEOBANvKocaenZcGKYubuzPQWaZmhraxnvwRB8xp4IIzRkbEl9RS7OWEfg1TlzURJvjo+/2AIPzyhoqyqRmnwWVs5elIgc6LD268RJ/wEkV4fwv0gBVT3pc2IzbZ1hG+LSjfDav2/ByP5u+GXvj/iRcSgNBqboPygMNgZ1qGW/8sU3YtCV2A7q6Q1pyiCVtLjd2HzgDBxtLRRcjNNEDXYyp9Qi6opcz3pGJhYIDR+OfliHNgaUZZzOwbIFd8LN3pagN+UwZJvMiYSM+FgERk/BynGTUFWcja+//wlBzLHiGxhA7NAy1NQ2EhODKRcICegRGA77Bi22fP016gpP85pgFKQnw9Q9DNdeP5pMJR+bv/0BvgMH0UG+Uy3qc/KpDf7HU0BlGn38iMS4WVUQh4nX/gkRIV44tvNL3PPUP+Dl64OCrGz89MMW9thB9g4VQVSAVv6RiNFyTtjvvv7y3KgEwl9UE1EP0MyMagQLLszPh62bLyZfMwYbjxagziYcw8ODiU1RpES/aggfWJh+Gnc9/gKmjRkGI9oqjBk/Pm3yONx/7xrc/9hzxL5Iwf13PAL7AHc4DpqDB26ajV92fg2HQVEwKDTGx19txdwVd2P5wmmwI26oaEtTCOjzz2dfQptXEAwlpubcKNWNK4kCfBXU0pcUEMkhg7g0g0L9CYZTiwM/b4MrkcQ93H0xZ8FCLFx4Da5dOJvJAcTy0WlnFIwLrlfA3i0Yc+Yvwg1UNZYtmk9EceaClchOGSTVFmEIeTmCoWGC4aMmMl9KGibPnURsTmZGO5GIVkOG0dcXInL+bZjHlAVVOUlY88Y/8eMvyQgdMQmP3DcZaTnF8A8djPFj++MUMTbGj46CvbUxThxPgZubK+xsBFE0EEuvnQMNw/1ffe5JfLszDv2HjcE1189j/pMCJU+tDEktVx4FVEmjj5+5YEhIsTClQZOGzComL2oTJPHo+3HDUkESJ3MgGlZL3DdEz+5gG+QIZqzX0kZgnYjxuHVADCUDUzSUnkVG8i4Ut/rCgikXKY8oBtYWqiAJZ/IwKTQMrjw6ipib7doiHEsrQ9QoY2hLUzFm/N0waq7Aulfuww+ngE1btyHg860YNCQKD63Zjqkj70U0Uwp8uacRgwf4oSAtFlv3HsKyh9qIo1GHgKlEE7c2oT2khMxiNIzbatHQroFgmwKfEmzYi5JPB5Yfj6jlyqGAyjT6+Fm3ceIThwrFXDo1NLKEl4MGW418UM9cHt9trIRPeAzGDglgygLx2eCFIkLwt4HShGCDniE26NZDabRpMJmitpxh4s5cIenMMC9VNEzb+M2u45gStQCrbl+JAf7uyEr4Htla2jxk0YVz2ZTqSEtDNaqMbBA9KhyHDxxFNUGLvezMkHp4IzKLbkAgpY0JCzRwsdFg1+b9bHmQTqLhlrW5KY2e7XDyDMIYrxCqTm2oKy0i5kU1uEDMlRgZiVquRAqoTKOPn7pEuLp6mSM18TSap0Zj3NxFeGfbI9izI1tBEp96hzdiwvzoAyG8gv86QCIUmwYVlMqSDHyz4TMmhLZigmhL+BM+T6QX/RQVRG8jY1MkbV6H7FVXYcLsRfTfqMN22k4s3VYS4YtOYyZAVW0DNJZ+8LE3x5cHhCG4wcXNibmX0pU7PhafimvGhGDpHEc0VhVi345N1EhGKVCEwsxKib1pRMNs3E8f4+m3vuukkr0HwpjNraWpkeNSlKbOc+rWFUEBlWn08WNuI/ampVM/HPz2Y+wZHYHpo8Zh42frEJuQrCCJB4QNUKQAsWEY02hqQhuFaDSCoCXQd6bmBBQGUcADfNBAAGKdt2iHTYNnjJnzw9BELCLFOJGYiSWzxyD75F6s/TEfc242UbxKrZ3CsPaHA5g1ajBW3PcKXML2I2DIaPRzNcOOvQeVO967Zy+mxkQiMtSJBtBvsCuDhwcSAlDDhEnmlsjbySRHt8/GhGvugInTQJTUU3Xq54eUvd/izR+TMdDVmtIGjbNqueIooDKNP+CRiwt2+CA//P3Pz6HqjlsxbsRgjIwZozhTCZLX6cR4EIAcDlz2zM9vQDNVCjMiiBfmF6C0rEpZWm06xzA4QDIVMYbChCjlxUxZVFGujPoAofyH9XdFyvEjyn6ztgIF+XnQtlqg8dCXWPupOxbOHI9ps2azjRbs2fo13n7/O0QOjcCJfUdwYmYSjIOdcGTvXrj4+NNE0YjiAqYYKNWBHL/3zgdYft0ChI8YRfR0ur8zreMJopJZSSoCtVyxFFA9Qns8er3Xp/5w13399u97hLI2JQcj2iISKGHA0hVD+hH+nwbQvMJ8VJRVIzh0INrqqlFU1QRvDxcYclLn5+TC2tkdNsw41umtqR8JeQn5RjntCtDYwMHeSpnEp9LS4eEdCDtbS9owapFbWAI3D2/FEFuSewb5ZW0IixiIuuIcnM2rRCglHQPqRopLekkuckoaEEC/DUtaaGVZt7QgD4aWjnBm/hFtZTHSsgoQHEIEc8NmnE5Jg3tACNMicIVGMch0jk3d+v9LgYv1CFWZRo9nrWcM+sNd9/XbF8Q0pAHq/IIk3trahEa6eUtSJGNBEqe1UoECJGOhv1Yngre4a9Mmoe9HP4auv4oLOEUPedCSF0SPYi770p8RG1SQzFlJ+hbU74YOVHETqh6CjEXBRSkKmji3hFno0yoonqi0rQiquOSVFTWqkfYLNq6oRrxQZRg68v3X/L1YpqGqJ3/ko+fXuJnu42IwNBU7BPfln2BeKoWTtSsy4IXABCrMQamsc/jqWl/ab+04wLmuRMIKIzFh38KImntA6fXWX1tHEmUZs6hSYrWQyFopkj+VzajlCqeAyjT+F14AmbC/JT38oUNg35erSvyfjf0PJYza+KVSQPUIvVTKqfVUClyhFFCZxhX64NXbVilwqRRQmcalUk6tp1LgCqWAyjSu0Aev3rZKgUulgMo0LpVyaj2VAlcoBVSmcYU+ePW2VQpcKgXUJddLpdwF1BN0cMnpqkcb76xCRynibojTg4LbSZ8IweHUF8XZis5Vv3aJkHoSct9Kt+5fx31If+300+i6xGpAZy8jtq/HB9X3Ib8S7yL4H+IdKiDCPa+RujIu8dkQBHVx+OpapL7ch0AAdsTdnTutr6sgr/c4qcMtZZst3cd6rvIFbOjbaFbD8y+AWn17iZGdnd0zfdvkf39r4kBlZmamm8Dn9XZqR1lRPqrqW2FlYdaNKBK1Ku7a1Y1tsLQwZ1hIIwoZ81FaVoaKiioY0BPT3NxcCUfvZBzi7QnkZ51lrIopLIim1b3rNvZXiHZjM5hwIss58RZtrKtBKcP0LdmevojfhXh7orURZxKS6HpeSNhAc9hZEWJQHLjI6hRPVuJqJCQlo5DnW43MYW3J++joVBiGAB+fPZMOU2tbaMR1tKMIk2mqr0V2XgED8Cx149GfIyNq4phycgthYmHJfjqZpb7+7/0KQ6qvLEHK6Vw4OTsoTO/36qjnz08BeR/knRanQ3l2+v/6GrLftahu5F2pwe2ejkxd9/Xbv+tGTk/Pdk7s/qGh0LTW4GTSaXpVSpCXTEd6ZraaEAxnIIyaqpGUlASNrRf6BxKtXCaeEv+RjX0798O9/0AQHpRSBaNb+VtR1YyY0dForMhDwqlsMhadp6fUaTM0Q2hoCKqLMpBRUKWkSGisr4e7fzBciZeRnJzMa0yV/sV9vCKLoftOIZg2MRp25ibIz0zFhh+PIJQpE4QB5KcnwjZoJMZFhcOasSaF2Wk4HncKppYWCt8waG1AvbETRg0NQd7peGSX1SsYp+Ju3ky3dWfGw/h7OCGX/eQUVnM8OpT1xrpGuPkGwtfLiX2cYuxLjRL1K5QxIpiyvJ+KGzxfZP3L2+kFS0bIsTdpq+EzKBoh3jY4vHs3ats0xCIhfjuZidTR1+/xaNXd81DgYt3IVZvGeQh5qYeVLzAD09qsXbFoxSrccvNqDA+wRb62GaampqjOSUbwyEm4+ZbbsOK6uTAtT4dL/xisuvEmLF+2FMuWr8ADjz6J1//5ElwMqtBEwGGRatLjkzBq1iLccfstmDJuGM6ePUNEcUmuRETx5jo0WLlj6aqVuGrUQKSdLoIFpZvTaWkYOXU2Vi5fCOuWM2yLsS8Mra8pyMbQ+TfhjddexPJrF2DajNm4494H8bf7r0dNWTnKSwowaen9eIUwf4vmz+H5mZgQMxKl6WdhyPpmDG5LTDmDJatuxC03rkRUsBvOFGvJbJhSgcmWTp05gxGTrsLNt9+BJVfPQN6ZVNYzgUZAhooNMX/pKty++kZMGjkAZ06VsD1TTnqgrDgPGdn5aKaUpCGXbKELfgNBj8996cgQRJ06dTYTg2MmYNE1V8PNogHaZrrKM66muqIE6Zm5aFKYrE79u9TnqNY7PwVUpnF+2lzaGREW+E90bhGjrW2dMHz0WFRknmIMiBGyq80QMyycqoCpEtPBmDOih/NLadCGfVs24oOPPsGxlBwMjBqDqxfMxKkkRrU2FMFz3AIsnDEOpoycbe0qLorkSElDomoFC8PYRCQaM2JzyC/jRvgr26JNcFhKaaiohLmFFRoqC/HlB2/i/oefQ1JeDYYTtTzEPo/h8lOw/JrZMNIW4O1/vIgnn3keX235Ca7BwcQXNkDW8TgsvOVRjBvaH62MZ9FLUUrjMh4WxZ5D6SogJBRTo/1R1djO/rIwatJYhBBpzIiSgTGxRMgemKmhEifPliFy5ATMnjYepg3lSCWOqbWDE1xcHRgwpxOb2yk+t5OJxoyIROIve/Ddt1tRWGcKa00LTsQmITBsOObOnASLthpkFlby3tl+hzqlDEr90ycUkKemlr6mAF9UeWFbGxtQUNQAvwFDMDrAAEVlJQidOA8hvi4oLiQzYEICI5nI/N9GjL6c5CP48ud4fLn+c3y2ZSscXT15kmA7Kf5Y8/gyaDiJk8tMCJIjIDxdiwSvkVXR4NhUX8MTBTiTJpGp5DfE5RDDqH7uiNHSeUAYDm38AJ+/WQx7nyBUUPXYGzcDA2aGo4VwHQuuHweL1go8cd0qHGhz47QuRLOJPQYP9EdLTR5aI2Zh6dWTUXA6FibO/gzGI4NiIqeuRQyk5bSFmFnYY9SEKdj08mZG0NXiybuHw6ixBmVNYmSV14+2DbdZWPPQMgR6MC8Lm2m+diG+fvclVPhOwo3Th2Hz2r9i88lyFJwtxfOvP4z+9jX49lgBIoaHIPHwNmyL1+DZ1/6F6EGBivrVQAlk0ycfYBNTQXi42vRiiO46UnX7YimgShoXS7ELuZ4ztJUMQfKfpJw8CRM7d0yYtgBnzmRi8vhRsIQWSek5iqrAj6JSBJurvUWrbC++5X6C+pqhvpaAPCx3P/MnhPnYUCp4F3Xtksag43OunJVVENo8+F+AevxCx+LZv7yABx54FH959s8I83OnUYRf6o7Pg/QjOqyNMzE+IoYi2MWCrXhgUtRAMoQy7Ca+j68rIQDrmrDqg0+wefN7+PyLT3H3kgkU/0uReKYRz9yzEjYtpXjvw6+Yg4VSjIzDTAyanYxDUMhqS3ORnl+BARHDEdhSAIROQniIL7LOJKCGOoRGdBKWRdctR7i/I/Zu3YgP129EvcYRS275E8qZic7YxhEjRk0gw0hFwMixGBzej6kaqMKY2MLT0x2NBWm44a7lGD8shOkivsXLb3yIWiMHXL14MVybM6mqiJ1D6Ub900cUUJlGHxGyZzOyfCn2g8qMOBRUtmDwsBHKJcP40pdkJKO4tolfWmJfULOQJVQDI1PMv/tFfLHha9xy3QzaHc7iu89fxZBZN2HG6FAc3f45Pt2+lysRhjQ0NihtifFQ5oP8GnNFRnBGHVy9MWhgKKH5gjEwLAxuDrYd7VsotgGDDoYjX3Qjpkf45Vg8Hnv5aQz0ssHuLV+zNcIG85ydswtQU4Sfft6NZjNHzFu8HK6Z2Vj54CM6BrbmUew5qFVWLuqrS2mQyKIKJHYEZWhKOgYTo1Ycp9pg6xaAcZMtMGvcaDhZtOMoEcfE9tHWTGnIIBr9AtyQfHQn/vL6O/hi3Tt47+udZLQ+CLPOUlQ1v/7hTAwFjBkbDVvjJuz7/mW0k3YtTQ2oaHXA4JAgtGlLUVoPBHnYoqikDDakwwAmpqrQNnCMKtfQPZW++asyjb6hYy+tcPaIkbK+AEeTMuDk3Q/LVtzF3K2miN27hUuYRP9VVApW5UvdTrCcorxcZKSfwY7NX+KFZx7CD2dCcc8NC2GFelS02eHBR5+GraUpHJkb5d5bV8K4VUtGIVYG2guIgi6Gxri9X2D+1fNw//334Oqr52Nn3GkaIU25OlrH/tqIqSH2AeKRUvI4fvwkHnrxTcwcNQi//Pg11qwngLCNM20vJihKT8JNd92Pf7z+Cl5Zt4VLuVaYdNfdmH/VSDRUFME2ZB6e/ss1TMlgyCxuM7BqySJoy8vJ/ETikFtrJ9M0wXefbGFeWSNEjr8Do4cMQF1JNtbuyqIdhAxTdCY3c8pkzaillAPTYIwc1h/l+UVUq5phZ2+BHYfjCFTmiqnXTMCQAUHQsv4HO1uJNMbVGGGWVk5EPWOHxtYYPXYCps+8Cn6OFijKL6StyIw+Kh1cTBmV+qcvKKDaNPqCij3b0H3+KUW0w5R+GG/vPoTpUcuxeNEMZbl004ZfsDD6Rk4aihliwxSmQXSvXR89js+P8XPJEhwUgPBIPyaR1qKs2hBDR45RvuLmhAI0tPLGyBEROHJgK9UgT9oc2Ab/yxw0JFI55Q04U/1IS8tUJqdMYPnYNhD7x9nKBHVE4kqMS8X9f/4HpkUPwJ5v3qW0sRaWTOuIimRoGxpgwuTPwWzpNP9LOgOZ4KaWttAS19Sc2exHjx/PM0wlycnv23+wkh926/ovYO3uweM6piGSR1HpMSTQnyIqahITORki/qftZBGWCqNT5CQuDze1GcPeifUaT+PQMWD+HYu5omKMZi6l7vtkJwoWTsComUtg5WaFU0f2KO3TE0W54abyDC5v0x+lugDz569Uzun/BIcOgj0Tagu+qVr6jgIq0+g7Wna2JLOXs1SWDU3MrFHx0zqkL5uDMYN9cGDbT0jjlYJCLufBiSyTS77K9l5R8KguhyeTFDU0EYm8NB1P33s7v8CmMGvXIi27CR98/ilto0dxw93PIWJoJEwII9iq74/ig8D90ZR4bixGsgxKNan0FDD7qWWYFR2KDa8+hLGz/krQ4dEooT+G1sQDL770grLsmbD/WyZN+gURq+fjybdfxe6jZzFl7lQYNFVg59fP4c/veMDHxhQ12RmoCZ+GDX97ACe+eA3PvP8jIocM5mpKk9K3eJIK4pc/9/YdjkXM4EUwqWEahx/WwsZ3Ds/xngXNDCfox5KOKUPH4W9PP4jTJRzn3HHQlmXgQCwHjXyc4Pl5E0egsTwLB+iXoRRKS7Iy5GLdjIOx8Ri8aCo+fe8NHPglAS7EMbVFNT566y9osBsEIxqZVbahI1tf/FWZRl9QsWsb8nYaGsOwpYnI4cWopDOTlCOxJ+Fh3YKjBw8q+zUU5YuLm9BqzYUHAgyXFBehlvq3+CZwwUORUkTUt3OS1ERcmDRiaoOCdoIS035QTVVDCg0iwi+kPyNKKtJfRaWklibIMF20pdQyQVJJSTOkhoZGS1OqHoaGVrBn6sWywjw0GVkjOnqkIkmYUM5vKDqFj159Ff29HDB1VAQWeofSKFqKjV9/goRqHwzysVfcyc2D/OFMJ9PS4hLU0k+CcOYcjm7pV/qtkX7pJGZtCWzffwCzJ0XBsDgJu+IAn5gWZazlFTJWDda99wEsjVdh4IgJGERmq2Xul88+eQ9pDTYYGNiMPft+wdAB3qg4cxJHT6TC0w7QVldxBaoYGucgfP7GO3AjI5sQHY6Zc/0Uj9rcxF9QV0u7kgOZKIellr6jgOoR2oOWeq9P/eGu+/rt3/UIlcpUPSrIGMxt7al/a5SXvKisEi7unkwBYMwXugbV9S1wdrLnqkk9SitqYO/gSLuEWCg6i96xSeENnJs1VRW0YFrAmn4eejBg5Wr2V15K1cHGXnExl3M6N/JaVNW1wtmReUq48mJraYzKai0ZQTXdyxupenAsdXVkGkqqWCKZe8CBbafEJ8CZ3qTeLrZIP3kUNZZeCPJ0UNyN9WNS7pHOYOZ2DvRc7bBRcDByvkFbgzpmaLO3pcpDpPXivDzyMnu42NtwErdwrOUws7aDFW00rVTBklPPwp8Z7V2ofsUePQZrrwB4OlgqqoXYYwpLCmFk7gxXoqSzebTwWEVVPdUaRybIblNQ3928A7jEasfVlUJkEmW9n5+n4orfSU11qzcKXKxHqMo0elBRzxj0h7vu67cviGmwAWVyURRQJryiNvAg98U+oJ94ujap3XMi6NvX993bb/d63a9QVkakvy5cp9v1NLY2NrdR2zFRbCBy7td9Sn2qVlR1mmn7EMcqM8atyOqoEhwmA+1SlPalzy7HZLNbv6yjoKjzOkUakfOyiqOMlbQQ9Yy2kSbaUprpM29mbkFrCd3tKS1Jd+Ikp+9VX19OyDldhjoZr4bjZX3Wkbga3cqUKmL0eCy97l4s01DVk17J2DcHu05IeTDKS94xu7qe46t/wR12r9e9mthVexa5Xj/hRI0xN9P5aZyvR17OokMul8lsTklEVnaUYFK5gR7lfOPpdlyYBZegu5bOsZJxkTbN/G9oTMc1WnXb6VdCU49CL6mjpHXoSjzlIAd67iZkvER953hNZVVF+hNVSS1/CAVUpvGHkLX3RnUT8uLP9V6jt6PnZlG3k+eOymTqMohuE7tbDd2OnP+9a3qpdoGHzo3q3PUCCdBleOeOKxu9nOjZwh873u7DuZL3xNSuFpUCKgVUClwwBVSmccGkUi9UKaBSQCigMg31PVApoFLgoiigMo2LIpd6sUoBlQIq01DfAZUCKgUuigIq07gocqkXqxRQKaAuuf6B74Au23pnJvfOrnSwdeJRqSB80wdBYjF0XhBc5qR7Zm9o4/RcUNC/Bfy3mzdoR8PShvg0dF1WFccoCQ3XZ5PvHIP4QTB+g05V4oglbf4KbZx1JZZFOU8/C92YOsYqjlVcBtXX7Tkefdu94XXKmKRdGdOlLumKT4agfwkYrlr+dymgMo0/jN4SJ1LEyE4zONhadZscgkZeUdyBAG5rraCRl5ZWKd6QwhisbO1gI8jgPVIDkCeghPEiGrpjW1t0gAqfG78uLsXU0gZmDIbTT+imei20ja2ws2GQi94bipNdIAYZQouctLMo1zbBk2C/znZWdOJq5lUSbKehe3cdzmacRW1DK9y9/eHI8+2tzcQQLUVji85ZTRiJja0D0c5Nzt2jMJLmRi2KqmoZ3u5Ihy2jc4xMPEGbG+pQXFkDW7rNm2ro+9nT4eLcPfW+IUynobqMgMW1CAj0UtHIeyfTH3ZUdSPvQdqeX76u+/rt33cjp7RgoEFgUD9o2mqRdDqDAWdMOSDTkQyjpdkYwQNDYNhcizOnTxMvwg0Bvh4KIpc4OJUVZGP//iPwZWi3KYPIxLnRmNBclYwVGTp8KJqqCnEqPZ+Awx0TlbOuzdAE/RhOX1Oag7ySWgamEbVbUME9/eFkbYy0M2nKNRLZIojelblnUW3hg+mCRk608XximH63Lx4D/b2UcRTnnIKxRzgRscKYgkGD4twMpjNIY7oCB05UX8Z76Ca7EYPSygkInJVXyshdMiKWZkboOrr7wJv4nvm56Sgs1XI8ogkztUFDE5w8fODl4YAipmMoqKhTgIWEUekidCUOT5y8yEnIfERK6urdKdirkh7BMySSsTDWOHbwAOoZQi+5XQw4JulFru8qbcmY1HJ+Cgi9mvjM6oleLwxf/19fQ/a7FlXS6EqNPthW0MGJgdnmGIIlN90MF6M6fPiP57H9VA287SxQnnkCg2bfh9tWXI1Wxqs/eedqOI1YiJuXXQUD5hHhlOZEacPZxONY+/ZbqDJxpOu3CTJOHMfkWx7DncumI/HAZmzZ8TdEDo0gY2ihwFCNRkc/rFh9E9L3b8CDL27CiBGBDOJKxLyb7sPYICs89/D1KNMMhoWJAaoLczF41nLifM4kvgYDxhhrYkIUrxGDv8OajzZTZWlCzPzbcB1D4m1NyRzIZDLjj2Dj5h2YvHgublk1CxoDunqTmQkyedyh7bjvsVcQGRkhbBGJiYn40/JblXD2lIM/4O4Hn0X/iEgYUrJJLGzHLQ/diOj+rtj13Yd44pVtGBrpTVWlhQF+pahjxKyzkwMlHcaikOm1yNgYB6MwAb68Ap6ckJCO2Tc/grkjfJB/8mecLDeBMxljVUU5qon67uTspDC15o48Hn3wWNUmulBAZRpdiNEnm6Lrd3zNBW7fxs4FI0aPwSfb/46g6ChkVRjhluGD4WBjwShNDb/6DFplzIWGCMP7tn2HsxVNGDJ8DGKIizmfEHoPv/Adhg6iihMzF9fOngALPrE2iufninwExP1a0LiIu2HCYDSidSgBXHKNwOrJMamiVwPqCksVlaK9vgLffPsdDp+qwuq7bseoyVOxc/ManHZchJWLr4ZRVTY+/OBjZFdRBaGk4Mr2LO1sKBm0YM+271GkbSMTMkIepRR//yAloE2Hhk7JiJG9RkQMCxowEFOH+yBR2w5zbQ6iJyxgjhcCBxm3KykYePdEFatF3OlyXDV1NGxM25F49CAym8wR5OtOFtpCCUtyqvA6MpbmFiMMHTIISUf2wbjYAYVaU46tFSdOJGPM5KsQaWeK5NgjyK03gaeTNeFRydm6fyiFLGq5DAqoTOMyiHfeqpydCho5ozYLSxrhHxqBGF/CaJaXIWTcfIT4uqKkqEiRKnRo5FQvOCHST+7HxzsT8PHaDUQj3whndy92UYTjid7418fLYdZQguQ0Y6ol50Mjb0OjgkZeiPQMXcBWPcVO+UrrGYagkbsQO/TAhvex/o0imLn7oaEgE4FkUv1mDkFrMXDNsgmwJojNU0uWY68OUwdw9YM7R2NLu0YLJ/lHr7yBrA4CaJx8EEqQC4mCJbSQclRAeMqJd2Fq4UA08qnY/I9tMGyowqN3jICGallZCyUqBY28CIaOEXhjzdMI9nYmTYgwRujAr95+HtqgqVh5VSTRyP+GbYmVyEsrwbN//xsGONRi07F8DBwSgjiil20/boCnXn6DQD/9FDVFW7UQ33z8PrYfzYKbs2CL6GjRMVz15zIp0OWTdZktqdU7KcAZeg6NPC6e0HkemDB9Pk6dJkLVhNGwMqxD0tlsBa1Lh0au0yPbm6uVNuavWg0XKzMFk0IO3P7U/Rji54CNa99DbatA//f4dHJXj0buExKDJ556BnfeeS+eeuJxhHpTPuDKiORXkcKeFJ3fhsDBg4dEYog3EW3ghAmRA9FWW4bdxPjxd3MiEnodlqxZh02bvsMX69fhTk5e4onD0dYClsQRffmzT/HFl1/grb+/QPXHDlW1jRxXRye8TtDIa0pykJFfhYGRI+DfkIe2kAkY3N8P2WcSmZKyVUnXyEuxeOkKRAa74/BPm/HpV5vRaumO629/GKUpqTCzd6WkNoEMIxV+I0YjgoyirrIYrWb28PHxRHPRGay453pMjh6ERKpCb77/GZrMXHHN0iVwrEsnlKAua5v0o5a+oYDKNPqGjr9qRUEj5wpERUYsCqtaMaQDjTwqPBilmSko+hUauQmuvuslrP98A+5cMRf1JZnYsvEt9L9qBWaPDUfsT19h3fc7FTFdcCN0RViAFOr6NJgKGrmzVyCihkUiPCwcw6KGw5u5TiXU3MCYuJy8uCsauTHBaw4fiSO48LMI97PD3m2b2JajIs7bu7jDtLkS+w8chqG1O1MCLMVYihoZZ1JoEE1Bbm4uiiu0TOo0DnfccTMsGrOoSAjuhW5EXFuhnaQZJ+KIRu5ONPKJhpgxfjT44cfRw0cI9deBRo4RCAnyQCrRyJ9++V/4+N1/4d2NvE/aaMIs0nE0JRf+xCAN4MjGjB2pQyPf8oaCNyp0KG+0RWRoMBleMTKLqmFv2oZsAhPbulH6CR+EShWNXF6QPi2qetKn5OzaGGcwDQntdfk4lpyJ+cOC+UW9De725vjxy21oHbJMMTLQHMFJqgPDqSgtQSXRf0/FHcTPWzdgf7wX3v9qEVUFLQpqNbj7/kdhQ2QrA+dA3LZqCY7FnkBDuy4/a0Mrl0nJOGL3fIEHnl+r5HVNTj6Fh1/5Nyb1t6XdgDlV+LTFF0NBI9cYEI08Dvc9+zrmjB+C4z9txJtrvyIaOfPPUkoozkjCqlvvUW5o+NkavHjH1Rg9bSZe+OBfOPA5l347EAdve+YfWDxhIKK50rPxVDX6uRCZi0VWPwQDdPPn2zB75gSikd+LWpdQ1HN159NdmZixUpC+ePPulgoaeXU1wUFNiUYeZojS3IIONHJz/EymNnbgVFw1fwyCQvuhvoz1f6zG4hHGCoMytnUlOhdJyDwok6+aybFLWggDlBaVUpJjEm0DnfSmDEr90ycUUJlGn5CxRyPyseWLLE5apuZm+HDPIVw1bCmWXDcLzZV5nEgHMDdqhW7ScN4oKy7M4L7jvfvwxQkdWE1QgD/CR1NHb2/i19IAI5mlTJo1pT3D0CYAE8c34OSxHVSDvDvRyHnekEA7tDzAxoYwe7LfwZBEyqijSmBqSuctqwAAQABJREFUTsAbTtbE2BTc/eSrlGIG49DmtXjwhXdgy1UHlCSjnqsWRjZm8Gf9DP43pdohNhH90mddsyl8AryQnX4WlTWEClTugWqPYpGQXnVMQxyw8vMPIzEtF5HDJ1M6MEbSrp9Q28IcLLxWkUqIRt5MNHI7B7dzaORzb7tW8TXhaLHrg524bf445rFdCms3a5w+tp8JHXTqmDCmpvJsZam1gXSdt2CV0rf+T8jAQXBQ0cj15OizX5Vp9BkpuzQkM4yzVDw0TcxtUPTDOmQumY1R4d44+MNupPLSa7l0aCxo5OQR4qxkTFXGwWcUPLWCRm6qTNyWsnQ8+8A9MCSjMG1voL9HK9HI13BiH2NWsWcREUk0cuZS1aOR6xDAReMUaUJYDNcmaGwUKLwyAnvPeoJo5CMG4KvXHsGo6S9g8ZxxTOqcgOJmG/z5uT9zGRVIOLAJP+w/iogb5+LpN1/Cj4dOY8bCafQpKce2ddvwyNN/g4dtK06eTIXlwmVc8YhBbclpHE0+Bi/bcN3SqNKvkeIP4sftfcxdEh12DQxqcrBnB0GE/WYptDFS0MiPIyE1CxMjxuP5x6qQUtSOBUQjr6/IxqGTHDTyEJucgdnjotBUkYMDe/bwGIvQlzRzZgLoX04mYvA1E/HRmr9j96GTcAvsD3sjLda/8woabENUNHIdxfrsr8o0+oyUHQ2RXwisniFXKSoJLFxNZyaZxEdPJsDTto3OSDo0cm1VJcrL6GPBrIjNDbUo58pKXV0DMTmZKb1Rvur8EpOZmFnRCCCYnYqRsV3xRQC/7rrSgXQlLtX01KwgyG+1glRuobhoyzWC2l1W3gbB/bZgDhYrtmdibAMnJ4L802O1hTlax4+foEgSJlzKaavKwBMvc4XCxwmTRw7B8sAINNdXYdMX63GSbcygk1rIoCEIDAnnpDVCRW4qvmLe1BLDQLgwDWUb1R8pdVXVoPsEKLAwJcIBzJk8nGjkifjpeDvRyFsVEOSqKl0ayrXvfwirW1chcux0RFL+qK/KxaefvI+UGisMDHAkGvlRDAv1Ixp5AjPCJRLVne3XMB8sgZRNXQPxyT/fYRIqM4wbHoaFPnSaI5PMSzqC+uoGGNmTieqGpIxL/XP5FFA9QnvQUO/1qT/cdV+//fseoaxNaUOr1VLSsKCobcRkQlrUEvXbih6Vlsx72sDl2IamVqKKW1KNaYa2rh7mltbKKojwHX3RSwyyL8JDfR0nGr0/zQmm2T3eg/3VaKExM1e8QXXCjrhzN6CeeVOtifrdZmQGRxsTlJRW0muznupKG8zpct5EAGHJAytLs5bWtgpCeWJ8IhNXh8HL2RaZSQeQ2+SOsEAn5OWkw9TSE75clWlprFTSOrr4BMKNjmuSNkHvTSggwU1kfJZkVLTEKgyN66+wFybIWawfq3i1tpJpJnNlaUBkFNM2apC4/yBaPfzh78TlXbbRSrfzarlvorDb2+gMuq1M6VhX3wQLa2tKSK2IT0yBf78BcHe2Q01lCTKp9nh7uJEFqRxD/y6d7/diPUJVptGDknrGoD/cdV+/fUFMQ99Ax6+kE1AmMvf/b1yc2T+ZkzAqc9pZlMH0GGPnLiUbqk+NDfW8vgXmFiKd0AWciZlE5WqlVNPI5CwGhhpFejFQgId1sSidbXRu6RgJ98kNhYZdmaIcNKBkJsvIDWSqTZRULCytlNy0Tc2daOQkGq/j1fztXp/tkpuKCtbE8TbRV0TUFsWLVIwtavldClws01DVk98l6aVfIJNFz2gUdYP7XRmGSA7CSKR0vVZ35Hx/WenX00a5+Hxt6I8bULWw5OqL3qApx3sW3Xh1aOQy+ay4kqKgkTNpm1wvdcXYakGJQMYhzmJSemmKX3ndSHWMosvNKtfraSPMjGjnnN/GpmaKUVeWiKVVfZsSuavruzu70N+XEFHiXcRZzJxjlv7098hm1NLHFFCZRh8TtGtzeoahP/brff0ZYR7dJ0TnmZ5b57/ufG2cOy6TqUs/54737KJjX873ds35jvdspttIu/Qr1/XaLplDtzpdGuz1+l7a7O26Ls2om31AATG1q0WlgEoBlQIXTAGVaVwwqdQLVQqoFBAKqExDfQ9UCqgUuCgKqEzjosilXqxSQKWAyjTUd0ClgEqBi6KAyjQuilzqxSoFVAqoTOMPfAcEi1PQvn9ddHEpekxM/XkFwZvxKBKTInEknX4Uuuv1fgv66+nJoDhb9TxuSPdzcSbrVnhRJ+J5tzPc0Z2Tfs93jdzLuXH1rM59qferPjuuu1g69NL8+Q/xvmRcPWlw/grqmculQG9v9OW2qdZXKNCO2qoKJQq0c/LrSCPgwjWVFQSukRgS3eQWRyoC8qMgJwunCTacU8BQccaUCPMQT87yigoFk7MrKxAX6UriYjbSM0o/aeS3TlsDbX1jN6YjKOKVlVUK5ka3ByQwgcTjrCovwanUUygqq1KQyvXtiRumeIfWVZfjzKlTyMwpJG6nftS6loQxVhLfs5Zu3T3vVdy7LoYO3cb2ezscZHtLIzKzstDQhQa/V009f3kUMLKzs3vm8pq48mpLvg4zMzPlC9e7MxGdogyMESixEI6WKCmvItK2DtVKJmMLwXODQkPham+FKjIPI3pdVuanEWDPHuPGjSU6VTh8PZ2QlngYVS1msLd3Qf9+AYzBqABxcwlpJzQnqjnMEDoghBGwjYzNaFJcsZuaGRAWEAhHAgZXME2ABJW1txGGj7B7wUE+aKypZkwIJz3bEMmmrbEKiYwiHTF2ImKIYepqZ4aU44ehsXUmsA8lFoIdxyekIjxqDEaPGoHgAE/UkkHUMzpXhBlBI6+ursegiGGwNyeORUUN6aJH8LpwOlQzgE8PL6aTlCTfijiB6d4vOXZuh4dk7MzxAFNbd0wYMxLt2jJU1DUrNJBAP12+lm5VdA2pf39FAXmH5Z2WHDLC9PX/9Rf2/BCoTENPmYv4/S2mobzMzcSYsPXF3ffdjYnREShMJaZEcSPsLc1Qkx+PoHGLcdctN2BosCuOH9yGnJIGhBNw96F7bsPk8SMxgGC80SNHYfTIEahIP4xc4wF44qFb4WbWiPVfbYGPvz+K4+IQtXg1bl9xDZpyE/DdyQL4O5gycKsRDzz1MKIYXPbex5/Dw9cftbkn4TdmGRHB5qM85TCOFdRygjOArbmG+JxhePLpJzB3+kQMJP7EyNGjEdbfHycO7IUh3bqLWyzx6BNP47qrZ/D8QISFDkBx0lHEFtbAicFjuXEnMXzBzbjvtuthb1KHT774Dl7enox25Wy/CDr8sm8jatudYE5080YGp1UwZ4qxiRmD74hETrdyAQ8SNUeYpRRjxppUZiXCe+Ri3Ld6MVpI128O5sDX1YZBevWoqCCjlvqUkiQRFNmMUk/982sKXCzTUNWTX9Pw8o4oX0d5wYljQUg7O0dXRHMiFqenwtTUGBnE4Bw9PAJOBOg1IXo4QS5hETQGt668jiHf7fj+q0/x6quv4cvvd8HaOxS33PsYyvZ9hoLKFgwIj0SwQHDQ3VrwOkdGhMGktRrHCEzj72xzLiubCXEqTEUS4jWS9MiY3ZhRmjFjBKwxVZFmTmj5erQy1YKZnQMcrE1wdNf3+Mszz2J3bAbCho/D9DHhlDCSccMNqzFpxECkHPkZL73wAt5+fx1OEbbLxcocTbWFMIuaicVzJ8GaaOXteiBSoeBF0cGEEhHtKYxWTYqNg4WTN6KiIoilqkX8mTwFgcuMyaFamwlzqHwJGe1L/AB73/6oyE7C1h3bcTKtEEFeNsg9fRJNGjsMjRoKG00jkrMKlWehZzYyNLVcHgXU2JPLo1/vtSnuCRp5C6Mui0ubEBA6FNEEFq+kKtJvDCH8/dxQVlJMi4QhilOAhS+NZ/6Rdqz961/w7uZjlDRCsGPHNuRWt+GhldNw163TseuXBNw6ZygmzhmFd35ORHDMfPTzdUFG/E7sTK5GxFCGyispCqkSkKk0M3RcEhamZGahlhzGuaaeX2ymc+QxUSsUlYUAvrVpe7B08UfKfbgQ2yOp1QsxYf5MkEROYzceIyNDGKq+Cfc8/vK5ew0KDYOdmQGOJRbhH2tXwKqlHClplTCj9NKtXCAdWtsNiSdai1SO85HnX8PoiAFUjcgcm7TYvfULrI9tw+sPL0EyAYKeXrMLvobZGLf6GcwZ1R9bP9+CoADCAKYfx6bd27Hy7kcxZ8oYWBGxq5nI7Hu3bcBbG/YgwNNFTeHY7eFc+o4qaVw67c5fU3REIl8aG7Yi+WQ8zBw8iUY+F6mpaQoauY1RPSHwBI2cmc3YiqeTI7RE7t778zEMHjqcmcrMERkegkPElSiva4RX8GB8unYntK0aDI0ZR6CcKowfNxJ2GiJoHdtHLOAAMZR0jMdYkTjsnDzxyIMP4YFbb8KTjz9CxK5+XN3gJeeMmBJl2kYpxAZh4eEYOXIkimmXXTFvDMw1bUg/fQLDJzG5Er/+sPLBp19uxNcbN+C1F56AQ3stjp2Ix42PvIihQc749uMPUM2UBL9CSb9QOlAyKo1txsobl2DWhBEoPHMCn372FQq0xph37SrEWBVAa2BNoOSRCKzLRlatH0ZSkrDTNCODphB/2nAIvQpMWIbF86ahiQjlH76zFrk1Bpg+fwmuIkZqKY1BkvtVLZdPAZVpXD4Ne21Bh0ZuQptELIpqWhExfKRyXdTgEJRmp/KYQP4TJIdHNVQlmonaJRq74EGIDt7C1QCtQQPzsNKISfAclG7Hmdwy+AcPVNoJZ1rH+vJc7NqyE/09qMd3IGZRH6EY3wpboomPHjsWw6OiEB1D6P9Qf8o1ErVK4+Y5YxdtiZRKBIsi+RBxTJf/CbPGDEFa3AGs3ZUHZxsC8xqbwc/XG7mn4pFOYJvhE2bgmnmTgcFXY8GUYUjYvQnvfbOjAyWdkGNK6ZycF0IHDemQwHrDwkJRm5eCm+55DB+vew83Pf8Bag0tMWr0QPyw9zhs3AOZEMkbdmNHI8DdFolkmLuKmylBNEHLlaqbx0fBkgwvgQjozIeJpOSzMGaqg8GDQ5nQqZJ0VF/3jgd0WT8qFS+LfL9VmZ90ftpbtXk4npIFF99gLFx0MzwdLHBy3w9oMZJMaBQQ+L+R4DOmNCoaUz2QVQLxO5DUjFYaa1gToatVMeQBJ+JTmffVFQ/ccgv83GyQkRKPk/zSWhDcU2ceZGNUS0xYJzc1FrNmz8KfHnkMi2fOwuvrd3GpVPw3JM+p9Mw/ROsyZfa1TKZ8HH7dnbj/xvmoyorD68+/Ai83yT3L8TCV4k8b3sLDT/4ZD9x5E20HRQgcMAxr7ifQL1HS04sacPOd9xPtS+w3vrhhyUIYttazLl8thXewld+jgwLJLvYXwgdypYlJFDBq1EiYNuWjhCszFrb2+OxdSlptZhgSPR1XxwyBOeGFD+/8BCEuVh0mTiOFDm1kvdFXzcL1y5dh6sj+qOFScaMR1SYucyu3LbeulsuigMo0Lot856ksk0XmJGen6Pkb9v6COthg2dLZaKkuwJb1ezoyqVO05qXpzERm7uCNqTOmISnumOKTEcev5LQp42DH1YQcJgqSsu/ALyitbcGEmTNh2lqL478chLkPc34QXLjbjJC+KU1IMaPob0dMTUU0p7pAEyiXbYngVU88Uvp/ZJyMxdBFt+PeVVejPP0oFi67A/El7cz32swJV0umxvwlXIXQF4H0M6L6ZGFCX5MGA4yfPgfzZkziSooZc64EY9b0CRxbscKglKW636MDV0c4LKWIlGXnYKegjR84cIj4qW5w4NJxu0hRtTtwJrsIAYNGYfzgQJTknMHnB+qINi4Z6aU60cSYxsGgtQ7vPjkH06fPwrxZszF95lx8ui0WYSGOlOJkFUUtl0sB1RB6uRTsrb68xJy04iWpMaNFf+t6ZC6eiZhBXjjEpEeJPH011QiRKtwCgfe/2cqUgsGYu+JerggwT+nZfFy/+m76H0SjKCMOX326ARHDhiH24BakZl6Nq2LCkJ14EDu3HuRXP0IRz5VVBWUsuqzwem9TxeeBT1l+lRUKpkRooQH0wb88iGYmo163N5NLlktg2VKGA4kZePCxR4kbqkFhVhr+/eHnyLhmGiYuuIFJicyh8R2KISEeiPv5S6Y/eF1ZoWhnPpUT8YKS/ipR0o8TJf3PREmPYOpFUbNIiN+jA6ULWUoN5diPcbVmCNMVvPry09i2P4m5ThbDxrAJcYePKXe2n6jmg5bMgJNBI7Z/8aVyTF5guVdza3umijiBeVSvbnr4PThv28k0DB4IZma6H7/5AqeLm2BJBty7X43SlPrnAimgMo0LJNQFXyYMgy+xIT0wq2mw1BJjkz6aOEagXm8HqhiHDihNNRBNu6qyFa0m1nApjcMr/1qD1cxhOnwskxjH0I7ByZSRQNvCmtdQ7xrKpdU2eFs24/DxREQEuiApMRZpTZaIoLqhpFtlv7IyIjpBbU0VDAhqLA9X7COE8mQGdoLzcjyNREc3NLeFvYMDmsqs4e/vRa/KelRxNXP05OlSg0vFpkhnGgVzrMcHH3/KDPfXYt6yGxWJ4GzcfnzKY0EDBjF1Y72SuFrpk6jn7VrJSCKFg7kIOlRWtsFuALDu3XXwcrLB6MgY3B5GGxBzwfzwzWf4bEc8IsJDsWvPbkwZPwwuBuXYu/sQvH3dCPPXgCreV32LBiU/fYj1/d1w9bSxuHbpcg7BGA3VOdjKezekitIhAOqGqP69ZAqowMI9SNfzS9R1X799ocDCioedSBs0wNXT0NkinpnG5kQSN6Khkw5L/BILczCmD0VdeT7ScooRNXIMEbfNUVVaiF+Ox8MvOJSZ1Hk9l0vli9xEtaKNKyUGtHuYmHPJgIbMnkWcoehYTsOfmFZ1RVZK9KkiJSGys6sr2piQubCEDIarCqb0GRG8TxmTAfUFA655mhE9vK4iH2fLuTAxYjBa6zhZD59g+oKBsDQRvFNd2zIZW2T1hn4a4lKup1NH18pSp8Hv0EGMsZIhPiEpFf3oj+Lv5oAC5mRJSKvl6k6Q4uAla1JaroLQygNjSwuyBLHlEB+UKpMh+zYlnTKYKsLYbwAG+buR59Qi43QWrJycFGBkvRqkH5f6q6OAGMObiLFaX19PwfD3PUJVptHjzen5wnfd129fKNOQ6/UuuLJiIfic+l/5bMuc0+n9PE4nLCMa67TaWkX31tCOYGVloTAIgfHXWSh4PSe4iP36zGk9hq/s6sep71t/jX48HIqC/G1Ary9TplcQb8ueRTxbJUbGkGDEgjZeU1NLRmLClAsck3hodhmT1D1fn/pz+rHo71//240OHJiGzLCxvg51lIjMLKzoIUp/i2aRpXQvMw1FZIiyAtTZp/6+hJ4mZD4tlD7qGHsjDnaSkU5hLR0MTsajlu4UUJlGd3pc9J7+5ddX7Lqv375QpiETRV9H2uu+L5Og88XX9ye2B4VDkKl0z2uiv6JnO53H9VvKBO1gSvpj8tu1f6Uf6YP/leu7XijbXetzoDLJpZwP5ft8fUqdrv3+ev/XdJDr9XW60k9fV367HtdfK8el6OvLtkhYvBW1/AYFLpZpqDaN3yDm5Z7q+mJLW933KWn08jKfb1J2HUv3drqe0W2f73zX41376Xr8163xCAfaFcW8t2t+q42e57rv/5oOcr77NZ099na857Hfqt/Zkrp1qRRQl1wvlXJqPZUCVygFVKZxhT549bZVClwqBVSmcamUU+upFLhCKaAyjSv0wau3rVLgUimgMo1LpZxaT6XAFUoBlWlcoQ9evW2VApdKAXXJ9VIpdwH1FF8IXtd1eVNfzVDBDBVfjE7HKvEv0NeR68QFXLcsK8fF56Onz0HvxwUjU+f8pOvt8pYgdX3ox60bV+eYux6/nG1xJhMXla6OZkILoYmuTz0tZE9HJ+WULAeThr2sXtMRjm3y6t7OK23znKCgXWqR2CJ5Jufzp7nUdv/T66lM4w97Qu2oq6tltKkGFmYm3fwO5GWvJ2J4u6ExXbUF7YoB3fQIFaDcspIiNDa1MtDNAk6O9gz0FhQuRpwSjMfc3FLxGtVPEAOGz9cS0Vxjak43aXHflunEOBMihknEqDALadfSivX4crf04vn5e7ff3t4CbW2j4qch7ZlyXBbmZkqQnPTXF0UmdxsxMaqrG2BlrQt11zBoroE0KiurJFapBVycHGBIz9TWNnqNagwVNPfKai0sbOzgwDDeVtKo63CExk0NdWgidLolXc4V4nQMVhiR0KiR5ywszBSaXex9iJdpWVEhNJZ2RDnr/nwvtq3/b9erwMKX8MR+C1hY15y4iBsRYNcfjsTfrKjRcrLrNEF5mVua2uEZEEBsTnMGlxExnLEnNcVZKKw1RXT0cPTv348o5tZIjj1ALAhb2Ng6wNfLA631VWhg+LdIEeLi3dxqggB/X8ZiEISmoUUJfxeXc2dXD3i4u8HJ2Rk2fKGzEo6iBhaw5gSRiS9j6JRq9FNN//XmyY4iX1FjU2v4+HjDiehiTozhMGwhaldsPOycXGHccalOSuisp6+v70MnLej70Z/V/QrDaGVAmcbKCSGBPkx3UEnatSOeAX6e/cIxbNgQeLva4ezpBDQZWsGUGB7xiaeIjj4KQwYPhL2FIcF4jsHCwVkBMZJWZSQKHdy84OFKVDSmf2ijVCDHFfozjsfBxRPebvaoo3u8YCB3pYls6xmijF32uxahf3O7BpHR0bA3a0VRaQ0ZmcT5dKGhvoGuFf9Dt+WdUNHI/+CH81tMQyaQgsJt54t7/3QPJo+KREHSIaSUNsOW2Bq1hfHwH7UI996+GlED3HH80HbklzWiX/QMPPrAnZg+eRzCwgZj1JixGEM08qJTe1BkMRhPPXwbXM0b8dnGbfD190MJAXgjrr0Jd96wGK35Sdh0Mg9+DmY4mQ3cc989WDB7CoYOjcLYceMwcfIkGNYUIp4h91byZWVwl+RMqaurp0qgC00XAJwGSkb1RAoTUGIJIKspSoBfzHW4e/VyjCIzi46OwfgJEzFySH+cij2EOgNzHdo3I3prOfkE/duE7Qh9BMpQ+pDjrR1gP8KEuhcGyhm1IyG5GY+/8BRmT4xE0qEdOFamwcOPPIpV1y1AFMPsBXksJjIMWSd3odRsIJ568nHe31SmeohQ6BQW4oOj+3bDwNyOfbZzDGwzC7jrvnsV0GPDugJ8sy0F3p62Cu6o1tIfDz14L6aOjkJhwhGcLNbC0dKcakaLEmMjYcFmBCcSrFXyYDJpYfg6pifxLGiqRo6JD557/AH42rVi7fqv4U3GKsxFJEjJQyMpLiROpndW2Z0K/9d7F8s0dJ+//+tR/zf1zxdHJoe8XCYU4x1cPBA9ZjQKz6bwRTJGejFD0JnWwMXRltGu5vxyF8HQJxp33nQ9/Bw12LF5A9544018+8MBQn8Oxh33P430PetRXAsMZPRnIF9D0dHzSLOYoeEMX9ciNvYX+DnZ8gXnpKxqhrWNDbRledj01QZGpcbC2i0Ii5YthbdJDhrbjVFRloWMwjp4eHpyTCbMfVKHuLh4OLj5IDjQC6Vn4lFCOEJ5OYw1BNxh0Fjc/p34butWpGaXYejoSVgwfzpOJRWgpjSbXWoQ3D8Exs0VSMkuJmiPCcoK0pFd3oiAfsFwo9R08mQqVQXdF1153JxNpuz7xMkk3PX0HYjs78NJJ4F7DFhrMYe3lztpdhL/euVlfPXDIXj1j8DsOTOR1mYJdxcbnDzwI15+8a84mJSLiJiJmD46HEnFzLnCKFulELNUAIisbB0RHhkNj/ZCtGvMmE4iHWMJF+jn7sL+qdYRBEjwOEpzUokjCt5Hf+KNtpMeyWjnMzQyInNlAFwbGZ9IHa1NdWg2MIVTazn2/LgDvxxNgLNnAL8TNaxzikBE/pQKnXAmKY7h+jqpUDeg/56/qk3jAp+lcOMLLrxWQSNnGHsJv8KBA4ciyp3zmaK3f8w8DPB3R3lJCQO8iUaeDCx6YSLcbA3w8asvYM3XhxAS0g/ff78J2VXP4E/LJuOR1VOx60gCbp45BJPmjcS6facROGIugn1dkZG0Gz8mlBGN3I92AcHuEHQqIm+Vl+CdDz9UhrzysVewYmoogXYcMGXxCnjZESDIygWBHg44uP0jPPl+Il558z2E+nsoX8vqlcvxzafr8Pk2MioywVbaGxJ2f4VPD2SyPQOs3/IjPLz9uF2K6LkPYd6UsbClGtSorcRuon+/+s4GLFx5J+bPnAR7Qd7ihCvLP4V/v/FPlDRZwITShSFVsqqsE4hZeBtmjR2M1JOJcPWwpjqkgYemCs/dvRr5TLzk7W6P73YcYx6YobBmOggcX4M/3bMTecRLtefbe7TWkRLbzWDSLxK4AYbuhClTnhXD9InmVVxUAkfPQEydORQ706o54kBEE+28gTCAgshuSImo6Gwqltz6AOZNHUvYQsIcEtEs8ZedeOjZjXjjw1dgXJKIJx99Di79fGHuPQYP3jgHJw9thQXVHzvDcpTkfcs+xuDltx5BWKCnImHlMJXC+2+/gZI2B5ifg1gkyf6fFJ0ay4ffS1EljV6I0tshnV7e25lejomOSBXA2KCFaOQJMHf0wsQZs5GScgZTJ46BrXEjktKyzqGRe9H2IGjku7YfUtDIzc2tFDTyfbv3E428GT78yn78yS7UtZkqaOSNZWUYPz6GyYnaEH98P1MN+FOJ16ORczyih+sFY40fBvh4KKBAxVkl/PI6ICp6JGxRi3179+JEUiaefuY+jCKEXtKR3di8Yw/MXYOw4qabIBDGLcoX1hAW9p6AkwcW3fwg3AjtV1GUA0QuwLIFMzlZs/H5J1+guNEUsxcuxegBwZg2YwYntRYbPl2PQycSUF5WoSQxEhuG4G6IbeRs+1Dcvnw+6vMT8dnOJCVPDMUohutr4ESmFDUiGpqmCkxYvBxehBsvK8jliOzh5uJDlWUkKsgjr589SkFPz8nJg6WLpRKyrzyRegETIlRiZjLv1ALRYycj+1QyYhZMRaC7DRLjEoneQUSO5nL4TVmO66+dBzNuf/f1RiRnV2DM9AV4dPUwlNU2Y9AwqmZDfZGcmsUMeDHw8XJExtlcZtALosrjonS37PqbED3AC4d/+h7b98YicMhorFi2HGnJCYrNSrno/9Gf33rfVabxBz1IwdIUvb787AkUa9vPoZGPoD2gPPsUCmoaKErTis/+RY1pIuqVPAxZ9WglXoUOjbyeaORMNUjgHuRtQVpuOQJCBikjHjKIaOQVedi19UeEeNl2opHDhGhWzXDzD8V7776Lr778F0YP9ETCkYMgRjdFcYL3FmTg5RWr8cxzz+ObM0aIGOiH1OO78OAzf8Vbr71EdPHdsHD2w1ULhqBScCmISD539QP46u03cfN1M1DOifjR02/hrvnjYWnciuOCXVpVTANpCozNHZgZLlRZ7TE1s6Qhth3PPfEQ7nn4z6g1ZqpHSkIaWlDjEs/gySduh6dZHf55472oIeK6AdWrqrJk5FQ10qZiSuNwGgodJuLW5XPQUJyBrz54D/0GUY3hPZw9eAjjF92FOeMjmfvlEN79/hcEOQjT0NtNKEVQvWjUliA5oxhBA4codBsbEwWjxnIcSRU1SgNtcTxmjhtBaUCLD15aiTXvvocHblvBHCz1GBEzFps27UCTsR1GjR3D+k6IGBTIxFeJ+Pz7n4hd2oJGZnMDwQpDQ/xQmHGa9pl0nE5JQHZRLfwDghVJTYzXPY2pymD+n/5RmcYf9uCozvDlbq3NxYmUbLj5hWDu/BvgydyuJw/sQLOhDo1c5INGIiaZWFvAiCuDol/rMrAz3YjGikl/iFMltgqWE8ypamLrivtuvIlo5HbITI1HLDO2CYpWp/Kkw8cQoJxGMo/i3LP4Yu2/8de33lPaEGStOiZtIog5sTyHYIC7nSLGV5YzU5FZMEYO7U/ErBw0NDTD3JJLmVKLS52ZqYnIKq6CKSf8ib3bIaidtuZcEGbO2tFzFuL2227D7HFhSvJpYwtjvL3uY2SWt2De0lvw8w/f47mHb0dtaQmXks1RStH96lsexuThA5B1OgluC5ZgShhVI9IkZvKtmBbhgdL8s6g0CcW///YQXDVafPzuP3HWLIRJmjTISWRCqQW34JFbroU2LwmvP/sU+ocNUQCLOukgShpBkZl7Ztu+WIVudyydi4FBXsijzSa9ikyFbz+1R1iyzSZtOYqa7ckoRvHOLFFKtUZjZoXYnz5CTlkdQgZFYMiUWUSTN0fyicO8pn8HxghFeBNbMrwW2HsF4cY7b8edq5fC1Zo5bvlcLUOsSL7/LkBjlWnw8fd5EVWQb68OjdwE3+w7gnpDW6xYPg+tXMXY9vFOitQ6FG0qFsjkC2rh6I1JUyZSbD6GWuJ7xiWdwaQJhP4jhF1e+illiPsPHEGZtg0TmZrArI0GUEoPGq9+ymTpvAdKJmy7KDMVd9xxO26/6x78c90OuLn7KZeIrqoYabnXyNSG5exLxHRrGyfCeZ3GoeOpcPKikZC2BUHQkiTQba1NOPDZk7j/tpVIK66nXWURfFm/jsZGgxYt3nl6IaZNW4zbVjNtwLSZ2LgzBam7vsYNS6/Bg0//DSn8ao+9ajbVFhdUkhlxsQIBvu5K+87+g3H9iusxdmgwc7daYtL02Rgx0A1ZBf546S8Pwd24Gn9/ahU+++EELGkbyEo4hpAZq/HgzdcyR20cbr3uFoVx1tVUcq2Gr3MXriH3akTj5wFmYSuobMRV16yAq1kLjuz5DibMqytLI3SVQR2lOY25DewNKwixGMs70yqo6HqnrRN8FtaugVi1YBxTUpRi/0+fgUtVNJ1IZ/zfVK+ANmcnHcCM6TNx9733YNZVV+H6+15AvcYfxmQoyqW8+r+hkGRq6XMKyLtEeVS8DgWNPJ0rIlmLpmNEqCeO/Pw14nh6NpcmBQ3LPQD4aNN22hSCcfWN98PWZxASzuRiwZIbMYX2j5LsRHy9/gsMGTqUKxjbkZo5F1NGDkJu0mHs/GE/Vzs60ch19yEWe+nXnN9LGjJHxjA9IRNSU/KQImMS71L59plbWKKIPg4pafmctOPx2F35iPuf9q4DPqsi2//TeyeEECAEEkgggZjQQgcRBJWyCPaVYmEfq/JQl7W8t+uyq7uyPn3oWlhAsKGoSLEgZSnSWwKEkFBCSAgkIb3n+1Le/8yXCzcfXzAizbd3+JHv3pm5U86dOXfmnDP/Q7XMw+OGoZa+HH9Ysx9+RP8Wtaxf5xFA0gZ8vmYD5jw+Cc//9WnMW7cDo/tFY+qsN+C5+ns4+rZHVKdW+Pbr7/HiX+ahviAD24gpmpVTgOhQb1VvOdW8kTHR+O6jhdi0woVbLxeUZO1A9F0vYcaEW/Deq7/HyvQALPrsT4gM8cTmtVvQrs+DeH64ByryT+NQ/gDMnvEQvBqK8MPeI7j36dmEBHTGucxTlNHsUL5pLb1r7KsYzeEoklJOY8KIvjh7dDc+X3kEfR+5W1mMegRE4vttibhrQCymzJoPu2WrETNkLOVAPtj1zTdCMvzww3YM6/UYEnoG4vDu9VgncPLdqbYmLR0JgUjCII00HBA/BH+aI1ufXEy6dwpMxaew8J1VCI0KoTHc/5/VhsE0ZFRczSAMQyYmJ2klv+JV1NkDhdhPeP7QAHsk7tqhahMHSeV0G1jv4gGvs3vw+jsLMP2+yRg8ciwShtVyT++I7LS9WPLuGyjxi6IrRBqEuVRgT+IRxEe0wdEjiUijMdgt9g0X0Mi1blTS67pDRaXyH1JdU62sJV048SVU00qy3IFMhNfiBiS6iy8WLlwK/yemY9jYBzCE7TcTQPjzjz/AbiKU30FE8PJy2m+UlyE0MgrfLFmEQX164paYfmi/YBI++DIUk0cPwpRHZrDflCGUncGKz8oQ2DYMMf1iMYj9caK2JGn7RuxMzab6lUZq1FqIFWx5KQ3bKBQuPs9vO2lVTnzUksIURHeeglZeTvT8TlDhfsNxC2U/dnQuVZ6djKojBRQw0y6kxp7+X8Yrga+gp59M2omvKYx1b9Wa2wHZ9NUTzJl66gp2gmHb7iQk9AjF0cMHwOoo4a1mv0pR5+iH498uwhdRHTDutgQ8+XRXtokGYzs2YOGijxHLLVzi91uRctcoeHdthQPb6bOmdXsyYTMqhS6NCOxLlyyFG9XmA0ZOQO+htHWhQ+y9W/NQbCpDmKiB/x8xDQNYWAaQLliWnBcj9PfadUsxQh0oiBODIQk1NFJwpDyglrp7GVCUXnBF0GBBCKf6sSI/CyezKzBw6ED40VK0tDAXW7gd6RAeBV/KCORLZc/BZ+Ly3oXbDzMHrQOFhbbWvRfORChTR1X9hT+CaC7PiDNopWUhM6mlpWnqiXz0H5ZAGwVHGm7tQGatD+Udfo0I5syjBr1oZeguklas3oHB9HxIVSyNzFrT90ok1b919IGSlZ4JO5rGV1Hd3C6sM/yJrF6Ym4mde08isltnTnix95TQVDgo0noFNswtQz2X82IX4UJjMfE0ZyZ6uggSZbtXy37bKfN72pewDwrgmGnyTANNzPVB0UEMtBhZb6LLSNqANFAt7UAmw2aQOdAtJpm6E5lEOrUcPuE9EBMeSneXOdi8Yy+60NG1C7dEdaSjMAkH9stUVavsbepIQ0F7F3lFA2lorixG2snzSKBWy9vVHkV5ucihDMjbz5vtssik9G27ma7F7sdAI/8Zb0RjDFoR+nvtuqVMQywjZWkvA17+y+DTIP7VQScZuFyVyCR2oKaF0gOevyi1DGQOUC8vL/XVbIJGzoLEFYFMCFsMQ9otB9342VfbAa0f2q8MEAmyTbEEigs5CR25YpEvfw0nqJePD20pqNnhUkRErKKREGajpiTrl19zTQ3syOzEctJcLasEC/q3KzVB4s1N+icC3hqWIedVPD1clNsGC8NorFr/QxpIPapfjBfaafS2ZBMBL20vZGvFfE3TpD9kwmLfrQuWvso2URgUn5P3odFNV5+0SVDMzdSElJVzlcazPD48r6NcOjBRqR8lP5935ApQmJcExXhlVSk0Yf3kPaQh3x9J7Mz3J6pj63aqB2+yPwbT+JkvxPol6++165YyDRls2jPSrCb3jZNPny5fX22AS7w2wa271KQc68TGeiS6admWjGoC2EzT6ham0xTY95L6rNou6fpyVb2MU5OJ89jSl2bZhaVh/KuvRyvvQmLjhZRlO03a3DS3Jd/FeH35ktPWvbIjsUV7qz5rz7N3unotNFStkDKsG6QSbr4/P5VpGDKNa/gOrSdtk3sOKKsxzpYIo7g01rqJTcqxTpRSLjNYm09rvu5LnrFqu6TbyvNTJ42+DP21dRcvl6bPa52vJffNqket+iz1WJfX0venb+Mv8Vpbo/4S22602aCAQYEbQAGDadwAohtVGhT4JVPAYBq/5LdntN2gwA2ggME0bgDRjSoNCvySKWAwjV/y2zPablDgBlDAYBo3gOhGlQYFfskUMFSu1/Dtic5fjKNsqVGVcRXVeHq1pNgNaP9FnScGUvxRQfLr7y2xFrsAsTjUK2q1MrSuXfqcltKSX53tAbNb2qWvrSVl/Hgerc162xSBTrQTgy0rWkhpQg95Rtqjf0Zfk4JeJGWaqkYt/bF+Rt6V2JWI2lSMt/TvpWmZlndkiw5aH34OvS14q2LcdvNakRorDf2IuMrXgnhdTcxNGUz6IPc1ksaj6ypw4MvJU7F2LCO6V35+PkoEjNjBSVmMNtDCs5LWlQpyTleQwONVM97MAaavodZsIv5npfpfXWPikRCnizB4uudbctnAY/FSh1ZeLa1aBc7PqkstKarZPDJhpY9y/kRjR06so76Wp3BJi+LSckUfi8Enj7vTerOmqgL55/NRTpR2Cx5p0+KFHmaajgs+SZO2Sn+qqy/UIwZ1UlctrUELWFc+wYJM0kfWYSvUyZkTeRdkLPpy5Z2KJW4V6S6m7VcSpAwzTfELCkrYPv0bvZLSrt0zBhr5FdBWzIkFONZRzjJoS4Em5fBrRTPuVoFtCB9nj9JKAu4ocFqLFWItXRQEBLeFt5uzAvd1pDl2ZeEZpJ01EX27J8JCO/D8iQv279gFBy8/eHp6IyjAn2esyghgZzHnlgFrMvOUbHAQnIgQVs0yxZpUBrOPXwAC/P3gTaxQnnAnwE4izC7E5nAT6L3G4cgCtNWO1nT911biJK8cLQ8Mag0fluVNs/bayiIk8fCdP/vGkxfqURnsqiytoMZfLV6Gf3PTSL6sDTw81uDkQWzNYAXMK48fOnQYvoTp6xEdhda+bkhNOUi8Dz+ikVcSjTwVnbvFIrJruAIBStqXCB8eVGNJjTXzS006+Ae0IlaGA2lMk3c5NCZ9J+ZpUKA/T/5W8aQvGQbPlhwkulrbsCh0i4xACFHca0pziF1yhrQNUMxMGIsEWdG5uvugTWAAaS/uEXgMQJLY/3qezXEm6FBQmyA0mKuZJudlLM9Z01XK0tLkWoLQoY7M3rcNkda6tEMxsUfqZaWl0jT6Xuyfeugq/ZH3LGO6ludypF3af61467Ya2xONMlfpV00CUznq/cLxOFHBAwQR6n9fxo4sE1p7uqKMaOQdBz+GJ6ZO5NHxNPz9b3ORWeSEjrGj8Ny949E5JJBnT+SUqwMemDwBS/4xF2e94zF7zkM4+sNKzHl5MXr1jkVu0l7ETX8Oj48fjM3L3sKr3ySjTwdv7DlVj3lPzMAtEa3JSCxuDYryzuC7Lz/FxqRTCKSPEI4KmQGoIp6GMD45tyFo5FU8Qi8nX8VPiDCBkuwD6DJyNmbeN5KMiWdBZIITW+P4oX1Y+v5iVLn4E5SHrINQgxU87enKo/Y8mqG+7urrzzpkhWLP4+NuBBGWQcnxqQtcNRA5/EByFV7/51xEhzjgf156HlvOOePZP83DoF4xCndEzutknziERW/9HWecozFv/guIIRCxA/shB9oO79qEt99ZCIcA4nPya+9EMODEgybMX/QEPMtPYtpTzyO2dx+UZOxBxOhnMXNif3z1j79i/ckCHoZzwuz//htGDIzn4TQye55vqasuwdZ1q/Hewi/RNqKTOiXsxDM2SQcS8RTxQe4a2htHtq/F7Bf/hphb4linCYnHq/CXv89B/25tsGXNB/jjGxsQRzAh6a+ernZc6cjKUJnYkxKWbRDpwI/QgeTDeGba0xjbrwNe/d0MJBV4orU3sVfJ4Kr4URD/NXwBpKPlAJ+OkNf10tieXG1yy3zkZJEtgZuHB1oHt0MC0cjPnkhVpyNP5tTRNUE8ggP9ODk9YF+fg5o28XhqxjR0CfbElnWr8N57/8R3m/chOLI3Zv3+ZRwlqG9htQOiY+MJfmNWpzazuLMZEN8TnjxafujQfh6752lK1ivAmT4+voQCzMPaNWuwOzEFAR264X4C3bR1PI1ycwNyzx3H4WN56mCabIvkmHhiUhJcPP0QEuSH9INJBOfhaVLSxtGZh824Qknesw3fr9+IU4Sx6zfsdky+ezRSk/OIep6FLALctG0fguqSLKRlF/KwljMKczJwMCMfgW3awsuF8H5JBy9BI3d2dcEBYnXOeOFJ9I7upLZnDmSWlbUeCA/viCIihC8gGPHqTfsRFtMH48bfiRN2vgjrEIjUvVsw/3/+F/uO56H3kFEYMzAayYRsFzRyabcEd3dPi6MoXjuRcUlX3XgYzcvTiwzOGdknT+DBab/BpDGDUXwmFR8tWYzFHywn3CBw5z1TMGPKHTiUdIZbFWKJNq4aXOnqwN3TB91iemB4jwDSk0yyIg+xgwcgJqoTXUTQmRTzcBTw3ZKZWNE1v9xEZseDieVFqOTJNvVV5xstI9Cxn6cbjpEhb964lUBFjkRGs8NRMqoaezeEtA1AJhHOC4gS78iTcU2Zr/T2+gVjpXEtaM2viwO/wGbKLfILzQiPjkdcYAN9apSiQ9+7CFTTFsUF+XS4Y4/zBO588M+3IYTQ2svmz8Wbn21BBL9uX365HKeL/own7x2K56YNwpY9yZg2ugdG3NUHy/ecRsded6JrxzbIOPoD1ibmEKQnhEtkwauUo/gNxNrMwVvvvqt6N/3F1/DgiCh41bfCbfdPQVtvts8zCF3aBxCN/CP89+v78cob7yEmor1abhflZeLLD5dgxTENjbwGSeuXNaKRe2PZtyvQLrQzy85F3Oj/xK9GDeWAd0VVWQE2fr0cby5ZiXGE+XuFvlcCeDReeNn57DQsePsfyDfRbYCgkXMSl2cfQq9xj2DcsDicSD6CgCAPopE7E62rGH999imcyj7LrYAHclZvQ1yvZfDhcXzsfQ9znt2Bk8ezFMjQ1nwPLH/5Mfj7+wPFx2DfxlO6r2ggMgaRa8iZ3/Qz2QQmBoLLiS/CbUYdV4MIuxVD+vfAOeKW3D/tSTgQsLhVYSY+IdLZ0hXvYODw2xC9fBmq6trDXe1DLALYIiLJu3oGYtDw0Vi/dBs8yaBnTE2AW0M1HWNxC8RVGnuMCscI/OX1d9Gzi6yK2DyCR3/0xjNw7vcE7hncHWuW/h3bM2qQkZaD5+a+hO6ta/D1vjMIahcCX+KJ7NlZiqdefAXD+/WEK73KFZARL3//n9iXUUbIAZcbJiw1Vhoyvq524Cyp43FzolAghZ7C3Fu1x/A7xuDIkTSMGj4Yfk4mJB+/iEbeIYho5PQfsuHrLfTR0YcrEB+C3HTBpo1bUFhlRhhdILz/2WZUNbig94ChdGKUi2HDBhAKkJ7I9m8HvDrCjgK6Cyt/fhUF98ISvNCJcg8H4nrkZ+QR3yEQCQMHobWrGbt370FyWiZemPcshvaOwomDO/H9ll3wad8N02Y8hggWIPt+2XK5eAXyzhnjp0xT26yS/LNE8BmLhyePg0t1HlatWA2iR+BX9/0a/cI74Y6xYxHoasLXK77CgZTjdO1YofA2LBOKOKgNlThe0BVPPDwJ5rxUfLIh+QIauSsFMZ5kAr369IOXAzFGJt5HpupGBHTWyTp8PAOIRt6foHzAA2P6cQvTgLPZ5+DaykPJdBjNQDhFyjW8/IIw8/EZdLw0CbOe/A8M6dGeWwOyVjKN7l0j4M1nUw/tYf5g9AoNRGivvrxOR8qxk3D1b42OncNRQXDlxoWGamNJTibxUisQ0ysBwUUZKA9NQFz3zjibnoIierpzkT0aw32/fhTDiIOq0dW7XRR+M2ce8k5mIrB9GMGKhxF7NQVtYnqjb99YONRVwdEnGFFEc0dhKibOnIoJowYxfxJWE8HMq20kHp4+Fa7ZxxTavdYmVdl1/GOsNK4RsQW0RryU5Z84gPzuPRDftz+w5Fv0pc+NojMpOFfqgp4O3qhh/c5u7jBxucotNffYBOshoIwd/YyW2xNli6A7jo5EHE5fTZCeR9A5Mka1ODY6EjXFZwmHt5b+T3ryOQriFDgXZQf0axrUMQrvvv0O/OisqV0bfxymJ7fDfFLwO4pzT+O1B6Zip5QUNghfzeqMY/s3Y9bzc1XZmZWOmDVpCMZM6IHdFCIKGvn4x3+PUdMpXPQPQOmZY/hk7pv47Yvz4UU3Cqs3/ItOlHJg8grBlLEDMWRQDPfglMuIz5OaAvzX72apcrtzSe8oMgfSJTExDc/NW4BQLzNenfVbFA94XqGRlxWlI6csBFEUvFYVnsZxu/546eHxMBdk4qsPFxBVvIfSpGTu24F+Ex7H+GG9kZmyFe+u3okesbFKbqLoQMZTS9lQq9BQ3Dk+iDIacgqu6e24bbSn4FiEjn5t/ShUIJoZNVZoRYAdkwn1fAmMJQp7NWkqwMROVupXQinaVWHXoVTcPSoew/hac7sMplsHR6xasweDJ3VTWh8gHj26d8LxA1ua0PU/Sdfudu/hwLFz6NktDm1Y12ACL/m71GH52qWojngUJqKtnS+xx+i4Hmgoy8ZGurLIya9CcOeuGBzTGdF9IrE3pwYB7pS/3IB9irHSUMP5WvwhB6CAsa4sC4mpWXQpEIkxdz2E9oFeOEwoORMdQ0sQpauJAkhn7mftuBUWoZ8ClOF61tPRg9J/gv7L+p7hwOE0uPi24df5YYRxwJ9OS8a+HEEj1+sNmJGoVxIEcKYkPxsrPl6IV//xTxUnIDcVhQXI412coJGH+BFW2Ey/JGfo8qwL/Xt0RRZ9slSRWXl40Y2hPEXh29n0E8gtrqZMwB67N67CDnI7QRQTNPLhkx7EnN/9DhNvjSWkfwVlI85Y/OEyZJfb495HZ2P9d6vwh9mPooTLeicK/ArTkzB2+jMYmdAdp1KS4Bw3HkOjgrisd6b3tvswqHsQStnu9Or2WPzmC2jnbsIni95CckMEfbcSD/TYPrQbORX/NfMBmM6n4c2//AFdonty+aBbbREkyJmMIystCVNG344//vllzJ55D97m9q+untie1FgV5RWRSKKU8aXfJ5OCWBSYRcayb3RNSSGtiSs0i/2GEMIiuHTis9+t3IDKBjfED52BgXHRMJOBf7XphAXNi9sfBPuQuZCu+U3pKiDGAQGu2EzPbG6EPhw9sifiYrqqD8DqVSfgRWR0eXuO/hFKT+bgFoCHHp2J5158Fr0iglFRWgkPd+8LY0I16jr/MVYa14Lg8tbJM+Qj4MpB8Om2PRjecyKmTvkV6stzsXbJOtz62t38gkGhemfS3qBPtygM5ZbjrS+2IzIqCqlHj+HuJ+7nF8gJSRknVCu3E/5vzCDKNcaN4/65UqGR24VEKAi7i3sTE4WXDsjhUvmxmb9v7J0PevfujHRuT0S9JsJPAgUqe4ViqjCJR0WBIWUCNce43aHbyKnjFeqU2Jk4cC8taOSbP5iDTw/64MOvlis08oWLVtEZNYWOdHq04E+PYnOOJ0IpTsjILqYzodY4fDgZv173Kbdlk3HPvffydwLS9u/G7oJanKWgcVJ4B8oVTGgTEYffUOArWyBBxRo9fhK8XZZg3cZ8LPz0RYS615ApPIvPN51EWDgZWso+dBj2MF4QhpGXgufun4FU9qWjcyk9uIs8g0TVBZFr5PI+kNuj8ydL0GEQNTj850AV75H0dJQQUb1Lt17M8RHS8z3hVSm0bofI8DDUFOXi9Mnj8GgTe7FYlm9H+h0/upH+VGagW//RqKVfmrRd9IhXSPsV9SI4AM5xO0YXmNZ0FaGq+Kr45rNNeGTsAAwaPwU+Ib5IT96ITNZMBELVPhP9yIhQuOL8afzH5Olwo99au/ICotHXIbCVPwIIy3il9iCs5mcFg2n8LPI187CMW2445Qsl0PhpS77C6Um3ow9RqfduWq18hoymoFQk58Tfxcdr1mMAnSjd/dgceLX7GklpWbh9/P0YM2o4CrOPYuWnn6BnXBwObl2PtPvG4tY+3ZB9dC82bdiCqPZEI6eUXuqzBIsMwsnFlX5eKXYgGnkdwYQtEIDMxu2JtEtWEG7ULpzbdwBpp3IxoNdQPP1oBvZlNSg08rqqPOxYvw8+E0bzGQf4h48ADm7AF99swjPTx+OluU/gzY17cHtCDB7g1oUw5XDy74iJk4Kw7vt/4bk/vgzz+ZPY8K9tSDs9FJHtw6mFcKDWoBJR0d2xbtn72PmNO7dedIrN1UIEv9jTx/akenou1qY5Y8Enf0P39t5087gK3l1uxTPx45SmJrmgt3Kl4GNfitVb92DYb2fiTmphcrIyKKPZDxdv+iBplOdIXzX4QHGM5B7AScmVlmxVHJypek5bR7T0u/CrW/ti6Tuv4bv1m1FpH49nxoxHJDVZ3336MQ6f98Ut7SwTWegrZQqDC+H1jr0HEU9HTnYVZ7Ft45ewC++l3qm4egR2k645SLCia31lLmU8JymzyOB7fgi39U5AbUUu1mz9QYq3sBzKw8SdwsFjxxF7RwKefeUFyjR2kuENR7B7HdYs/xA1niGUU1ENrp66vn8MpnG16d3IMMReQCwpq1Fw2eQAAAi3SURBVJU5cA4Sj6QiLJCOlHdTcMlgplViVSWFEHQ14JSxHfMXuGPaPRNx29h7MISWomJ1mcNl/AcL5iPfMxIBnAptHYqxN+koenVpi7SjSUgpone0MC6hRTCiC2JtWiPlM65G0MhZngv9p0gQbUIV02TDIzYZ3cM9sHjxhwj47VSMuWc6RnJrU19djK8++QjbuU6/s8HMflTSU1k5OnSNxKqFizGwTw9qa4YiaNFELFvZkXv7/pg5qysBdrnRKc/G1ytXo22nSEQP7kNtz2QyCzvaUmwmGnkWgunesZ7bnTpzFXJzypQWJZ8o5YHxRG4nvfKz96J92BQEB7hT21SJngNvRy97TlalbUlG/ZFCOqS2Y15HjJxwrzLoEo3LycSdWPvZCrSNi+duSjRI4tfFQge5Vmbj5Ktm+qVVVrTcJgSHdcZHC19n4kyMSIjF9M7R1N7Q16x9NdZ+vhTz3/6CcpJIyjroF4WYnxJque2pqrYD12VYuWm7QjC3y0ujQ6YcRAyws7xzCq8lfLT0Y/jNeLgJXVd88iF25ToiisuyrdsPoG9MOIrp12bb9l1ozdlopgVvFS1jvdqFYsE776MdnWf37zsCEXTz6MixkpO6F1+cL4C9dwe2W1j/9Q8GGrkVzWX5rg/6e+1aBGY+BN8Vq1DrMwwXn6X/UxpJmQi6W0vGYeY+2tOdbgDFHSMnkaOzm/JWJqbTgipelpeBUwUuGDG8N3zFCIxqvA3U14vwK8CD4L0UdIrBlclUT3WcGydNOTU03P9e0l5ZQbgzni4UlNRfW4HIyr0BLm5Ua3KdUUFBn6x0RO5hqihCWq4ZwwfFKw9mJ6hNOFJsj+6Ud9RTLezhTjtMtlPM2EW+YaKQM6BNMOorS7DvwEFExCWgS4fW1I5U4kxGpmKUdXyuQ1gnhaxeRFXjDztT6Ps0jBaY3BzoVmJCL2mXbJnEf4kYQgmfdSFtXcg4laaDEdLWek74Sk4q8fYuoL0kvlqiyyLLTIdFIoeRfJYybdCB9Ygg1IN2J9KfOvbHkTYTh5JT0LMPNUq+Hhhy52QMieuMbd8sw2uvLEHb2K5kcBYmJO10pp0HF0zKlFy2B05ETAcdRosbTXuuHt1J+1qu7EzsYy3pk5ZrsqKrHY3YArg6ZNurTdQS+ZD+1bynnorM0YFCZzfKqOT9EEIdySnHkDB4OFr7e0EcQmWePgN71ikq3KYjVXX7iv7IGJYxLeb1EoSGGh21e5XQ+MdgGnpq8FpjDFq0/l67bhmwMOH2OdjsxeKSo0GWzALFL4I2KUe2C2rQMV1mkQOFazLRS4qLieBdz8HpCh9fb1ob0tZAZwEoc0LOUziKFkDtfrWWXvytE8tLkRFQqGodxE+seHF35ABXgXXLhBXLytLiEoVG7u3rR7sA2pmwHDGyEIalne+wDCbLmRdHTiBRj9bQv0gZ7R/UxKdhkxMZkfSviv5XxHWDCx1ae1PQq9pl3aDGezFME0tHkWuIXECsYoVOGs0lmzA48fimLEt5r09zID2s+2uTDlb94exQ50yqeZalsjQPp8964/XF89ArPADffroYryzehNjI1qo90gZBIBdZlNBPaCF1kJtbzghJHy68czH9FjcVl9LVRO2WmpjkiLKykDEiWi3VX9JNzvfIOBEuIpa65aUl6pySCG/d3NwUI5W2XK1gMI2fSUn9QJSitHvtV+JaxjQsHJsFNH4RhHtfLE9u5JuoL1fiFINpzGd9elXqlqAm7oVyLXH6v5aJbVV2Y4Zm01Tdli+MDCJ9u+QZ63spTouTPf7F06iWiS7PaP+FIdg66atvs1zr65FrW4HdFjLZDFp7tEStDFvxtuIcOHlF/lNUXouukeFcKlQh+2weVxM6VwTSL1agPW9dh7rXvxvmVybj/LWmq7TT+nnGqP5p5UseWWFKPokTWgoNrmawxTSkfK1t2q9WJ9mZEfQU0F6OPu5Kr/UvnsOs6cvWDyytAsbJfv/HQtNyL819ufRm01Tdtkej9TOX3nMgWzVb8ljnu7SlTWP0+fXXTXPJhLWOsX3fXBm24iVOTgfbcavo7+eE9OOpsOe1O4WsTfJLv3TVNUljvPW9NLa5Y/ZSzCX5rccJ88ikvlmCzA+DabTwbVxNZtLCKo1s150C/JrLKosTw4taGJnQl07q696oG1Kh9epC3wiDaeip8ROvtUF1OQL/xCKN7DcDBX5kdXAzNPFGtsFgGj9C/eZWGBKvYUgYTONHiGgk39QUuNxqytbYNpjGFbxOYRYK/enfePl6BWQzHrkJKSBMQQT7YgQn15djIFrzDaahUaIFvxpRhcDy30zVmREMCvzSKSBjWcCYxFZDxrj8v1wwmIYN6mjMQUuydS8MQ+PK2q+WX/ttLl5LN34NClwvCjTHCLR4YRjWQUvT4rV7g2loFPkJv0I8jSFov/K4/trW/U+owshqUOCaUkBjADJm5Vq7b0mlBtNoCZV0eTSGYYvIWpqWXZ9HezlamvFrUOBaUuBy400/LqUN+nv9dXPtu9TOuLmc/2bx1sTT3zd3LSSSNC1d+9Xi/81IaHT3BlLA1tjTj02tabbySZo+3vreWGlo1GvBrxBS24JYX8vjWppca0TXfiXOCAYFbhQFrMfh5e6t06zbbKw0rCmiu7dFPH2c/loek3vtv/5eV6RxaVDgulLA1ni0NW61RlmnSbx1nLHS0Kj1E36FiNqqQk9QLc6a0Po8P6EaI6tBgatGAesxaH0vFdmKs9UAg2nYooouTgipZwZakq14a6Jrz1nHa2UYvwYFrjUFWjoGmxujtuINptGCtyaE04ivz64n6I+l658zrg0KXC8K6MeodZ2XS5O8zaUbMg1rSjZz3xwBteySrv3Xx2nXxq9BgRtFAf3Y1caoPs5Wuy6Xbqw0bFGsmTiNkLZWFfpHtHwSp7/W5zGuDQpcTwq0dBy2JJ/BNK7gzWmE/THmcQVFG48YFLghFNDGdEsq/z+SRIE1Avc96QAAAABJRU5ErkJggg=='/></center>]]
end


-- Image as Base64 content
-- Example: itm.HTMLPreview.HTML = Image()
function ResolutionImage()
	return [[<center><img width='250' height='320' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPoAAAFACAYAAACVymGaAAABe2lDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx3/GiLxkwYKyuHlbzUyMmtgoM4mpWWiMMtjcueZFmXG7c4VsLJStosTG24JPwMZCWSulSMnGNyA2mq7nGBov5alznt95znn+PecPLo9umrPuLsjmbCs6FNTG4xNa5SPVuKmimQrdyJsDIyMRJL7yz3i9oUzla6/S+nv/b9RMJ/MGlFUJ9xumZQsPC7ct2KZipddoyVDCK4rTRd5UnCjy8cebWDQkfCasGRl9Wvhe2GNkrCy4lH574tub9DfOzs4bn/Oon9Qmc2OjkltltZAnyhBBNMIMEiJAN32yB/Dixycn7OSirZpDc+aSNZPO2NqAOJHUwjnD59H8Xd19oHz97VepNrcHvS9Qvl6qJbbgdA2a7kq19l2oX4WTC1O39I9SuSxXKgVPR1AXh4YrqJ7Mp3r8xR/VBqHiwXGeO6ByAwrrjvO27ziFA2kWj85zRY8+tTi8hdgyRC5hewc6Rbt+6h3AB2cADbNUywAAAAlwSFlzAAALEwAACxMBAJqcGAAAB3FpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpJbWFnZVdpZHRoPjUwMDwvdGlmZjpJbWFnZVdpZHRoPgogICAgICAgICA8dGlmZjpJbWFnZUxlbmd0aD42Mzk8L3RpZmY6SW1hZ2VMZW5ndGg+CiAgICAgICAgIDxwaG90b3Nob3A6SUNDUHJvZmlsZT5zUkdCIElFQzYxOTY2LTIuMTwvcGhvdG9zaG9wOklDQ1Byb2ZpbGU+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDxleGlmOlBpeGVsWERpbWVuc2lvbj41MDA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjE8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjYzOTwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTktMTAtMDRUMDg6MjM6MjItMDM6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE5LTEwLTA0VDA4OjIzOjIyLTAzOjAwPC94bXA6TW9kaWZ5RGF0ZT4KICAgICAgICAgPHhtcE1NOkhpc3Rvcnk+CiAgICAgICAgICAgIDxyZGY6U2VxPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHhtcE1NOnNvZnR3YXJlQWdlbnQ+QWZmaW5pdHkgUGhvdG8gKEF1ZyAxNSAyMDE5KTwveG1w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'/></center>]]
end


-- Image as Base64 content
-- Example: itm.HTMLPreview.HTML = Image()
function FormatImage()
	return [[<center><img width='230' height='281' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOYAAAEZCAYAAACD2VnDAAABe2lDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx3/GiLxkwYKyuHlbzUyMmtgoM4mpWWiMMtjcueZFmXG7c4VsLJStosTG24JPwMZCWSulSMnGNyA2mq7nGBov5alznt95znn+PecPLo9umrPuLsjmbCs6FNTG4xNa5SPVuKmimQrdyJsDIyMRJL7yz3i9oUzla6/S+nv/b9RMJ/MGlFUJ9xumZQsPC7ct2KZipddoyVDCK4rTRd5UnCjy8cebWDQkfCasGRl9Wvhe2GNkrCy4lH574tub9DfOzs4bn/Oon9Qmc2OjkltltZAnyhBBNMIMEiJAN32yB/Dixycn7OSirZpDc+aSNZPO2NqAOJHUwjnD59H8Xd19oHz97VepNrcHvS9Qvl6qJbbgdA2a7kq19l2oX4WTC1O39I9SuSxXKgVPR1AXh4YrqJ7Mp3r8xR/VBqHiwXGeO6ByAwrrjvO27ziFA2kWj85zRY8+tTi8hdgyRC5hewc6Rbt+6h3AB2cADbNUywAAAAlwSFlzAAALEwAACxMBAJqcGAAAB3FpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpJbWFnZVdpZHRoPjQ2MDwvdGlmZjpJbWFnZVdpZHRoPgogICAgICAgICA8dGlmZjpJbWFnZUxlbmd0aD41NjI8L3RpZmY6SW1hZ2VMZW5ndGg+CiAgICAgICAgIDxwaG90b3Nob3A6SUNDUHJvZmlsZT5zUkdCIElFQzYxOTY2LTIuMTwvcGhvdG9zaG9wOklDQ1Byb2ZpbGU+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDxleGlmOlBpeGVsWERpbWVuc2lvbj40NjA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjE8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjU2MjwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTktMTAtMDRUMDg6MjQ6MzctMDM6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE5LTEwLTA0VDA4OjI0OjM3LTAzOjAwPC94bXA6TW9kaWZ5RGF0ZT4KICAgICAgICAgPHhtcE1NOkhpc3Rvcnk+CiAgICAgICAgICAgIDxyZGY6U2VxPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHhtcE1NOnNvZnR3YXJlQWdlbnQ+QWZmaW5pdHkgUGhvdG8gKEF1ZyAxNSAyMDE5KTwveG1w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'/></center>]]
end


-- Image as Base64 content
-- Example: itm.HTMLPreview.HTML = Image()
function PathMapImage()
	return [[<center><img width='190' height='232' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAL4AAADoCAYAAABRo153AAABemlDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx38GmbxkMRYWFjdvqyFGTWajZiahLDQog82dO29qXm53rpCNhbJVlNh4W/AJ2Fgoa6UUKdn4BsRGup5jaAblqXOe33nOef495w8ur26amaoeyOZsKzIU0qai01rNI7VU4cZDQDcKZnBsbBSJ7/wzXm+oUPm6S2n9vf836uKJggEVbuEBw7Rs4WHhtgXbVKz0miwZSnhFcarIm4pjRT7+fDMRCQufCWtGWo8L3wt7jbSVBZfSb4+VvUmVcTYzb3zNo35Sn8hNjktuldVCgQhDhNAYYZAwfnoJyO6nCx/dcsJOLNqqOZw3l6y5VNrWguJEQhvJGd1ezdfTGwDl62+/SrX8HvS/QOV6qRbbgtM1aL4r1dp3oXEVTi5M3dI/S5WyXMkkPB1BQxQ8V1A7U0j2+Yo/qg9B9YPjPHdAzQa8rzvO277jvB9Is3h0nit69KXF4S1MLMPoJWzvQKdoN85+AB2oZy4vOJ0JAAAACXBIWXMAAAsTAAALEwEAmpwYAAAGUGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyI+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOkltYWdlV2lkdGg+Mzc5PC90aWZmOkltYWdlV2lkdGg+CiAgICAgICAgIDx0aWZmOkltYWdlTGVuZ3RoPjQ2MzwvdGlmZjpJbWFnZUxlbmd0aD4KICAgICAgICAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPnNSR0IgSUVDNjE5NjYtMi4xPC9waG90b3Nob3A6SUNDUHJvZmlsZT4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjM3OTwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+NDYzPC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxOS0xMC0wNFQwODoxNzowOS0wMzowMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTktMTAtMDRUMDg6MTc6MDktMDM6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZmZpbml0eSBQaG90byAoQXVnIDE1IDIwMTkpPC9zdEV2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'/></center>]]
end

-- Show a preview of the URL address when you "Shift + Click" a link
function DisplayHoverToolTip(x,y, url)
	-- Init UI Manager
	local ui = fu.UIManager
	local disp = bmd.UIDispatcher(ui)
	local width,height = 900,50

	hoverwin = disp:AddWindow({
		ID = 'HoverToolTipWin',
		TargetID = "HoverToolTipWin",
		Geometry = {x, y - (height/2) - 25, width, height},
		WindowFlags = {
			Popup = true,
			WindowStaysOnTopHint = true,
		},
		ui:HGroup{
			ID = 'root',
			-- Show the URL in hovering text
			ui:Label{
				Weight = 1,
				ID = "HoverLabel",
				Text = tostring(url),
				Alignment = {
					AlignHLeft= true,
					AlignVCenter = true,
				},
			},
		},
	})

	-- Enable window transparency
	-- hoverwin:SetAttribute('WA_TranslucentBackground', true)

	-- Add your GUI element based event functions here:
	local itm = hoverwin:GetItems()

	-- Add support for manually closing the window on Windows 7 
	function hoverwin.On.HoverToolTipWin.Clicked(ev)
		disp:ExitLoop()
	end

	hoverwin:Show()

	-- Pause for 1.5 seconds then close the window
	bmd.wait(1.5)
	hoverwin:Hide()
end


-- Create a UI Manager dialog
function HelpWindow()
	-- Init UI Manager
	local ui = fu.UIManager
	local disp = bmd.UIDispatcher(ui)
	local width,height = 684,740
	local x = fu:GetMousePos()[1]
	local y = fu:GetMousePos()[2]

	-- Cursor icon "click zone" offset
	local iconWidth = 15

	-- Help Resources
	local URL = 'https://www.andrewhazelden.com'

	-- Build the new window
	win = disp:AddWindow({
		ID = 'HelpWin',
		TargetID = 'HelpWin',
		WindowTitle = 'KartaVR Video Snapshot Help Window',
		-- Geometry = {x - (width / 2), y + 8, width, height},
		Geometry = {x - width - 24, y - 24, width, height},
		Events = {Close = true, KeyPress = true, KeyRelease = true,},
		Spacing = 10,

		ui:VGroup{
			ID = 'root',
			-- Add your GUI elements here:

			-- Add the main Message
			ui:TextEdit{
				ID = 'AboutText',
				ReadOnly = true,
				Alignment = {AlignHCenter = true, AlignTop = true},
				Events = {AnchorClicked = true},
				HTML = [=[
<h1>About KartaVR Video Snapshot</h1>
<h1>]=] .. tostring(_VERSION) .. [=[</h1>

<p>The "KartaVR Video Snapshot" script allows you to capture imagery from an HDMI/SDI/USB/Thunderbolt video capture device using the MacOS (AV Foundation) and Windows (DirectShow) libraries. The script has a UI Manager GUI and uses FFMPEG from the command line to do the capture task.</p>

<p>The script is compatible with Fusion 9/16 and Resolve 15/16.</p>


<h1>Screenshot</h1>

<!-- Video Snapshot Capture Window Screenshot -->
]=] .. VideoSnapshotWindowImage() .. [=[


<h1>Usage</h1>

<p>Step 1. Select the "Script &gt; KartaVR &gt; Movies &gt; Video Snapshot" menu item in Fusion to launch the script.</p>

<p>Step 2. On the top row of the Video Snapshot window you can select the "Video Input Device", then you can select the captured "Media Type", "Resolution", "FPS" (Frame Rate), and image buffer "Format". Make sure to adjust the "Capture Duration" value to define if you want single frame or multi-frame recording.</p>

<p>Step 3. Click the "Capture Image" button to frame grab footage from your video input device.</p>


<h1>GUI Controls</h1>

<h2>Video Input Device</h2>

<p>On macOS, the "Video Input Device" list includes entries like "Capture screen 0", or possibly even "Capture screen 1" or "Capture screen 2" (if you have a multi-monitor setup). You can use these capture sources to perform a monitor based frame-grab which can then be loaded back into Fusion. This can be used as a simulated input device that will let you frame grab content shown on a 2nd display by another application.</p>

<!-- Video Input Device ComboBox Screenshot -->
]=] .. VideoInputDeviceImage() ..[=[


<h2>Media Type</h2>

<p>The "Media Type" list allows you to choose the image/movie format that will be saved to disk. Options include: "JPEG Image", "PNG Image", "TIFF Image", "TGA Image", "BMP Image", "JPEG2000 Image", "GIF Movie", "MP4 H.264 Movie", "MP4 H.265 Movie", "MOV H.264 Movie", "MOV ProRes 422 Movie", and "MOV ProRes 422 HQ Movie".</p>

<!-- Media Type ComboBox Screenshot -->
]=] .. MediaTypeImage() ..[=[


<h2>Resolution</h2>

<p>The "Resolution" control allows you to set the captured image/movie's width and height.</p>

<p>Note: Some video sources are very picky about this setting so you may not get a successful capture if you set the Resolution control to a value outside of the bounds of your video input device's capabilites. In this case you will see an FFmpeg error message in the "Capture Log" window listing the issue.</p>

<!-- Resolution ComboBox Screenshot -->
]=] .. ResolutionImage() ..[=[


<h2>FPS</h2>

<p>The "FPS" control defines the video capture frame rate that is used when a movie is saved, or when an image sequence is captured.</p>

<p>Note: Some video sources are very picky about this setting so you may not get a successful capture if you set the FPS control to a value outside of the bounds of your video input device's capabilites. In this case you will see an FFmpeg error message in the "Capture Log" window listing the issue.</p>


<h2>Format</h2>

<p>The "Format" control allows you to customize the pixel format used in the video capture frame buffer. This is an advanced control you shouldn't need to adjust.</p>

<!-- Format ComboBox Screenshot -->
]=] .. FormatImage() ..[=[

<h2>PathMap</h2>

<p>The "PathMap" ComboBox menu allows you to choose a location where your media will be saved. You could choose to save your video framegrabs into the current "Comp:/" PathMap location, or to other places like your operating system's temporary folder using the "Temp:/" PathMap.</p>

<!-- PathMap ComboBox Screenshot -->
]=] .. PathMapImage() ..[=[


<h2>Image Prefix</h2>

<p>The "Image Prefix:" text field allows you to customzie the starting part of the Screenshot filename. By default this setting is "Snapshot" and will result in the incrementing filename of "Snapshot_Take_1.0001.jpg" being written to disk.</p>

<p>Note: You can add intermediate folder names at the start of the "Image Prefix" field, and each of those folders will be created on-the-fly like "Project_77/Snapshot".</p>


<h2>Take</h2>

<p>The "Take" number field control allows you to auto-increment the filename captured to disk.</p>


<h2>Cam Warmup Delay</h2>

<p>The "Cam Warmup Delay" number field expects a value entered in seconds. It is used with self-powered cameras that need a few moments to adjust auto-exposure/auto white balance after they are turned on.<p>

<p>The default "Cam Warmup Delay" value is 0.5 seconds which means after you press the "Capture Image" button, the video source is powered up immediately and an image is recorded after only 0.5 seconds of initialization time.</p>

<p>If you are capturing footage from a self-powered USB webcam, you might need to set the "Cam Warmup Delay" to a value of 1 second or 2 seconds+ so a slight a recording delay happens before the image stream is snapshotted and saved. This delay allows the camera to adjust the auto-exposure so your stop-motion style of capture has a more consistent brightness between takes.</p>


<h2>Capture Duration</h2>

<p>The "Capture Duration" number field expects a value entered in frames. The is the length of the recording.</p>


<h2>Capture Modes</h2>

<p>The "Capture Mode" label is a heads up tip that summarizes how the footage will be captured based upon the combination of the "Media Type" and "Capture Duration" settings.<p>

<p>If the "Media Type" is set to an image format, and you set the "Capture Duration" field to a value of "1", the "Capture Mode: Stop-Motion Sequence" text will appear to the right of this field. The script will then capture video frame grabs in a stop-motion-esque way so each time you hit the "Capture Image" button a new frame is added to the end of the sequence. The "Take" control is used to represent the current sequence frame number like this: "Snapshot.0001.tif", "Snapshot.0002.tif", "Snapshot.0003.tif".</p>

<p>If the "Media Type" is set to an image format, and you set the "Capture Duration" field to a value of "2" or higher, the "Capture Mode: Multi-Frame Take" text will appear to the right of this field. The script will then capture a short burst of imagery and name it as an image sequence. The "Take" control is used to separate each of the image sequences uniquely like this: "Snapshot_Take_0001.[0001-0030].tif", "Snapshot_Take_0002.[0001-0030].tif", "Snapshot_Take_0003.[0001-0030].tif".</p>

<p>If the "Media Type" is set to a movie format, the "Capture Mode: Movie Take" text will appear to the right of this field.  The script will then capture a short burst of imagery and save it to an MP4 or MOV formatted video file. The frame length of the video recording is defined by the "Capture Duration" number field's value.</p>

<h2>Overwrite Mode</h2>

<p>The "Overwrite Mode" button has a "checked" status that allows it to stay pressed/unpressed to toggle the setting.</p>

<p>If the Overwrite mode is unpressed and disabled, each new capture you do will be saved to a unique filename that will auto-increment based upon the "Take" setting.</p>

<p>If the Overwrite mode is pressed down and enabled, each new capture you do will overwrite the example same file on disk.</p>

<h2>Image Filename</h2>

<p>The "Image Filename" textual label is non-editable and is used to provide a preview of the recorded image's folder location on disk along with the auto-generated filename.</p>


<h2>Capture Image</h2>

<p>The "Capture Image" button saves a new image or movie framegrab to your chosen PathMap location using the current "Video Input Device" as your video recording source.</p>


<h2>Add Loader Node</h2>

<p>The "Add Loader Node" button will create a new Fusion Loader node in your composite and set the clip to use the current filename of your captured image sequence. The new Loader node footage will be shown automatically on the left Fusion image viewer window. Also, the Loader clip and Fusion timeline frame range will be set to the number of screenshots saved in the current sequence.</p>


<h2>Update Selected Loader</h2>

<p>The "Update Selected Loader" button allows you to refresh an existing Loader node in your composite with the revised capture settings based filename and clip frame ranges. This button is used by first selecting the Loader node in the Nodes view, and then pressing the "Update Selected Loader".</p>


<h2>Show Output Folder</h2>

<p>The "Show Output Folder" button will open up the PathMap based folder where the screenshots are saved to using a new Windows Explorer/macOS Finder based folder browser window.</p>


<h2>Edit</h2>
<p>The "Edit" button loads the "Video Snapshot.lua" script in the default script editor program that is defined in the Fusion Preferences "Global and Default Settings &gt; Script &gt; Editor Path" section.</p>


<h2>Help (?)</h2>
<p>If you click the "?" button at the top right of the Video Snapshow window, a new HTML based help documentation window will be displayed.</p>


<h2>Capture Log</h2>

<p>The "Capture Log" region is updated when the "Capture Image" button is pressed. This read-only text field shows the captured results log from each time FFmpeg is run. If you press the "Capture Image" button, and no image/movie clip is saved to disk, you can troubleshoot the issue by scrolling down in the Capture Log to see diagnostic information that indicates if an invalid combination of the "Video Input Device", "Resolution", "FPS", and "Format" controls are selected.</p>


<h1>Reactor Dependencies</h1>

<p>On Windows, the Reactor "Bin" Category based "FFmpeg" atom package is required.</p>

<p>On macOS, the Reactor "Bin" Category based "FFmpeg" atom package is required.</p>

<p>On Linux, you need to install "FFmpeg" using your operating system's package manager like yum, apt-get, or pacman.</p>


<h1>Notes</h1>

<p>If you select an image size or frame rate that is not compatible with your current video input device, the "Capture Log" at the bottom of the view will list the compatible image capture formats.</p>

<p>If you are on macOS and use a "Facetime HD Camera" as the video source you would typically select "1280x720" as the frame size, and "30.000000" frames per second as your capture settings.</p>


<h1>Tokens (Work in Progress)</h1>

<p>This script supports the use of the following pre-defined token values in the "Filename Prefix" field. If any other value is written inside the ${} token format it will be looked up as if it was an environment variable.</p>

<pre>
${COMP} - The current Fusion comp name (Composition1)
${WIDTH} - The current video capture width (1080)
${HEIGHT} - The current video capture height (1920)
${FPS} - The current frame rate (24)
${FRAME} - The current unpadded frame number (1001)
${STARTFRAME} - The global start frame (1001)
${ENDFRAME} - The global end frame (1144)
${DURATION} - The global time duration (144)
${DATE} - The date in YYYY-MM-DD format (2019-10-04)
${TIME} - The time in HH.MM.SS format (14.59.05)
${HOME} - The Home folder name (/Users/andrew)
${USER} - The current user account name (andrew)
${HOSTNAME} - The computer's host name (Pine.local)
${SEP} - The file separator slash (/ or \)
${PLATFORM} - The OS Platform (Mac/Windows/Linux)
${FUHOST} - Is Fusion or Resolve the host package (Fusion/Resolve)
${FUVERSION} - The version of Fusion/Resolve that is running (9/15/16)
</pre>


<h2>Filename Examples</h2>

<p>Filename Token Example 1:<br>
${COMP}/${DATE}_${TIME}_${COMP}_${WIDTH}x${HEIGHT}px_${FPS}fps</p>

<p>This would result in a rendered EXR image filename like:<br>
Comp:/Capture/2019-10-04_14.59.05_Capture_1920x1080px_30fps.0000.tif</p>


<h1>FFMPEG Command Prompt Based Video Capture Reference Docs</h1>

<p>You can check the ffmpeg docs for more details on how the MacOS AV Foundation and Windows DirectShow based capture workflow works from the command prompt:</p>

<a href="https://ffmpeg.org/ffmpeg-devices.html">FFmpeg Devices Documentation.</a>


<h2>macOS Capture</h2>

<p>You can generate a ffmpeg list of supported AV Foundation video capture sources in a terminal window using:</p>

<pre>
# Generate an FFMPEG Video Input List:
ffmpeg -f avfoundation -list_devices true -i "" 2>&1 | /usr/local/bin/bbedit

# Result:
[AVFoundation input device @ 0x7fbc99e00320] AVFoundation video devices:
[AVFoundation input device @ 0x7fbc99e00320] [0] Cisco VTCamera3
[AVFoundation input device @ 0x7fbc99e00320] [1] Cisco VTCamera3 #2
[AVFoundation input device @ 0x7fbc99e00320] [2] FaceTime HD Camera
[AVFoundation input device @ 0x7fbc99e00320] [3] Capture screen 0
[AVFoundation input device @ 0x7fbc99e00320] [4] Capture screen 1
[AVFoundation input device @ 0x7fbc99e00320] AVFoundation audio devices:
[AVFoundation input device @ 0x7fbc99e00320] [0] Scarlett 2i2 USB
[AVFoundation input device @ 0x7fbc99e00320] [1] Cisco VTCamera3
[AVFoundation input device @ 0x7fbc99e00320] [2] Built-in Microphone
[AVFoundation input device @ 0x7fbc99e00320] [3] Cisco VTCamera3
</pre>

<p>You can use a terminal window with ffmpeg + AV Foundation to capture a still frame from a video source in using:</p>

<pre>
# Still frame FFmpeg capture
/usr/local/bin/ffmpeg -y -f avfoundation -framerate 30.000000 -video_size 1280x720 -pixel_format uyvy422 -vsync 2 -i "default" -f image2 -vcodec mjpeg -vframes 1 -qscale:v 2 $HOME/Desktop/Snapshot.0001.jpg 2>&1</pre>


<h2>Windows Capture</h2>

<pre>
REM Generate an FFMPEG Video Input List:
"C:\ffmpeg\ffmpeg.exe" -f dshow -list_devices true -i dummy 2>&1 > device_list.txt</pre>

<pre>
REM Generate an FFMPEG Video Resolution List:
"C:\ffmpeg\ffmpeg.exe" -f dshow -i video="Integrated Camera" -list_options true 2>&1 > device_options.txt</pre>

<pre>
REM You can use a command prompt window with ffmpeg + DirectShow to capture a still frame from a video source in using:
"C:\ffmpeg\ffmpeg.exe" -y -f dshow -framerate 30 -video_size 1280x720 -vcodec mjpeg -vsync 2 -i video="Integrated Camera" -f image2 -ss 2 -pix_fmt rgb24 -compression_algo lzw -dpi 72 -vframes 1 -qscale:v 2 CAM1.%04d.tif 2>&1</pre>

or

<pre>
"C:\ffmpeg\ffmpeg.exe" -y -f dshow -framerate 30 -video_size 1280x720 -vcodec mjpeg -vsync 2 -i video="Cisco VTCamera3" -f image2 -ss 2 -pix_fmt rgb24 -compression_algo lzw -dpi 72 -vframes 1 -qscale:v 2 CAM1.%04d.tif 2>&1</pre>
]=]
			},
			-- Add clickable links
			ui:VGroup{
				Weight = 0,

				ui:Label{
					ID = "URL",
					Text = 'Web: <a style="color: rgb(139,155,216)" href="' .. URL .. '">' .. URL .. '</a>',
					Alignment = {
						AlignHCenter = true,
						AlignTop = true,
					},
					WordWrap = true,
					OpenExternalLinks = true,
				},
			},
		},
	})

	function win.On.HelpWin.Close(ev)
		disp:ExitLoop()
	end

	-- Add your GUI element based event functions here:
	local itm = win:GetItems()

	function win.On.DoneButton.Clicked(ev)
		disp:ExitLoop()
	end

	-- Track if the shift key is currently held down
	shiftKeyPressed = false

	-- The shift key was held down
	function win.On.HelpWin.KeyPress(ev)
		if ev.Key == 0x1000020 then
			shiftKeyPressed = true
		end
	end

	-- The shift key was released
	function win.On.HelpWin.KeyRelease(ev)
		if ev.Key == 0x1000020 then
			shiftKeyPressed = false
		end
	end

	-- Open an HTML link when clicked on in the HTML text area
	function win.On.AboutText.AnchorClicked(ev)
		if shiftKeyPressed == true then
			-- The shift key was pressed
			print('[URL Preview] ', ev.URL)
			
			-- Refresh the mouse position
			local mousex = fu:GetMousePos()[1] - (iconWidth)
			local mousey = fu:GetMousePos()[2] - (iconWidth)
	
			-- Show a preview of the URL address when you "Shift + Click" a link
			DisplayHoverToolTip(mousex, mousey, ev.URL)
			
			-- Force unset the Shift key pressed flag
			shiftKeyPressed = false
		else
			-- Open the URL
			bmd.openurl(ev.URL)
		end
	end


	-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the window instead of closing the foreground composite.
	app:AddConfig('HelpWin', {
		Target {
			ID = 'HelpWin',
		},

		Hotkeys {
			Target = 'HelpWin',
			Defaults = true,
			
			CONTROL_W = 'Execute{cmd = [=[app.UIManager:QueueEvent(obj, "Close", {})]=]}',
			CONTROL_F4 = 'Execute{cmd = [=[app.UIManager:QueueEvent(obj, "Close", {})]=]}',
		},
	})

	win:Show()
	disp:RunLoop()
	win:Hide()

	return win,win:GetItems()
end


-- Add a loader node to the composite based upon the current frame name
-- Example: AddSnapshotLoader('SnapshotLoader', filename)
function AddSnapshotLoader(nodeName, filename)
	print('[Add Loader Node]')

	-- Update the comp pointer to use the foreground comp
	cmp = app.CurrentComp or comp
	print('[Active Composite] ', tostring(cmp:GetAttrs()['COMPS_Name']))

	-- Lock the comp flow area
	cmp:Lock()

	-- Disable the file browser dialog
	AutoClipBrowse = fusion:GetPrefs('Global.UserInterface.AutoClipBrowse')
	fusion:SetPrefs('Global.UserInterface.AutoClipBrowse', false)

	-- Add a new loader node at the default coordinates in the Flow
	local snapshotLoader = composition:AddTool('Loader', -32768, -32768)
	if snapshotLoader then
		-- Re-enable the file browser dialog
		fusion:SetPrefs('Global.UserInterface.AutoClipBrowse', AutoClipBrowse)

		-- Rename the loader node
		snapshotLoader:SetAttrs({TOOLS_Name = nodeName, TOOLB_NameSet = true})

		-- Update the loader's clip filename
		snapshotLoader.Clip[TIME_UNDEFINED] = filename

		-- Loop the Loader node
		-- snapshotLoader:SetAttrs({TOOLBT_Clip_Loop = true})
		-- snapshotLoader.Loop = true

		-- Adjust the Loader node frame range
		if math.floor(durationFrames) >= 2 then
			-- Multi-frame (take) capture
			snapshotLoader:SetAttrs({GlobalStart = 1})
			snapshotLoader:SetAttrs({GlobalEnd = durationFrames})

			-- Update the timeline render and global ranges
			cmp:SetAttrs({COMPN_RenderStart = 1})
			cmp:SetAttrs({COMPN_RenderEnd = durationFrames})

			cmp:SetAttrs({COMPN_GlobalStart = 1})
			cmp:SetAttrs({COMPN_GlobalEnd = durationFrames - 1})
		else
			-- Single frame stop-motion capture
			snapshotLoader:SetAttrs({GlobalStart = 1})
			snapshotLoader:SetAttrs({GlobalEnd = takeNumber})

			-- Update the timeline render and global ranges
			cmp:SetAttrs({COMPN_RenderStart = 1})
			cmp:SetAttrs({COMPN_RenderEnd = takeNumber})

			cmp:SetAttrs({COMPN_GlobalStart = 1})
			cmp:SetAttrs({COMPN_GlobalEnd = takeNumber - 1})
		end

		-- Enable HiQ mode
		cmp:SetAttrs{COMPB_HiQ = true}

		-- Display the Loader node in the Viewer 1 window
		if appVersion >= 15 then
			-- Fusion 16 compatible viewer
			cmp:GetPreviewList().LeftView:ViewOn(snapshotLoader, 1)
		else
			-- Fusion 9 compatible viewer
			cmp:GetPreviewList().Left:ViewOn(snapshotLoader, 1)
		end

		-- Get the Loader frame range
		local toolAttrs = snapshotLoader:GetAttrs()
		local currentMediaStartFrameRange = toolAttrs.TOOLNT_Clip_Start[1]
		local currentMediaEndFrameRange = toolAttrs.TOOLNT_Clip_End[1]
		if currentMediaEndFrameRange <= -100000 then
			currentMediaEndFrameRange = currentMediaStartFrameRange
			snapshotLoader.GlobalEnd = currentMediaEndFrameRange 
		end

		print('[Selected Node] ', snapshotLoader.Name, '[Frame Range] ' .. tostring(currentMediaStartFrameRange) .. '-' .. tostring(currentMediaEndFrameRange))

		-- Move the timeline playhead to the current snapshot frame
		if outputImageFormat == 'mp4' or outputImageFormat == 'mov' or outputImageFormat == 'gif' then
			-- movie (take) capture
			cmp.CurrentTime = 1
		elseif math.floor(durationFrames) >= 2 then
			-- Multi-frame (take) capture
			cmp.CurrentTime = 1
		else
			-- Single frame stop-motion capture
			comp.CurrentTime = takeNumber - 1
		end
	else
		print("[Add Loader Node] Loader node pointer is a nil value.")
	end
	-- Unlock the comp flow area
	cmp:Unlock()
end


-- Update the selected loader node's time range in the comp
function UpdateLoader(nodeName, filename)
	print('[Update Loader Node]')
		
	-- Update the comp pointer to use the foreground comp
	cmp = app.CurrentComp or comp
	print('[Active Composite] ', tostring(cmp:GetAttrs()['COMPS_Name']))

	-- List the selected Node in Fusion
	selectedNode = cmp.ActiveTool
	if selectedNode then
		toolAttrs = selectedNode:GetAttrs()
		-- Read data from either a the loader and saver nodes
		if toolAttrs.TOOLS_RegID == 'Loader' then
			-- Lock the comp flow area
			cmp:Lock()

			-- Disable the file browser dialog
			AutoClipBrowse = fusion:GetPrefs('Global.UserInterface.AutoClipBrowse')
			fusion:SetPrefs('Global.UserInterface.AutoClipBrowse', false)

			-- Rename the loader node
			selectedNode:SetAttrs({TOOLS_Name = nodeName, TOOLB_NameSet = true})

			-- Update the loader's clip filename
			selectedNode.Clip[TIME_UNDEFINED] = filename

			-- Loop the Loader node
			-- selectedNode:SetAttrs({TOOLBT_Clip_Loop = true})
			-- selectedNode.Loop = true

			-- Re-enable the file browser dialog
			fusion:SetPrefs('Global.UserInterface.AutoClipBrowse', AutoClipBrowse)

			-- Adjust the Loader node frame range
			if math.floor(durationFrames) >= 2 then
				-- Multi-frame (take) capture
				selectedNode.GlobalStart = 1
				selectedNode.GlobalEnd = durationFrames

				-- Update the timeline render and global ranges
				cmp:SetAttrs({COMPN_RenderStart = 1})
				cmp:SetAttrs({COMPN_RenderEnd = durationFrames})

				cmp:SetAttrs({COMPN_GlobalStart = 1})
				cmp:SetAttrs({COMPN_GlobalEnd = durationFrames - 1})
			else
				-- Single frame stop-motion capture
				selectedNode.GlobalStart = 1
				selectedNode.GlobalEnd = takeNumber

				-- Update the timeline render and global ranges
				cmp:SetAttrs({COMPN_RenderStart = 1})
				cmp:SetAttrs({COMPN_RenderEnd = takeNumber})

				cmp:SetAttrs({COMPN_GlobalStart = 1})
				cmp:SetAttrs({COMPN_GlobalEnd = takeNumber - 1})
			end

			-- Enable HiQ mode
			cmp:SetAttrs{COMPB_HiQ = true}

			-- Display the Loader node in the Viewer 1 window
			if appVersion >= 15 then
				-- Fusion 16 compatible viewer
				cmp:GetPreviewList().LeftView:ViewOn(selectedNode, 1)
			else
				-- Fusion 9 compatible viewer
				cmp:GetPreviewList().Left:ViewOn(selectedNode, 1)
			end

			-- Move the timeline playhead to the current snapshot frame
			if math.floor(durationFrames) >= 2 then
				-- Multi-frame (take) capture
				cmp.CurrentTime = 1
			else
				-- Single frame stop-motion capture
				cmp.CurrentTime = takeNumber - 1
			end

			-- Unlock the comp flow area
			cmp:Unlock()

			-- Get the Loader frame range
			local currentMediaStartFrameRange = toolAttrs.TOOLNT_Clip_Start[1]
			local currentMediaEndFrameRange = toolAttrs.TOOLNT_Clip_End[1]
			if currentMediaEndFrameRange <= -100000 then
				currentMediaEndFrameRange = currentMediaStartFrameRange
				selectedNode.GlobalEnd = currentMediaEndFrameRange 
			end

			print('[Selected Node] ', selectedNode.Name, '[Frame Range] ' .. tostring(currentMediaStartFrameRange) .. '-' .. tostring(currentMediaEndFrameRange))
		else
			print('[Error] Please select and activate a loader node in the flow view.')
		end
	else
		print('[Error] No media node was selected. Please select and activate a loader node in the flow view.')
	end
end

-- Convert a filepath to an HTML image tag
-- Example: html = html .. AddImage('Temp:/Fusion/Screenshot.0001.jpg')
function AddImage(Imagename)
	return '<img style="padding:70px;" src="' .. comp:MapPath(Imagename) .. '" />\n'
end

-- Check the ffmpeg video device list
-- Example: VideoDeviceList()
function VideoDeviceList()
	-- Create a new empty table to hold the list of video capture devices
	videoDevicesTable = {}

	-- Create a new table to hold the list of frame sizes
	videoResolutionTable = {}
	videoResolutionTable[1] = {id = 1, resolution = '3840x2160'}
	videoResolutionTable[2] = {id = 2, resolution = '1920x1280'}
	videoResolutionTable[3] = {id = 3, resolution = '1920x1080'}
	videoResolutionTable[4] = {id = 4, resolution = '1600x1200'}
	videoResolutionTable[5] = {id = 5, resolution = '1600x1000'}
	videoResolutionTable[6] = {id = 6, resolution = '1280x800'}
	videoResolutionTable[7] = {id = 7, resolution = '1280x720'}
	videoResolutionTable[8] = {id = 8, resolution = '960x720'}
	videoResolutionTable[9] = {id = 9, resolution = '800x600'}
	videoResolutionTable[10] = {id = 10, resolution = '768x480'}
	videoResolutionTable[11] = {id = 11, resolution = '640x480'}
	videoResolutionTable[12] = {id = 12, resolution = '640x360'}
	videoResolutionTable[13] = {id = 13, resolution = '320x240'}
	videoResolutionTable[14] = {id = 14, resolution = '160x120'}

	-- Create a new table to hold the list of frame rates
	videoFrameRateTable = {
		{id = 1, fps = '120.000000'},
		{id = 2, fps = '60.000000'},
		{id = 3, fps = '59.940000'},
		{id = 4, fps = '48.000000'},
		{id = 5, fps = '30.000000'},
		{id = 6, fps = '29.970000'},
		{id = 7, fps = '25.000000'},
		{id = 8, fps = '24.000000'},
		{id = 9, fps = '23.976000'},
		{id = 10, fps = '20.000000'},
		{id = 11, fps = '18.000000'},
		{id = 12, fps = '16.000000'},
		{id = 13, fps = '15.000000'},
		{id = 14, fps = '14.000000'},
		{id = 15, fps = '12.000000'},
		{id = 16, fps = '10.000000'},
		{id = 17, fps = '7.500000'},
		{id = 18, fps = '6.000000'},
		{id = 19, fps = '5.000000'},
		{id = 20, fps = '4.000000'},
		{id = 21, fps = '1.000000'},
	}

	-- Create a new table to hold the list of pixel formats
	videoPixelFormat = {}
	videoPixelFormat[1] = {id = 1, format = 'uyvy422'}
	videoPixelFormat[2] = {id = 2, format = 'yuyv422'}
	videoPixelFormat[3] = {id = 3, format = 'rgb24'}
	videoPixelFormat[4] = {id = 4, format = '0rgb'}
	videoPixelFormat[5] = {id = 5, format = 'bgr0'}
	videoPixelFormat[6] = {id = 6, format = 'bgr24'}
	videoPixelFormat[7] = {id = 7, format = 'nv12'}
	videoPixelFormat[8] = {id = 8, format = 'yuv420p'}
	videoPixelFormat[9] = {id = 9, format = 'yuv422p'}
	videoPixelFormat[10] = {id = 10, format = 'yuv422p10le'}
	videoPixelFormat[11] = {id = 11, format = 'yuva444p10le'}
	videoPixelFormat[12] = {id = 12, format = 'gbrp10le'}

	-- Create a new table to hold the list of media types
	videoMediaType = {}
	videoMediaType[1] = {id = 1, format = 'JPEG Image', extension = 'jpg'}
	videoMediaType[2] = {id = 2, format = 'PNG Image', extension = 'png'}
	videoMediaType[3] = {id = 3, format = 'TIFF Image', extension = 'tif'}
	videoMediaType[4] = {id = 4, format = 'TGA Image', extension = 'tga'}
	videoMediaType[5] = {id = 5, format = 'BMP Image', extension = 'bmp'}
	videoMediaType[6] = {id = 6, format = 'JPEG2000 Image', extension = 'jp2'}
	videoMediaType[7] = {id = 7, format = 'GIF Movie', extension = 'gif'}
	videoMediaType[8] = {id = 8, format = 'MP4 H.264 Movie', extension = 'mp4'}
	videoMediaType[9] = {id = 9, format = 'MP4 H.265 Movie', extension = 'mp4'}
	videoMediaType[10] = {id = 10, format = 'MOV H.264 Movie', extension = 'mov'}
	videoMediaType[11] = {id = 11, format = 'MOV ProRes 422 Movie', extension = 'mov'}
	videoMediaType[12] = {id = 12, format = 'MOV ProRes 422 HQ Movie', extension = 'mov'}
	-- videoMediaType[13] = {id = 13, format = 'MOV ProRes 4444 Movie', extension = 'mov'}
	-- videoMediaType[14] = {id = 14, format = 'MOV DNxHD HD1080 Movie', extension = 'mov'}

	-- PathMap list
	PathMapTable = {}
	PathMapTable[1] = {id = 1, path = 'Comp:/'}
	PathMapTable[2] = {id = 2, path = 'Comp:/Media/'}
	PathMapTable[3] = {id = 3, path = 'Comp:/Capture/'}
	PathMapTable[4] = {id = 4, path = 'Previews:/'}
	PathMapTable[5] = {id = 5, path = 'Temp:/'}
	PathMapTable[6] = {id = 6, path = 'Temp:/KartaVR/'}
	PathMapTable[7] = {id = 7, path = 'Temp:/Fusion/'}
	PathMapTable[8] = {id = 8, path = 'Temp:/Capture/'}
	PathMapTable[9] = {id = 9, path = 'AllDocs:/'}
	PathMapTable[10] = {id = 10, path = 'UserDocs:/'}
	-- Add your own (extra) PathMap entries here:
	--PathMapTable[11] = {id = 11, path = 'Custom:/'}
	--PathMapTable[12] = {id = 12, path = 'Video:/'}

	-- Todo:
	-- List all PathMaps - Example: ==comp:GetPrefs("Global.Paths.Map")
	-- PathMapTable = comp:GetPrefs("Global.Paths.Map") or app:GetPrefs("Global.Paths.Map") 

	-- FFmpeg capture log
	videoDevicesOutputLog = app:MapPath('Temp:/KartaVR/KartaVRVideoDevicesLog.txt')
	
	local options = ''
	if platform == 'Windows' then
		-- Running on Windows
		options = options .. ' ' .. '-f dshow -list_devices true -i dummy > "' .. videoDevicesOutputLog .. '" ^2^>^&^1'
	elseif platform == 'Mac' then
		-- Running on Mac
		options = options .. ' ' .. '-f avfoundation -list_devices true -i "" 2>&1'
	else
		-- Linux
		options = options .. ' ' .. ''
	end

	local i = 1

	-- Add a 'disabled' video device
	videoDevicesTable[i] = {id = i, device = 'Disabled'}
	i = i + 1

	-- Add the supported video input devices
	if platform == 'Mac' then

		-- Add a macOS based 'default' video device
		videoDevicesTable[i] = {id = i, device = 'Default'}
		i = i + 1

		-- Verify FFmpeg is installed before trying to run it
		if ffmpegMissing == false then
			-- Scan the ffmpeg terminal output line by line
			local handler = io.popen(ffmpegProgram .. ' ' .. options)

			-- Scan the io.popen output for the remaining video devices
			for line in handler:lines() do
				-- [AVFoundation input device @ 0x7fbc99e00320] [0] Cisco VTCamera3
				searchString = '%[%d%].*$'
				rawResult = string.match(line, searchString)
				if rawResult ~= nil then
					-- print(rawResult)
					-- Example: [0] Cisco VTCamera3

					-- Trim off the ID Code trailing square bracket
					searchString = '%].*$'
					device = string.match(rawResult, searchString):sub(3)
					-- print(device)
					-- Example: Cisco VTCamera3

					-- Add a new entry to the table
					videoDevicesTable[i] = {id = i, device = device}
					-- Example: videoDevicesTable[1] = {id = 1, device = 'Cisco VTCamera3'}

					-- Increment the device counter
					i = i + 1
				end
			end
			
			-- Close the io.popen() pointer
			handler:close()
		else
			response = 'The required executable was not found at: ', defaultFFmpegProgram
			local commandResults = '[Launch Command]\n' .. tostring(ffmpegProgram) .. tostring(options) .. '\n\n[FFmpeg Results]\n'  .. tostring(response)
			itm.Result.PlainText = commandResults
			print(commandResults)
		end
	elseif platform == 'Windows' then
		-- Add a Windows based 'Integrated Camera' video device
		videoDevicesTable[i] = {id = i, device = 'Default'}
		i = i + 1

		-- Check if the "Temp:/KartaVR/" log folder exists. Create this folder if required
		logDir = app:MapPath('Temp:/KartaVR/')
		if not bmd.direxists(logDir) then
			bmd.createdir(logDir)
			print('[Created Folder] ', logDir, '\n')
		end

		-- Verify FFmpeg is installed before trying to run it
		if ffmpegMissing == false then
			-- Write out a .bat script to do the capture and collect the CLI stdin/stdout/stderr text output 
			videoDevicesBatPath = app:MapPath('Temp:/KartaVR/KartaVRVideoDevices.bat')
			videoDevicesBatFP = io.open(videoDevicesBatPath, "w")
			if videoDevicesBatFP ~= nil then
				videoDevicesBatFP:write('@echo off\n')
				videoDevicesBatFP:write('@title KartaVR Video Snapshot\n')
				videoDevicesBatFP:write('setlocal EnableDelayedExpansion\n\n')
				videoDevicesBatFP:write('echo Video Device Scan Script' .. _VERSION .. '\n')
				videoDevicesBatFP:write('echo Created by:\n')
				videoDevicesBatFP:write('echo Andrew Hazelden\n')
				videoDevicesBatFP:write('echo ----------------------------------------------------------------------\n')
				videoDevicesBatFP:write('echo This script uses FFmpeg to scan for DirectShow video input devices.\n')
				videoDevicesBatFP:write('echo echo The results are automatically loaded into the Video Snapshot GUI.\n')
				videoDevicesBatFP:write('echo ----------------------------------------------------------------------\n\n')
				videoDevicesBatFP:write('@echo on\n')
				videoDevicesBatFP:write(ffmpegProgram .. options .. '\n')
				videoDevicesBatFP:write('@echo off\n')
				videoDevicesBatFP:write('\n')
				videoDevicesBatFP:write('echo Done\n')
				videoDevicesBatFP:close()
			end

			-- Pause for a moment
			bmd.wait(0.1)
		
			-- Run the KartaVRVideoDevices.bat script
			-- if os.execute('start cmd /k call "' .. videoDevicesBatPath .. '"') then
			if os.execute('"' .. videoDevicesBatPath .. '"') then
				print('[Capture Script] Started: ', videoDevicesBatPath)
			else
				print('[Capture Script] Failed to launch: ', videoDevicesBatPath)
			end

			-- Pause for a moment
			bmd.wait(0.1)

			-- Open the "Temp:/KartaVR/KartaVRVideoDeviceLog.txt" logfile saved by Wintee
			responseFP = io.open(videoDevicesOutputLog, 'r')
			if responseFP ~= nil then
				-- valid file pointer for opening the output log file
				response = responseFP:read('*all')
				responseFP:close()
			else
				-- nil file pointer for the output log file
				response = '[Error] No FFmpeg log file saved'
			end

			-- Add the result to the FFmpeg log results TextEdit field
			local commandResults = '[Launch Command]\n' .. tostring(ffmpegProgram) .. tostring(options) .. '\n\n[FFmpeg Results]\n'  .. tostring(response)
			itm.Result.PlainText = commandResults
			print(commandResults)
		
			-- Scan for individual video input devices
			for line in io.lines(videoDevicesOutputLog) do
				-- print(line)
				-- [dshow @ 00000290ee4904c0]  "Cisco VTCamera3"
				searchString = '%[.*%]%s+"(.*)".*$'
				rawResult = string.match(line, searchString)
				if rawResult ~= nil then
					print('[Video Input Device] ', rawResult)
					-- Example: Cisco VTCamera3
				
					device = rawResult
				
					-- Add a new entry to the table
					videoDevicesTable[i] = {id = i, device = device}
					-- Example: videoDevicesTable[1] = {id = 1, device = 'Cisco VTCamera3'}

					-- Increment the device counter
					i = i + 1
				end
			end
		else
			-- Add the result to the FFmpeg log results TextEdit field
			response = 'The required executable was not found at: ', defaultFFmpegProgram
			local commandResults = '[Launch Command]\n' .. tostring(ffmpegProgram) .. tostring(options) .. '\n\n[FFmpeg Results]\n' .. tostring(response)
			itm.Result.PlainText = commandResults
			print(commandResults)
		end
	end

	-- Add the video input device entries to the ComboControl menu
	for i = 1, table.getn(videoDevicesTable) do
		itm.VideoDevicesCombo:AddItem(videoDevicesTable[i].device)
	end

	-- Add the video resolution entries to the ComboControl menu
	for i = 1, table.getn(videoResolutionTable) do
		itm.VideoResolutionCombo:AddItem(videoResolutionTable[i].resolution)
	end

	-- Add the video frame rates entries to the ComboControl menu
	for i = 1, table.getn(videoFrameRateTable) do
		itm.VideoFrameRateCombo:AddItem(videoFrameRateTable[i].fps)
	end

	-- Add the video format entries to the ComboControl menu
	for i = 1, table.getn(videoPixelFormat) do
		itm.VideoPixelFormatCombo:AddItem(videoPixelFormat[i].format)
	end

	-- Add the media type entries to the ComboControl menu
	for i = 1, table.getn(videoMediaType) do
		itm.MediaTypeCombo:AddItem(videoMediaType[i].format)
	end
	
	-- Add the PathMap entries to the ComboControl menu
	for i = 1, table.getn(PathMapTable) do
		itm.PathMapCombo:AddItem(PathMapTable[i].path)
	end

	-- Restore the settings from the prefs:
	itm.VideoResolutionCombo.CurrentIndex = defaultResolution
	-- Select a 30 fps frame rate
	itm.VideoFrameRateCombo.CurrentIndex = defaultFrameRate
	-- Select the "Default" device
	itm.VideoDevicesCombo.CurrentIndex = defaultVideoDevice
	-- Select "Temp:/KartaVR/"
	itm.PathMapCombo.CurrentIndex = defaultPathMap

	if platform == 'Mac' then
		-- Select the "uyvy422" video format
		itm.VideoPixelFormatCombo.CurrentText = 'uyvy422'
	else
		-- Windows and Linux
		-- Select the "yuyv422" video format
		itm.VideoPixelFormatCombo.CurrentText = 'yuyv422'
	end

	-- Restore the last media type
	if defaultMediaType and defaultMediaType <= 14 then
		-- Valid range
		itm.MediaTypeCombo.CurrentIndex = defaultMediaType
	else
		-- Fallback to index value 1
		itm.MediaTypeCombo.CurrentIndex = 1
		print('[Media Type] Default value out of range. Reset to an index of 1')
	end
end


-- Generate the snapshot filename
-- Example: filename, tokenFilename = FrameFilename('Snapshot')
function FrameFilename(filenamePrefix)
	-- How many digits of frame padding?
	framePadding = 4
	paddedImageNumber = string.format('%0' .. framePadding .. 'd', takeNumber)

	local filename = ''
	local tokenFilename = ''

	-- Capture mode
	if outputImageFormat == 'mp4' or outputImageFormat == 'mov' or outputImageFormat == 'gif' then
		-- Movie Capture

		-- Generate the filenames
		filename = filenamePrefix .. '_Take_' .. paddedImageNumber .. '.' .. outputImageFormat
		tokenFilename = filename
		-- Snapshot_Take_0001.mp4
	elseif math.floor(durationFrames) >= 2 then
		-- Multi-frame take capture

		-- Generate the filenames
		filename = filenamePrefix .. '_Take_' .. paddedImageNumber .. '.0001' .. '.' .. outputImageFormat
		-- Snapshot_Take_0002.0001.jpg

		-- FFmpeg naming with the un-expanded %04d token present in the generated filename
		tokenFilename = filenamePrefix ..'_Take_' .. paddedImageNumber .. '.' .. '%0' .. framePadding .. 'd' .. '.' ..outputImageFormat
		-- Snapshot_Take_0002.%04d.jpg
	else
		-- Single-frame capture (stop-motion sequence builder)

		-- Generate the filenames
		filename = filenamePrefix .. '.' .. paddedImageNumber .. '.' .. outputImageFormat
		-- Snapshot.0001.jpg
		tokenFilename = filename
		-- Snapshot.0001.jpg
	end

	return filename, tokenFilename
end


-- Get the Snapshot filepath and verify the snapshot filename is unique
-- Example: filename, tokenFilename, startframe = CheckFilename()
function CheckFilename()
	-- Generate the filename that is saved to disk
	snapshotFilenamePrefix, snapshotTokenFilenamePrefix = FrameFilename(FilenamePrefix)
	local snapshotFilename = outputDirectory .. snapshotFilenamePrefix
	-- Temp:/Fusion/Screenshot.0001.jpg
	local snapshotTokenFilename = outputDirectory .. snapshotTokenFilenamePrefix
	-- Temp:/Fusion/Screenshot.%04d.jpg

	-- Ensure the outputFilename is unique to avoid overwriting images
	if overwriteMedia == 0 then
		while eyeon.fileexists(snapshotFilename) do
			-- The Overwrite checkbox is turned off so a unique filename will be used for each capture

			-- An existing take image was found so increment the take number
			takeNumber = takeNumber + 1

			-- Grab the next filename
			snapshotFilenamePrefix, snapshotTokenFilenamePrefix = FrameFilename(FilenamePrefix)
			snapshotFilename = outputDirectory .. snapshotFilenamePrefix
			-- Temp:/Fusion/Screenshot.0001.jpg
			snapshotTokenFilename = outputDirectory .. snapshotTokenFilenamePrefix
			-- Temp:/Fusion/Screenshot.%04d.jpg
		end
	end

	return snapshotFilename, snapshotTokenFilename, takeNumber
end

-- Use ffmpeg to capture a still image
-- Example: FrameCapture('screenshot')
function FrameCapture(outputFilenamePrefix)
	-- Update the comp pointer to use the foreground comp
	cmp = app.CurrentComp or comp
	print('[Active Composite] ', tostring(cmp:GetAttrs()['COMPS_Name']))

	-- Create the temporary output folder (Also create intermediate "Image Prefix" based folders too)
	outputDirectory = cmp:MapPath(itm.PathMapCombo.CurrentText) or cmp:MapPath('Temp:/KartaVR/')
	local outputDirectoryAndFilenamePrefix = tostring(outputDirectory) .. tostring(outputFilenamePrefix)

	-- Check if paths are non-nil
	if outputDirectoryAndFilenamePrefix then
		if platform == 'Windows' then
			os.execute('mkdir "' .. Dirname(outputDirectoryAndFilenamePrefix) .. '" &')
		else
			-- Mac and Linux
			os.execute('mkdir -p "' .. Dirname(outputDirectoryAndFilenamePrefix) .. '" &')
		end

		print('[Output Folder] ', Dirname(outputDirectoryAndFilenamePrefix))
	end

	-- ffmpeg Video Source
	if itm.VideoDevicesCombo.CurrentText == 'Disabled' then
		result = '[Capture Skipped] [Video Input] ' .. itm.VideoDevicesCombo.CurrentText

		-- Add the result to the ffmpeg log results TextEdit field
		itm.Result.PlainText = result
		print(result)

		return 
	elseif itm.VideoDevicesCombo.CurrentText == 'Default' then
		if platform == 'Windows' then
			-- Windows default camera name
			videoInputName = 'Integrated Camera'
		elseif platform == 'Mac' then
			-- Mac default camera name
			videoInputName = 'default'
		end
	else
		videoInputName = itm.VideoDevicesCombo.CurrentText
		-- Example: videoInputName = 'Cisco VTCamera3'
	end

	-- FFmpeg capture video resolution
	resolution = itm.VideoResolutionCombo.CurrentText
	-- Example: resolution = '1600x1200'

	-- FFmpeg capture frame rate
	frameRate = itm.VideoFrameRateCombo.CurrentText
	-- Example: frameRate = '5.000000'

	-- FFmpeg capture pixel format
	pixelFormat = itm.VideoPixelFormatCombo.CurrentText
	-- Example: pixelFormat = 'uyvy422'

	-- FFmpeg Still image compression/extraction quality (2 = very good quality)
	quality = 2
	
	--This is set to '-vcodec mjpeg' for image format based outputs
	imageMode = ''

	-- movie / image filetype
	outputImageFormat = videoMediaType[itm.MediaTypeCombo.CurrentIndex + 1].extension
	if itm.MediaTypeCombo.CurrentIndex >= 6 then
		print('[Movie Format] ' .. tostring(itm.MediaTypeCombo.CurrentText) .. ' (.' .. tostring(outputImageFormat) .. ')')
	else
		print('[Image Format] ' .. tostring(itm.MediaTypeCombo.CurrentText) .. ' (.' .. tostring(outputImageFormat) .. ')')
	end

	-- Generate the filename that is saved to disk
	outputFilename, tokenFilename, startFrame = CheckFilename()
	-- Example: Temp:/KartaVR/Screenshot.0001.jpg

	-- Update the label to list the captured frame name
	-- itm.ImageFilepathText.Text = FrameFilename(outputFilenamePrefix)
	itm.ImageFilepathText.Text = outputFilename

	-- List if this is a multi-frame, movie or stop-motion capture
	local captureMode = 'Multi-Frame Take'
	if itm.MediaTypeCombo.CurrentIndex >= 6 then
		captureMode = 'Movie Take'
	elseif (durationFrames == 1) then
		captureMode = 'Stop-Motion Sequence'
	end
	itm.CaptureModeText.Text = captureMode

	local captureCodec = ''
	-- Image and Video capture settings
	if itm.MediaTypeCombo.CurrentIndex == 0 then
		-- JPEG image format
		captureCodec = '-f image2 -pix_fmt yuvj444p'
		imageMode = '-vcodec mjpeg'
	elseif itm.MediaTypeCombo.CurrentIndex == 3 then
		-- Targa image format
		captureCodec = '-f image2 -pix_fmt bgr24'
		imageMode = '-vcodec mjpeg'
	elseif itm.MediaTypeCombo.CurrentIndex == 4 then
		-- BMP image format
		captureCodec = '-f image2 -pix_fmt bgr24'
		imageMode = '-vcodec mjpeg'
	elseif itm.MediaTypeCombo.CurrentIndex == 5 then
		-- JPEG2000 image format
		-- captureCodec = '-f image2 -format jp2 -c:v libopenjpeg -pix_fmt rgb24'
		captureCodec = '-f image2 -format jp2 -pix_fmt rgb24'
		imageMode = '-vcodec mjpeg'
	elseif itm.MediaTypeCombo.CurrentIndex == 6 then
		-- GIF Movie (-loop 0 = infinite looping)
		captureCodec = '-vf fps=' .. math.floor(tonumber(frameRate)) .. ',scale=640:-1:flags=lanczos -loop 0'
		quality = 1
	elseif itm.MediaTypeCombo.CurrentIndex == 7 then
		-- MP4 H.264 Movie (libx264)
		captureCodec = '-f mp4 -vcodec libx264 -pix_fmt yuv420p'
		quality = 1
	elseif itm.MediaTypeCombo.CurrentIndex == 8 then
		-- MP4 H.265 Movie (libx265)
		captureCodec = '-f mp4 -vcodec libx265 -pix_fmt yuv420p'
		quality = 1
	elseif itm.MediaTypeCombo.CurrentIndex == 9 then
		-- MOV H.264 Movie (libx264)
		captureCodec = '-f mov -vcodec libx264 -pix_fmt yuv420p'
		quality = 1
	elseif itm.MediaTypeCombo.CurrentIndex == 10 then
		-- MOV ProRes 422 Movie (prores_ks)
		captureCodec = '-f mov -vcodec prores_ks -profile:v 2 -vendor ap10 -pix_fmt yuv422p10le'
		quality = 0
	elseif itm.MediaTypeCombo.CurrentIndex == 11 then
		-- MOV ProRes 422 HQ (prores_ks)
		captureCodec = '-f mov -vcodec prores_ks -profile:v 3 -vendor ap10 -pix_fmt yuv422p10le'
		quality = 0
	elseif itm.MediaTypeCombo.CurrentIndex == 12 then
		-- MOV ProRes 4444 (prores)
		captureCodec = '-f mov -vcodec prores -profile:v 4444 -vendor ap10 -pix_fmt yuva444p10le -alpha_bits 8'
		quality = 0
	elseif itm.MediaTypeCombo.CurrentIndex == 13 then
		-- MOV DNxHD HD1080
		captureCodec = '-f mov -vcodec dnxhd -s hd1080 -b:v 175M -vendor ap10 -pix_fmt yuv422p'
		quality = 1
	else
		-- image format capture
		-- captureCodec = '-f image2 -vcodec mjpeg'
		captureCodec = '-f image2 -pix_fmt rgb24'
		-- captureCodec = '-f image2'
		-- imageMode = '-vcodec mjpeg'
		imageMode = ''
	end

	local options = ''
	local command = ''
	local response = ''
	if platform == 'Windows' then
		-- Running on Windows
		-- FFmpeg capture log
		outputLog = cmp:MapPath('Temp:/KartaVR/KartaVRCaptureLog.txt')

		-- FFmpeg capture options
		-- Seek forwards 1 second in capture stream = -ss 1
		-- Maybe switch "-compression_algo lzw" to use packbits for jpeg and png?
		-- -compression_algo lzw
		-- -dpi 72
		-- -vcodec mjpeg -vsync 2
		-- ' -pixel_format ' .. pixelFormat .. 

		-- FFmpeg standard options:
		-- options = options .. ' ' .. '-y -f dshow -framerate ' .. frameRate .. ' -video_size ' .. resolution .. ' ' .. imageMode .. ' -vsync 2 -i video="' .. videoInputName .. '" ' .. captureCodec .. ' -ss ' .. warmupSeconds .. ' -vframes ' .. durationFrames .. ' -qscale:v ' .. quality .. ' "' .. tokenFilename .. '" 2>&1 | "' .. cmp:MapPath('Reactor:/Deploy/Bin/wintee/bin/wtee.exe') .. '" -a ' .. ' "' .. outputLog.. '"'

		-- Bat Script launching mode - escape the FFmpeg "%04d" specifier in the image sequence filename
		escapedTokenFilename = string.gsub(tokenFilename, '%%', '%%%%')

		-- Bat Script commands
		options = options .. ' ' .. '-y -f dshow -framerate ' .. frameRate .. ' -video_size ' .. resolution .. ' ' .. imageMode .. ' -vsync 2 -i video="' .. videoInputName .. '" ' .. captureCodec .. ' -ss ' .. warmupSeconds .. ' -vframes ' .. durationFrames .. ' -qscale:v ' .. quality .. ' "' .. escapedTokenFilename .. '" > "' .. outputLog .. '" ^2^>^&^1'

		-- Capture a single frame using ffmpeg from the terminal
		-- command = 'start "" ' .. ffmpegProgram .. options
		-- print('[Launch Command] ' .. command)
		-- os.execute(command)

		-- Write out a .bat script to do the capture and collect the CLI stdin/stdout/stderr text output 
		captureBatPath = cmp:MapPath('Temp:/KartaVR/KartaVRCapture.bat')
		captureBatFP = io.open(captureBatPath, "w")
		if captureBatFP ~= nil then
			captureBatFP:write('@echo off\n')
			captureBatFP:write('@title KartaVR Video Snapshot\n')
			captureBatFP:write('setlocal EnableDelayedExpansion\n\n')
			captureBatFP:write('echo Video Snapshot Capture Script' .. _VERSION .. '\n')
			captureBatFP:write('echo Created by:\n')
			captureBatFP:write('echo Andrew Hazelden\n')
			captureBatFP:write('echo ----------------------------------------------------------------------\n')
			captureBatFP:write('echo This script uses FFmpeg to capture imagery from a live video feed.\n')
			captureBatFP:write('echo The results are then loaded back into your active Fusion composite.\n')
			captureBatFP:write('echo ----------------------------------------------------------------------\n\n')
			captureBatFP:write('@echo on\n')
			captureBatFP:write(ffmpegProgram .. options .. '\n')
			captureBatFP:write('@echo off\n')
			captureBatFP:write('\n')
			captureBatFP:write('echo Done\n')
			captureBatFP:close()
		end

		-- Verify FFmpeg is installed before trying to run it
		if ffmpegMissing == false then
			-- Pause for a moment
			bmd.wait(0.1)

			-- Run the KartaVRCapture.bat script
			-- if os.execute('start cmd /k call "' .. captureBatPath .. '"') then
			if os.execute('"' .. captureBatPath .. '"') then
				print('[Capture Script] Started: ', captureBatPath)
			else
				print('[Capture Script] Failed to launch: ', captureBatPath)
			end

			-- Pause for a moment
			bmd.wait(0.1)

			-- Open the "Temp:/KartaVR/KartaVRCaptureLog.txt" logfile saved by Wintee
			responseFP = io.open(outputLog, 'r')
			if responseFP ~= nil then
				-- valid file pointer for opening the output log file
				response = responseFP:read('*all')
				responseFP:close()
			else
				-- nil file pointer for the output log file
				response = '[Error] No FFmpeg log file saved'
			end
		else
			response = "The FFmpeg executable is not installed at the expected filepath: ", ffmpegProgram
		end
			-- Add the result to the FFmpeg log results TextEdit field
			local commandResults = '[Launch Command]\n' .. tostring(ffmpegProgram) .. tostring(options) .. '\n\n[FFmpeg Results]\n' .. tostring(response)
			itm.Result.PlainText = commandResults
			print(commandResults)
	elseif platform == 'Mac' then
		-- Running on Mac

		-- FFmpeg sequence handling docs:
		-- https://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/image_sequence#Filename_numbering

		-- FFmpeg capture options
		options = options .. ' ' .. '-y -f avfoundation -framerate ' .. frameRate .. ' -video_size ' .. resolution .. ' -pixel_format ' .. pixelFormat .. ' -vsync 2 ' .. ' -i "' .. videoInputName .. '" ' .. captureCodec .. ' -ss ' .. warmupSeconds .. ' -vframes ' .. durationFrames .. ' -qscale:v ' .. quality .. ' "' .. tokenFilename .. '" 2>&1'

		-- Capture a single frame using ffmpeg from the terminal
		command = ffmpegProgram .. options
		print('[Launch Command] ' .. command)

		-- Verify FFmpeg is installed before trying to run it
		if ffmpegMissing == false then
			-- Run FFmpeg and grab the result
			handler = io.popen(command)
			if handler then
				response = handler:read('*a')
				handler:close()
			end
		else
			response = "The FFmpeg executable is not installed at the expected filepath: ", ffmpegProgram
		end
		
		-- Add the result to the ffmpeg log results TextEdit field
		-- Add the result to the ffmpeg log results TextEdit field
		local commandResults = '[Launch Command]\n' .. tostring(command) .. '\n[FFMpeg Results]\n' .. tostring(response)
		itm.Result.PlainText = commandResults
		print(commandResults)
		
	else
		-- Running on Linux
		options = options .. ' ' .. ''
		command = ffmpegProgram .. options

		print('[Launch Command] ' .. command)
		-- os.execute(command)
		-- response = assert(io.open(outputLog, 'r'):read'*all'))
		
		handler = io.popen(command)
		if handler then
			response = handler:read('*a')
			handler:close()
		end
		
		-- Add the result to the ffmpeg log results TextEdit field
		itm.Result.PlainText = tostring(command) .. '\n' .. tostring(response)
		print(tostring(command) .. '\n' .. tostring(response))
	end

	-- Write the take number into the window title
	itm.SnapshotWin.WindowTitle = 'KartaVR Video Snapshot |' .. ' Take ' .. tostring(takeNumber)

	-- Increment the take number
	-- takeNumber = takeNumber + 1

	-- Update the Take Number textfield
	-- itm.TakeText.Text = tostring(takeNumber)
end


-- Load the default settings from the Fusion prefs
-- Image Prefix - Example: "Snapshot"
FilenamePrefix = getPreferenceData('KartaVR.VideoSnapshot.FilenamePrefix', 'Snapshot', printStatus)

-- Capture sequence duration - Example: "1"
durationFrames = getPreferenceData('KartaVR.VideoSnapshot.DurationFrames', tonumber(1), printStatus)

-- Camera warmup delay in seconds - Example: "0.5" seconds or "2" seconds (for USB webcams)
warmupSeconds = getPreferenceData('KartaVR.VideoSnapshot.WarmupSeconds', tonumber(0.5), printStatus)

-- Should files be overwritten each time a capture is done? - Example: "0" for false, and "1" for true
overwriteMedia = getPreferenceData('KartaVR.VideoSnapshot.OverwriteMedia', tonumber(0), printStatus)

-- Initial PathMap index - Example: "1" ("Comp:/Media/")
defaultPathMap = getPreferenceData('KartaVR.VideoSnapshot.PathMap', tonumber(1), printStatus)

-- Video Input Device index
defaultVideoDevice = getPreferenceData('KartaVR.VideoSnapshot.VideoDevice', tonumber(1), printStatus)

-- Image or Movie format index
defaultMediaType = getPreferenceData('KartaVR.VideoSnapshot.MediaType', tonumber(1), printStatus)

-- Resolution index
defaultResolution = getPreferenceData('KartaVR.VideoSnapshot.Resolution', tonumber(6), printStatus)

-- FPS index = 30 FPS
defaultFrameRate = getPreferenceData('KartaVR.VideoSnapshot.FPS', tonumber(4), printStatus)


-- FFmpeg program path
defaultFFmpegProgram = ''
if platform == 'Windows' then
	-- Where is ffmpeg installed on Windows?
	defaultFFmpegProgram = comp:MapPath('Reactor:/Deploy/Bin/ffmpeg/bin/ffmpeg.exe')
	-- defaultFFmpegProgram = 'C:\\Program Files\\ffmpeg\\bin\\ffmpeg.exe'
	-- defaultFFmpegProgram = 'C:\\ffmpeg\\bin\\ffmpeg.exe'
elseif platform == 'Mac' then
	-- Where is ffmpeg installed on your MacOS?
	defaultFFmpegProgram = comp:MapPath('Reactor:/Deploy/Bin/ffmpeg/bin/ffmpeg')
	-- defaultFFmpegProgram = '/opt/local/bin/ffmpeg'
	-- defaultFFmpegProgram = '/usr/local/bin/ffmpeg'
	-- defaultFFmpegProgram = 'ffmpeg'
else
	-- Linux
	-- Where is ffmpeg installed on Linux?
	defaultFFmpegProgram = '/opt/local/bin/ffmpeg'
	-- defaultFFmpegProgram = '/usr/local/bin/ffmpeg'
	-- defaultFFmpegProgram = 'ffmpeg'
end

-- ffmpegProgram = '"' .. getPreferenceData('KartaVR.SendMedia.FFmpegFile', defaultFFmpegProgram, printStatus) .. '"'
ffmpegProgram = '"' .. defaultFFmpegProgram .. '"'

-- Was the FFmpeg executable located? 
ffmpegMissing = false

-- Check if FFmpeg was installed to a Reactor location
if bmd.fileexists(defaultFFmpegProgram) == false then
	-- FFmpeg couldn't be located on disk
	ffmpegMissing = true

	-- Fallback to using "Disabled" as the active Video Input Device index
	defaultVideoDevice = 0

	-- FFmpeg was not located
	response = 'The FFmpeg executable is not installed at the expected filepath: ', ffmpegProgram

	-- Add the result to the ffmpeg log results TextEdit field
	-- Add the result to the ffmpeg log results TextEdit field
	local commandResults = '\n[FFMpeg Results]\n' .. tostring(response)
	print(commandResults)
end




-- Get the Snapshot filepath and verify the snapshot filename is unique
filename, tokenFilename, startFrame = CheckFilename()

-- List if this is a multi-frame, movie or stop-motion capture
local captureMode = 'Multi-Frame Take'
if outputImageFormat == 'mp4' or outputImageFormat == 'mov' or outputImageFormat == 'gif' then
	captureMode = 'Movie Take'
elseif durationFrames == 1 then
	captureMode = 'Stop-Motion Sequence'
end

local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)
-- local width,height = 1400,350
local width,height = 1250,350
win = disp:AddWindow({
	ID = 'SnapshotWin',
	TargetID = 'SnapshotWin',
	WindowTitle = 'KartaVR Video Snapshot',
	Geometry = {200, 100, width, height},
	Composition = comp,

	ui:VGroup{
		ID = 'root',
		-- Add your GUI elements here:

		-- Video Capture Settings
		ui:HGroup{
			Weight = 0.1,
			-- Video input list
			ui:Label{ID = 'VideoDevicesLabel', Text = 'Video Input Device:', Weight = 0.001},
			ui:ComboBox{ID = 'VideoDevicesCombo'},

			-- Media Type List
			ui:Label{ID = 'MediaTypeText', Text = 'Media Type: ', Weight = 0.001},
			ui:ComboBox{ID = 'MediaTypeCombo'},

			-- Image Resolution list
			ui:Label{ID = 'ResolutionText', Text = 'Resolution: ', Weight = 0.001},
			ui:ComboBox{ID = 'VideoResolutionCombo'},

			-- Frame Rate list
			ui:Label{ID = 'FPSText', Text = 'FPS: ', Weight = 0.001},
			ui:ComboBox{ID = 'VideoFrameRateCombo'},

			-- Pixel Format list
			ui:Label{ID = 'PixelFormatText', Text = 'Format: ', Weight = 0.001},
			ui:ComboBox{ID = 'VideoPixelFormatCombo'},

			-- Edit Button
			ui:Button{ID = 'EditButton', Text = 'Edit', MinimumSize = {40, 24}, Weight = 0.001},

			-- Help Button
			ui:Button{ID = 'HelpButton', Text = '?', MinimumSize = {24, 24}, Weight = 0.001},
		},

		-- Frame Saving Settings
		ui:HGroup{
			Weight = 0.1,

			-- PathMap
			ui:Label{ID = 'PathMapText', Text = 'PathMap: ', Weight = 0.001},
			ui:ComboBox{ID = 'PathMapCombo'},

			-- Filename Prefix
			ui:Label{ID = 'FilenamePrefixLabel', Text = 'Filename Prefix:', Weight = 0.001},
			ui:LineEdit{ID = 'FilenamePrefixText', PlaceholderText = 'Enter a filename prefix.', Text = FilenamePrefix, Weight = 2, MinimumSize = {150, 24}},

			-- ui:HGap(0, 4),

			-- Takes
			ui:Label{ID = 'TakeLabel', Text = 'Take:', Weight = 0.001},
			ui:LineEdit{ID = 'TakeText', PlaceholderText = 'Take #', Text = tostring(takeNumber), Weight = 0.5, MinimumSize = {72, 24}, Weight = 0.001},

			-- Warmup - Camera recording start delay (in seconds)
			ui:Label{ID = 'WarmupLabel', Text = 'Cam Warmup Delay:', MinimumSize = {120, 24}, Weight = 0.001},
			ui:LineEdit{ID = 'WarmupText', PlaceholderText = 'Sec', Text = tostring(warmupSeconds), MinimumSize = {34, 24}, Weight = 0.001},

			-- Duration
			ui:Label{ID = 'DurationLabel', Text = 'Capture Duration:', Weight = 0.001},
			ui:LineEdit{ID = 'DurationText', PlaceholderText = 'Frames', Text = tostring(durationFrames), MinimumSize = {60, 24}, Weight = 0.20},

			-- Capture Mode (based upon duration being 1 frame or greater then 1 frame)
			ui:Label{ID = 'CaptureText', Text = 'Capture Mode: ', Weight = 0.001},
			ui:Label{ID = 'CaptureModeText', Text = captureMode, MinimumSize = {130, 24}, Weight = 0.001},

			-- Overwrite Media Checkbox
			ui:Button{ID = 'OverwriteButton', Text = 'Overwrite Mode', MinimumSize = {120, 24}, Flat = false, Checkable = true, Weight = 0.1},

			-- ui:HGap(0, 0.5),
		},
		ui:HGroup{
			Weight = 0.1,
			-- Saved image filename
			ui:Label{ID = 'SavedImageText', Text = 'Image Filename: ', Weight = 0.001},
			ui:Label{ID = 'ImageFilepathText', Text = filename, MinimumSize = {150, 24}, Weight = 3},

			-- ui:HGap(0, 0.5),

			-- Buttons
			ui:Button{ID = 'GoButton', Text = 'Go!', MinimumSize = {40, 24}},
			ui:Button{ID = 'CaptureImageButton', Text = 'Capture Image', MinimumSize = {150, 24}},
			ui:Button{ID = 'AddLoaderButton', Text = 'Add Loader Node', MinimumSize = {150, 24}},
			ui:Button{ID = 'UpdateSelectedLoaderButton', Text = 'Update Selected Loader', MinimumSize = {150, 24}},
			ui:Button{ID = 'ShowOutputFolderButton', Text = 'Show Output Folder', MinimumSize = {150, 24}},
		},

		-- JPEG/PNG based image preview
		-- ui:HGroup{
		--	 Weight = 0.5,
		--	 ui:TextEdit{ID = 'HTMLPreview', ReadOnly = true},
		-- },

		-- FFmpeg results log
		ui:VGroup{
			ID = 'ResultGroup',
			Weight = 4,

			-- ui:VGap(10), -- fixed 10 pixels gap

			ui:Label{ID = 'LogLabel', Text = 'Capture Log:', Weight = 0.001},
			ui:TextEdit{ID='Result', Text = '', ReadOnly = true}
		},
	},
})

-- Add your GUI element based event functions here:
itm = win:GetItems()

-- The window was closed
function win.On.SnapshotWin.Close(ev)
	disp:ExitLoop()
end

-- The filename prefix text was changed
function win.On.FilenamePrefixText.TextChanged(ev)
	setPreferenceData('KartaVR.VideoSnapshot.FilenamePrefix', tostring(itm.FilenamePrefixText.Text), printStatus)
	FilenamePrefix = tostring(itm.FilenamePrefixText.Text)
end

-- The Capture Duration text was changed
function win.On.DurationText.TextChanged(ev)
	setPreferenceData('KartaVR.VideoSnapshot.DurationFrames', tonumber(itm.DurationText.Text), printStatus)
	durationFrames = tonumber(itm.DurationText.Text)
	print('[Capture Duration] ', durationFrames)

	-- List if this is a multi-frame, movie or stop-motion capture
	local captureMode = 'Multi-Frame Take'
	if itm.MediaTypeCombo.CurrentIndex >= 6 then
		captureMode = 'Movie Take'
	elseif (durationFrames == 1) then
		captureMode = 'Stop-Motion Sequence'
	end
	itm.CaptureModeText.Text = captureMode
end

-- Camera Warmup was changed
function win.On.WarmupText.TextChanged(ev)
	setPreferenceData('KartaVR.VideoSnapshot.WarmupSeconds', tonumber(itm.WarmupText.Text), printStatus)
	warmupSeconds = tonumber(itm.WarmupText.Text)
	print('[Camera Warmup in Seconds] ',  warmupSeconds)
end

-- Take number was changed
function win.On.TakeText.TextChanged(ev)
	takeNumber = tonumber(itm.TakeText.Text)
	print('[Take Number] ', takeNumber)
end

-- Edit button was clicked
function win.On.EditButton.Clicked(ev)
	scriptPath = app:MapPath('Reactor:/Deploy/Scripts/Comp/KartaVR/Movies/Video Snapshot.lua')

	-- Open the script using Fusion's default editor in the Fusion preferences.
	editorPath = fu:GetPrefs('Global.Script.EditorPath')
	if editorPath == nil or editorPath == "" then
		comp:Print('[Script Error] The "Editor Path" is empty. Please choose a text editor in the Fusion Preferences "Global and Default Settings > Script > Editor Path" section.\n')
		app:ShowPrefs("PrefsScript")
	else
		-- Open the script for editing
		OpenDocument('Edit Script', editorPath, scriptPath)
	end
end

-- Help (?) button was clicked
function win.On.HelpButton.Clicked(ev)
	print('[Show Help]')

	-- Display a UI Manager based help window
	HelpWindow()
end

-- Overwrite (files) button was toggled
function win.On.OverwriteButton.Clicked(ev)
	if itm.OverwriteButton.Checked == true then
		-- Captured media files will be overwritten with the same filename
		overwriteMedia = 1
	else
		-- -- Captured media files will get a unique file name each time
		overwriteMedia = 0
	end

	setPreferenceData('KartaVR.VideoSnapshot.OverwriteMedia', tonumber(overwriteMedia), printStatus)
	print('[Overwrite] ' .. tostring(itm.OverwriteButton.Checked))
end



-- The "Go" button was pressed
function win.On.GoButton.Clicked(ev)
	-- Use ffmpeg to capture a still image
	FrameCapture(FilenamePrefix)

	-- Update the Take Number textfield
	itm.TakeText.Text = tostring(takeNumber)

	-- List the selected Node in Fusion 
	selectedNode = comp.ActiveTool

	if selectedNode then
		print('[Selected Node] ', selectedNode.Name)
		toolAttrs = selectedNode:GetAttrs()
	
		-- Read data from either a the loader and saver nodes
		if toolAttrs.TOOLS_RegID == 'Loader' then
			-- Add a loader node to the composite based upon the current frame name
			UpdateLoader('SnapshotLoader', itm.ImageFilepathText.Text)
		else
			-- Something other then a loader node was selected so...
			-- Add a loader node to the composite based upon the current frame name
			AddSnapshotLoader('SnapshotLoader', itm.ImageFilepathText.Text)
		end
	else
		-- Nothing was selected so...
		-- Add a loader node to the composite based upon the current frame name
		AddSnapshotLoader('SnapshotLoader', itm.ImageFilepathText.Text)
	end
end


-- The "Capture Image" button was pressed
function win.On.CaptureImageButton.Clicked(ev)
	-- Use ffmpeg to capture a still image
	FrameCapture(FilenamePrefix)

	-- Update the Take Number textfield
	itm.TakeText.Text = tostring(takeNumber)
end

-- The "Show Output Folder" button was pressed
function win.On.ShowOutputFolderButton.Clicked(ev)
	-- Update the comp pointer to use the foreground comp when resolving PathMaps in the captured image filename
	cmp = app.CurrentComp or comp
	print('[Active Composite] ', tostring(cmp:GetAttrs()['COMPS_Name']))
	
	outputDirectory = cmp:MapPath(itm.PathMapCombo.CurrentText) or cmp:MapPath('Temp:/KartaVR/')
	OpenDirectory(outputDirectory)
end

-- The "Add Loader Node" button was pressed
function win.On.AddLoaderButton.Clicked(ev)
	-- Add a loader node to the composite based upon the current frame name
	AddSnapshotLoader('SnapshotLoader', itm.ImageFilepathText.Text)

	-- Update the HTML based JPEG/PNG image preview
	-- itm.HTMLPreview.HTML = AddImage(itm.ImageFilepathText.Text)
	-- print('[HTML Preview] ', itm.HTMLPreview.HTML)
end

-- The "Update Selected Loader" button was pressed
function win.On.UpdateSelectedLoaderButton.Clicked(ev)
	-- Add a loader node to the composite based upon the current frame name
	UpdateLoader('SnapshotLoader', itm.ImageFilepathText.Text)
end

-- The "PathMap" menu was changed
function win.On.PathMapCombo.CurrentIndexChanged(ev)
	print('[PathMap] ', itm.PathMapCombo.CurrentText)

	-- Fallback to comp:MapPath('Temp:/KartaVR/') if this field is empty
	outputDirectory = comp:MapPath(itm.PathMapCombo.CurrentText) or comp:MapPath('Temp:/KartaVR/')
	setPreferenceData('KartaVR.VideoSnapshot.PathMap', tonumber(itm.PathMapCombo.CurrentIndex), printStatus)
end

function win.On.VideoPixelFormatCombo.CurrentIndexChanged(ev)
	print('[Pixel Format] ', itm.VideoPixelFormatCombo.CurrentText)
end

function win.On.VideoDevicesCombo.CurrentIndexChanged(ev)
	print('[Video Input] ', tostring(itm.VideoDevicesCombo.CurrentText) .. ' @ ' .. tostring(itm.VideoResolutionCombo.CurrentText))

	setPreferenceData('KartaVR.VideoSnapshot.VideoDevice', tonumber(itm.VideoDevicesCombo.CurrentIndex), printStatus)
end

function win.On.VideoResolutionCombo.CurrentIndexChanged(ev)
	print('[Video Input] ', tostring(itm.VideoDevicesCombo.CurrentText) .. ' @ ' .. tostring(itm.VideoResolutionCombo.CurrentText))

	setPreferenceData('KartaVR.VideoSnapshot.Resolution', tonumber(itm.VideoResolutionCombo.CurrentIndex), printStatus)
end

function win.On.VideoFrameRateCombo.CurrentIndexChanged(ev)
	print('[FPS] ', tostring(itm.VideoFrameRateCombo.CurrentText))

	setPreferenceData('KartaVR.VideoSnapshot.FPS', tonumber(itm.VideoFrameRateCombo.CurrentIndex), printStatus)
end

function win.On.MediaTypeCombo.CurrentIndexChanged(ev)
	-- Update the file extension based upon the Media Type index value
	outputImageFormat = videoMediaType[itm.MediaTypeCombo.CurrentIndex + 1].extension
	if itm.MediaTypeCombo.CurrentIndex >= 6 then
		print('[Movie Format] ', tostring(itm.MediaTypeCombo.CurrentText) .. ' (.' .. tostring(outputImageFormat) .. ')')
	else
		print('[Image Format] ', tostring(itm.MediaTypeCombo.CurrentText) .. ' (.' .. tostring(outputImageFormat) .. ')')
	end

	-- List if this is a multi-frame, movie or stop-motion capture
	local captureMode = 'Multi-Frame Take'
	if itm.MediaTypeCombo.CurrentIndex >= 6 then
		captureMode = 'Movie Take'
	elseif (durationFrames == 1) then
		captureMode = 'Stop-Motion Sequence'
	end
	itm.CaptureModeText.Text = captureMode

	setPreferenceData('KartaVR.VideoSnapshot.MediaType', tonumber(itm.MediaTypeCombo.CurrentIndex), printStatus)
end

-- Check the ffmpeg video device list
VideoDeviceList()

win:Show()

-- Adjust the colors of the ffmpeg Results area on Fusion 9+
if appVersion >= 9 then
	bgcol = {R=0.125, G=0.125, B=0.125, A=1}
	itm.Result.BackgroundColor = bgcol
	itm.Result:SetPaletteColor('All', 'Base', bgcol)
else
	print('[Warning] You should really be running Fusion 9+!')
end

-- The app:AddConfig() command that will capture the "Control + W" or "Control + F4" hotkeys so they will close the Atomizer window instead of closing the foreground composite.
app:AddConfig('SnapshotWin', {
	Target {
		ID = 'SnapshotWin',
	},

	Hotkeys {
		Target = 'SnapshotWin',
		Defaults = true,

		CONTROL_W = 'Execute{cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]]}',
		CONTROL_F4 = 'Execute{cmd = [[app.UIManager:QueueEvent(obj, "Close", {})]]}',
	},
})

disp:RunLoop()
win:Hide()
app:RemoveConfig('SnapshotWin')
collectgarbage()
