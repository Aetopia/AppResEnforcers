; Application Properties
#NoTrayIcon
#Persistent
#SingleInstance,Force
;Generates the win32options.ini if it doesn't exist.
IniRead, App_W, win32options.ini, App_Resolution, App_Width, Default
IniRead, App_H, win32options.ini, App_Resolution, App_Height, Default
IniRead, W, win32options.ini, Screen_Resolution, Width, Default
IniRead, H, win32options.ini, Screen_Resolution, Height, Default
IniRead, R, win32options.ini, Screen_Resolution, Refresh_Rate, Default
IniRead, ExeName, win32options.ini, App, Exe, Default
If (App_W = "Default" and App_H = "Default" and W = "Default" and H = "Default" and R = "Default" and ExeName = "Default"){
	IniWrite, 0, win32options.ini, App_Resolution, App_Width
	IniWrite, 0, win32options.ini, App_Resolution, App_Height
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36)
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM )
	GRR = % "" . NumGet(&dM, 120)
	IniWrite, %A_ScreenWidth%, win32options.ini, Screen_Resolution, Width
	IniWrite, %A_ScreenHeight%, win32options.ini, Screen_Resolution, Height
	IniWrite, %GRR%, win32options.ini, Screen_Resolution, Refresh_Rate
	IniWrite, 32, win32options.ini, Screen_Resolution, Color_Depth
	IniWrite, null, win32options.ini, App, Exe
}
;Defines the Function for changing the screen resolution.
ChangeResolution( cD, sW, sH, rR ) { 
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36) 
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM ), 
	NumPut(0x5c0000,dM,40) NumPut(cD,dM,104), NumPut(sW,dM,108), NumPut(sH,dM,112), NumPut(rR,dM,120) 
	Return DllCall( "ChangeDisplaySettingsA", UInt,&dM, UInt,0 ) 
}

SetTimer, Win32Active, On
SetTimer, Win32NotActive, Off
return

Win32Active:
IfWinActive, ahk_exe %ExeName%
{
	IniRead, App_W, win32options.ini, App_Resolution, App_Width, Default
	IniRead, App_H, win32options.ini, App_Resolution, App_Height, Default
	IniRead, R, win32options.ini, Screen_Resolution, Refresh_Rate, Default
	IniRead, CD, win32options.ini, Screen_Resolution, Color_Depth, Default
	ChangeResolution(CD, App_W, App_H, R)
	SetTimer, Win32NotActive, On 
	SetTimer, Win32Active, Off
}
return

Win32NotActive:
IfWinNotActive, ahk_exe %ExeName%
{
	IniRead, W, win32options.ini, Screen_Resolution, Width, Default
	IniRead, H, win32options.ini, Screen_Resolution, Height, Default
	IniRead, CD, win32options.ini, Screen_Resolution, Color_Depth, Default
	IniRead, R, win32options.ini, Screen_Resolution, Refresh_Rate, Default
     ChangeResolution(CD, W, H, R)
	SetTimer, Win32NotActive, Off 
	SetTimer, Win32Active, On
}
return
