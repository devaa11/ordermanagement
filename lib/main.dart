import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ordermanagement/firebase_options.dart';
import 'package:ordermanagement/modules/auth/login/login_screen.dart';
import 'package:ordermanagement/utils/theme/theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}


