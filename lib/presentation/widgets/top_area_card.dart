import 'package:flutter/material.dart';

class TopAreaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          gradient: RadialGradient(
            colors: [Color(0xff00A152), Color(0xff00A152)],
          ),
        ),
        padding: EdgeInsets.all(5.0),
        child: const Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  "Balance",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),

              ],
            ),
            Text(
                  r"$ " "95,940.00",
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
            SizedBox(height: 35.0),
          ],
        ),
      ),
    );
  }
}
