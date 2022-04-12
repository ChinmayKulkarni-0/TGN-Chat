
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tgn_chat_app/Auth/Auth_Service.dart';
import 'package:tgn_chat_app/Screens/Recording/RecordingHomeView.dart';


final _firestore = FirebaseFirestore.instance;
 final user = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String messageText;

 
  @override
  Widget build(BuildContext context) {
         final authService = Provider.of<AuthService>(context);
    final user = FirebaseAuth.instance.currentUser;
    return WillPopScope(
       onWillPop: () async {
        return false;
        },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
           automaticallyImplyLeading: false,
          primary: true,
          title: Text("Group Chat"),
          elevation: 5,
          backgroundColor: Colors.black,
          actions: [IconButton(onPressed: (){
            authService.signOut();
             Navigator.pushNamed(context, '/');
          }, icon: Icon(Icons.login_outlined))]
          ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            MessagesStream(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                         style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                         focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Message...",
                        hintStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.message,color: Colors.white,)
                        ),
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': user?.email,
                          
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.green,
                        ),
                        height: 30,
                        width: 80,
                        child: Center(
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ),
                      IconButton(
                        icon: Icon(Icons.voice_chat,color: Colors.white,),
                      onPressed: () {
                       Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const  RecorderHomeView(title: 'Voice Chat',)),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context ) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot,) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docChanges.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message.doc['text'];
          final messageSender = message.doc['sender'];
          
          final currentUser =user?.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sender,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 10.0,
            color: isMe ? Color.fromARGB(255, 102, 255, 64) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}