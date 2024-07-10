import 'package:flutter/material.dart'; 






class inputfeild extends StatelessWidget {
  final String hinttext ; 
  String? Function(String?)? validator ; 
  final Widget? prefixIcon ; 
   final TextEditingController? controller  ;
   final formkey = GlobalKey<FormState>() ;  
  // final Function(String) onSaved ;
  // final bool obscuretext ; 
  // final String regEx ; 

   inputfeild({
    
    super.key, required this.hinttext,  this.prefixIcon, this.controller, this.validator , 
    // this.validator, required this.onSaved, required this.obscuretext, required this.regEx 
  });


  // we creat this methode in order to tigger validation : 



  @override
  Widget build(BuildContext context) {
    return TextFormField(
    
      controller:  controller ,
      
      // style: TextStyle(color: Colors.white), //this is for the intern color 
      decoration:
        
       InputDecoration(

        errorStyle: TextStyle(color: Colors.white ) ,
        
        hintText:  "   $hinttext"  ,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 129, 129, 129) ), 
        filled: true ,
        fillColor: Colors.white  , 
        prefixIcon:  prefixIcon , 
        contentPadding: EdgeInsets.symmetric(vertical: 17)  , 
        
      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(50) , 
      //   ) , 
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(50) , 
      //   ) , 
           

           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50) , 
           )
           
        ) , 
        validator: validator ,
      
        
        
      );
  }
}