$Volumes = Get-WmiObject -Namespace "Root\CIMV2\Security\MicrosoftVolumeEncryption" `
                        -Class Win32_EncryptableVolume

if ($null -eq $Volumes) {
    Write-Host "No BitLocker volumes detected on this system." -ForegroundColor Red
    return
}

do {
    Clear-Host
    Write-Host "--- Bitlocker Decryption Checker: v1.0 ---" -ForegroundColor Yellow
    Write-Host "Refresh Rate: 1 Second (Press Ctrl+C to Exit)"
    Write-Host "------------------------------------------"

    $AnyActive = $false

    foreach ($Vol in $Volumes) {
        # Refresh the status for this specific volume
        $Status = $Vol.GetConversionStatus()
        $RawPercent = $Status.EncryptionPercentage
        $DisplayPercent = [math]::Round($RawPercent, 2)
        
        # Get Drive Size Information
        $DriveInfo = Get-Partition -DriveLetter $Vol.DriveLetter.TrimEnd(':')
        $TotalGB = [math]::Round($DriveInfo.Size / 1GB, 2)
        $EncryptedGB = [math]::Round(($TotalGB * ($RawPercent / 100)), 2)

        # UI Display
        Write-Host "Drive $($Vol.DriveLetter)" -ForegroundColor White -NoNewline
        Write-Host " ($($Vol.PersistentVolumeID))" -ForegroundColor DarkGray
        
        Write-Host "  Percent Encrypted : " -NoNewline
        Write-Host "$DisplayPercent%" -ForegroundColor White
        
        Write-Host "  Data Protected    : " -NoNewline
        Write-Host "$EncryptedGB GB / $TotalGB GB" -ForegroundColor Gray

        # Check Activity
        Write-Host "  Current Status    : " -NoNewline
        if ($Status.ConversionStatus -eq 0) {
            Write-Host "Idle / Complete" -ForegroundColor Green
        } else {
            Write-Host "In Progress..." -ForegroundColor Yellow
            $AnyActive = $true
        }
        Write-Host "------------------------------------------"
    }

    Start-Sleep -Seconds 1

# The script keeps running while at least one drive is still decrypting
# Or you can change this to 'while ($true)' to keep the monitor open indefinitely
} while ($AnyActive)

Write-Host "`nDecryption on all drives complete!" -Fo
