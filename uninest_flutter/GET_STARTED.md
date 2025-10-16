# 🚀 Get Started with UniNest Flutter

Welcome! Your Next.js app has been converted to Flutter. Here's everything you need to know.

## ⚡ Quick Start (3 Commands)

```bash
# 1. Navigate to Flutter project
cd uninest_flutter

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

That's it! The app should now be running on your device/emulator.

## 📱 What You Got

### ✅ Complete Feature Parity

Your Next.js app has been fully converted to Flutter with all these features:

**🔐 Authentication**
- Login screen with email/password
- Signup with validation
- Supabase integration
- Session management

**🏠 Home Screen**
- Search functionality
- 4 feature cards (Social, Marketplace, Notes, Workspace)
- Statistics (10,000+ students, 200+ vendors)
- Testimonials carousel
- Timeline/Journey section
- Call-to-action buttons

**👥 Social Feed**
- Create posts
- Like, comment, share
- User profiles
- Infinite scroll ready

**🛒 Marketplace**
- Product listings
- Category filtering
- Buy/Sell functionality
- Product details

**📚 Study Hub**
- Upload/Download notes
- Subject filtering
- Note sharing
- Download tracking

**💼 Workspace**
- Competitions listing
- Internships listing
- Application tracking
- Deadline management

**💬 Chat**
- Message list
- Unread indicators
- Chat conversations

**👤 Profile**
- User information
- Stats display
- Settings access
- Logout

**⚙️ Settings**
- Notifications toggle
- Dark mode
- Account management
- Privacy settings

**👨‍💼 Admin Dashboard**
- User management
- Content moderation
- Analytics
- System settings

**💝 Donations**
- Quick amounts
- Custom amounts
- Razorpay integration

**🆘 Support**
- Ticket submission
- FAQ access
- Contact information

### 🎨 Design Features

- **Material 3** design system
- **Light & Dark** themes
- **Gradient branding** matching your web app
- **Responsive layouts** for all screen sizes
- **Smooth animations** throughout
- **Custom fonts** (Google Fonts - Inter)

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flutter 3.0+ |
| State Management | Riverpod 2.5 |
| Navigation | go_router 14.2 |
| Backend | Supabase |
| Payments | Razorpay |
| AI | Google Gemini |
| HTTP | Dio |
| Storage | Shared Preferences |

## 📂 Project Structure

```
uninest_flutter/
├── lib/
│   ├── main.dart              # Entry point
│   ├── config/                # Configuration
│   ├── core/                  # Utilities
│   ├── features/              # All features
│   │   ├── auth/
│   │   ├── home/
│   │   ├── social/
│   │   ├── marketplace/
│   │   ├── notes/
│   │   ├── workspace/
│   │   ├── profile/
│   │   ├── chat/
│   │   ├── settings/
│   │   ├── admin/
│   │   ├── donate/
│   │   └── support/
│   └── services/              # Backend services
├── android/                   # Android config
├── ios/                       # iOS config
└── assets/                    # Images, icons
```

## 🎯 Next Steps

### 1. Preview the App

**Option A: Android Emulator**
```bash
# Open Android Studio > AVD Manager > Create Virtual Device
flutter run
```

**Option B: iOS Simulator** (macOS only)
```bash
open -a Simulator
flutter run
```

**Option C: Physical Device**
```bash
# Enable USB debugging on device
# Connect via USB
flutter run
```

### 2. Test All Features

- ✅ Sign up with a test account
- ✅ Navigate through all screens
- ✅ Test social feed
- ✅ Try marketplace
- ✅ Upload/download notes
- ✅ View workspace opportunities
- ✅ Test payment (use Razorpay test mode)

### 3. Customize Your App

**Change App Name:**
- Edit `pubspec.yaml`
- Edit `android/app/src/main/AndroidManifest.xml`
- Edit `ios/Runner/Info.plist`

**Change App Icon:**
```bash
# Replace assets/icons/app_icon.png (1024x1024)
flutter pub run flutter_launcher_icons
```

**Change Colors:**
- Edit `lib/config/theme.dart`

### 4. Build for Production

**Android APK:**
```bash
flutter build apk --release
```
Find at: `build/app/outputs/flutter-apk/app-release.apk`

**iOS (macOS only):**
```bash
flutter build ios --release
# Then archive in Xcode
```

### 5. Deploy to Stores

See `DEPLOYMENT.md` for detailed instructions on:
- Signing your app
- Google Play Store submission
- Apple App Store submission

## 📖 Documentation Files

Your project includes comprehensive documentation:

| File | Purpose |
|------|---------|
| `README.md` | Main documentation |
| `GET_STARTED.md` | This file - quick start |
| `QUICKSTART.md` | 5-minute setup guide |
| `SETUP_INSTRUCTIONS.md` | Detailed setup |
| `DEPLOYMENT.md` | Production deployment |
| `PROJECT_STRUCTURE.md` | Complete file listing |

## 🔑 Important Files

### Environment Configuration
- `.env` - Your API keys (already configured)
- `lib/config/env.dart` - Environment variables

### Backend Services
- `lib/services/supabase_service.dart` - Database & auth
- `lib/services/payment_service.dart` - Razorpay payments
- `lib/services/ai_service.dart` - Gemini AI

### Navigation
- `lib/config/routes.dart` - All app routes

### Theme
- `lib/config/theme.dart` - Light/dark themes

## 💡 Pro Tips

### Hot Reload
While running, press `r` in terminal to instantly reload changes!

### Check for Issues
```bash
flutter doctor -v
```

### Clean Build
If something breaks:
```bash
flutter clean
flutter pub get
flutter run
```

### View Logs
```bash
flutter run --verbose
```

### Performance
```bash
flutter run --profile
```

## 🐛 Common Issues & Fixes

**Issue: "Cannot find Flutter SDK"**
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

**Issue: "Gradle build failed"**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**Issue: "Pod install failed" (iOS)**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

**Issue: "Supabase not initialized"**
- Check internet connection
- Verify credentials in `.env`
- Ensure `main.dart` calls `SupabaseService.initialize()`

## 🎨 Customize Branding

Your app uses these brand colors:

| Color | Hex | Usage |
|-------|-----|-------|
| Primary Blue | `#3B82F6` | Main actions |
| Primary Purple | `#8B5CF6` | Gradients |
| Primary Green | `#10B981` | Success |
| Primary Orange | `#F97316` | Highlights |

