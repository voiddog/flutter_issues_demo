# Floating point precision error makes restore position failure in NestedScrollView

## flutter doctor
```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, v1.7.8+hotfix.4, on Mac OS X 10.14.5 18F132, locale zh-Hans-CN)
 
[!] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
    ! Some Android licenses not accepted.  To resolve this, run: flutter doctor --android-licenses
[!] Xcode - develop for iOS and macOS (Xcode 10.3)
    ! CocoaPods out of date (1.6.0 is recommended).
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your
        plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To upgrade:
        brew upgrade cocoapods
        pod setup
[✓] iOS tools - develop for iOS devices
[!] Android Studio (version 3.4)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[✓] IntelliJ IDEA Ultimate Edition (version 2019.2)
[✓] VS Code (version 1.37.0)
[✓] Connected device (2 available)

! Doctor found issues in 3 categories.
```

## Issure gif
![Imgur](https://i.imgur.com/eJjgZXv.gif)