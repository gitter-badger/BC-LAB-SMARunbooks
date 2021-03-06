workflow BugConnector-Process
{
    Param (
        [string]$SCSMServer
    )
   
    InlineScript{
        
       Write-Output "Inline Script Started!"
       
       $SCSMServer = $Using:SCSMServer
       
       Write-Output "SCSM Server set to: $SCSMSERVER"
        
       
        
       #Run Processing DTSX     
       Write-Output "Starting DTSX"
       
       $strOutput = & "DTEXEC.exe" /FILE "D:\BugZillaConnector\Process.DTSX" /REPORTING EW
       
       Write-Output "DTSX Complete"                             
                             
       #Load SCSM CMDLETS
       Write-Output "Importing SCSM Modules"
       Import-Module "D:\Service Manager\PowerShell\System.Center.Service.Manager.psd1"
      
       #Import-Module "C:\Program Files\Microsoft System Center 2012 R2\PowerShell\System.Center.Service.Manager.psd1"
       #IMPORT CSV 
       Write-Output "Beginning CSV IMPORT!"  
       Import-SCSMInstance -ComputerName $SCSMServer -DataFileName "D:\BugZillaConnector\import.csv" -FormatFileName "D:\BugZillaConnector\ProblemFormat.xml"
       Write-Output "Finished CSV IMPORT!"
        
       Start-Sleep -Seconds 10
        
        
    } 
    
    
}
