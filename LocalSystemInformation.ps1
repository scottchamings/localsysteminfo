# Local System Information v3
# Shows details of currently running PC
# Based on Thom McKiernan 11/09/2014
# Heavily modified by Scott Chamings 14/05/2020

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$OutputFile = $DesktopPath + '\MyComputerInfo.txt'
$computerSystem = Get-CimInstance CIM_ComputerSystem
$computerBIOS = Get-CimInstance CIM_BIOSElement
$computerOS = Get-CimInstance CIM_OperatingSystem
$computerCPU = Get-CimInstance CIM_Processor
$computerHDD = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'"

# Collect Team Viewer ID
$TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\TeamViewer").ClientID
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\WOW6432Node\TeamViewer").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\WOW6432Node\TeamViewer\Version14").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\TeamViewer\Version14").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\WOW6432Node\TeamViewer\Version13").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\TeamViewer\Version13").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\WOW6432Node\TeamViewer\Version12").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\TeamViewer\Version12").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\WOW6432Node\TeamViewer\Version11").ClientID } 
if (!$TVID) { $TVID = (Get-ItemProperty -erroraction SilentlyContinue "HKLM:\SOFTWARE\TeamViewer\Version11").ClientID } 

#Write Out Computer Information to Output File
Write-Output "System Information for:" $computerSystem.Name | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "Manufacturer: " $computerSystem.Manufacturer | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "Model: " $computerSystem.Model | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "Serial Number: " $computerBIOS.SerialNumber | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "CPU: " $computerCPU.Name | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "HDD Capacity: " | out-file $OutputFile -Append
$HDDCapacity = "{0:N2}" -f ($computerHDD.Size/1GB) + "GB" 
Write-Output $HDDCapacity | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "HDD Space: " | out-file $OutputFile -Append
$HDDSpace = "{0:P2}" -f ($computerHDD.FreeSpace/$computerHDD.Size) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace/1GB) + "GB)" 
Write-Output $HDDSpace | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "RAM: " | out-file $OutputFile -Append
$RAM = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB" 
Write-Output $RAM | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "Operating System: " $computerOS.caption | out-file $OutputFile -Append
Write-Output "Architecture: " $computerOS.OSArchitecture | out-file $OutputFile -Append
Write-Output "Version: " $computerOS.Version | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "User logged In: " $computerSystem.UserName | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append

Write-Output "TeamViewerID: " $TVID | out-file $OutputFile -Append
Write-Output "----------------------------------------------------------------------" | out-file $OutputFile -Append
