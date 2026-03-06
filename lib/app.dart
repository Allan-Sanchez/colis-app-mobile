import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'router/app_router.dart';

class ColisApp extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const ColisApp({super.key, this.scaffoldMessengerKey});

  @override
  ConsumerState<ColisApp> createState() => _ColisAppState();
}

class _ColisAppState extends ConsumerState<ColisApp> {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Link en frio (app cerrada al abrir desde QR)
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleDeepLink(initialUri);
      });
    }

    // Links en caliente (app ya abierta, llega link)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (mounted) _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    // Convierte colis://restaurants/1/menu -> /restaurants/1/menu
    final path = '/${uri.host}${uri.path}';
    appRouter.go(path);
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.light,
      routerConfig: appRouter,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
