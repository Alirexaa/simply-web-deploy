$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe"

$source = $args[0]
$recycleApp = $args[1]
$computerName = $args[2]
$username = $args[3]
$password = $args[4]
$delete = $args[5]
$skipDirectory = $args[6]

$computerNameArgument = "$computerName/MsDeploy.axd?site=$recycleApp"
$contentPath = $source

# Initialize the msdeploy arguments array
[System.Collections.ArrayList]$msdeployArguments = @(
    "-verb:sync",
    "-allowUntrusted",
    "-source:contentPath=$contentPath",
    "-dest:contentPath=$recycleApp,computerName=$computerNameArgument/MSDeploy.axd,username=$username,password=$password,AuthType=Basic",
    "-allowUntrusted"
)

if ($delete -ne "true") {
    $msdeployArguments.Add("-enableRule:DoNotDeleteRule")
}

if ($skipDirectory) {
    $msdeployArguments.Add("-skip:Directory=$skipDirectory")
}

# Output the msdeploy command for debugging purposes
# Write-Host "Running msdeploy with the following arguments:"
# $msdeployArguments | ForEach-Object { Write-Host $_ }

# Execute the msdeploy command with the arguments
& $msdeploy @msdeployArguments