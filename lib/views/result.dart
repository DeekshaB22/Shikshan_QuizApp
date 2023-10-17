import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yolo/views/profile.dart';

import '../services/funct.dart';
import '../widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct,incorrect, total;
  Results({super.key, required this.correct,required this.incorrect,required this.total});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late Map<String, double> dataMap;


  @override
  void initState() {
    super.initState();
    dataMap = {
      "Correct": widget.correct.toDouble(),
      "Incorrect": widget.incorrect.toDouble(),
      "Unattempted": (widget.total - widget.correct - widget.incorrect).toDouble(),
    };
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PieChart(
               dataMap: dataMap,
                chartRadius: MediaQuery.of(context).size.width / 1.7,
                colorList: [Color(0xFF88a4c9), Color(0xFFbbe6dd), Color(0xFFfde8b2)],
                legendOptions: LegendOptions(
                  legendPosition: LegendPosition.bottom,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
              ),
            SizedBox(height: 8,),
            Text("${widget.correct}/${widget.total}"),
              SizedBox(height: 8,),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                  color:const Color(0xffADC4CE),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 19),),
            ),
          ),
          ],
          ),
        ),
      ),
    );
  }
}
