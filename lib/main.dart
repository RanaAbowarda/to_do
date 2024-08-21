import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/authentication/log_in.dart';
import 'package:to_do/authentication/registeration.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/provider/user_provider.dart';
import 'package:to_do/screens/edit_sceen.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/themeing/my_theme_data.dart';
import 'package:to_do/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore.instance.disableNetwork();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        startLocale: const Locale('ar'),
        path: 'assets/translations',
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MyProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
          ],
          child: const MyApp(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: provider.mode,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        EditScreen.routeName: (context) => const EditScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LogInScreen.routeName: (context) => const LogInScreen(),
      },
    );
  }
}
