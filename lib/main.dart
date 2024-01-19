

import 'package:fazwalls/firebase/auth/auth_provider.dart';
import 'package:fazwalls/firebase_options.dart';
import 'package:fazwalls/pages/onboarding/onboarding.dart';



import 'package:fazwalls/theme/theme.dart';
import 'package:fazwalls/utils/bottom_navigation_bar.dart';
import 'package:fazwalls/wallpaper_provider/favorite_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp]);
 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isUserSignedIn = prefs.getBool('isUserSignedIn') ?? false;
  Widget initialScreen = isUserSignedIn ? const GnavigationBar() : const OnBoarding();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProviderr()),
        ChangeNotifierProvider(create: (context)=> FavoriteWallpapersProvider())
        ],
      child:  MyApp(initialScreen: initialScreen,)));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key, required this.initialScreen});
  final Widget initialScreen;

  

 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home:  initialScreen,
    );
  }
}
