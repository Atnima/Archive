    #Get-WmiObject -ComputerName 'm354prd1' -Namespace 'root\SMS\Site_B01' -query "Select * from SMS_R_SYSTEM where SMS_R_SYSTEM.ResourceId in (SELECT ResourceId FROM SMS_CM_RES_COLL_B0100536)"

