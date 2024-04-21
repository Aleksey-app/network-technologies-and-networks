# Заданный список рабочих станций
$computers = Get-Content "C:\...\список.txt"

# Путь к файлу лога
$logPath = "C:\...\log.txt"

# Создание или очистка файла лога
New-Item -Path $logPath -ItemType File -Force

# Проход по каждой рабочей станции из списка
foreach ($computer in $computers) {
    # Попытка подключения к удаленной машине
    try {
        $disk = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $computer -Filter "DeviceID='C:'" -ErrorAction Stop
        $diskSize = [math]::Round($disk.Size / 1GB, 2)
        $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)

        # Форматирование строки для записи в лог
        $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Computer: $($computer.ToUpper()) - Disk Size: $($diskSize)GB - Free Space: $($freeSpace)GB"

        # Добавление записи в лог
        Add-Content -Path $logPath -Value $logEntry
    }
    catch {
        # Если не удалось подключиться к машине, записываем ошибку в лог
        $errorMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Error connecting to $($computer.ToUpper()): $_"
        Add-Content -Path $logPath -Value $errorMessage
    }
}

# Вывод сообщения об успешном завершении
Write-Host "Сканирование завершено. Лог сохранен по пути: $logPath"
