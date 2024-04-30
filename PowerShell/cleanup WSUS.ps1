# Подключаем модуль WSUS
Import-Module UpdateServices

# Подключаемся к серверу WSUS
$wsusServer = "имя_сервера_вашего_WSUS"
$wsus = Get-WsusServer -Name $wsusServer

# Проверяем, было ли успешно выполнено подключение к серверу WSUS
if ($wsus -ne $null) {
    # Создаем каталог для журнала выполнения
    $logDirectory = "D:\systemWSUS"
    New-Item -Path $logDirectory -ItemType Directory -Force | Out-Null

    # Задаем путь к файлу журнала выполнения
    $logPath = Join-Path -Path $logDirectory -ChildPath "WSUS_Cleanup_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

    # Направляем вывод в файл журнала выполнения
    Start-Transcript -Path $logPath

    # Удаляем неиспользуемые обновления из базы данных WSUS
    Write-Host "Удаление неиспользуемых обновлений из базы данных WSUS..."
    $wsus.CleanupObsoleteUpdates()

    # Удаляем неиспользуемые компьютеры из базы данных WSUS
    Write-Host "Удаление неиспользуемых компьютеров из базы данных WSUS..."
    $wsus.CleanupObsoleteComputers()

    # Оптимизируем базу данных WSUS
    Write-Host "Оптимизация базы данных WSUS..."
    $wsus.Runspace.PerformingCleanup = $true
    $wsus.Runspace.PerformCleanup()
    $wsus.Runspace.PerformingCleanup = $false

    Write-Host "Очистка базы данных WSUS завершена."

    # Останавливаем запись в файл журнала выполнения
    Stop-Transcript
} else {
    Write-Host "Ошибка: не удалось подключиться к серверу WSUS с именем '$wsusServer'. Проверьте правильность имени сервера WSUS."
}
