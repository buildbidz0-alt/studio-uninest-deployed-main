# Complete Setup Instructions for UniNest Flutter

This guide will walk you through setting up the UniNest Flutter app from scratch.

## 📋 Prerequisites Checklist

Before you begin, ensure you have:

- [ ] Flutter SDK 3.0.0 or higher installed
- [ ] Dart SDK (comes with Flutter)
- [ ] Android Studio (for Android development)
- [ ] Xcode (for iOS development, macOS only)
- [ ] VS Code or Android Studio (IDE)
- [ ] Git installed
- [ ] A Supabase account (free tier available)
- [ ] A Razorpay account (for payments)
- [ ] A Google Cloud account (for Gemini AI)

## 🔧 Step-by-Step Setup

### Step 1: Install Flutter

**Windows:**
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add to PATH: `C:\src\flutter\bin`
4. Run `flutter doctor` to verify

**macOS:**
```bash
# Using Homebrew
brew install --cask flutter

# Or manual installation
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

**Linux:**
```bash
# Download and extract Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz
tar xf flutter_linux_3.x.x-stable.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"
```

### Step 2: Verify Flutter Installation

```bash
flutter doctor -v
```

Fix any issues reported. Key items:
- ✅ Flutter SDK
- ✅ Android toolchain
- ✅ Xcode (macOS only)
- ✅ VS Code or Android Studio
- ✅ Connected device

### Step 3: Accept Android Licenses

```bash
flutter doctor --android-licenses
```

Accept all licenses when prompted.

### Step 4: Setup the Project

```bash
cd uninest_flutter
flutter pub get
```

This installs all dependencies from `pubspec.yaml`.

### Step 5: Configure Environment Variables

The `.env` file is already created with your credentials. Verify it contains:

```env
SUPABASE_URL=https://dfkgefoqodjccrrqmqis.supabase.co
SUPABASE_ANON_KEY=your_key_here
RAZORPAY_KEY_ID=rzp_live_R5uXLNwkjvkrju
GEMINI_API_KEY=your_key_here
```

**Important:** These are also hardcoded in `lib/config/env.dart` as fallbacks.

### Step 6: Setup Supabase Database

1. Go to https://supabase.com
2. Create a new project
3. Run these SQL commands to create tables:

```sql
-- Profiles table
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  email TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  handle TEXT UNIQUE NOT NULL,
  avatar_url TEXT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Posts table
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) NOT NULL,
  content TEXT NOT NULL,
  image_url TEXT,
  likes_count INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Marketplace items
CREATE TABLE marketplace_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  seller_id UUID REFERENCES profiles(id) NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  price DECIMAL NOT NULL,
  category TEXT NOT NULL,
  image_url TEXT,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notes
CREATE TABLE notes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_id UUID REFERENCES profiles(id) NOT NULL,
  title TEXT NOT NULL,
  subject TEXT NOT NULL,
  description TEXT,
  file_url TEXT NOT NULL,
  downloads_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Competitions
CREATE TABLE competitions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  organization TEXT NOT NULL,
  description TEXT,
  prize TEXT,
  deadline TIMESTAMP WITH TIME ZONE,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Internships
CREATE TABLE internships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  company TEXT NOT NULL,
  description TEXT,
  stipend TEXT,
  duration TEXT,
  deadline TIMESTAMP WITH TIME ZONE,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE marketplace_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE competitions ENABLE ROW LEVEL SECURITY;
ALTER TABLE internships ENABLE ROW LEVEL SECURITY;

-- Create policies (allow read for all, write for authenticated users)
CREATE POLICY "Public profiles are viewable by everyone"
  ON profiles FOR SELECT USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Posts are viewable by everyone"
  ON posts FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create posts"
  ON posts FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Add similar policies for other tables...
```

4. Update credentials in `.env` if using a new project

### Step 7: Setup Razorpay

1. Go to https://razorpay.com
2. Sign up for an account
3. Get your API keys from Dashboard > Settings > API Keys
4. Update `RAZORPAY_KEY_ID` in `.env`

**Test Mode:** Use test keys (starts with `rzp_test_`) for development

### Step 8: Setup Gemini AI

1. Go to https://makersuite.google.com/app/apikey
2. Create an API key
3. Update `GEMINI_API_KEY` in `.env`

### Step 9: Run the App

**Option A: Using Emulator/Simulator**

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

**Option B: Physical Device**

1. Enable USB debugging on Android device
2. Connect via USB
3. Run: `flutter run`

For iOS (macOS only):
1. Connect iPhone
2. Trust computer on iPhone
3. Run: `flutter run`

### Step 10: Test the App

1. **Sign Up**: Create a test account
2. **Login**: Sign in with test account
3. **Navigate**: Test all bottom nav items
4. **Features**: Try posting, marketplace, etc.
5. **Payment**: Test donation (use test mode)

## 🎨 Customization

### Change App Name

**pubspec.yaml:**
```yaml
name: your_app_name
description: Your app description
```

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<application android:label="Your App Name">
```

**iOS:** `ios/Runner/Info.plist`
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### Change App Icon

1. Replace `assets/icons/app_icon.png` with your icon (1024x1024 px)
2. Run:
```bash
flutter pub run flutter_launcher_icons
```

### Change Theme Colors

Edit `lib/config/theme.dart`:

```dart
static const Color primaryBlue = Color(0xFF3B82F6); // Your color
```

## 🐛 Troubleshooting

### "Package not found" Error
```bash
flutter clean
flutter pub get
```

### Gradle Build Failed (Android)
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Pod Install Failed (iOS)
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### "Supabase not initialized"
- Ensure `SupabaseService.initialize()` is called in `main.dart`
- Check internet connection
- Verify credentials in `.env`

### Payment Not Working
- Verify Razorpay key is correct
- Use test key for testing
- Check Razorpay dashboard for errors

### App Crashes on Startup
```bash
flutter clean
flutter pub get
flutter run --verbose
```

Check console for error details.

## 📱 Building for Release

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)
```bash
flutter build ios --release
```
Then archive in Xcode.

## 🚀 Deployment

See `DEPLOYMENT.md` for detailed deployment instructions including:
- Signing apps
- Store submissions
- CI/CD setup

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Supabase Flutter Guide](https://supabase.com/docs/guides/getting-started/quickstarts/flutter)
- [Razorpay Flutter Plugin](https://razorpay.com/docs/payment-gateway/flutter-integration/)
- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Riverpod Documentation](https://riverpod.dev)

## 🆘 Getting Help

If you encounter issues:

1. Check `flutter doctor` output
2. Review error messages carefully
3. Search GitHub issues
4. Check Stack Overflow
5. Contact support@uninest.com

## ✅ Final Checklist

Before deploying:

- [ ] All tests pass
- [ ] App runs on both Android and iOS
- [ ] Authentication works
- [ ] All screens load correctly
- [ ] Payment flow tested
- [ ] Icons and branding updated
- [ ] Privacy policy added
- [ ] Terms of service added
- [ ] App signed for release
- [ ] Store listings prepared

---

**Congratulations!** Your UniNest Flutter app is now set up and ready for development! 🎉
