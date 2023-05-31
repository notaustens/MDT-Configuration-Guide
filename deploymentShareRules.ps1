#Requires -RunAsAdministrator

# Configure NTFS Permissions for the MDT Deployment share
$DeploymentShareNTFS = "E:\DeploymentShare$"
icacls $DeploymentShareNTFS /grant '"Administrator":(OI)(CI)(RX)'
icacls $DeploymentShareNTFS /grant '"Administrators":(OI)(CI)(F)'
icacls $DeploymentShareNTFS /grant '"SYSTEM":(OI)(CI)(F)'
icacls "$DeploymentShareNTFS\Captures" /grant '"Administrator":(OI)(CI)(M)'

# Configure Permissions for the MDT Deployment share
$DeploymentShare = "DeploymentShare$"
Grant-SmbShareAccess -Name $DeploymentShare -AccountName "EVERYONE" -AccessRight Change -Force
Revoke-SmbShareAccess -Name $DeploymentShare -AccountName "CREATOR OWNER" -Force