$errpref = $ErrorActionPreference #Save Actual Preference
$ErrorActionPreference = "silentlycontinue"

#Relocate Useful Microsoft Office 2016 Tools

Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office Tools\Database Compare.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office Tools\Spreadsheet Compare.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2016 Tools 2016\Database Compare 2016.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2016 Tools\Spreadsheet Compare 2016.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

#Recursively remove unused Microsoft Office files from Start Menu

Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office Tools" -Recurse

Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2016 Tools" -Recurse

#Relocate Applications

Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SCAP Compliance Checker 5.7.1\SCAP Compliance Checker (SCC) 5.7.1.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
Move-Item –Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\STIG Tools\STIG Viewer.lnk" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

#Recursively remove unused SCAP files from Start Menu

Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SCAP Compliance Checker 5.7.1" -Recurse
Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\STIG Tools" -Recurse

#Hide News and Interests

Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" | select ShellFeedsTaskbarViewMode
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" | select ShellFeedsTaskbarViewMode

$ErrorActionPreference = $errpref #Restore Previous Preference