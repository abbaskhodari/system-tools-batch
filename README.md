# System Tools Menu (Tools.bat)

A simple interactive Windows batch (.bat) menu that bundles a few common
system maintenance and diagnostic tasks into one tool.

## Features

| # | Option | What it does |
|---|--------|---------------|
| 1 | Show Windows Product Key | Reads the OEM product key embedded in the BIOS/firmware, using PowerShell (`Get-CimInstance`) with a fallback to `wmic` on older systems. |
| 2 | Device Properties | Opens Windows System Information (`msinfo32`). |
| 3 | Clean Temporary Files | Deletes `C:\Windows\Temp`, the current user's `%LOCALAPPDATA%\Temp`, and `C:\Windows\Prefetch`. |
| 4 | Scan and Repair System | Runs `sfc /scannow` and schedules `chkdsk /f` on the system drive. |
| 5 | Exit | Closes the tool. |

The tool automatically checks for Administrator privileges on launch and
requests elevation (UAC prompt) if it isn't already running as admin —
several of the options above require it to work correctly.

## Requirements

- Windows 10 or Windows 11
- Administrator access on the machine
- PowerShell (included by default in Windows 10/11)

## Usage

1. Download `Tools.bat`.
2. Double-click it, **or** right-click → "Run as administrator".
3. If prompted by User Account Control (UAC), click **Yes** to allow it to
   run with administrator privileges.
4. Choose an option from the menu by typing its number and pressing Enter.

## ⚠️ Warnings — Please read before running

- **Deleting temporary files (option 3) cannot be undone.** In most cases
  this is safe and simply frees up disk space, but make sure no important
  application data is stored in those temp folders before running it.
- **`chkdsk /f` (option 4)** cannot run on the system drive while Windows
  is using it. It will instead be **scheduled** to run automatically the
  next time you restart your computer. Save your work and be prepared to
  restart when convenient.
- **`sfc /scannow` (option 4)** can take a significant amount of time
  depending on your system.
- This script modifies system files/folders and requires administrator
  rights — only run it if you understand what each option does, and only
  on machines you own or are authorized to manage.
- The Product Key option (option 1) only retrieves the **OEM key embedded
  by the manufacturer**, if one exists. It will not reveal retail/digital
  license keys tied to a Microsoft account.

## Disclaimer

This script is provided "as is", without warranty of any kind. The
author(s) are not responsible for any data loss, system instability, or
other damage resulting from its use. Use at your own risk.

## License

Released under the MIT License — see [LICENSE](LICENSE) for details.

## Author

**Abbas Khodari**
GitHub: [@AbbasKhodari](https://github.com/AbbasKhodari)
