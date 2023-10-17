import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return Center(
    child:RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 25),
      children: <TextSpan>[
        TextSpan(text: 'Shikshan', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
        // TextSpan(text: ' App',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    ),
  ),
  );
}