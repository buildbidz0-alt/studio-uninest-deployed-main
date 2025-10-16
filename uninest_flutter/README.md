# UniNest Flutter

A comprehensive student platform mobile app built with Flutter for Android and iOS.

## Features

- **Authentication**: Secure login/signup with Supabase
- **Social Feed**: Connect with 10,000+ students
- **Marketplace**: Buy and sell products
- **Study Hub**: Share and access notes
- **Workspace**: Competitions and internships
- **AI Chat**: Powered by Gemini AI
- **Hostel Booking**: Find and book hostels
- **Payment Integration**: Razorpay for secure payments
- **Admin Dashboard**: Complete admin management

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Supabase account
- Razorpay account

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the root directory with your credentials:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   RAZORPAY_KEY_ID=your_razorpay_key_id
   GEMINI_API_KEY=your_gemini_api_key
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Build for Production

#### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── env.dart
│   ├── routes.dart
│   └── theme.dart
├── core/
│   ├── constants/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── home/
│   ├── social/
│   ├── marketplace/
│   ├── notes/
│   ├── workspace/
│   ├── chat/
│   ├── profile/
│   ├── admin/
│   └── payment/
└── services/
    ├── supabase_service.dart
    ├── payment_service.dart
    └── ai_service.dart
```

## Dependencies

- **flutter_riverpod**: State management
- **go_router**: Navigation
- **supabase_flutter**: Backend & authentication
- **razorpay_flutter**: Payment gateway
- **dio**: HTTP client
- **cached_network_image**: Image caching
- **google_fonts**: Custom fonts

## License

This project is private and proprietary.
