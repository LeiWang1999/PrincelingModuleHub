#以后要 使用 ll 而不是 ls了。

function createtb_function{
    param(
        [Parameter(ValueFromPipeline=$true)]
        $InputObject
    )
    $FileName = $InputObject
    $tbFileName = "tb_" + $FileName.split("\")[-1]
    echo $tbFileName
    python $env:TestBenchPath $FileName >> $tbFileName
}

set-alias ll Get-ChildItemColor  

# cd "C:/Users/22306"

$env:TestBenchPath="C:\Users\22306\.vscode\extensions\truecrab.verilog-testbench-instance-0.0.5\out\vTbgenerator.py"

set-alias createtb createtb_function
function prompt  
{
    # $my_path 获取当前所在目录
    $my_path = $(get-location).toString()  
    $my_pos = ($my_path).LastIndexOf("\") + 1
    # 下面的 if-else 语句用来获得文件路径的最后一个目录名
    # 比如 c:/user/xiaoming   ,  则 $my_path_tail 的内容是 xiaoming 
    # 主要为了命令行终端的提示简洁一些， 根据需要自己修改
    if( $my_pos -eq ($my_path).Length ) { $my_path_tail = $my_path }  
    else { $my_path_tail = ($my_path).SubString( $my_pos, ($my_path).Length - $my_pos ) }  
    # 下面一堆 write-host 定义了终端提示格式。
    Write-Host ("[") -nonewline -foregroundcolor 'Cyan'  
    Write-Host ("Princeling") -nonewline -foregroundcolor 'Cyan'  
    Write-Host (" @ ") -nonewline -foregroundcolor 'Cyan'  
    Write-Host ("WIN10 ") -nonewline -foregroundcolor 'Cyan'  
    Write-Host ($my_path_tail) -nonewline -foregroundcolor 'Cyan'  
    Write-Host ("]#") -nonewline -foregroundcolor 'Cyan'  
    return " "  
}  

function Get-ChildItemColor {  
<#  
.Synopsis  
  Returns childitems with colors by type.  
.Description  
  This function wraps Get-ChildItem and tries to output the results  
  color-coded by type:  
  Directories - Cyan  
  Compressed - Red  
  Executables - Green  
  Text Files - Gray  
  Image Files - Magenta  
  Others - Gray  
.ReturnValue  
  All objects returned by Get-ChildItem are passed down the pipeline  
  unmodified.  
.Notes  
  NAME:      Get-ChildItemColor  
  AUTHOR:    blueky 
#>  
  # 这个函数用来做正则匹配，并为不同的文件配置不同的颜色。
  $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
  $fore = $Host.UI.RawUI.ForegroundColor  
  $compressed = New-Object System.Text.RegularExpressions.Regex(  
      '\.(zip|tar|gz|rar|7z|tgz|bz2)', $regex_opts)  
  $executable = New-Object System.Text.RegularExpressions.Regex(  
      '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|sh)', $regex_opts)  
  $text_files = New-Object System.Text.RegularExpressions.Regex(  
      '\.(txt|cfg|conf|ini|csv|log)', $regex_opts)  
  $image_files = New-Object System.Text.RegularExpressions.Regex(  
      '\.(bmp|jpg|png|gif|jpeg)', $regex_opts)  

  Invoke-Expression ("Get-ChildItem $args") |  
    %{  
      if ($_.GetType().Name -eq 'DirectoryInfo') { $Host.UI.RawUI.ForegroundColor = 'Cyan' }  
      elseif ($compressed.IsMatch($_.Name)) { $Host.UI.RawUI.ForegroundColor = 'Red' }  
      elseif ($executable.IsMatch($_.Name)) { $Host.UI.RawUI.ForegroundColor = 'Green' }  
      elseif ($text_files.IsMatch($_.Name)) { $Host.UI.RawUI.ForegroundColor = 'Gray' }  
      elseif ($image_files.IsMatch($_.Name)) { $Host.UI.RawUI.ForegroundColor = 'Magenta' }  
      else { $Host.UI.RawUI.ForegroundColor = 'Gray' }  
      echo $_  
      $Host.UI.RawUI.ForegroundColor = $fore  
    }  
}  

function Show-Color( [System.ConsoleColor] $color )  
{  
    $fore = $Host.UI.RawUI.ForegroundColor  
    $Host.UI.RawUI.ForegroundColor = $color  
    echo ($color).toString()  
    $Host.UI.RawUI.ForegroundColor = $fore  
}  

# 在powershell终端里面输入 show-allcolor 就可以查看颜色，用来帮助自定义颜色主题
function Show-AllColor  
{  
    Show-Color('Black')  
    Show-Color('DarkBlue')  
    Show-Color('DarkGreen')  
    Show-Color('DarkCyan')  
    Show-Color('DarkRed')  
    Show-Color('DarkMagenta')  
    Show-Color('DarkYellow')  
    Show-Color('Gray')  
    Show-Color('DarkGray')  
    Show-Color('Blue')  
    Show-Color('Green')  
    Show-Color('Cyan')  
    Show-Color('Red')  
    Show-Color('Magenta')  
    Show-Color('Yellow')  
    Show-Color('White')  
}  
