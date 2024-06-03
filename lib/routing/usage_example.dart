import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// For simple push -->>Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        context.go('/login'); 
        /// For push and removeUntil -->>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        context.go('/login',extra: {
          'replace': true
        });
        /// For replace -->> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        context.replace('/login');
        //
        context.pop();
      },
      child: const Center(
        child: Text('Routing Usage Demo'),
      ),
    );
  }
}
