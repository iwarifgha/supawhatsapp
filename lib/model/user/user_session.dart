import 'package:supabase_flutter/supabase_flutter.dart';

class UserSession {
  final String? providerToken;
  final String? providerRefreshToken;
  final String accessToken;

  /// The number of seconds until the token expires (since it was issued).
  /// Returned when a login is confirmed.
  final int? expiresIn;

  final String? refreshToken;
  final String tokenType;
  final User user;

  UserSession({
    required this.accessToken,
    this.expiresIn,
    this.refreshToken,
    required this.tokenType,
    this.providerToken,
    this.providerRefreshToken,
    required this.user,
  });

  static UserSession fromSupabaseSession (Session session){
    return UserSession(
        accessToken: session.accessToken,
        tokenType: session.tokenType,
        user: session.user,
      expiresIn: session.expiresIn,
      refreshToken: session.refreshToken,
      providerToken: session.providerToken,
      providerRefreshToken: session.providerRefreshToken,
    );
  }

}