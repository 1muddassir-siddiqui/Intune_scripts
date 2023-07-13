# Prompt the user for confirmation before proceeding
$confirmation = Read-Host "This action will wipe your PC and restore it to factory settings. Are you sure you want to continue? (Y/N)"

if ($confirmation -eq "Y" -or $confirmation -eq "y") {
    # Initiate the factory reset
    $reset = Get-WmiObject -Namespace "root\cimv2\mdm\dmmap" -Class Win32_DeviceManagementClient | Where-Object {$_.DeviceFunction -eq "FactoryReset"}
    $reset.InvokeMethod("FactoryReset", $null)
    Write-Host "Factory reset initiated. Your PC will now restart and reset to factory settings."
} else {
    Write-Host "Factory reset cancelled."
}