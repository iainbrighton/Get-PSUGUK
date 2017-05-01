break;

Set-Location -Path '~\OneDrive\Documents\Get-PSUGUK Lability';

#region Part 1

PSEdit 'Get-PSUGUKv1.psd1','.\Get-PSUGUK.ps1';

## Import the configuration
. '.\Get-PSUGUK.ps1';

Get-ChildItem -Path Function:\Get-PS*;

## Compile the LCM configuration into .meta.mof files
Get-PSUGUKLCMConfig -OutputPath (Get-LabHostDefault).ConfigurationPath -ConfigurationData .\Get-PSUGUKv1.psd1;

## Compile the configuration into .mof files
Get-PSUGUK -OutputPath (Get-LabHostDefault).ConfigurationPath -ConfigurationData .\Get-PSUGUKv1.psd1;

#endregion Part 1

#region Part 2

Get-Command -Module Lability;

## Get the host default values
Get-LabHostDefault;

## Get the VM default values
Get-LabVMDefault;

## Ensure the host is configured correctly. You can run Start-LabHostConfiguration, but
## that's run when calling Start-LabConfiguration anyway
Test-LabHostConfiguration -Verbose;

## Looks like there's a bug in the latest xPendingReboot module!
Invoke-DscResource -Name xPendingReboot -Method Test -ModuleName xPendingReboot -Verbose -Property @{ Name = 'Something' }

## Get all the registered media definitions (.ISO, .VHD and/or .WIM files).
Get-LabMedia;

## Get all the custom/unique media definitions
Get-LabMedia -CustomOnly;

## Look at the Nano server definition
Get-LabMedia -Id 2016_x64_Datacenter_Nano_EN_Eval | Format-List;

## There is a one-to-one correlation between a media definition and an image
## Media = the source configuration/definition for a parent VHD(X) image
## Image = the resulting parent VHD(X) file, built from the media definition

## Get all the current parent/master VHD(X)images on the host
Get-LabImage

## There is currently no Nano server image present
Get-LabImage -Id 2016_x64_Datacenter_Nano_EN_Eval

#endregion Part 2

#region Part 3

## Sprinkle some Lability metadata
PSEdit '.\Get-PSUGUKv2.psd1';

## Avoid any fat finger issues and create the local Administrator password.
$localAdminPassword = ConvertTo-SecureString -String 'Passw0rd' -AsPlainText -Force;

## Start the configuration, using the supplied password. Lability prompts if local Administrator password is not supplied.
Start-LabConfiguration -ConfigurationData .\Get-PSUGUKv2.psd1 -Password $localAdminPassword -Verbose -IgnorePendingReboot | Start-VM

## Connect to a server
$localAdminCredential = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList '~\Administrator', $localAdminPassword;
Enter-PSSession -ComputerName 10.200.0.101 -Credential $localAdminCredential;
# Hostname
# Get-Module -ListAvailable
# Get-DscResource
# Get-DscConfigurationStatus | Format-List
# Test-DscConfiguration -Verbose
# Exit

#endregion Part 3

#region Part 4

## Stop the lab (can define start-up and shutdown order)
Stop-Lab -ConfigurationData .\Get-PSUGUKv2.psd1 -Verbose;

## Update the configuration with '2016_x64_Datacenter_Core_EN_Eval' media
PSEdit '.\Get-PSUGUKv3.psd1'

## Server Core image already created!
Get-LabImage -Id '2016_x64_Datacenter_Core_EN_Eval' | Format-List

## Remove and redploy the lab using the updated configuaton
Remove-LabConfiguration -ConfigurationData .\Get-PSUGUKv2.psd1 -Verbose;
$localAdminPassword = ConvertTo-SecureString -String 'Passw0rd' -AsPlainText -Force;
Start-LabConfiguration -ConfigurationData .\Get-PSUGUKv3.psd1 -Password $localAdminPassword -Verbose -IgnorePendingReboot
Start-VM -Name 'GETPSUGUK01' -Verbose

## Wait. Wait and wait a bit more to connect to a server!
$localAdminCredential = New-Object -TypeName 'System.Management.Automation.PSCredential' -ArgumentList '~\Administrator', $localAdminPassword;
Enter-PSSession -ComputerName 10.200.0.101 -Credential $localAdminCredential;

#endregion Part 4
