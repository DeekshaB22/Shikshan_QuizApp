import 'package:flutter/material.dart';
import 'package:yolo/views/hometest.dart';
import 'package:yolo/views/home.dart';
import 'package:yolo/views/signin.dart';
import 'package:yolo/services/auth.dart';

import '../helper/functions.dart';
import '../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  // final Function toogleView;
  // SignUp({required this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  late String name,email,password;
  AuthService authService=new AuthService();
  late bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        final result = await authService.signUpWithEmailAndPassword(email, password);
        if (result != null) {
          // Signup was successful, navigate to the home page.
          // HelperFunctions.saveUserLoginInDetails(isLoggedin: true);
          Navigator.pushReplacement(
            context, MaterialPageRoute(
              builder: (context) => Quiz()),
          );
        }
      } catch (e) {
        // Handle Firebase authentication error
        print("Firebase Authentication Error: $e");
        setState(() {
          _isLoading = false;
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: appBar(context) ,
    backgroundColor: const Color(0xff9EB384),
    elevation: 0.0,
    ),
        body: _isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),
        ):
        Container(
            color:const Color(0xffFFFEE0),
          child:Form(
            key:_formKey,
            child: Container(
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  Spacer(),

                  TextFormField(
                    validator: (val){ return val!.isEmpty ? "Enter name": null;},
                    decoration: InputDecoration(
                        hintText: "Name"
                    ),
                    onChanged: (val){
                      name = val;
                    },
                  ),
                  SizedBox(height: 6,),

                  TextFormField(
                    validator: (val){ return val!.isEmpty ? "Enter email": null;},
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                    onChanged: (val){
                      email = val;
                    },
                  ),
                  SizedBox(height: 6,),

                  TextFormField(
                    obscureText: true,
                    validator: (val){ return val!.isEmpty ? "Enter correct password": null;},
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                    onChanged: (val){
                      password = val;
                    },
                  ),
                  SizedBox(height: 20,),

                  GestureDetector(
                    onTap: (){
                      signUp();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        color:const Color(0xffADC4CE),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // width: MediaQuery.of(context).size.width -10,
                      alignment: Alignment.center,
                      child:Text("Sign up",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: TextStyle(fontSize: 17)),
                      GestureDetector(
                          onTap:(){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()
                            ));
                          },
                          child: Text("Sign In",style: TextStyle(fontSize: 17, decoration: TextDecoration.underline))),
                    ],
                  ),

                  SizedBox(height: 20,),
                ],),
            ),
          )
        ),
    );;
  }
}
