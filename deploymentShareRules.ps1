#Requires -RunAsAdministrator

# Configure NTFS Permissions for the MDT Deployment share
$DeploymentShareNTFS = "X:\DeploymentShare$" # You will need to change "X:\" to the drive letter that your $DeploymentShare folder currently resides on
icacls $DeploymentShareNTFS /grant '"Administrator":(OI)(CI)(RX)'
icacls $DeploymentShareNTFS /grant '"Administrators":(OI)(CI)(F)'
icacls $DeploymentShareNTFS /grant '"SYSTEM":(OI)(CI)(F)'
icacls "$DeploymentShareNTFS\Captures" /grant '"Administrator":(OI)(CI)(M)'

# Configure Permissions for the MDT Deployment share
$DeploymentShare = "DeploymentShare$"
Grant-SmbShareAccess -Name $DeploymentShare -AccountName "EVERYONE" -AccessRight Change -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "CREATOR OWNER" -Force