Change them in `lib/config/theme.dart`.

## 🔄 Sync with Web App

Your Flutter app mirrors your Next.js web app:

| Next.js Route | Flutter Screen |
|--------------|----------------|
| `/` | `HomeScreen` |
| `/login` | `LoginScreen` |
| `/signup` | `SignupScreen` |
| `/social` | `SocialScreen` |
| `/marketplace` | `MarketplaceScreen` |
| `/notes` | `NotesScreen` |
| `/workspace` | `WorkspaceScreen` |
| `/profile` | `ProfileScreen` |
| `/chat` | `ChatScreen` |
| `/settings` | `SettingsScreen` |
| `/admin` | `AdminDashboardScreen` |
| `/donate` | `DonateScreen` |
| `/support` | `SupportScreen` |

## 📊 Performance Tips

1. **Use release builds** for testing performance
2. **Enable caching** for images (already configured)
3. **Lazy load** lists (implemented)
4. **Optimize images** before adding to assets
5. **Profile your app** regularly

## 🔒 Security Best Practices

✅ **Already Implemented:**
- Environment variables for sensitive data
- Secure storage for tokens
- HTTPS for all API calls
- Input validation
- SQL injection prevention (Supabase)

⚠️ **You Should:**
- Never commit `.env` file
- Use Row Level Security in Supabase
- Implement proper error handling
- Add rate limiting
- Enable 2FA for admin accounts

## 📱 Device Testing

Test on multiple devices:
- [ ] Small phone (Android)
- [ ] Large phone (Android)
- [ ] Tablet (Android)
- [ ] iPhone (iOS)
- [ ] iPad (iOS)

## 🚀 Launch Checklist

Before going live:

- [ ] All features tested
- [ ] No debug code remaining
- [ ] Analytics integrated
- [ ] Crash reporting setup
- [ ] Privacy policy added
- [ ] Terms of service added
- [ ] App store assets ready
- [ ] Production backend configured
- [ ] Payment gateway tested
- [ ] Beta testing completed

## 🎓 Learning Resources

- **Flutter Basics**: https://docs.flutter.dev/get-started
- **Riverpod Guide**: https://riverpod.dev/docs/getting_started
- **Supabase Flutter**: https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- **Material Design**: https://m3.material.io

## 🆘 Need Help?

1. **Check documentation** in this folder
2. **Run** `flutter doctor` to diagnose issues
3. **Search** Stack Overflow
4. **Contact** support@uninest.com

## 🎉 You're All Set!

Your UniNest app is ready to run on Android and iOS!

Start with:
```bash
flutter run
```

Happy coding! 🚀

---

**Made with ❤️ for UniNest** | Last Updated: 2025
