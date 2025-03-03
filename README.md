# StorageChecker
This powershell script quickly finds which directories are taking up the most space on a Windows system.

StorageChecker: Automated Storage Usage Scanner

## Overview

StorageChecker is a PowerShell script that scans all available drives on a system and identifies the directories consuming the most storage. It provides a quick and efficient way to analyze disk usage and detect large folders that may need cleanup.

Features

- Automatic Drive Detection: Scans all available filesystem drives.

- Recursive Directory Analysis: Calculates the total size of directories, including hidden and system files.

- Customizable Depth: Adjusts how deep the script scans within directories.

- Top Usage Reporting: Displays the top largest directories consuming disk space.

- Error Handling: Skips inaccessible directories and provides warnings for potential issues.

## Requirements

- Windows PowerShell (Recommended: PowerShell 5.1 or later)

- Administrator privileges may be required for full access to system files.


## Running the Script

1. Open PowerShell as Administrator.

2. Navigate to the directory where storagecheck.ps1 is located.

3. Run the script using:

```.\storagecheck.ps1 ```

4. The script will analyze storage usage and display the top 10 largest directories.

## Customization

To modify the scanning depth, update the $Depth variable in the script.

To change the number of top results displayed, adjust the $Top variable.

## Example Output

```
Directory              SizeGB
---------              ------
D:\VMs                  25.85
D:\ISOs                 16.15
C:\Windows               5.22
C:\Program Files         1.17
D:\qemu                  1.06
C:\Program Files (x86)   0.74
D:\VideoJuegos           0.51
C:\vkd                   0.12
C:\x64                   0.12
C:\OVFTool               0.09
```
## License

This script is provided as-is. Feel free to modify and distribute as needed.

## Contributions

If you have improvements or find any issues, feel free to suggest updates!

## Author

Bob Theisen aka "LTNBOB"
