# App Resolution Enforcers
Resolution Enforcers for both UWP and Win32 Apps.
## What do these executables do?
These executables allows you to enforce a screen resolution for a particular application which doesn't have support to be used at lower resolutions.  
Also the executables will dynamically change your screen resolution, if desired application window is inactive or closed then your screen resolution will be set to default else your screen resolution will be set to the resolution you desire to use with that application.
## How to setup?
1. First download the latest release.
2. Start up either "UWP App Resolution Enforcer.exe" or "Win32 App Resolution Enforcer.exe".  
3. You should now see uwpoptions.ini or win32options.ini generate depending on which executable you started.
4. The .ini files should look like this
   * uwpoptions.ini  
   ```
   [App_Resolution]
   App_Width=0
   App_Height=0
   [Screen_Resolution]
   Width=1920
   Height=1080
   Refresh_Rate=80
   Color_Depth=32
   [App]
   App=null
   ```
   * win32options.ini  
   ```
   [App_Resolution]
   App_Width=0
   App_Height=0
   [Screen_Resolution]
   Width=1920
   Height=1080
   Refresh_Rate=80
   Color_Depth=32
   [App]
   Exe=null
   ```
5. Enter your desired resolution's width into ```App_Width``` and height into ```App_Height```.  
Example: ```App_Width=1280``` and ```App_Height=720``` for 1280x720 resolution.

6. If you are using the "UWP App Resolution Enforcer.exe" then put in the UWP app's title name into ```App``` by replacing ```null```.  
Example: ```App=Minecraft``` for Minecraft Bedrock Edition.  

7. But if you are using the "Win32 App Resolution Enforcer.exe"  then put in the executable's name into ```Exe``` by replacing ```null```.  
Example: ```Exe=Discord.exe``` for Discord.

8. Finally save the .ini files and relaunch the executables to apply the new changes.  

9. Launch your desired application and test if the executable works or not. 
## Troubleshooting
If the executables aren't working for you then try the following;

1. Make sure you have set the correct values for `App_Width`,`App_Height` and `App` or `Exe`.
2. Also check if the respective UWP or Win32 App Resolution Enforcers are running in the background.
