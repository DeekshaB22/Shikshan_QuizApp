import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService{
  Future<QuerySnapshot>getQuizData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Quiz")
        .doc("Space")
        .collection("Q1")
        .get();
    return querySnapshot;
  }

}

