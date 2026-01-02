# ==========================================
# Persistent WMI Subscription â€“ Event ID 104
# ==========================================

$Name = "Detect_EventLog_Clear_104"
$LogFile = "C:\WMI_Alerts\EventLogCleared.log"
$PSExe = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

New-Item -ItemType Directory -Path (Split-Path $LogFile) -Force | Out-Null

# EVENT FILTER
$Query = @"
SELECT * FROM __InstanceCreationEvent
WITHIN 5
WHERE TargetInstance ISA 'Win32_NTLogEvent'
AND TargetInstance.EventCode = '104'
"@

$Filter = Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{
    Name           = $Name
    EventNamespace = "root\cimv2"
    QueryLanguage  = "WQL"
    Query          = $Query
}

# EVENT CONSUMER
$Command = @"
`t = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
`m = "[ALERT] Event Log Cleared | Time=`$t | Host=`$env:COMPUTERNAME"
Add-Content -Path '$LogFile' -Value `$m
"@

$Consumer = Set-WmiInstance -Namespace root\subscription -Class CommandLineEventConsumer -Arguments @{
    Name = $Name
    CommandLineTemplate = "$PSExe -NoProfile -ExecutionPolicy Bypass -Command $Command"
    RunInteractively = $false
}

# BIND FILTER TO CONSUMER
Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{
    Filter   = $Filter.__PATH
    Consumer = $Consumer.__PATH
}

Write-Host "[OK] WMI Persistent Subscription CREATED" -ForegroundColor Green
