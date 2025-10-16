import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user;
});

// Auth status provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial()) {
    _init();
  }

  final SupabaseClient _supabase = Supabase.instance.client;

  void _init() {
    // Listen to auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        state = AuthState.authenticated(session.user);
      } else {
        state = const AuthState.unauthenticated();
      }
    });

    // Check initial auth state
    final session = _supabase.auth.currentSession;
    if (session != null) {
      state = AuthState.authenticated(session.user);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();
      
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        state = AuthState.authenticated(response.user!);
      } else {
        state = const AuthState.error('Sign in failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      state = const AuthState.loading();
      
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        state = AuthState.authenticated(response.user!);
      } else {
        state = const AuthState.error('Sign up failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      state = const AuthState.loading();
      
      await _supabase.auth.resetPasswordForEmail(email);
      
      // Reset to previous state after successful reset
      final session = _supabase.auth.currentSession;
      if (session != null) {
        state = AuthState.authenticated(session.user);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void clearError() {
    if (state.hasError) {
      final session = _supabase.auth.currentSession;
      if (session != null) {
        state = AuthState.authenticated(session.user);
      } else {
        state = const AuthState.unauthenticated();
      }
    }
  }
}

// Auth state class
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState._({
    this.user,
    this.isLoading = false,
    this.error,
  });

  const AuthState.initial() : this._();
  
  const AuthState.loading() : this._(isLoading: true);
  
  const AuthState.authenticated(User user) : this._(user: user);
  
  const AuthState.unauthenticated() : this._();
  
  const AuthState.error(String error) : this._(error: error);

  bool get isAuthenticated => user != null;
  bool get hasError => error != null;
}
