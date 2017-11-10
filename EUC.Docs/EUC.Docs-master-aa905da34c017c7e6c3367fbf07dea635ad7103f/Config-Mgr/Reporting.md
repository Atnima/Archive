## Reporting

### Configuration Manager Setup

1. added a new rolled named *Report Viewers* under *Administration -> Security -> Security Roles*
    * this role includes read and run reports permissions for collections and applications
1. added a new user under *Administration -> Security -> Administrative Users* with the existing AD security group *BCC\SCCM SQL Reporting Users*, and assigned this user this new role within the default scopes
1. waited 10 minutes; SCCM updates the SQL Reporting Services permissions automatically as part of a scheduled job that runs approx. every 10 minutes

### Custom reports
The Software Licensing team use a number of custom reports. These have all been added to the *Custom Reports* folder.

#### BCC - All Add and Remove Software

~~~~ sql
SELECT      dbo.v_R_System_Valid.Netbios_Name0, dbo.v_R_System_Valid.User_Name0, dbo.v_Add_Remove_Programs.Publisher0, dbo.v_Add_Remove_Programs.DisplayName0, dbo.v_Add_Remove_Programs.Version0, dbo.v_Add_Remove_Programs.InstallDate0
FROM        dbo.v_R_System_Valid
INNER JOIN  dbo.v_Add_Remove_Programs ON dbo.v_R_System_Valid.ResourceID = dbo.v_Add_Remove_Programs.ResourceID
INNER JOIN  dbo.v_CM_RES_COLL_SMSDM003 ON dbo.v_R_System_Valid.ResourceID = dbo.v_CM_RES_COLL_SMSDM003.ResourceID
ORDER BY    dbo.v_Add_Remove_Programs.Publisher0
~~~~

#### BCC - Machines with location and serial number

~~~~ sql
select		c.Name0 as 'AssetTag',
			c.User_Name0 as 'LastLoggedOnUser',
			se.SerialNumber0 as 'SerialNumber',
			cs.Manufacturer0 as 'Manufacturer',
			cs.Model0 as 'Model',
			(select replace(replace(
						(select b.DisplayName from v_RA_System_IPSubnets ip
						inner join vSMS_Boundary b on b.Value = ip.IP_Subnets0
						where ip.ResourceID = c.ResourceID
						for xml path('')),  '<DisplayName>' , ''), '</DisplayName>' , ',')) as Location
from v_R_System c
inner join v_GS_SYSTEM_ENCLOSURE se on se.ResourceID = c.ResourceID
inner join v_GS_COMPUTER_SYSTEM cs on cs.ResourceID = c.ResourceID
~~~~

#### BCC - Machines with nnn
These reports were exported from SCCM 2007, and imported in to Config Mgr 1610. The datasets were updated, but not changes to the queries or look and feel were made.
