import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.backgroundBottom,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const PlayveuwApp());
}

class PlayveuwApp extends StatelessWidget {
  const PlayveuwApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playveuw',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
