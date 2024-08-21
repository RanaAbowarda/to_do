import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/authentication/log_in.dart';
import 'package:to_do/provider/user_provider.dart';
import 'package:to_do/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fireBaseUsers != null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LogInScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
              "assets/images/logo.png",
              height: 211,
              width: 189,
            ))),
            Image.asset(
              "assets/images/route blue.png",
              height: 128,
              width: 213,
            ),
          ],
        ),
      ),
    );
  }
}
