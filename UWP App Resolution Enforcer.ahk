; Application Properties
#NoTrayIcon
#Persistent
#SingleInstance,Force
;Generates the uwpoptions.ini if it doesn't exist.
IniRead, App_W, uwpoptions.ini, App_Resolution, App_Width, Default
IniRead, App_H, uwpoptions.ini, App_Resolution, App_Height, Default
IniRead, W, uwpoptions.ini, Screen_Resolution, Width, Default
IniRead, H, uwpoptions.ini, Screen_Resolution, Height, Default
IniRead, R, uwpoptions.ini, Screen_Resolution, Refresh_Rate, Default
IniRead, AppName, uwpoptions.ini, App, App, Default
If (App_W = "Default" and App_H = "Default" and W = "Default" and H = "Default" and R = "Default" and AppName = "Default"){
	IniWrite, 0, uwpoptions.ini, App_Resolution, App_Width
	IniWrite, 0, uwpoptions.ini, App_Resolution, App_Height
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36)
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM )
	GRR = % "" . NumGet(&dM, 120)
	IniWrite, %A_ScreenWidth%, uwpoptions.ini, Screen_Resolution, Width
	IniWrite, %A_ScreenHeight%, uwpoptions.ini, Screen_Resolution, Height
	IniWrite, %GRR%, uwpoptions.ini, Screen_Resolution, Refresh_Rate
	IniWrite, 32, uwpoptions.ini, Screen_Resolution, Color_Depth
	IniWrite, null, uwpoptions.ini, App, App
}
;Defines the Function for changing the screen resolution.
ChangeResolution( cD, sW, sH, rR ) { 
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36) 
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM ), 
	NumPut(0x5c0000,dM,40) NumPut(cD,dM,104), NumPut(sW,dM,108), NumPut(sH,dM,112), NumPut(rR,dM,120) 
	Return DllCall( "ChangeDisplaySettingsA", UInt,&dM, UInt,0 ) 
}

SetTimer, UWPActive, On
SetTimer, UWPNotActive, Off
return

UWPActive:
IfWinActive, %AppName% ahk_exe ApplicationFrameHost.exe
{
	IniRead, App_W, uwpoptions.ini, App_Resolution, App_Width, Default
	IniRead, App_H, uwpoptions.ini, App_Resolution, App_Height, Default
	IniRead, R, uwpoptions.ini, Screen_Resolution, Refresh_Rate, Default
	IniRead, CD, uwpoptions.ini, Screen_Resolution, Color_Depth, Default
	ChangeResolution(CD, App_W, App_H, R)
	SetTimer, UWPNotActive, On 
	SetTimer, UWPActive, Off
}
return

UWPNotActive:
IfWinNotActive, %AppName% ahk_exe ApplicationFrameHost.exe
{
	IniRead, W, uwpoptions.ini, Screen_Resolution, Width, Default
	IniRead, H, uwpoptions.ini, Screen_Resolution, Height, Default
	IniRead, CD, uwpoptions.ini, Screen_Resolution, Color_Depth, Default
	IniRead, R, uwpoptions.ini, Screen_Resolution, Refresh_Rate, Default
     ChangeResolution(CD, W, H, R)
	SetTimer, UWPNotActive, Off 
	SetTimer, UWPActive, On
}
return
