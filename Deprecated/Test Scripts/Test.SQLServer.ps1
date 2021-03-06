CLS
. PSUnit.ps1
import-module SQLServer -force

##function Test.Get-SqlConnection_Windows([switch] $Skip)
function Test.Get-SqlConnection_Windows([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlConnection "$env:computername\sql2K8"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ServerConnection'}
}

##function Test.Get-SqlConnection_SQL([switch] $Skip)
function Test.Get-SqlConnection_SQL([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlConnection "$env:computername\sql2K8" "sa" "Passw0rd"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ServerConnection'}
}

##function Test.Get-SqlServer([switch] $Skip)
function Test.Get-SqlServer([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlServer "$env:computername\sql2K8"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Server'}
}


##function Test.Get-SqlDatabase_All([switch] $Skip)
function Test.Get-SqlDatabase_All([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2K8")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Database'}
}

##function Test.Get-SqlDatabase_ByName([switch] $Skip)
function Test.Get-SqlDatabase_ByName([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlDatabase "$env:computername\sql2K8" "pubs"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Database'}
}

##function Test.Get-SqlData_Windows([switch] $Skip)
function Test.Get-SqlData_Windows([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-sqldata "$env:computername\sql2K8" "pubs" "select * from authors")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-SqlData_SQL([switch] $Skip)
function Test.Get-SqlData_SQL([switch] $Category_GetSql)
{
    #Arrange
    $server = Get-SqlServer "$env:computername\sql2K8" "sa" "Passw0rd"
    #Act
    $Actual = (Get-sqldata $server "pubs" "select * from authors")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-SqlData_ByDatabaseObject([switch] $Skip)
function Test.Get-SqlData_ByDatabaseObject([switch] $Category_GetSql)
{
    #Arrange
    $db = Get-SqlDatabase "$env:computername\sql2K8" "pubs"
    #Act
    $Actual = (Get-sqldata  -dbname $db -qry "select * from authors")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Set-SqlData([switch] $Skip)
function Test.Set-SqlData([switch] $Category_SetSql)
{
    #Arrange
    Set-sqldata  "$env:computername\sql2K8" "pubs" "Update authors set au_lname = 'White' WHERE au_lname = 'White'"
    #Act
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Get-SqlShowMbrs([switch] $Skip)
function Test.Get-SqlShowMbrs([switch] $Category_GetSql)
{
    #Arrange
    #Manually create testgroup and populate with a user
    $server = Get-SqlServer "$env:computername\SQL2K8"
    #Act
    $Actual = (Get-SqlShowMbrs $server "$env:computername\TestGroup")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue -eq 'Z002\TestGroup'}
}

##function Test.Get-SqlUser([switch] $Skip)
function Test.Get-SqlUser([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\SQL2K8" pubs | Get-SqlUser)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'User'}
}


##function Test.Get-SqlDatabaseRole([switch] $Skip)
function Test.Get-SqlDatabaseRole([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\SQL2K8" pubs | Get-SqlDatabaseRole)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DatabaseRole'}
}

##function Test.Get-SqlLogin([switch] $Skip)
function Test.Get-SqlLogin([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (SqlLogin "$env:computername\SQL2K8")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Login'}
}

##function Test.Get-SqlLinkedServerLogin([switch] $Skip)
function Test.Get-SqlLinkedServerLogin([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = SqlLinkedServerLogin "$env:computername\SQL2K8"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'LinkedServerLogin'}
}

##function Test.Get-SqlServerRole([switch] $Skip)
function Test.Get-SqlServerRole([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (SqlServerRole "$env:computername\SQL2K8")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ServerRole'}
}

##function Test.Get-SqlServerPermission([switch] $Skip)
function Test.Get-SqlServerPermission([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (SqlServerPermission "$env:computername\SQL2K8")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ServerPermissionInfo'}
}

##function Test.Get-SqlDatabasePermission([switch] $Skip)
function Test.Get-SqlDatabasePermission([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\SQL2K8" pubs | Get-SqlDatabasePermission)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DatabasePermissionInfo'}
}

##function Test.Get-SqlObjectPermission([switch] $Skip)
function Test.Get-SqlObjectPermission([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\SQL2K8" pubs | Get-SqlObjectPermission)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ObjectPermissionInfo'}
}

##function Test.Get-SqlTable([switch] $Skip)
function Test.Get-SqlTable([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name "authors"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Table'}
}

##function Test.Get-SqlStoredProcedure([switch] $Skip)
function Test.Get-SqlStoredProcedure([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlStoredProcedure -name "byroyalty"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'StoredProcedure'}
}

##function Test.Get-SqlView([switch] $Skip)
function Test.Get-SqlView([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlView -name "titleview"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'View'}
}

##function Test.Get-SqlUserDefinedDataType([switch] $Skip)
function Test.Get-SqlUserDefinedDataType([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlUserDefinedDataType -name "empid")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'UserDefinedDataType'}
}

##function Test.Get-SqlUserDefinedFunction([switch] $Skip)
function Test.Get-SqlUserDefinedFunction([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "AdventureWorks" | Get-SqlUserDefinedFunction -name "ufnGetAccountingEndDate"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'UserDefinedFunction'}
}


##function Test.Get-SqlSynonym([switch] $Skip)
function Test.Get-SqlSynonym([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlSynonym
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Synonym'}
}

##function Test.Get-SqlSynonym([switch] $Skip)
function Test.Get-SqlSynonym([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlSynonym
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Synonym'}
}

##function Test.Get-SqlTrigger_Database([switch] $Skip)
function Test.Get-SqlTrigger_Database([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTrigger -name tr_MStran_alterview 
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DatabaseDdlTrigger'}
}

##function Test.Get-SqlTrigger_Table([switch] $Skip)
function Test.Get-SqlTrigger_Table([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual =  Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable | Get-SqlTrigger
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Trigger'}
}

##function Test.Get-SqlColumn([switch] $Skip)
function Test.Get-SqlColumn([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name "authors" | Get-SqlColumn)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Column'}
}

##function Test.Get-SqlIndex([switch] $Skip)
function Test.Get-SqlIndex([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name "authors" | Get-SqlIndex)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Index'}
}

##function Test.Get-SqlStatistic([switch] $Skip)
function Test.Get-SqlStatistic([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "Northwind" | Get-SqlTable | Get-SqlStatistic)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Statistic'}
}

##function Test.Get-SqlCheck([switch] $Skip)
function Test.Get-SqlCheck([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable | Get-SqlCheck)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Check'}
}

##function Test.Get-SqlForeignKey([switch] $Skip)
function Test.Get-SqlForeignKey([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable | Get-SqlForeignKey)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'ForeignKey'}
}

##function Test.Get-SqlScripter([switch] $Skip)
function Test.Get-SqlScripter([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name "authors" | Get-SqlScripter)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'String'}
}

##function Test.Get-Information_Schema.Tables([switch] $Skip)
function Test.Get-Information_Schema.Tables([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-Information_Schema.Tables)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-Information_Schema.Columns([switch] $Skip)
function Test.Get-Information_Schema.Columns([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-Information_Schema.Columns)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}


##function Test.Get-Information_Schema.Views([switch] $Skip)
function Test.Get-Information_Schema.Views([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-Information_Schema.Views
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-Information_Schema.Routines([switch] $Skip)
function Test.Get-Information_Schema.Routines([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-Information_Schema.Routines)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}


##function Test.Get-SysDatabases([switch] $Skip)
function Test.Get-SysDatabases([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SysDatabases "$env:computername\sql2k8" )[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-SqlDataFile([switch] $Skip)
function Test.Get-SqlDataFile([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlDataFile
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataFile'}
}

##function Test.Get-SqlLogFile([switch] $Skip)
function Test.Get-SqlLogFile([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlLogFile
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'LogFile'}
}

##function Test.Get-sqlversion([switch] $Skip)
function Test.Get-sqlversion([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-sqlversion "$env:computername\sql2k8"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'PSCustomObject'}
}

##function Test.Get-sqlport([switch] $Skip)
function Test.Get-sqlport([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-sqlport "$env:computername\sql2k8"
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'PSCustomObject'}
}

##function Test.Get-Sql([switch] $Skip)
function Test.Get-Sql([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-Sql $env:computername)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'PSCustomObject'}
}

##function Test.Invoke-SqlDatabaseCheck([switch] $Skip)
function Test.Invoke-SqlDatabaseCheck([switch] $Category_InvokeSql)
{
    #Arrange
    #Act
    Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Invoke-SqlDatabaseCheck
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Invoke-SqlIndexRebuild([switch] $Skip)
function Test.Invoke-SqlIndexRebuild([switch] $Category_InvokeSql)
{
    #Arrange
    #Act
    Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name authors | Get-SqlIndex |  Invoke-SqlIndexRebuild
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Invoke-SqlIndexDefrag([switch] $Skip)
function Test.Invoke-SqlIndexDefrag([switch] $Category_InvokeSql)
{
    #Arrange
    #Act
    Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name authors | Get-SqlIndex |  Invoke-SqlIndexDefrag
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Get-SqlIndexFragmentation([switch] $Skip)
function Test.Get-SqlIndexFragmentation([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "pubs" | Get-SqlTable -name authors | Get-SqlIndex |  Get-SqlIndexFragmentation)[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.update-sqlstatistic([switch] $Skip)
function Test.update-sqlstatistic([switch] $Category_UpdateSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlDatabase "$env:computername\sql2k8" "Northwind" | Get-SqlTable | Get-SqlStatistic)[0] | update-sqlstatistic
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Invoke-SqlBackup([switch] $Skip)
function Test.Invoke-SqlBackup([switch] $Category_InvokeSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    #Act
    Invoke-SqlBackup "$env:computername\sql2k8" "pubs"  "$($server.BackupDirectory)\pubs.bak" -force
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Invoke-SqlRestore([switch] $Skip)
function Test.Invoke-SqlRestore([switch] $Category_InvokeSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!(test-path "$($server.BackupDirectory)\Northwind.bak"))
    { Invoke-SqlBackup "$env:computername\sql2k8" "Northwind"  "$($server.BackupDirectory)\Northwind.bak" -force }
    
    #Act
    Invoke-SqlRestore "$env:computername\sql2k8" "NorthwindTestRestore"  "$($server.BackupDirectory)\Northwind.bak" -relocatefiles @{Northwind='C:\Program Files\Microsoft SQL Server\MSSQL10.SQL2K8\MSSQL\DATA\northwnd2.mdf'; Northwind_log='C:\Program Files\Microsoft SQL Server\MSSQL10.SQL2K8\MSSQL\DATA\northwnd2.ldf'} -force
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlDatabase([switch] $Skip)
function Test.Add-SqlDatabase([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if ($server.Databases["NorthwindTestRestore"])
    { Remove-SqlDatabase "$env:computername\sql2k8" "NorthwindTestRestore" }
    
    #Act
    Add-SqlDatabase "$env:computername\sql2k8" "NorthwindTestRestore"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlDatabase([switch] $Skip)
function Test.Remove-SqlDatabase([switch] $Category_InvokeSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.Databases["NorthwindTestRestore"]))
    { Add-SqlDatabase "$env:computername\sql2k8" "NorthwindTestRestore" }
    
    #Act
    Remove-SqlDatabase "$env:computername\sql2k8" "NorthwindTestRestore"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlLogin([switch] $Skip)
function Test.Add-SqlLogin([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if ($server.logins["TestPSUnit"])
    { Remove-SqlLogin "$env:computername\sql2k8" "TestPSUnit"}
    
    #Act
    Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" 'SqlLogin' 
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlUser([switch] $Skip)
function Test.Add-SqlUser([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit"  "SQLPSXTesting" 'SqlLogin' }
    $database = get-sqldatabase $server "pubs"
    if ($database.Users["TestPSUnit"])
    { Remove-SqlUser -dbname $database -name "TestPSUnit" }
    
    #Act
    Add-SqlUser -dbname $database -name "TestPSUnit"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlDatabaseRole([switch] $Skip)
function Test.Add-SqlDatabaseRole([switch] $Category_AddSql)
{
    #Arrange
    $database = get-sqldatabase "$env:computername\sql2k8" "pubs"
    if ($database.Roles["TestPSUnitDBRole"])
    { Remove-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole" }
    
    #Act
    Add-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlDatabaseRoleMember([switch] $Skip)
function Test.Add-SqlDatabaseRoleMember([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.Logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" 'SqlLogin' }
    $database = get-sqldatabase $server "pubs"
    if (!($database.Users["TestPSUnit"]))
    { Add-SqlUser -dbname $database -name "TestPSUnit" }
    if (!($database.Roles["TestPSUnitDBRole"]))
    { Add-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole" }
    if (($database.Roles["TestPSUnitDBRole"]).EnumMembers() | where {$_.Name -eq "TestPSUnit"})
    {Remove-SqlDatabaseRoleMember -dbname $database -name "TestPSUnit" -rolename "TestPSUnitDBRole" }
    
    #Act
    Add-SqlDatabaseRoleMember -dbname $database -name "TestPSUnit" -rolename "TestPSUnitDBRole" 
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlDatabaseRoleMember([switch] $Skip)
function Test.Remove-SqlDatabaseRoleMember([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.Logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" 'SqlLogin' }
    $database = get-sqldatabase $server "pubs"
    if (!($database.Users["TestPSUnit"]))
    { Add-SqlUser -dbname $database -name "TestPSUnit" }
    if (!($database.Roles["TestPSUnitDBRole"]))
    { Add-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole" }
    if (!(($database.Roles["TestPSUnitDBRole"]).EnumMembers() | where {$_.Name -eq "TestPSUnit"}))
    {Add-SqlDatabaseRoleMember -dbname $database -name "TestPSUnit" -rolename "TestPSUnitDBRole" }
    
    #Act
    Remove-SqlDatabaseRoleMember -dbname $database -name "TestPSUnit" -rolename "TestPSUnitDBRole" 
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlDatabaseRole([switch] $Skip)
function Test.Remove-SqlDatabaseRole([switch] $Category_RemoveSql)
{
    #Arrange
    $database = get-sqldatabase "$env:computername\sql2k8" "pubs"
    if (!($database.Roles["TestPSUnitDBRole"]))
    { Add-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole" }
    
    #Act
    Remove-SqlDatabaseRole -dbname $database -name "TestPSUnitDBRole"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlUser([switch] $Skip)
function Test.Remove-SqlUser([switch] $Category_RemoveSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit"  "SQLPSXTesting" 'SqlLogin' }
    $database = get-sqldatabase $server "pubs"
    if (!($database.Users["TestPSUnit"]))
    { Add-SqlUser -dbname $database -name "TestPSUnit" }
    
    #Act
    Remove-SqlUser -dbname $database -name "TestPSUnit"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Add-SqlServerRoleMember([switch] $Skip)
function Test.Add-SqlServerRoleMember([switch] $Category_AddSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" 'SqlLogin'}
    $role = $server.Roles["bulkadmin"]
    if ($role.EnumServerRoleMembers() | where {$_.name -eq "TestPSUnit"})
    {Remove-SqlServerRoleMember $server "TestPSUnit" "bulkadmin"}
    
    #Act
    Add-SqlServerRoleMember $server "TestPSUnit" "bulkadmin"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlServerRoleMember([switch] $Skip)
function Test.Remove-SqlServerRoleMember([switch] $Category_RemoveSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit"  "SQLPSXTesting" 'SqlLogin' }
    $role = $server.Roles["bulkadmin"]
    if (!($role.EnumServerRoleMembers() | where {$_.name -eq "TestPSUnit"}))
    {Add-SqlServerRoleMember $server "TestPSUnit" "bulkadmin"}
    
    #Act
    Remove-SqlServerRoleMember $server "TestPSUnit" "bulkadmin"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Remove-SqlLogin([switch] $Skip)
function Test.Remove-SqlLogin([switch] $Category_RemoveSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit"  "SQLPSXTesting" 'SqlLogin' }
    
    #Act
    Remove-SqlLogin "$env:computername\sql2k8" "TestPSUnit"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Set-SqlServerPermission([switch] $Skip)
function Test.Set-SqlServerPermission([switch] $Category_SetSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" "SqlLogin" }
    
    #Act
    Set-SqlServerPermission $server "ViewServerState" "TestPSUnit" "Grant"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Set-SqlDatabasePermission([switch] $Skip)
function Test.Set-SqlDatabasePermission([switch] $Category_SetSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" "SqlLogin" }
    $database = get-sqldatabase $server "pubs"
    if (!($database.Users["TestPSUnit"]))
    { Add-SqlUser -dbname $database -name "TestPSUnit" }
    
    #Act
    Set-SqlDatabasePermission -dbname $database -permission "ViewDefinition" -name "TestPSUnit" -action "Grant"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}


##function Test.Set-SqlObjectPermission([switch] $Skip)
function Test.Set-SqlObjectPermission([switch] $Category_SetSql)
{
    #Arrange
    $server = get-sqlserver "$env:computername\sql2k8"
    if (!($server.logins["TestPSUnit"]))
    { Add-SqlLogin "$env:computername\sql2k8" "TestPSUnit" "SQLPSXTesting" "SqlLogin" }
    $database = get-sqldatabase $server "pubs"
    if (!($database.Users["TestPSUnit"]))
    { Add-SqlUser -dbname $database -name "TestPSUnit" }
    
    #Act
    $database | get-sqlschema -name dbo | set-sqlobjectpermission -permission Select -name TestPSUnit -action Grant
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Get-SqlSchema([switch] $Skip)
function Test.Get-SqlSchema([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = get-sqldatabase "$env:computername\sql2k8" "pubs" | get-sqlschema -name dbo
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'Schema'}
}

##function Test.Get-SqlProcess([switch] $Skip)
function Test.Get-SqlProcess([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (get-SqlProcess "$env:computername\sql2k8")[0]
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-SqlTransaction([switch] $Skip)
function Test.Get-SqlTransaction([switch] $Category_GetSql)
{
    #Arrange
    #Act
    Get-SqlTransaction "$env:computername\sql2k8" "pubs"
    $Actual = $?
    Write-Debug $Actual
    #Assert
    Assert-That -ActualValue $Actual -Constraint {$ActualValue}
}

##function Test.Get-SqlErrorLog([switch] $Skip)
function Test.Get-SqlErrorLog([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = (Get-SqlErrorLog "$env:computername\sql2k8")[0]
    Write-Debug $Actual
    #Assert
     Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'DataRow'}
}

##function Test.Get-SqlEdition([switch] $Skip)
function Test.Get-SqlEdition([switch] $Category_GetSql)
{
    #Arrange
    #Act
    $Actual = Get-SqlEdition "$env:computername\sql2k8"
    Write-Debug $Actual
    #Assert
     Assert-That -ActualValue $Actual -Constraint {$ActualValue.GetType().Name -eq 'PSCustomObject'}
}
