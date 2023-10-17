 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yolo/services/auth.dart';
import 'package:yolo/views/home.dart';
import 'package:yolo/views/signup.dart';

import '../helper/functions.dart';
import '../widgets/widgets.dart';
import 'hometest.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  late String email,password;
  final AuthService authService = new AuthService();

  bool isLoading = false;

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((val) {
        if (val != null) {
          setState(() {
            isLoading = false;
          });
          // HelperFunctions.saveUserLoginInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Quiz()
          ));
        }
      });
    }
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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
      body: isLoading? Container(

        child: Center(
          child: CircularProgressIndicator(),
        ),
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
                // flutter:
                // assets:
                // - assets/Stack-of-Books-Clipart.jpg
                Spacer(),

                TextFormField(
                  validator: (val){ return val!.isEmpty ? "Enter correct email": null;},
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
                    signIn();
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
                    child:Text("Sign in",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account? ",style: TextStyle(fontSize: 17)),
                    GestureDetector(
                        onTap:(){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()
                          ));
                        },
                        child: Text("Sign Up",style: TextStyle(fontSize: 17, decoration: TextDecoration.underline))
                    ),
                  ],
                ),

                SizedBox(height: 60,),
              ],),
          ),
        )
      ),
    );
  }
}
