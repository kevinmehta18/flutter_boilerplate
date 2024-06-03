import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.username, this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  final String username;
  final String? password;
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          context.go('/home');
        },
        child: Text(AppLocalizations.of(context)!.login)),
    );
  }

 
}