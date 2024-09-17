import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sd_online/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sd_online/firebase_options.dart';
import 'package:sd_online/screen/home_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sd_online/widgets/admobe/ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Ads().showAppOpenAd();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sd_online',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AE"),
      home: const HomeScreen(),
    );
  }
}
