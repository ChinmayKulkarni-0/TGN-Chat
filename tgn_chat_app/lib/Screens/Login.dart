import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgn_chat_app/Auth/Auth_Service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
   final authService = Provider.of<AuthService>(context);
    return  WillPopScope(
       onWillPop: () async {
        return false;
        },
      child: Scaffold(
         body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new NetworkImage("https://cdn.pixabay.com/photo/2016/02/05/13/11/fairy-tale-1180921_960_720.png"), fit: BoxFit.cover,),
            ),
          ),
         Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome to TGN Chat',
                      style: TextStyle(fontSize: 30,color: Colors.white),
                    )),
                    SizedBox(height: 50,),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                     style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    controller: nameController,
                     decoration: InputDecoration(
                         focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                      ),
                    hintText: "john@gmail.com",
                    helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      icon: Icon(Icons.mail,color: Colors.white,),
                      iconColor: Colors.white,
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                     style: TextStyle(color: Colors.white),
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      icon: Icon(Icons.password,color: Colors.white,),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Password',
                    ),
                  ),
                ),
                  SizedBox(height: 10,),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style:  ButtonStyle( shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Colors.teal, 
                        width: 2.0,
                    ),
                ),
                          )
                      ),
                      child: const Text('Login'),
                      onPressed: () {
                        authService.signInWithEmailAndPassword(
                            nameController.text, passwordController.text);
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?',style: TextStyle(color: Colors.white),),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
        ],
      )
      ),
    );
  }
}
