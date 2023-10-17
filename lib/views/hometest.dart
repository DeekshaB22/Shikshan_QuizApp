// // import 'dart:js_util';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:yolo/services/database.dart';
// import 'package:yolo/widgets/widgets.dart';
//
// class Home extends StatefulWidget {
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late Stream quizStream;
//   DatabaseService databaseService= new DatabaseService();
//
//
//   Widget quizList(){
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 24 ),
//       child: StreamBuilder(
//         stream: quizStream,
//         builder: (context,snapshot){
//           return snapshot.data ==null
//               ? Container():
//               ListView.builder(
//                 itemCount: snapshot.data.docs.length,
//                   itemBuilder: (context, index) {
//                     var doc = snapshot.data.docs[index];
//                     return QuizTitle(
//                       imgUrl: doc["quizeimgUrl"],
//                       title: doc["quizTitle"],
//                       desc: doc["quizdesc"],
//                     );
//                     // return QuizTitle(
//                     //   imgUrl: snapshot.data.documents[index].data["quizeimgUrl"],
//                     //   title: snapshot.data.documents[index].data["quizTitle"],
//                     //   desc: snapshot.data.documents[index].data["quizdesc"],
//                     // );
//               });
//         },
//       ),
//       );
//   }
//
//   @override
//   void initState() {
//     databaseService.getQuizData().then((value){
//       quizStream =value;
//       setState(() {});
//     });
//     super.initState();
//     // quizStream = FirebaseFirestore.instance.collection("Quiz1").snapshots();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:appBar(context),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: quizStream != null // Add a null check here
//           ? quizList()
//           : CircularProgressIndicator(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {  },
//         child:Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class QuizTitle extends StatelessWidget {
//   // const QuizTitle({super.key});
//   final String imgUrl,title,desc;
//   QuizTitle({required this.imgUrl, required this.title,required this.desc});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       child: Stack(
//         children: [
//         Image.network(imgUrl,width: MediaQuery.of(context).size.width -48, ),
//           Container(
//             child: Column(children:[
//               Text(title),
//               Text (desc),
//             ])
//           )
//         ],
//       )
//     );
//   }
// }
//
