net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
rem net stop UsoSvc
net stop DoSvc
rmdir /q /s C:\Windows\SoftwareDistribution
ren C:\Windows\System32\catroot2 catroot2.old
rem rmdir /q /s C:\Windows\SoftwareDistribution.old
rmdir /q /s C:\Windows\System32\catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
rem net start UsoSvc
net start DoSvc
pause