import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlareActor(
              "assets/success_animation.flr", // Replace with your Flare animation file
              animation: "success",
              fit: BoxFit.contain,
            ),
            Text('Check issued successfully!'),
          ],
        ),
      ),
    );
  }
}
