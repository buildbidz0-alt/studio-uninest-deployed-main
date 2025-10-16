import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';

// Auth state provider
final authStateProvider = StreamProvider<AuthState>((ref) {
  return SupabaseService.authStateChanges;
});

// Current user provider
final currentUserProvider = StateProvider<User?>((ref) {
  return SupabaseService.currentUser;
});

// Auth controller
final authControllerProvider = Provider((ref) => AuthController(ref));

class AuthController {
  final Ref ref;
  
  AuthController(this.ref);
  
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? handle,
  }) async {
    try {
      final response = await SupabaseService.signUp(
        email: email,
        password: password,
        metadata: {
          'full_name': fullName,
          'handle': handle ?? email.split('@')[0],
        },
      );
      
      if (response.user != null) {
        // Create user profile
        await SupabaseService.table('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
          'handle': handle ?? email.split('@')[0],
          'created_at': DateTime.now().toIso8601String(),
        });
        
        ref.read(currentUserProvider.notifier).state = response.user;
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.signIn(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        ref.read(currentUserProvider.notifier).state = response.user;
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> signOut() async {
    try {
      await SupabaseService.signOut();
      ref.read(currentUserProvider.notifier).state = null;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await SupabaseService.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
