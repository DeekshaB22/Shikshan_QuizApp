import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin{
  int _secondsLeft = 15; // Initial time in seconds
  bool _isRunning = false;
  bool _hasCompletedCycle = false;
  late Timer _timer;
  StreamController<int>? imageStreamController;
  List<String> imageAssets = [
    'assets/images/butterflies.png',
    'assets/images/caterpillar.png',
    'assets/images/silk-cocoon (1).png',
    // Add more image paths as needed
  ];

  int initialImageIndex = 0; // Initial image index

  late AnimationController _butterflyController;
  late Animation<Offset> _butterflyAnimation;
  // GlobalKey<_ButterflyState> butterflyKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    imageStreamController = StreamController<int>();
    _butterflyController = AnimationController(
      duration: Duration(seconds: 5), // Adjust the duration as needed
      vsync: this, // Make sure your State class is a TickerProvider
    );
    _butterflyAnimation = Tween<Offset>(
      begin: Offset(1, 0), // Starting position off-screen
      end: Offset(-1, 0), // Ending position off-screen
    ).animate(_butterflyController);
  }

  @override
  void dispose() {
    _timer.cancel();
    imageStreamController?.close();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // if(_isRunning==false)
        //   if (_secondsLeft == 0)
        //     _secondsLeft=15;

        if (_secondsLeft > 0) {
          _secondsLeft--;

          // Update the image index every 5 seconds
          if (_secondsLeft % 5 == 0) {
            initialImageIndex = (_secondsLeft ~/ 5) % imageAssets.length;
            imageStreamController?.add(initialImageIndex);
          }
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      _isRunning = false;
    });
    if (_secondsLeft == 0 && !_isRunning) {
      setState(() {
        _hasCompletedCycle = true; // Set the cycle completed flag to true
      });
    } else {
      setState(() {
        _hasCompletedCycle  = false; // Set the cycle completed flag to false
      });
    }
    _timer.cancel();
  }

  void resetTimer() {
    setState(() {
      _secondsLeft = 15; // Reset the timer to the initial time
      initialImageIndex = 0; // Reset the initial image index
      if (_isRunning) {
        // If the timer is running, stop it.
        stopTimer();
      }

      // Start the butterfly animation
      // butterflyKey.currentState?.startAnimation();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: const Color(0xffA9CBB2),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100,),
            if (_secondsLeft == 15 && !_isRunning)
              Image.asset(
                'assets/images/metamorphosis.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            if (_secondsLeft > 10 && _secondsLeft != 15)
              Image.asset(
                'assets/images/eggs.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            StreamBuilder<int>(
              stream: imageStreamController?.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int imageIndex = snapshot.data ?? 0;
                  String imagePath = imageAssets[(initialImageIndex + imageIndex) % imageAssets.length];
                  return Image.asset(
                    imagePath,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 20,),
            if (_hasCompletedCycle)
              // Butterfly(key: butterflyKey),
              Text(
                "You did it! Well Done!!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 20,),
            Text(
              "${(_secondsLeft % 60).toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  _isRunning
                      ? ElevatedButton(
                    onPressed: stopTimer,
                        child: Text('Pause Timer'),
                  )
                      : ElevatedButton(
                    onPressed: startTimer,
                        child: Text('Start Timer'),
                  ),
                SizedBox(width: 20),

                if (_secondsLeft !=0)
                    ElevatedButton(
                      onPressed: resetTimer,
                      child: Text('Reset Timer'),
                    ),
              ],
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}

// class Butterfly extends StatefulWidget {
//   const Butterfly({Key? key}) : super(key: key);
//
//   @override
//   _ButterflyState createState() => _ButterflyState();
// }
//
// class _ButterflyState extends State<Butterfly> with TickerProviderStateMixin{
//   late AnimationController _controller;
//   late Animation<Offset> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 5), // Adjust the duration as needed
//       vsync: this,
//     );
//     _animation = Tween<Offset>(
//       begin: Offset(1, 0), // Starting position off-screen
//       end: Offset(-1, 0), // Ending position off-screen
//     ).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void startAnimation() {
//     _controller.reset();
//     _controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _animation,
//       child: Image.asset(
//         'assets/images/butterflies.png',
//         width: 200, // Adjust the width as needed
//         height: 200, // Adjust the height as needed
//         fit: BoxFit.contain, // Adjust the fit as needed
//       ),
//     );
//   }
// }
