$CsvFilePath = "permissions.csv"

# Read the CSV file
$Permissions = Import-Csv -Path $CsvFilePath

foreach ($Permission in $Permissions) {
    $Mailbox = $Permission.Mailbox
    $User = $Permission.User
    $AccessRights = $Permission.AccessRights

    # Echo the variable values
    Write-Host "Mailbox: $Mailbox"
    Write-Host "User: $User"
    Write-Host "Access Rights: $AccessRights"
    Write-Host "--------"

    if ($Mailbox) {
        # Check if the folder permission already exists
        $ExistingPermission = Get-MailboxFolderPermission -Identity "${Mailbox}:\Kalender" -User $User -ErrorAction SilentlyContinue

        if ($ExistingPermission) {
            # If the permission exists, set the access rights
            Set-MailboxFolderPermission -Identity "${Mailbox}:\Kalender" -User $User -AccessRights $AccessRights
            Write-Host "Updated folder permission for $User on $Mailbox"
        }
        else {
            # If the permission doesn't exist, add it
            Add-MailboxFolderPermission -Identity "${Mailbox}:\Kalender" -User $User -AccessRights $AccessRights
            Write-Host "Added folder permission for $User on $Mailbox"
        }
    }
    else {
        Write-Host "Invalid Mailbox value. Skipping permission change."
    }
}
