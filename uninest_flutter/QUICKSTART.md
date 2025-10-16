# UniNest Flutter - Quick Start Guide

Get your UniNest Flutter app running in minutes!

## 🚀 Quick Setup (5 minutes)

### 1. Install Flutter

**Windows:**
```powershell
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin
```

**macOS/Linux:**
```bash
# Download Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

Verify installation:
```bash
flutter doctor
```

### 2. Setup Project

```bash
cd uninest_flutter
flutter pub get
```

### 3. Configure Backend

The app is already configured to use:
- **Supabase**: Database and Authentication
- **Razorpay**: Payment Gateway
- **Gemini AI**: AI Features

All credentials are in the `.env` file and `lib/config/env.dart`.

### 4. Run the App

**For Android:**
```bash
# Connect device or start emulator
flutter run
```

**For iOS (macOS only):**
```bash
# Start simulator
open -a Simulator
# Run app
flutter run
```

## 📱 Preview Without Building

You can test the app instantly using:

1. **Flutter DevTools**
   ```bash
   flutter run -d chrome
   ```

2. **Hot Reload**
   - Press `r` in terminal while app is running
   - Changes appear instantly!

## 🏗️ Build for Production

### Android APK (Quick Install)
```bash
flutter build apk --release
```
Find APK at: `build/app/outputs/flutter-apk/app-release.apk`

Install on device:
```bash
flutter install
```

### iOS (macOS only)
```bash
flutter build ios --release
```
Then open in Xcode and archive.

## 🎯 Key Features Included

✅ **Authentication** - Login/Signup with Supabase  
✅ **Social Feed** - Post and interact with students  
✅ **Marketplace** - Buy/sell items  
✅ **Study Hub** - Share and download notes  
✅ **Workspace** - Competitions and internships  
✅ **Chat** - Message other students  
✅ **Payments** - Razorpay integration  
✅ **AI Chat** - Gemini AI assistant  
✅ **Dark Mode** - System theme support  

## 🔧 Common Commands

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk

# Build for iOS
flutter build ios

# Run tests
flutter test

# Clean build
flutter clean

# Check for issues
flutter doctor -v

# Generate icons
flutter pub run flutter_launcher_icons
```

## 📂 Project Structure

```
lib/
├── config/          # App configuration (theme, routes, env)
├── core/            # Core utilities and constants
├── features/        # Feature modules (auth, home, social, etc.)
│   ├── auth/
│   ├── home/
│   ├── social/
│   ├── marketplace/
│   ├── notes/
│   ├── workspace/
│   ├── profile/
│   └── chat/
├── services/        # Backend services (Supabase, Payment, AI)
└── main.dart        # App entry point
```

## 🐛 Troubleshooting

**App won't run?**
```bash
flutter clean
flutter pub get
flutter run
```

**Build fails?**
```bash
# Check Flutter version
flutter --version

# Update Flutter
flutter upgrade

# Check dependencies
flutter pub outdated
```

**Android issues?**
- Install Android Studio
- Accept Android licenses: `flutter doctor --android-licenses`

**iOS issues?**
- Install Xcode from App Store
- Install CocoaPods: `sudo gem install cocoapods`

## 📖 Next Steps

1. **Customize Branding**
   - Update app name in `pubspec.yaml`
   - Replace app icon in `assets/icons/`
   - Run: `flutter pub run flutter_launcher_icons`

2. **Configure Backend**
   - Create Supabase project
   - Update credentials in `.env`
   - Setup database tables

3. **Test Features**
   - Sign up a test account
   - Try each feature module
   - Test payment flow (use Razorpay test mode)

4. **Deploy**
   - Follow `DEPLOYMENT.md` for detailed steps
   - Build signed APK/IPA
   - Upload to Play Store / App Store

## 🆘 Need Help?

- **Documentation**: See `README.md` and `DEPLOYMENT.md`
- **Flutter Docs**: https://docs.flutter.dev
- **Supabase Docs**: https://supabase.com/docs
- **Support**: support@uninest.com

## 🎉 You're Ready!

Your UniNest Flutter app is ready to run. Start with:

```bash
flutter run
```

Happy coding! 🚀
