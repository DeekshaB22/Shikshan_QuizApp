import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String opt, desc,correctAns, optSel;
  OptionTile({required this.opt,required this.optSel,required this.correctAns,required this.desc});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child:Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border:Border.all(
                  color: widget.desc==widget.optSel ?
              widget.optSel==widget.correctAns ?
              Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7)
                      : Colors.grey,width: 1.5),
                borderRadius: BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child:Text("${widget.opt}",style: TextStyle(
              color: widget.optSel==widget.desc ?
               widget.correctAns==widget.optSel ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7)
                  : Colors.grey
            ),),
          ),
          SizedBox(width:8,),
          Text(widget.desc,style: TextStyle(fontSize: 16, color: Colors.black ))
        ],
      )
    );
  }
}
