



import 'package:chatify_app/authentication/signupPage.dart';
import 'package:chatify_app/customWidjets/custom_input_feild.dart';

import 'package:chatify_app/messagesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {

  static String screenRout = "login" ; 

  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

    TextEditingController Username = TextEditingController() ; 
  TextEditingController email = TextEditingController() ; 
  TextEditingController password = TextEditingController() ; 

   GlobalKey<FormState> formkey = GlobalKey<FormState>();  


  void login() async {
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text   , 
    password: password.text , 
  );

  Navigator.of(context).pushReplacementNamed(messagesPage.screenRout) ;      
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
   SnackBar(content: 
   Text("No user found for that email") , 
   ) ;
    print('===============No user found for that email.');
  } else if (e.code == 'wrong-password') {

  SnackBar(content: 
   Text("Wrong password provided for that user") , 
   ) ;
    print('==================Wrong password provided for that user.');
  }
}
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
     
     Padding(

       padding: const EdgeInsets.symmetric(horizontal: 30 ) , 
       child: Form(
        key:  formkey ,
         child: ListView(
         
          
          children: [
         
            SizedBox(height: 60 ,) , 
         
            Container(
              alignment: Alignment.center,
              child: Text("chatify" , style: TextStyle(fontSize: 40 , color: Colors.white), )) , 
            SizedBox(height: 40 ,) ,   
             
          
            SizedBox(height: 40 ,) ,  
         
            
         
            SizedBox(height: 40 ,) , 
            inputfeild(
              hinttext: "email" , 
              prefixIcon: Icon(Icons.email), 
              controller: email,
               validator: 
                
                (value) { 
                  if(value == null || value.isEmpty || value.trim().characters.length <=5 || value.trim().characters.length >50 ) {
                    return "email must be between 5 and 50 charachters " ; 
                  }
                  return null ;
                   
                },
              
              ),
            SizedBox(height: 20 ,  ) , 
            inputfeild(hinttext: "password" , prefixIcon: Icon(Icons.password , ) , controller: password ,),
            SizedBox(height: 20 ,) ,
            Container(
              alignment: Alignment.centerRight,
              child: Text("forgot you password    " , style: TextStyle(fontSize: 15 , color: Colors.white), )) , 
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
                  onPressed: (){
                    if (formkey.currentState!.validate()) {
                    login() ;  
                    }
                } , 
                child: 
                Text("login"),
                ),
              )   , 
         
              SizedBox(height: 50 ,) , 
         
              Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [
                  Text("don't have an account?" ,  style: TextStyle(fontSize: 15 , color: Colors.white , ),),
                  SizedBox(width: 5 ,) , 
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed(signupPage.screenRout) ; 
                    },
                    child: Text("sign up" , style: TextStyle(fontSize: 15 , color: Colors.white , fontWeight: FontWeight.bold),)) , 
                 ],
              )
         
         
          
              
              
            
          ],
         ),
       ),
     )
    ) ;
  }
}



///////////////////

