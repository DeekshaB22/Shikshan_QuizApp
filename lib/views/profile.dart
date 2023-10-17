import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yolo/views/progress.dart';


import '../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  final double coverHeight = 150;
  final double profileHeight = 120;
  @override
  Widget build(BuildContext context) {
    final top=coverHeight-profileHeight/2;
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: const Color(0xffA9CBB2), //0xff9EB384//96B6C5//blue: a8dadc//yellow:f6bd60//green:9cc5a1
          elevation: 0.0,
        ),
        body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildTop(),
              buildContent(),
            ]
        )
    );
  }
  Widget buildTop(){
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children : [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }
  Widget buildCoverImage() =>
      Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/free-vector/blue-white-gradient-abstract-background_53876-60241.jpg?w=740&t=st=1694349449~exp=1694350049~hmac=209dc8e589c2ef7875d615f3a60d01699b2ac0ef1bba2877302d110471b46086',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: AssetImage('assets/images/prof.png'),
  );

  Widget buildContent() => Container(
    padding: EdgeInsets.symmetric(horizontal: 60),
    child: Column(
      children: [
        const SizedBox(height:8),
        TextFormField(

          decoration: InputDecoration(
              hintText: "Username"
          ),

        ),
        SizedBox(height: 6,),
        TextFormField(
          decoration: InputDecoration(
              hintText: "About"
          ),
        ),
        const SizedBox(height: 16),


      ],
    ),
  );
  Widget buildSocialIcon(IconData icon) => CircleAvatar(
    radius: 25,
    child: Material(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onTap: (){},
        child: Center(child: Icon(icon, size: 32)),
      ),
    ),
  );
}