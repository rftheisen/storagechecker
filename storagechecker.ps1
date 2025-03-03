# StorageCheck: Automated Storage Usage Scanner

# Get all drives
$diskdrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\$' } | Select-Object -ExpandProperty Root

# Function to get directory size
function Get-DirectorySize {
    param (
        [string]$FolderPath,
        [int]$CurrentDepth,
        [int]$MaxDepth
    )
    
    if ($CurrentDepth -gt $MaxDepth) {
        return 0
    }
    
    $size = 0
    try {
        # Get size of all files including hidden ones
        $size += (Get-ChildItem -Path $FolderPath -File -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
        
        # Get size of subdirectories recursively
        Get-ChildItem -Path $FolderPath -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
            $size += Get-DirectorySize -FolderPath $_.FullName -CurrentDepth ($CurrentDepth + 1) -MaxDepth $MaxDepth
        }
    } catch {
        Write-Warning "Failed to access: $FolderPath"
    }
    return $size
}

# Set scan depth and number of top directories to display
$Depth = 5
$Top = 10

# Collect directory sizes for all drives
$directories = @()
foreach ($drive in $diskdrives) {
    if (-Not (Test-Path $drive)) {
        Write-Warning "Skipping inaccessible drive: $drive"
        continue
    }
    
    $directories += Get-ChildItem -Path $drive -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
        $size = Get-DirectorySize -FolderPath $_.FullName -CurrentDepth 1 -MaxDepth $Depth
        [PSCustomObject]@{
            Directory = $_.FullName
            SizeGB = [math]::Round($size / 1GB, 2)
        }
    }
}

# Sort and display results
$directories | Sort-Object -Property SizeGB -Descending | Select-Object -First $Top | Format-Table -AutoSize
