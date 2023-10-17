import "package:cloud_firestore/cloud_firestore.dart";
import"package:flutter/material.dart";
import "package:yolo/models/question_model.dart";
import "package:yolo/services/database.dart";
import "package:yolo/views/profile.dart";
import "package:yolo/views/result.dart";
import "package:yolo/widgets/quiz_play_widgets.dart";

import "../widgets/widgets.dart";

class PlayQuiz extends StatefulWidget {

  final String quizid;
  PlayQuiz(this.quizid);
  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total=0;
int _correct=0;
int _incorrect=0;
int _notAttempted=0;

class _PlayQuizState extends State<PlayQuiz> {

  late DatabaseService databaseService=new DatabaseService();
  late QuerySnapshot? questionSnapshot;

  @override
  void initState(){
    super.initState();
    print("${widget.quizid}");
    databaseService.getQuizData().then((value){
      setState(() {
        questionSnapshot = value;
        _notAttempted =0;
        _correct=0;
        _incorrect=0;
        total =questionSnapshot!.docs.length;

        print("$total this is total");
      });
    });
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    Map<String, dynamic>? data = questionSnapshot.data() as Map<String, dynamic>?;

    questionModel.question = data?["question"];

    /// shuffling the options
    List<String> options = [
      data?["option 1"],
      data?["option 2"],
      data?["option 3"],
      data?["option 4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctopt = data?["option 1"];
    questionModel.answered = false;

    // print(questionModel.correctopt.toLowerCase());

    return questionModel;
  }

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
      body: SingleChildScrollView(
        child: Container(
        child: Column(children: [
          questionSnapshot == null ?
              Container():
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionSnapshot!.docs.length,
                itemBuilder: (context,index){
                return QuizPlayTile(
                  questionModel:getQuestionModelFromDatasnapshot(
                      questionSnapshot!.docs[index]),
                  index: index,
                );
                },
              )
        ],),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_circle_outline_outlined),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=> Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            )
          ));
        },
      ),
    );
  }
}
class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({required this.questionModel,required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  
  String optSel = " ";
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(height: 15,),
        Text("Q${widget.index+1} ${widget.questionModel.question}", style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w500)),
        SizedBox(height: 7,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option1 ==
                  widget.questionModel.correctopt){
                optSel=widget.questionModel.option1;
                widget.questionModel.answered=true;
                _correct=_correct+1;
                _notAttempted =_notAttempted-1;
                print("${widget.questionModel.correctopt}");
                setState(() {

                });
              }else{
                optSel=widget.questionModel.option1;
                widget.questionModel.answered=true;
                _incorrect=_incorrect+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }
            }
          },
          child: OptionTile(
            opt: "A",
            optSel: optSel,
            correctAns: widget.questionModel.correctopt ?? "", // Provide a default value if it's null
            desc: widget.questionModel.option1 ?? "", // Provide a default value if it's null
          ),
        ),

        SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option2 ==
                  widget.questionModel.correctopt){
                optSel=widget.questionModel.option2;
                widget.questionModel.answered=true;
                _correct=_correct+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }else{
                optSel=widget.questionModel.option2;
                widget.questionModel.answered=true;
                _incorrect=_incorrect+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }
            }
          },
          child: OptionTile(
            opt: "B",
            optSel: optSel,
            correctAns: widget.questionModel.correctopt ?? "", // Provide a default value if it's null
            desc: widget.questionModel.option2 ?? "", // Provide a default value if it's null
          ),
        )
        ,
        SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option3 ==
                  widget.questionModel.correctopt){
                optSel=widget.questionModel.option3;
                widget.questionModel.answered=true;
                _correct=_correct+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }else{
                optSel=widget.questionModel.option3;
                widget.questionModel.answered=true;
                _incorrect=_incorrect+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }
            }
          },
          child: OptionTile(
            opt: "C",
            optSel: optSel,
            correctAns: widget.questionModel.correctopt?? "", // Provide a default value if it's null
            desc: widget.questionModel.option3 ?? "", // Provide a default value if it's null
          ),
        )
        ,
        SizedBox(height: 4,),
        GestureDetector(
          onTap: (){
            if(!widget.questionModel.answered){
              if(widget.questionModel.option4 ==
                  widget.questionModel.correctopt){
                optSel=widget.questionModel.option4;
                widget.questionModel.answered=true;
                _correct=_correct+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }else{
                optSel=widget.questionModel.option4;
                widget.questionModel.answered=true;
                _incorrect=_incorrect+1;
                _notAttempted =_notAttempted-1;
                setState(() {

                });
              }
            }
          },
          child: OptionTile(
            opt: "D",
            optSel: optSel,
            correctAns: widget.questionModel.correctopt ?? "", // Provide a default value if it's null
            desc: widget.questionModel.option4 ?? "", // Provide a default value if it's null
          ),
        ),
      ],),
    );
  }
}

