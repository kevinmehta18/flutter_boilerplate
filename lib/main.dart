import 'dart:io';
import 'package:boilerplate/constants.dart/colors.dart';
import 'package:boilerplate/constants.dart/miscellaneous.dart';
import 'package:boilerplate/providers/auth_provider.dart';
import 'package:boilerplate/providers/locale_provider.dart';
import 'package:boilerplate/providers/theme_provider.dart';
import 'package:boilerplate/routing/app_router.dart';
import 'package:boilerplate/services/notification_service/notification_services/firebase_options.dart';
import 'package:boilerplate/services/notification_service/notification_services/push_notofications_manager.dart';
import 'package:boilerplate/shared_preferences/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
   if(!kIsWeb){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    Platform.isIOS
        ? await FirebaseMessaging.instance.requestPermission(
            alert: true,
            sound: true,
          )
        : await Permission.notification.request();
    PushNotificationsManager.getInstance().init();
  }

  await PrefUtils().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocaleProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder:
          (BuildContext context, themeProvider, localeProvider, Widget? child) {
        return ToastificationWrapper(
          config:
              const ToastificationConfig(animationDuration: kAnimationDuration),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'App Name',
            routerConfig: router,
            theme: ThemeData(
                textTheme:
                    GoogleFonts.josefinSansTextTheme(Typography.blackHelsinki),
                scaffoldBackgroundColor: kWhite,
                useMaterial3: false),
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(
              useMaterial3: false,
            ).copyWith(
              textTheme:
                  GoogleFonts.josefinSansTextTheme(Typography.whiteHelsinki),
              scaffoldBackgroundColor: kBlack,
            ),
            themeAnimationCurve: Curves.easeIn,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: localeProvider.locale,
          ),
        );
      },
    );
  }
}


/// Handles Notifications in background state
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  PushNotificationsManager.getInstance().handleForegroundMessage(message);
}
