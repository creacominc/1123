local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)
local width,height = 400,125

win = disp:AddWindow({
	ID = 'MyWin',
	WindowTitle = 'My First Window',
	Geometry = {100, 100, width, height},
	Spacing = 10,

	ui:VGroup{
		ID = 'root',
		Margin = 0,

		-- Add your GUI elements here:
		ui:LineEdit{
			ID='MyLineTxt',
			Text = 'Hello Fusioneers!',
			PlaceholderText = 'Please Enter a few words.',
			Weight = 0.5,
		},
		ui:Button{
			ID = 'PrintButton',
			Text = 'Print Text',
			Weight = 0.5,
		},
	},
})

-- The window was closed
function win.On.MyWin.Close(ev)
	disp:ExitLoop()
end

-- Add your GUI element based event functions here:
itm = win:GetItems()

function win.On.PrintButton.Clicked(ev)
	print(itm.MyLineTxt.Text)
end

function win.On.MyLineTxt.TextChanged(ev)
	print(itm.MyLineTxt.Text)
end

win:Show()
disp:RunLoop()
win:Hide()
