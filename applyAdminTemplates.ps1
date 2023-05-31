$errpref = $ErrorActionPreference #save actual preference
$ErrorActionPreference = "silentlycontinue"

xcopy "\\<exampleServer>\Resources\Ingress Preparation\Admin Templates\Microsoft\Office 2016\*.admx" C:\Windows\PolicyDefinitions
xcopy "\\<exampleServer>\Resources\Ingress Preparation\Admin Templates\Microsoft\Office 2016\en-US\*.adml" C:\Windows\PolicyDefinitions\en-US

xcopy "\\<exampleServer>\Resources\Ingress Preparation\Admin Templates\Security Settings\*.admx" C:\Windows\PolicyDefinitions
xcopy "\\<exampleServer>\Resources\Ingress Preparation\Admin Templates\Security Settings\en-US\*.adml" C:\Windows\PolicyDefinitions\en-US

$ErrorActionPreference = $errpref #Restore Previous Preference
