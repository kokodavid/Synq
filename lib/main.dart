import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synq/helpers/utils/themes.dart';
import 'package:synq/router.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_API_KEY'),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(kIsWeb ? webRouterProvider : mobileRouteProvider);
    
    return MaterialApp.router(
      title: kIsWeb ? 'Admin Portal' : 'Synq',
      theme: GlobalThemeData.lightThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: GlobalThemeData.darkThemeData,
      routerConfig: router,
    );
  }
}


