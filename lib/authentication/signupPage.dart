



import 'package:chatify_app/authentication/loginPage.dart';
import 'package:chatify_app/customWidjets/custom_input_feild.dart';
import 'package:chatify_app/messagesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class signupPage extends StatefulWidget {

  static String screenRout = "signup" ;

  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {

  TextEditingController Username = TextEditingController() ; 
  TextEditingController email = TextEditingController() ; 
  TextEditingController password = TextEditingController() ; 
  GlobalKey<FormState> formkey = GlobalKey<FormState>(); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
     
     Padding(

       padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 10  ) , 
       
       child: Form(
        key: formkey ,
         child: ListView(
           children: [
            SizedBox(height: 40 , ) , 
             Container(
              alignment: Alignment.center,
               child: Text("chatify" , style: TextStyle(fontSize: 40 , color: Colors.white), )) , 
             SizedBox(height: 40 ,) ,   
         
                        
             SizedBox(height: 40 ,) ,  
                        
            
             SizedBox(height: 40 ,) , 
             inputfeild(
              hinttext: "Username" , 
              prefixIcon: Icon(Icons.person ,) , 
              controller: Username , 
              validator: 
              
              (value) { 
                if(value == null || value.isEmpty || value.trim().characters.length <=5 || value.trim().characters.length >50 ) {
                  return "name must be between 5 and 50 charachters " ; 
                }
                return null ;
                 
              },
                ), 
             SizedBox(height: 20 ,) , 
             inputfeild(hinttext: "email" , prefixIcon: Icon(Icons.email), controller: email),
             SizedBox(height: 20 ,) , 
             inputfeild(hinttext: "password" , prefixIcon: Icon(Icons.password), controller: password ),
             SizedBox(height: 20 ,) ,
                          
               SizedBox(height: 40 ,) , 
                        
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 30),
                 child: MaterialButton(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(50 ) , 
                   ) , 
                   color: Colors.white ,
                   minWidth: double.infinity,
                   padding: EdgeInsets.symmetric(vertical: 15 ),
                   onPressed: () async  {

                     if (formkey.currentState!.validate()){

                    try {
                      final Credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email:  email.text , //i need controller of the two feilds     , 
                        password: password.text , 
                        ) ;
         
                        print("user added succfully") ; 
                         Navigator.of(context).pushReplacementNamed(messagesPage.screenRout ) ; 
                    }on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                       showDialog(
                  context: context,
                 builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('AlertDialog Title'),
                  content: Text('This is the content of the AlertDialog.'),
                       
                       ) ;
                      }
                       );
                      
                          print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                      
                     }  //validate will returen a bool 
                   

                      
                   
                     
                 } , 
                 child: 
                 Text("sign up"),
                 ),
               )   , 
                        
               SizedBox(height: 50 ,) , 
                        
               Row(
                 mainAxisAlignment: MainAxisAlignment.center ,
                 children: [
                   Text("you have an account?" ,  style: TextStyle(fontSize: 15 ,
                    color: Colors.white , 
                    ),),
                   SizedBox(width: 5 ,) , 
                   InkWell(
                    onTap:  (){
                    Navigator.of(context).pushReplacementNamed(loginPage.screenRout) ;  
                    },
                    child: Text("log in" , style: TextStyle(fontSize: 15 , color: Colors.white , fontWeight: FontWeight.bold),)) , 
                  ],
               ),
           ],
         ),
       ),
     )
    ) ;
  }
}




