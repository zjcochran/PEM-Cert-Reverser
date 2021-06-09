$text = Get-Content .\input.pem
$from = ($text | Select-String -Pattern "-----BEGIN CERTIFICATE-----" | Select-Object LineNumber).LineNumber
$to = ($text | Select-String -Pattern "-----END CERTIFICATE-----" | Select-Object LineNumber).LineNumber
if ($from.Count -eq $to.Count) {
    $i = $from.Count - 1
    $array = @()
    while ($i -ge 0) {
        for ($j = $from[$i] - 1; $j -le $to[$i] - 1; $j++) {
            $array += $text[$j]
        }
        $i = $i - 1
    }
    $array | Out-File .\output.pem
} else {
    Write-Host "There's something wrong with the input file."
}
