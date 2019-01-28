[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [parameter(Mandatory=$true)]
    [string]$folder,
    [switch]$recurse
)

$fso = New-Object -ComObject Scripting.FileSystemObject

Get-ChildItem -Path $folder -File -Recurse:$recurse | ForEach-Object {

    $shortName = $fso.getfile($_.Fullname).ShortName
    if ($shortName -ne $_.Name)
    {
        $fullShortName = Join-Path $_.Directory -ChildPath $shortName
        Move-Item -LiteralPath $_.Fullname -Destination $fullShortName
    }
}