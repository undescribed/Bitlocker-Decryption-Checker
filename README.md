# Bitlocker-Decryption-Checker
Checks the status of all volumes while, you will have to start decrypting Bitlocker drives by going into Windows Settings though.

# Instructions
Search "Device encryption settings" inside your settings, and begin the decryption process.
Run Powershell as Administrator, and set the Execution Policy to Unrestricted if not already, by running the command `Set-ExecutionPolicy Unrestricted -Force`.
Use the command "cd", following it the location of the file to move Powershell to the location of where bitlockerchecker.ps1 is located
Run the command `./bitlockerchecker.ps1` inside Powershell to start the script
The script will continue running as long as one drive is still decrypting.
