# Detect-Suspicious-Windows-Log-Clearing-with-PowerShell
# WMI Event Log Clear Detection

This project provides a **PowerShell-based solution** to detect when Windows Event Logs are cleared. It uses a **persistent WMI subscription** to monitor Event IDs **104 (System/Application)** and **1102 (Security)**. Alerts are written to a log file and can optionally be forwarded to a SIEM like Splunk.

## **Features**
- Detects clearing of **System, Application, and Security logs**.
- Writes alerts to a log file: `C:\WMI_Alerts\EventLogCleared.log`.
- Optionally sends alerts to a **Splunk HTTP Event Collector (HEC)**.
- Fully persistent using **WMI Event Subscriptions**.
- Survives system reboots.

## **Requirements**
- Windows 10 or Windows Server
- PowerShell 5.x or 7.x
- Administrator privileges
- Optional: Splunk HEC for forwarding


