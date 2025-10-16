class Env {
  // Supabase
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://dfkgefoqodjccrrqmqis.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRma2dlZm9xb2RqY2NycnFtcWlzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczNDgxMjQsImV4cCI6MjA3MjkyNDEyNH0._3SxtAocgCIoJ7gyBbZoMsZrHAV4yd-sFu-GFINfNqw',
  );
  
  // Razorpay
  static const String razorpayKeyId = String.fromEnvironment(
    'RAZORPAY_KEY_ID',
    defaultValue: 'rzp_live_R5uXLNwkjvkrju',
  );
  
  // Gemini AI
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyBhC9r7kUGeima1iwsB0GAaJprs9jZzksU',
  );
  
  // Admin
  static const String adminEmail = 'admin@uninest.com';
  static const String adminPassword = '5968474644j';
}
