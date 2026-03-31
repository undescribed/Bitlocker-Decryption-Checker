# Bitlocker-Decryption-Checker
Checks the current decryption status of all volumes on your computer.

# Instructions
Search "Device encryption settings" inside your settings, and begin the decryption process.
Run Powershell as Administrator, and set the Execution Policy to Unrestricted if not already, by running the command `Set-ExecutionPolicy Unrestricted -Force`.
Use the command "cd", following it the location of the file to move Powershell to the location of where bitlockerchecker.ps1 is located


Run the command `./bitlockerchecker.ps1` inside Powershell to start the script




The script will continue running as long as one drive is still decrypting.


![Alt text](https://github.com/undescribed/Bitlocker-Decryption-Checker/blob/main/Preview.png "a title")
