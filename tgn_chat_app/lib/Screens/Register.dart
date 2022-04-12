import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgn_chat_app/Auth/Auth_Service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
   // final authService = Provider.of<AuthService>(context);
     final authService = Provider.of<AuthService>(context);

 return Scaffold(
       body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new NetworkImage("https://cdn.pixabay.com/photo/2020/06/07/02/16/fantasy-5268744_960_720.jpg"), fit: BoxFit.cover,),
          ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.width * 0.3),
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: const Text(
                      'Register Your Self with TGN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  )),
                  //SizedBox(height: MediaQuery.of(context).size.width * 0.5),
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
              SizedBox(height: 20,),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ButtonStyle( shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: Colors.teal, 
                      width: 2.0,
                  ),
              ),
                        )
                    ),
                    child: const Text('Sign In'),
                    onPressed: () async {
                      await authService.createUserWithEmailAndPassword(
                          nameController.text, passwordController.text);
                      Navigator.pushNamed(context, '/');
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  ),

        )])]));
  }
}