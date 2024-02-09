import 'package:flutter/material.dart';
import 'package:football/controller/splash_controller.dart';
import 'package:football/framework/components/custom_progress.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = SplashController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        controller.syncData(),
      ]).then((value) => Navigator.of(context).pushReplacementNamed("/principal"));
    });

    return Container(
      color: Colors.white,
      child: const CustomProgress(),
    );
  }
}

