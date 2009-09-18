dir -force -Recurse | ? { $_.GetType() -like 'System.IO.DirectoryInfo'} | %{ 
   if ($_.Name -eq ".svn")
    {
       write-host $_.FullName
	   rd $_.FullName -force -recurse
    }
}
write-host "done"
start-sleep 5