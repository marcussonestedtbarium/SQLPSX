function Show-ConnectionManager ()
{
    $ui = New-Grid -Columns 3 -Rows 7 -Name ConnectionGrid {
        
        $ComboBoxStyle = @{
                Height = 30
                Width = 100
                Margin = 5                
                FontSize = 12
                IsSynchronizedWithCurrentItem = $true
            }
        $LabelStyle = @{
               Height = 30
               Width = 100 
               HorizontalContentAlignment = 'Right'
               FontSize = 12
               FontWeight = 'Bold'
            }
        $TextStyle = @{
                Width = 200
                Height = 30
                FontSize = 12
            }
        $ButtonStyle = @{
                Margin = 5
                FontSize = 12
                FontWeight = 'Bold'
            }
        
        New-Label Connections @LabelStyle 
        New-ComboBox -row 1 -Name Selector @ComboBoxStyle -DataBinding @{ 
                ItemsSource = New-Binding
            } -On_SelectionChanged {
                $Name
            } -DisplayMemberPath Name
        
        New-Label -Row 1 -Column 1 Name @LabelStyle 
        New-TextBox -Row 1 -Column 2 -Name ConnName @TextStyle -DataBinding @{Text = New-Binding -Path Name -Mode TwoWay}
        
        New-Label -Row 2 -Column 1 Server @LabelStyle
        New-TextBox -Row 2 -Column 2 -Name Server @TextStyle -DataBinding @{Text = New-Binding -Path Server -Mode TwoWay}
        
        New-Label -Row 3 -Column 1 Database @LabelStyle
        New-TextBox -Row 3 -Column 2 -Name Database @TextStyle -DataBinding @{Text = New-Binding -Path Database -Mode TwoWay}
        
        New-Label -Row 4 -Column 1 UserName @LabelStyle
        New-TextBox -Row 4 -Column 2 -Name UserName @TextStyle -DataBinding @{Text = New-Binding -Path UserName -Mode TwoWay}
        
        New-Label -Row 5 -Column 1 Password @LabelStyle
        New-TextBox -Row 5 -Column 2 -Name Password @TextStyle -DataBinding @{Text = New-Binding -Path Password -Mode TwoWay}
        
        New-Button -Row 6 '_Add New' @ButtonStyle -On_Click { 
                ($window | Get-ChildControl ConnectionGrid).Datacontext += (New-Object PSObject -Property @{
                                                                Name='Change Me'
                                                                Server = ''
                                                                Database = ''
                                                                UserName = ''
                                                                Password = ''
                                                              })
                 
                ($window | Get-ChildControl Selector).SelectedIndex = ($window | Get-ChildControl ConnectionGrid).Datacontext.count - 1
            }
        New-Button -Row 6 -Column 1 '_Delete' @ButtonStyle -On_Click {
                ($window | Get-ChildControl ConnectionGrid).Datacontext = @(($window | Get-ChildControl ConnectionGrid).Datacontext | 
                   where {$_.Name -ne ($window | Get-ChildControl Selector).SelectedItem.Name})
            }
        New-Button -Row 6 -Column 2  '_Save' @ButtonStyle -On_Click { 
                $this.parent.tag = ($window | Get-ChildControl ConnectionGrid).Datacontext
                $window.close()
            }
    } 
    
    if (Test-UserStore -fileName "Connections.xml" -dirName "SQLIse")
    {
        $ui.datacontext = @(Read-UserStore -fileName "Connections.xml" -dirName "SQLIse" -typeName "PSObject")
    }
    else
    {
        $ui.datacontext = @()
    }
    
    $Connections = Show-Window $ui 
    
    if ($Connections)
    {
      Write-UserStore -fileName "Connections.xml" -dirName "SQLIse" -object $Connections
    }
}
