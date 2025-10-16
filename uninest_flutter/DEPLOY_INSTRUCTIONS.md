# 🚀 UniNest Flutter - Deployment Instructions

Your Flutter app is ready for deployment! Follow these steps to build and deploy.

## 📋 Prerequisites

### 1. Enable Developer Mode (Required for Windows)
1. Press `Windows + I` to open Settings
2. Go to **Update & Security** → **For developers**
3. Turn on **Developer Mode**
4. Restart your computer if prompted

### 2. Verify Flutter Setup
```powershell
C:\flutter\bin\flutter.bat doctor
```

## 📱 Build for Android

### Option A: APK (Direct Install)
```powershell
cd uninest_flutter
C:\flutter\bin\flutter.bat build apk --release
```
**Output:** `build/app/outputs/flutter-apk/app-release.apk`

### Option B: App Bundle (Google Play Store)
```powershell
C:\flutter\bin\flutter.bat build appbundle --release
```
**Output:** `build/app/outputs/bundle/release/app-release.aab`

## 🍎 Build for iOS (macOS only)

```bash
flutter build ios --release
```
Then open in Xcode and archive for App Store.

## 🖥️ Build for Windows Desktop

```powershell
C:\flutter\bin\flutter.bat build windows --release
```
**Output:** `build/windows/x64/runner/Release/`

## 🌐 Build for Web

```powershell
C:\flutter\bin\flutter.bat build web --release
```
**Output:** `build/web/`

## 📦 Deployment Options

### 1. Direct APK Distribution
- Share the APK file directly
- Users can install via "Install from Unknown Sources"
- Good for beta testing

### 2. Google Play Store
1. Create Google Play Developer account ($25 one-time fee)
2. Upload the `.aab` file
3. Fill store listing details
4. Submit for review

### 3. Apple App Store
1. Apple Developer account ($99/year)
2. Build iOS version on macOS
3. Upload via Xcode or Transporter
4. Submit for review

### 4. Web Hosting
- Deploy `build/web/` folder to any web hosting service
- Netlify, Vercel, Firebase Hosting, etc.

### 5. Windows Store
- Package the Windows build
- Submit to Microsoft Store

## 🔧 Build Commands Summary

```powershell
# Navigate to project
cd uninest_flutter

# Android APK
C:\flutter\bin\flutter.bat build apk --release

# Android App Bundle (Play Store)
C:\flutter\bin\flutter.bat build appbundle --release

# Windows Desktop
C:\flutter\bin\flutter.bat build windows --release

# Web
C:\flutter\bin\flutter.bat build web --release

# Check build size
C:\flutter\bin\flutter.bat build apk --analyze-size
```

## 📊 Expected Build Sizes

- **Android APK**: ~15-20 MB
- **Android App Bundle**: ~12-18 MB
- **Windows**: ~25-35 MB
- **Web**: ~2-5 MB (compressed)

## 🚀 Quick Deploy to Web

### Deploy to Netlify (Free)
1. Build web version: `flutter build web --release`
2. Go to https://netlify.com
3. Drag & drop the `build/web` folder
4. Your app is live!

### Deploy to Vercel (Free)
1. Install Vercel CLI: `npm i -g vercel`
2. Build: `flutter build web --release`
3. Run: `vercel build/web`
4. Follow prompts

### Deploy to Firebase Hosting (Free)
1. Install Firebase CLI: `npm i -g firebase-tools`
2. Build: `flutter build web --release`
3. Run: `firebase init hosting`
4. Set public directory to `build/web`
5. Run: `firebase deploy`

## 📱 Test Your Builds

### Test APK
```powershell
# Install on connected Android device
C:\flutter\bin\flutter.bat install
```

### Test Windows Build
```powershell
# Run the built executable
.\build\windows\x64\runner\Release\uninest_flutter.exe
```

## 🔒 Production Checklist

Before deploying:

- [ ] Enable Developer Mode
- [ ] Test all features work
- [ ] Update app version in `pubspec.yaml`
- [ ] Add app icon (replace `assets/icons/app_icon.png`)
- [ ] Test on multiple devices
- [ ] Configure production backend (Supabase)
- [ ] Use production API keys
- [ ] Add privacy policy
- [ ] Add terms of service
- [ ] Test payment flow
- [ ] Enable crash reporting

## 🎯 Next Steps

1. **Enable Developer Mode** (most important!)
2. **Build APK**: `flutter build apk --release`
3. **Test on device**: Install and test the APK
4. **Deploy to stores**: Follow store-specific guidelines
5. **Monitor**: Set up analytics and crash reporting

## 🆘 Troubleshooting

### "Building with plugins requires symlink support"
- **Solution**: Enable Developer Mode in Windows Settings

### "Gradle build failed"
- **Solution**: Update Gradle version (already fixed in project)

### "Java version incompatible"
- **Solution**: Update Java or Gradle version

### Build takes too long
- **Solution**: Use `--split-per-abi` for smaller APKs

## 📞 Support

If you encounter issues:
1. Check `flutter doctor` output
2. Review error messages
3. Check Flutter documentation
4. Contact support@uninest.com

---

**Your UniNest app is ready for the world! 🌍**

Start with enabling Developer Mode, then run:
```powershell
C:\flutter\bin\flutter.bat build apk --release
```
