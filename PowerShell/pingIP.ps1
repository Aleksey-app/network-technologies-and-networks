# Функция для выполнения пинг-проверки
function Test-IPRange {
    param (
        [string]$StartIP,
        [string]$EndIP
    )

    $ip = [System.Net.IPAddress]::Parse($StartIP)
    $endIP = [System.Net.IPAddress]::Parse($EndIP)

    while ($ip.Address -le $endIP.Address) {
        $ipStr = $ip.ToString()
        $result = Test-Connection -ComputerName $ipStr -Count 1 -Quiet

        if ($result) {
            Write-Host "$ipStr is reachable"
        } else {
            Write-Host "$ipStr is unreachable"
        }

        $ip = [System.Net.IPAddress]::Parse($ip.Address + 1)
    }
}

# Указать начальный и конечный IP-адреса диапазона
$StartIP = "192.168.0.1"
$EndIP = "192.168.0.10"

# Вызов функции для проверки диапазона
Test-IPRange $StartIP $EndIP
