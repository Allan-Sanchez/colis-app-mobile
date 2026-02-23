import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'app.dart';
import 'core/constants/api_constants.dart';
import 'firebase_options.dart';
import 'providers/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init — no-fatal: si firebase_options.dart es el stub
  // (flutterfire configure aún no ejecutado), el app sigue funcionando.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FCM: solicitar permiso y registrar token
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    final fcmToken = await messaging.getToken();
    if (fcmToken != null) {
      _registerDeviceToken(fcmToken);
    }
  } catch (_) {
    // Firebase no configurado todavía — ejecutar: flutterfire configure
    debugPrint('[Firebase] Inicialización omitida. Ejecutar flutterfire configure.');
  }

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const ColisApp(),
    ),
  );
}

void _registerDeviceToken(String token) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  dio.post(ApiConstants.deviceTokens, data: {
    'fcmToken': token,
    'platform': 'android',
  }).catchError((_) {
    // Ignorar errores de registro de token — no es crítico para el arranque
  });
}
