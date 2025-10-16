# UniNest Flutter - Deployment Guide

This guide will help you build and deploy the UniNest Flutter app for Android and iOS.

## Prerequisites

### General Requirements
- Flutter SDK 3.0.0+ installed
- Dart SDK
- Git
- A code editor (VS Code or Android Studio recommended)

### For Android
- Android Studio
- Android SDK (API level 21+)
- Java Development Kit (JDK) 11+

### For iOS (macOS only)
- Xcode 14+
- CocoaPods
- Apple Developer Account (for App Store deployment)

## Initial Setup

1. **Clone and Navigate to Project**
   ```bash
   cd uninest_flutter
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter Installation**
   ```bash
   flutter doctor -v
   ```
   Fix any issues reported by the doctor command.

4. **Configure Environment Variables**
   - Update `.env` file with your credentials
   - Ensure all API keys are correct

## Android Deployment

### Development Build

1. **Connect Android Device or Start Emulator**
   ```bash
   flutter devices
   ```

2. **Run Development Build**
   ```bash
   flutter run
   ```

### Production Build (APK)

1. **Build APK**
   ```bash
   flutter build apk --release
   ```
   The APK will be available at: `build/app/outputs/flutter-apk/app-release.apk`

2. **Build Split APKs (Recommended for smaller file sizes)**
   ```bash
   flutter build apk --split-per-abi --release
   ```
   This creates separate APKs for different CPU architectures.

### Production Build (App Bundle for Play Store)

1. **Create App Bundle**
   ```bash
   flutter build appbundle --release
   ```
   The bundle will be at: `build/app/outputs/bundle/release/app-release.aab`

2. **Sign the App Bundle**
   - Create a keystore:
     ```bash
     keytool -genkey -v -keystore ~/uninest-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias uninest
     ```
   
   - Create `android/key.properties`:
     ```
     storePassword=<your-password>
     keyPassword=<your-password>
     keyAlias=uninest
     storeFile=<path-to-keystore>
     ```
   
   - Update `android/app/build.gradle` to use the signing config
   
   - Build signed bundle:
     ```bash
     flutter build appbundle --release
     ```

3. **Upload to Google Play Console**
   - Go to [Google Play Console](https://play.google.com/console)
   - Create a new app or select existing
   - Upload the `.aab` file
   - Fill in store listing details
   - Submit for review

## iOS Deployment

### Development Build

1. **Open iOS Project in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure Signing**
   - Select the Runner project
   - Go to Signing & Capabilities
   - Select your development team
   - Ensure automatic signing is enabled

3. **Run on Device/Simulator**
   ```bash
   flutter run
   ```

### Production Build (App Store)

1. **Update Version**
   - Edit `pubspec.yaml` and update `version`
   - Update in Xcode: Runner > General > Identity

2. **Configure Release Settings**
   - In Xcode, set scheme to "Release"
   - Ensure all required app icons are present

3. **Build for Release**
   ```bash
   flutter build ios --release
   ```

4. **Archive in Xcode**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Product > Archive
   - Wait for archive to complete

5. **Upload to App Store**
   - Window > Organizer
   - Select your archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Follow the upload wizard

6. **Submit for Review**
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Select your app
   - Create a new version
   - Fill in metadata, screenshots, etc.
   - Submit for review

## Testing

### Run Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## Performance Optimization

### Analyze Build Size
```bash
flutter build apk --analyze-size
flutter build ios --analyze-size
```

### Enable Obfuscation
```bash
flutter build apk --release --obfuscate --split-debug-info=<directory>
flutter build ios --release --obfuscate --split-debug-info=<directory>
```

## Common Issues and Solutions

### Android

**Issue: Gradle build fails**
- Solution: Update Android SDK tools and Gradle version

**Issue: MultiDex error**
- Solution: Already configured in build.gradle

**Issue: Permission errors**
- Solution: Check AndroidManifest.xml permissions

### iOS

**Issue: Pod install fails**
- Solution: 
  ```bash
  cd ios
  pod deintegrate
  pod install
  ```

**Issue: Signing errors**
- Solution: Verify your Apple Developer account and certificates

**Issue: Archive fails**
- Solution: Clean build folder (Product > Clean Build Folder) and try again

## Environment-Specific Builds

### Staging
```bash
flutter build apk --release --dart-define=ENVIRONMENT=staging
```

### Production
```bash
flutter build apk --release --dart-define=ENVIRONMENT=production
```

## Continuous Integration/Deployment

### GitHub Actions Example

Create `.github/workflows/deploy.yml`:

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '11'
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
      - run: flutter pub get
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

## Post-Deployment

1. **Monitor Crash Reports**
   - Set up Firebase Crashlytics or similar
   - Monitor Play Console / App Store Connect

2. **Track Analytics**
   - Integrate Firebase Analytics
   - Monitor user engagement

3. **Update Strategy**
   - Use semantic versioning
   - Test thoroughly before releasing updates
   - Consider staged rollouts

## Support

For issues or questions:
- Email: support@uninest.com
- Documentation: [Add your docs link]

## Resources

- [Flutter Deployment Docs](https://docs.flutter.dev/deployment)
- [Google Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
