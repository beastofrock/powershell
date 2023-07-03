$LogFilePath = "logging-access.txt"

while ($true) {
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Permissions = Get-MailboxFolderPermission -Identity "username:\kalender"
    $PermissionsOutput = $Permissions | Out-String
    
    # Append the timestamp and output to the log file
    $LogMessage = "Timestamp: $Timestamp`r`n$PermissionsOutput`r`n"
    Add-Content -Path $LogFilePath -Value $LogMessage
    
    # Wait for 2 minutes before running the command again
    Start-Sleep -Seconds 120
}
