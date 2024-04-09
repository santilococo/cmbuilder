# cmbuilder

This repository hosts macOS applications optimized for ARM-based Apple Silicon. You can easily install these apps by downloading the corresponding `*.dmg` or `*.tar.gz` file from the releases section or by utilizing my Homebrew tap.

## Table of contents
  - [Installation <a name="intallation"></a>](#installation-)
  - [Troubleshooting <a name="troubleshooting"></a>](#troubleshooting-)
  - [Contributing <a name="contributing"></a>](#contributing-)
  - [License <a name="license"></a>](#license-)

## Installation <a name="installation"></a>

To install an optimized version of an app for Apple Silicon, follow these steps:

1. **Download via Releases Section:**

- Navigate to the releases section of this repository.
- Download the corresponding `*.dmg` or `*.tar.gz` file for the desired application. For a `*.dmg` file, double-click to open and drag the app to Applications. For a `*.tar.gz` file, extract and move the `*.app` to /Applications.

3. **Using Homebrew Tap:**

- Execute the following commands in your Terminal:

 ```bash
 brew tap santilococo/cmtap
 brew install --cask santilococo/cmtap/[app-name]
```

Replace `[app-name]` with the name of the application you wish to install.

## Troubleshooting <a name="troubleshooting"></a>

If you encounter an error message stating that the app "can't be opened because Apple cannot check it for malicious software," it is due to macOS Gatekeeper's security system, which verifies that apps are signed with a valid developer certificate. You can resolve this issue by removing the quarantine extended attribute on the application.

Follow these steps:

1. Open your Terminal.
2. Execute the following command:
    
```bash
xattr -d com.apple.quarantine /Applications/[app-name].app
```

Replace `[app-name]` with the name of the application causing the issue.

This command removes the quarantine attribute from the specified application, allowing macOS to open it without displaying the error message.

## Contributing <a name="contributing"></a>
PRs are welcome.

## License <a name="license"></a>
[MIT](https://raw.githubusercontent.com/santilococo/cmbuilder/master/LICENSE.md)

