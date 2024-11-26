import 'package:cat_breeds/src/config/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/notifiers/cat_breeds_notifier.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CatBreedsNotifier(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cat Breeds',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAE28FA)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routerConfig: appRouter,
    );
  }
}
