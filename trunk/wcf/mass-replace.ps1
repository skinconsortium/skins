#$old = "APPFRAMESTUB"
#$new = "FILEHUB"

#$old = " \* @license.*"
#$new = " * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>"
dir -Recurse | ? { $_.GetType() -like 'System.IO.FileInfo'} | %{ 
    if ($_.Extension -notlike ".ps1")
    {
        $filename=($_.DirectoryName+"\"+$_.Name); $a = get-content $filename ; $a = $a -replace ($old, $new) ; set-content $filename $a
        write-host $filename
    }
}
write-host "done"
start-sleep 5