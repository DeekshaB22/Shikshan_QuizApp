import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yolo/views/timer.dart';
import '../widgets/widgets.dart';
import "give_quiz.dart";
import 'profile.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: const Color(0xffA9CBB2), //0xff9EB384//96B6C5//blue: a8dadc//yellow:f6bd60//green:9cc5a1
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ); // Navigate to profile page
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xffFEFCF9),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoxPage(3)),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/spaces.jpeg'),
                    fit: BoxFit.cover, // You can adjust the BoxFit as needed
                  ),
                ),
                child: Center(
                  child: Text('SPACE', style: TextStyle(color: Color(0xFF461257 ),fontWeight: FontWeight.w500, fontSize: 45)),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoxPage(1)),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/sciencedyu.jpeg'),
                    fit: BoxFit.cover, // You can adjust the BoxFit as needed
                  ),
                ),
                child: Center(
                  child: Text('SCIENCE', style: TextStyle(color: Color(0xFF133B7B),fontWeight: FontWeight.w500, fontSize: 45)),
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                String quizId = await fetchQuizIdFromFirebase();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayQuiz(quizId)),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/hist.jpeg'),
                    fit: BoxFit.cover, // You can adjust the BoxFit as needed
                  ),
                ),
                child: Center(
                  child: Text('HISTORY', style: TextStyle(color: Color(0xFF2F3229),fontWeight: FontWeight.w500, fontSize: 45)),
                ),
              ),
            ),


            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoxPage(3)),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('assets/images/geodyu1.jpeg'),
                    fit: BoxFit.cover, // You can adjust the BoxFit as needed
                  ),
                ),
                child: Center(
                  child: Text('GEOGRAPHY', style: TextStyle(color: Color(0xffA6694D),fontWeight: FontWeight.w500, fontSize: 45)),
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimerPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class BoxPage extends StatelessWidget {
  final int boxNumber;

  BoxPage(this.boxNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: const Color(0xffA9CBB2), //0xff9EB384//96B6C5//blue: a8dadc//yellow:f6bd60//green:9cc5a1
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ); // Navigate to profile page
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xffFFFEE0),
        child: Column(
            children: [

        Center(
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 225),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage('assets/images/wek.png'),
              fit: BoxFit.cover, // You can adjust the BoxFit as needed
            ),
          ),
      ),
        ),
      ],
    ),
    ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomFloatingButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,// Adjust the distance from the bottom as needed
      child: InkWell(
        onTap: onPressed,
        child: Container(

          // margin: EdgeInsets.symmetric(vertical: 30),
          width: 100, // Adjust the width as needed
          height: 100, // Adjust the height as needed
          decoration: BoxDecoration(
            // color:Colors.white, // Change the background color
            borderRadius: BorderRadius.circular(15), // Adjust the border radius
          ),
          child: Center(
            child: Image.asset(
              'assets/images/deadline.png',
              // width: 200, // Adjust the width as needed
              // height: 200, // Replace with your image asset path// Adjust the image height
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> fetchQuizIdFromFirebase() async {
  try {
    // Reference the Firestore collection and document
    final quizDocumentReference =
        FirebaseFirestore.instance.collection("Quiz").doc("Space");

    // Fetch the document snapshot
    final documentSnapshot = await quizDocumentReference.get();

    if (documentSnapshot.exists) {
      // If the document exists, extract the quiz ID from it.
      final quizId =
          documentSnapshot.id; // The document ID is the quiz ID in this case.
      return quizId;
    } else {
      throw Exception("Quiz document not found");
    }
  } catch (error) {
    // Handle any errors that may occur during the database query.
    // You can log the error or take appropriate action based on your app's requirements.
    print("Error fetching quiz ID: $error");
    throw error; // Rethrow the error so it can be handled by the caller.
  }
}
