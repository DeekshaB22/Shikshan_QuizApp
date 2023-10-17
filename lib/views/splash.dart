import "package:flutter/material.dart";
import "package:yolo/views/signin.dart";
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500),() {});
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (contect)=>SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bookicon.png'),
                      fit: BoxFit.cover, // You can adjust the BoxFit as needed
                    ),
                  ),
                  child:  Text('Quizosaurus',style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),),
                ),
              ],

            )




        ),
      )
    );
  }
}
