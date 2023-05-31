#Requires -RunAsAdministrator

#OneLine
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Or
$Loc = Get-Location
"Security.Principal.Windows" | % { IEX "( [ $_`Principal ] [$_`Identity ]::GetCurrent() ).IsInRole( 'Administrator' )" } | ? {
    $True | % { $Arguments =  @('-NoProfile','-ExecutionPolicy Bypass','-NoExit','-File',"`"$($MyInvocation.MyCommand.Path)`"","\`"$Loc\`"");
    Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $Arguments; } }

$errpref = $ErrorActionPreference #Save Actual Preference
$ErrorActionPreference = "silentlycontinue"

Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"\\<exampleServer>\Resources\Ingress Preparation\Certs\SW-MS-EC.reg`"" -Wait
Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"\\<exampleServer>\Resources\Ingress Preparation\Certs\SW-MS-SC.reg`"" -Wait
Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"\\<exampleServer>\Resources\Ingress Preparation\Certs\SW-POL-EC.reg`"" -Wait
Start-Process -FilePath "cmd.exe" -ArgumentList "/c reg.exe import `"\\<exampleServer>\Resources\Ingress Preparation\Certs\SW-POL-S.reg`"" -Wait

cd "C:\Program Files\DoD-PKE\InstallRoot"

.\installroot.exe --insert

cd "C:\Temp"
xcopy "\\<exampleServer>\Resources\Ingress Preparation\Certs\DoD CA Certificate Package\0-DoD_Interoperability_Root_CA_1_SS.cer" C:\Temp
Import-Certificate -FilePath "C:\Temp\0-DoD_Interoperability_Root_CA_1_SS.cer" -CertStoreLocation Cert:\LocalMachine\Root

$ErrorActionPreference = $errpref #Restore Previous Preference