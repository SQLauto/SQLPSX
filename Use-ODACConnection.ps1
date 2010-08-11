# $default_oracleuser     = 'system'
# $default_oraclepassword = '12345'
# $default_oraclehost     = 'spaceball'


function Use-ODACConnection
{
    param(
        $tns_or_name,
        $mode = 'tns',
        $oracle_host = $null,
        $port = '1521',
        $user = $null,
        $password = $null,
        $dbaPrivilege = $null,
        [switch]$dedicated
        
    )

[System.Reflection.Assembly]::LoadWithPartialName("Oracle.DataAccess") 

if ($dedicated) { $sd = '(SERVER=DEDICATED)' } else { $sd = ''}
if (! $user) { $user = $default_oracleuser }                  
if (! $password) { $password = $default_oraclepassword }
if (! $oracle_host) { $oracle_host = $default_oraclehost }
     

switch ($mode)
{
    tns { 
        $ConnectionString = "Data Source=$($tns_or_name);User ID=$($user);Password=$($password)" 
        }
    service { 
        $ConnectionString = @"
Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$($oracle_host))(PORT=$($port))))(CONNECT_DATA=$($sd)(SERVICE_NAME=$($tns_or_name))));User ID=$($user);Password=$($password)
"@        
        }
    sid { 
        $ConnectionString = @"
Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$($oracle_host))(PORT=$($port))))(CONNECT_DATA=$($sd)(SID=$($tns_or_name))));User ID=$($user);Password=$($password)
"@

 
        }
}
if ($dbaPrivilege)
{
    $ConnectionString += ";DBA Privilege=$dbaPrivilege"
}

write-Host  "Current mode: $mode with  $ConnectionString" 
 
$conn = new-object Oracle.DataAccess.Client.OracleConnection 
$conn.ConnectionString = $ConnectionString 
$conn.Open() 
$sql  = 'SELECT upper(user) || ''@'' || global_name name FROM global_name union Select banner name from V$Version'
$sql1 = 'SELECT upper(user) || ''@'' || global_name name FROM global_name'
$sql2 = 'Select banner name from V$Version'
$cmd1 = new-object Oracle.DataAccess.Client.OracleCommand($sql1,$conn)
$cmd2 = new-object Oracle.DataAccess.Client.OracleCommand($sql2,$conn)

#	$cmd.CommandTimeout=$timeout

$ds1 = New-Object system.Data.DataSet
$ds2 = New-Object system.Data.DataSet

$da1 = New-Object Oracle.DataAccess.Client.OracleDataAdapter($cmd1)
$da1.fill($ds1) 

$da2 = New-Object Oracle.DataAccess.Client.OracleDataAdapter($cmd2)
$da2.fill($ds2) 
    
$conn.close()

$ds1.tables[0]
$ds2.tables[0]

}

<# Public Examples 

Use-ODACConnection myTSN -user myUser -pass myPassword                                         # uses TNS
Use-ODACConnection mySID   sid  -ora myHost -port 1521 -user myUser -pass myPassword           # uses SID
Use-ODACConnection myService   service  -ora myHost -port 1521 -user myUser -pass myPassword   # uses Service

Use-ODACConnection myTSN -user SYS -pass mySysPassword  -dba 'SYSDBA'                          # uses TNS & SYS as SYSDBA

#>
