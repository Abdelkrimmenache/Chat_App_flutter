

import 'package:chatify_app/authentication/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late User signedUser  ; 

class messagesPage extends StatefulWidget {
  static String screenRout = "messagePage" ; 
  const messagesPage({super.key});

  @override
  State<messagesPage> createState() => _messagesPageState();
}

class _messagesPageState extends State<messagesPage> {

  
  final  FirebaseFirestore firestore =  FirebaseFirestore.instance ; 
  TextEditingController   messageEditingController = TextEditingController()  ;  
  

   //tipe that incluse information about user (will give us the email)
  String? messagetext   ;
  List data =  [] ; 

  @override
  void initState() {
    getCurrentUser() ; 
    super.initState();
  }

  
  void getCurrentUser (){
    try {
      final user = FirebaseAuth.instance.currentUser! ; 
      if(user != null) {
        signedUser = user ; 
        print(signedUser.email) ; 
      }
    }catch(e) {
      print(e) ; 
    }
  }

  // getmessages () async{
  // final messages  =  await FirebaseFirestore.instance.collection("messages").get() ; 
  
  
  // for (var message in messages.docs){
  //   print(message.data()) ; 
  // }

  // }

  void messagesStream () async {
    await for (var snapshot in  FirebaseFirestore.instance.collection('messages').orderBy("time").snapshots()) {
      for(var snapshot in snapshot.docs) {
        print(snapshot.data()) ; 
      }

    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 4, 61) , 
      appBar: 
      AppBar(
        backgroundColor: Color.fromARGB(255, 33, 4, 61)  , 
        title: 
       Row(
        children: [
          Image.asset('images/google.png' ,height: 25,) , 
          SizedBox(width: 5 ,) , 
          Text("messageMe" , style: TextStyle(color: Colors.white ),) , 
        ],
       )  , 

          actions: [
            IconButton(
              onPressed: () async {

                // messagesStream() ;  


                 try {
               await FirebaseAuth.instance.signOut();  
               Navigator.of(context).pushReplacementNamed(loginPage.screenRout ) ;
              } catch(e) {
                print(e) ; 
              }
                

            }, 
            icon: Icon(Icons.close , color: Colors.white ,)
            
            )
          ],

      ),

      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch ,
        children: [

         


          streambuilder() , 
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 78, 62, 55), 
              borderRadius: BorderRadius.circular(10),
              // border: Border(
              //   top: BorderSide(
              //     color: const Color.fromARGB(255, 255, 255, 255) , 
              //     width: 0.5 , 
              //   )
              // )
            ),

          child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              Expanded(
                child: 
                TextField(
                  style: TextStyle(color: Colors.white ),
                  controller: messageEditingController ,
                  onChanged: (value){ 
                    messagetext = value ; 
                    

                  },
                  decoration: InputDecoration(
                   
                    hintText: "write you message here" , 
                  hintStyle: TextStyle(color: Colors.white ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 10 )
                  ),


                )

              ) , 

              InkWell (

                onTap: () {
                  messageEditingController.clear() ; 
                  firestore.collection("messages").add(
                    {
                    "sender" : signedUser.email , 
                    "text" : messagetext , 
                    "time" : FieldValue.serverTimestamp() , 

                    }
                  ) ; 
                },
                child: Text("send" , style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold , fontSize: 20),)) , 
              SizedBox(width: 10,) , 
            ],
          )



          )
          

        
     
           
        ],
      ),
    );
  }
}


///////////////////////
///
class streambuilder extends StatelessWidget {
   streambuilder({
    super.key,
  });
  
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("messages").snapshots() , 
      builder: (context , snapshot ) {
        List<messageLine> massageWidgets = [] ;  
    
        if (snapshot.connectionState == ConnectionState.waiting) {
        // Stream is still loading, return a loading indicator or placeholder
        return CircularProgressIndicator(); // Placeholder example
      }
    
      if (!snapshot.hasData || snapshot.data == null) {
        // Stream has no data or snapshot is null, handle accordingly
        return Text('No messages available'); // Placeholder example
      }
      
        final messages = snapshot.data!.docs.reversed ; //like this i will take the data inside snapshot 
    
        for (var message in messages) {
          final messagetext = message.get('text') ;
          final messageSender = message.get('sender') ;  
          final currrentUser = signedUser.email ; 
          final messagegeWidjet = messageLine(text: messagetext, sender: messageSender , isMe: messageSender == currrentUser ,) ; 
          massageWidgets.add(messagegeWidjet) ; 
        }
    
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              reverse: true  ,
              children:  massageWidgets 
               
              
            ),
          ),
        )  ; 
    
      }
      
      );
  }
}

class messageLine extends StatelessWidget {
  const messageLine({super.key, this.text, this.sender,  required this.isMe});
  
 final text ; 
 final sender ;  
 final bool isMe ; 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end : CrossAxisAlignment.start , 
        
        children: [
          Text("$sender" , style: TextStyle(color: const Color.fromARGB(115, 255, 255, 255) , fontSize: 12),) , 
          SizedBox(height: 5,) , 
          Material(
            elevation: 5 ,
            borderRadius: isMe? BorderRadius.only(
              topLeft: Radius.circular(30) , 
              bottomLeft: Radius.circular(30) , 
              bottomRight: Radius.circular(30) , 
              
              ) : 
              BorderRadius.only(
              topRight: Radius.circular(30) , 
              bottomLeft: Radius.circular(30) , 
              bottomRight: Radius.circular(30) , 
              
              ) ,  
            
            color:isMe? Colors.blue[800] : Colors.white , 
            child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10 ) , 
              child: Text("$text" , 
              style: TextStyle(
                color:isMe? Colors.white : Colors.black ),),
            )  
          ),
        ],
      ),
    ) ; 
  }
}