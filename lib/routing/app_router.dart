import 'package:boilerplate/views/authentication/login_screen.dart';
import 'package:boilerplate/views/home/home_screen.dart';
import 'package:boilerplate/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final extra = state.extra;
        final Map<String, String> defaultExtra = extra is Map<String, dynamic>
            ? extra.map((key, value) => MapEntry(key, value.toString()))
            : {};
        
        return LoginScreen(
          username: defaultExtra['username'] ?? '',
          password: defaultExtra['password'],
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
