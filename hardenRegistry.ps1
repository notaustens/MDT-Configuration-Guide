# Registry modifications present in other scripts should be consolidated to exist within this script

# OneLine
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    
# Or
$Loc = Get-Location
"Security.Principal.Windows" | % { IEX "( [ $_`Principal ] [$_`Identity ]::GetCurrent() ).IsInRole( 'Administrator' )" } | ? {
    $True | % { $Arguments =  @('-NoProfile','-ExecutionPolicy Bypass','-NoExit','-File',"`"$($MyInvocation.MyCommand.Path)`"","\`"$Loc\`"");
    Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $Arguments; } }

# Saves current error action preference
$errpref = $ErrorActionPreference
$ErrorActionPreference = "silentlycontinue"

New-Item -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog"
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security" -Name "MaxSize" -Type DWord -Value 1024000

New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1

# <serverExample> should be changed to reflect the hostname of your deployment server
Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"\\<serverExample>\Resources\Ingress Preparation\OneDrive.reg`"" -Wait 

# Disable OneDrive FilieSync via group policies (just in case)
force-mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
sp "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

# Remove remaining OneDrive files
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
rm -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"

# Reverts change made to error action preference
$ErrorActionPreference = $errpref

