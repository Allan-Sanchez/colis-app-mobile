import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'providers/favorites_provider.dart';
import 'providers/notifications_provider.dart';

/// Clave global del ScaffoldMessenger para mostrar SnackBars en foreground
/// sin depender del contexto de widget (funciona con GoRouter).
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

late final ProviderContainer _container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init — no-fatal: si firebase_options.dart es el stub
  // (flutterfire configure aún no ejecutado), el app sigue funcionando.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Escuchar mensajes FCM en foreground (no requiere permiso)
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
  } catch (_) {
    // Firebase no configurado todavía — ejecutar: flutterfire configure
    debugPrint('[Firebase] Inicialización omitida. Ejecutar flutterfire configure.');
  }

  final prefs = await SharedPreferences.getInstance();

  // Generar deviceId único y persistente si aún no existe
  if (!prefs.containsKey('device_id')) {
    final random = Random.secure();
    final id = List.generate(32, (_) => random.nextInt(16).toRadixString(16)).join();
    await prefs.setString('device_id', id);
  }

  _container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: _container,
      child: ColisApp(scaffoldMessengerKey: scaffoldMessengerKey),
    ),
  );
}

void _onForegroundMessage(RemoteMessage message) {
  // Detectar campañas push por appCode
  if (message.data['appCode'] == 'CAMPAIGN_PUSH') {
    final title = message.notification?.title ?? message.data['title'] ?? 'Notificación';
    final body = message.notification?.body ?? message.data['body'] ?? '';

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            if (body.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(body, style: const TextStyle(fontSize: 13)),
              ),
          ],
        ),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1e293b),
      ),
    );

    // Guardar en historial de notificaciones
    try {
      _container.read(notificationsProvider.notifier).add(
            AppNotification(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              body: body,
              receivedAt: DateTime.now(),
              isRead: false,
            ),
          );
    } catch (_) {}
  }
}
