import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.go('/login',extra: {'replace': true});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // For simple push with parameters
        // context.go('/login', extra: {'username': 'user123', });
        
        context.go('/login', extra: {'username': 'user123',});

        // // For push and removeUntil with parameters
        // context.go('/login', extra: {'username': 'user123', 'password': 'pass123', 'replace': true});

        // // For replace with parameters
        // context.replace('/login', extra: {'username': 'user123', 'password': 'pass123'});

        // // Pop (not relevant for passing parameters)
        // context.pop();
      },
      child: const Center(
        child: Text('Routing Usage Demo'),
      ),
    );
  }
}
