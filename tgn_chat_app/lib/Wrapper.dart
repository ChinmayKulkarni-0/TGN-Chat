import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgn_chat_app/Auth/Auth_Service.dart';
import 'package:tgn_chat_app/Screens/ChatScreen.dart';
import 'package:tgn_chat_app/Screens/Login.dart';
import 'package:tgn_chat_app/main.dart';

import 'Auth/UserModule.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginScreen() : ChatScreen();
          } else {
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
              )),
            );
          }
        });
  }
}