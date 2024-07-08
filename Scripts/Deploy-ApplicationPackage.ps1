$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe"

$source = $args[0]
$destination = $args[1]
$recycleApp = $args[2]
$computerName = $args[3]
$username = $args[4]
$password = $args[5]
$delete = $args[6]
$skipDirectory = $args[7]

$computerNameArgument = "$computerName/MsDeploy.axd?site=$recycleApp"

$contentPath = $source

# Initialize the msdeploy arguments array
[System.Collections.ArrayList]$msdeployArguments = @(
    "-verb:sync",
    "-allowUntrusted",
    "-source:contentPath='$contentPath'",
    "-dest:auto,computerName='$computerNameArgument',username='$username',password='$password',AuthType='Basic'"
)

if ($delete -NotMatch "true") {
    $msdeployArguments.Add("-enableRule:DoNotDeleteRule")
}

if ($skipDirectory) {
    $msdeployArguments.Add("-skip:Directory='$skipDirectory'")
}

# Convert the arguments array to a single string with space-separated values
$msdeployArgumentsString = $msdeployArguments -join " "

# Execute the msdeploy command with the arguments
& $msdeploy $msdeployArgumentsString