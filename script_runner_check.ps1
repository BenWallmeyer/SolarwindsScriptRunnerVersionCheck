<######################################################################
#                                                                     #
#                                                                     #
#                                                                     #
#   Herausgeber: Wallmeyer & Wallmeyer GbR                            #
#   Website: https://www.coswa.de                                     #
#   Telefon: 05921-3083753                                            #
#   E-Mail: info@coswa.de                                             #
#                                                                     #
#                                                                     #
#                                                                     #
#                                                                     #
#######################################################################>
#
param(
    $runner_version ="",
    $script_runner_path =""
)


Write-Host "Parameter Version: $runner_version"
Write-Host "Parameter Pfad: $script_runner_path"

if (!$runner_version) { 
    $runner_version = '2.18.0.25'
}
if (!$script_runner_path) { 
    $script_runner_path = 'C:\Program Files (x86)\Advanced Monitoring Agent\ScriptRunner\Scriptrunner.exe'
}
#>

$script_name = "Script Runner Version Ueberpruefung"
$script_version = "1.0"
Write-Host $script_name
Write-Host "Skriptstand: 18.02.2021 06:15"
Write-Host "Version: $script_version"



if (Test-Path $script_runner_path) {
    Write-Host 'ScriptRunner.exe wurde im angegebenen Verszeichnis gefunden'
    write-host '------------------------------' 
    Write-Host "Ueberpruefe ScriptRunner Version: $runner_version"
    write-host '------------------------------'
    $script_runner_version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($script_runner_path).FileVersion

    if ($script_runner_version -lt $runner_version) {
        write-host "Ihre ScriptRunner Version: $script_runner_version ist kleiner als die zu ueberpruefende Version: $runner_version"
        $exitcode = 2001
        $result = 1
        $bpalert = 1
        $resultstring = "Fehler"
    }
    elseif ($script_runner_version -gt $runner_version) {
        write-host "Ihre ScriptRunner Version: $script_runner_version ist groesser als die zu ueberpruefende Version: $runner_version"
        $exitcode = 2001
        $result = 1
        $bpalert = 1
        $resultstring = "Fehler"
    }
    elseif ($script_runner_version -eq $runner_version) {
        write-host "Ihre ScriptRunner Version: $script_runner_version ist gleich mit der zu ueberpruefende Version: $runner_version"
        $exitcode = 0
        $result = 0
        $bpalert = 0
        $resultstring = "Alles In Ordnung"
       
    }
    else {
        Write-Host 'Ueberpruefung unbekannt'
        $exitcode = 2001
        $result = 1
        $bpalert = 1
        $resultstring = "Fehler"
    }
}
else {
    Write-host "$script_runner_path wurde nicht gefunden"
    $exitcode = 2001
    $result = 1
    $bpalert = 1
    $resultstring = "Fehler"
}

exit $exitcode