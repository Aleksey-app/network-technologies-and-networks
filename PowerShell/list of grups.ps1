$computerName = "имя_рабочей_станции"

$groups = Get-ADPrincipalGroupMembership -Identity $computerName | Select-Object Name

foreach ($group in $groups) {
    Write-Output $group.Name
}
