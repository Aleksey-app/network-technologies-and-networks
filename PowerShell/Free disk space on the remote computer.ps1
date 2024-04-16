Get-WmiObject -Class Win32_LogicalDisk -ComputerName na...me |
Select-Object -Property DeviceID, VolumeName, @{Label='Свободно (Gb)'; expression={($_.FreeSpace/1GB).ToString('F2')}},
@{Label='Всего (Gb)'; expression={($_.Size/1GB).ToString('F2')}},
@{label='Свободно %'; expression={[Math]::Round(($_.freespace / $_.size) * 100, 2).ToString('F2')+'%'}}|ft