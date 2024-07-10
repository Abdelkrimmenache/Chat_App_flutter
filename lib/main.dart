import 'package:chatify_app/authentication/loginPage.dart';
import 'package:chatify_app/authentication/signupPage.dart';

import 'package:chatify_app/messagesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';




// void main() {
  
// }



void main() async {    


  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAbtAPTgH3EN1_B2MQU3pq6-_rMFQOEyTo",
      appId: "1:379917018574:android:50ec01150d7da1aa71379f", 
      messagingSenderId: "379917018574",
      projectId: "chatify-udemy-758b1" , 
      storageBucket: "chatify-udemy-758b1.appspot.com"   
      ) 
  );

  runApp(const MyApp()); 
}



class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  void userChanges()  {
  FirebaseAuth.instance
  .userChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!') ;
    } 
    
    else {
      print('User is signed in!');
    }

  }

  );

  }

  void initState() {
    userChanges() ; 
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          scaffoldBackgroundColor:   Color.fromARGB(255, 33, 4, 61) ,  
         
        ),
        home: FirebaseAuth.instance.currentUser != null?messagesPage() : loginPage( )  , 
        routes: {
          loginPage.screenRout :  (context) => loginPage() , 
          signupPage.screenRout :  (context) => signupPage() , 
         
          messagesPage.screenRout :  (context) => messagesPage() , 

        },
      );
    
  }
}

