
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgn_chat_app/Auth/Auth_Service.dart';
import 'package:tgn_chat_app/Wrapper.dart';
import 'package:tgn_chat_app/Screens/ChatScreen.dart';
import 'package:tgn_chat_app/Screens/Login.dart';
import 'package:tgn_chat_app/Screens/Register.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [Provider<AuthService>(create:(_)=> AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
             '/login': (context) => const LoginScreen(),
             '/register': (context) => const RegisterScreen(),
             '/ChatScreen':((context) => ChatScreen())
          },
      ),
    );
  }
}