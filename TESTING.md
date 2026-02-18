# Testing Guide - Portfolio App

This guide explains how to test the Portfolio app before Play Store submission.

## Quick Start - Build Debug APK

### Option 1: Using PowerShell Script (Recommended)

```powershell
cd portfolio
.\build_debug.ps1
```

This script will:
- Check Flutter installation
- Get dependencies
- Analyze code
- Build debug APK
- Show installation instructions

### Option 2: Manual Build

```powershell
cd portfolio
flutter pub get
flutter analyze
flutter build apk --debug
```

The APK will be located at:
```
build\app\outputs\flutter-apk\app-debug.apk
```

## Installing on Your Device

### Method 1: Using Flutter (Easiest)

1. Enable USB debugging on your Android device
2. Connect your device via USB
3. Run:
   ```powershell
   cd portfolio
   flutter install
   ```

### Method 2: Manual Installation

1. Copy `app-debug.apk` to your device
2. Enable "Install from unknown sources" in device settings
3. Open the APK file to install

## Testing Checklist

### ✅ Core Functionality

- [ ] App launches successfully
- [ ] Splash screen displays with GT logo animation
- [ ] Home page loads correctly
- [ ] All navigation works
- [ ] All screens are accessible

### ✅ UI/UX Testing

- [ ] GT logo displays correctly on all screens
- [ ] Colors match design (dark background, gold/cyan accents)
- [ ] Text is readable
- [ ] No layout issues on different screen sizes
- [ ] Animations play smoothly

### ✅ Orientation Testing

- [ ] Portrait mode works
- [ ] Landscape mode works
- [ ] Rotation is smooth
- [ ] UI adapts correctly to orientation changes

### ✅ Edge-to-Edge Display

- [ ] App uses full screen on devices with notches/cutouts
- [ ] Content is not hidden behind system bars
- [ ] System UI is properly configured

### ✅ Performance Testing

- [ ] App launches quickly (< 3 seconds)
- [ ] No lag when navigating
- [ ] Animations are smooth (60fps)
- [ ] Memory usage is reasonable

### ✅ Compatibility Testing

Test on different Android versions:
- [ ] Android 13 (API 33)
- [ ] Android 14 (API 34)
- [ ] Android 15 (API 35)

Test on different screen sizes:
- [ ] Small phone (< 5.5")
- [ ] Medium phone (5.5" - 6.5")
- [ ] Large phone (> 6.5")
- [ ] Tablet

## GitHub Actions Testing

The GitHub Actions workflow automatically builds:
- **Debug APK** - On every push and pull request
- **Release APK** - Only on main branch push (requires keystore secrets)

### View Build Status

1. Go to: https://github.com/govindtank/portfolio/actions
2. Click on the latest workflow run
3. Download artifacts from the workflow run

### Download Debug APK from GitHub Actions

1. Navigate to the Actions tab
2. Click on a completed workflow run
3. Scroll to "Artifacts" section
4. Download `app-debug.apk`

## Privacy Policy Testing

The privacy policy is deployed to GitHub Pages at:
```
https://govindtank.github.io/portfolio/privacy_policy.html
```

### Test Privacy Policy

1. Visit the URL above
2. Verify all sections are displayed
3. Check that links work
4. Verify the content is accurate

## Common Issues and Solutions

### Issue: Build fails with "SDK not found"

**Solution:**
```powershell
flutter doctor
```
Install missing dependencies as suggested.

### Issue: APK won't install

**Solution:**
- Enable "Install from unknown sources" in device settings
- Uninstall any previous version of the app
- Try installing again

### Issue: App crashes on launch

**Solution:**
```powershell
flutter logs
```
Check the logs for error messages and fix accordingly.

### Issue: GitHub Actions workflow fails

**Solution:**
- Check the workflow logs in the Actions tab
- Verify all dependencies are in `pubspec.yaml`
- Ensure the code compiles locally first

## Pre-Play Store Checklist

Before submitting to Play Store, ensure:

- [ ] All testing items above are completed
- [ ] App icon displays correctly
- [ ] Feature graphic is ready (1024x500)
- [ ] Screenshots are taken (minimum 2, 1080x1920)
- [ ] Privacy policy URL is updated in AndroidManifest
- [ ] App description is written
- [ ] Store listing is complete
- [ ] Signing keystore is created
- [ ] Release APK is built and tested

## Next Steps

After successful testing:

1. **Create Signing Keystore**
   ```powershell
   keytool -genkey -v -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -keystore android/release.jks -alias portfolio
   ```

2. **Configure Signing**
   - Copy `android/key.properties.template` to `android/key.properties`
   - Fill in your keystore details

3. **Build Release APK**
   ```powershell
   flutter build apk --release
   ```

4. **Upload to Play Store Console**
   - Create app listing
   - Upload APK
   - Submit for review

## Support

For issues or questions:
- Check Flutter documentation: https://flutter.dev/docs
- Check GitHub Actions logs
- Review error messages carefully

---

**Happy Testing! 🚀**