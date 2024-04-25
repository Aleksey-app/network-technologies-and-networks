# Функция для выполнения пинг-проверки с записью в лог
function Test-IPRange {
    param (
        [string]$StartIP,
        [string]$EndIP,
        [string]$LogFile
    )
    $ip = [System.Net.IPAddress]::Parse($StartIP)
    $endIP = [System.Net.IPAddress]::Parse($EndIP)

    while ($ip.Address -le $endIP.Address) {
        $ipStr = $ip.ToString()
        $result = Test-Connection -ComputerName $ipStr -Count 1 -Quiet
        if ($result) {
            "$ipStr is reachable" | Out-File -FilePath $LogFile -Append
        } else {
            "$ipStr is unreachable" | Out-File -FilePath $LogFile -Append
        }
        $ip = [System.Net.IPAddress]::Parse($ip.Address + 1)
    }
}
# Указать начальный и конечный IP-адреса диапазона
$StartIP = "192.168.0.1"
$EndIP = "192.168.0.10"
$LogFile = "ping_log.txt"

# Вызов функции для проверки диапазона
Test-IPRange $StartIP $EndIP $LogFile
