$services = @(

	"AJRouter"
	"ALG"
	"bthserv"
    	"BthHFSrv"
	"MapsBroker"
	"FDResPub"
	"lfsvc"
	"vmickvpexchange"
	"vmicguestinterface"
	"vmicshutdown"
	"vmicheartbeat"
	"vmicvmsession"
	"vmicrdv"
	"vmictimesync"
	"vmicvss"
	"InstallService"
	"WpcMonSvc"
	"SEMgrSvc"
	"RmSvc"
	"RetailDemo"
	"seclogon"
	"TabletInputService"
	"UevAgentService"
	"WFDSConMgrSvc"
	"WbioSrvc"
	"FrameServer"
	"wisvc"
	"WMPNetworkSvc"
	"icssvc"
	"spectrum"
	"perceptionsimulation"
	"dot3svc"
	"workfolderssvc"
	"XboxGipSvc"
	"XblAuthManager"
	"XblGameSave"
	"XboxNetApiSvc"
    	"WwanSvc"
    	"WlanSvc"
    	"AppVClient"
    	"XboxGipSvc"
    	"MapsBroker"
   	"FDResPub"
   	"lfsvc"
    	"irmon"
    	"SCardSvr"
    	"ScDeviceEnum"
    	"SCPolicySvc"
    	"*UPNP*"
    	"*Fax*"
    	"*perceptionsimulation*"
    	"IpOverUsbSvc"
    	"WpcMonSvc"
    	"InstallService"
    	"BTAGService"
    	"*ibtsiva*"

)

foreach ($service in $services) {

    $errpref = $ErrorActionPreference #Save Actual Preference
    $ErrorActionPreference = "silentlycontinue"

    #Stop & disable services referenced in $service
    Get-Service -Name $service | Stop-Service -PassThru | Set-Service -StartupType Disabled

    $ErrorActionPreference = $errpref #Restore Previous Preference

}

