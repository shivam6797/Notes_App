import 'package:flutter/material.dart';
import 'package:notes_app/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
      Future.delayed(Duration(seconds: 3), () {
       Navigator.pushReplacementNamed(context,AppRoutes.ROUTE_HOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(fit: StackFit.expand, children: [
        Container(
          color: Colors.white,
        ),
        Center(
          child: Image.asset(
            'assets/images/notes_app_pencil.png',
            height: 200,
            width: 200,
          ),
        ),
      ]),
    );
  }
}
