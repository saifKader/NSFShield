import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nsfsheild/presentation/screens/pinCode_screen.dart';

import '../widgets/appBar.dart';
import '../widgets/button.dart';
import '../widgets/text_form_field.dart';

class ManualEntryScreen extends StatefulWidget {
  final double amount;

  ManualEntryScreen({required this.amount});

  @override
  _ManualEntryScreenState createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  TextEditingController ribController = TextEditingController();
  TextEditingController checkNumberController = TextEditingController();
  String accountNumber = '';
  String _alertText = '';
  String checkNumber = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Account Details",
        useRoundedShape: true,
        onBackPress: () {
          //pop back
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: TextEditingController(),
              labelText: 'Enter RIB',
              inputType: TextInputType.number,
              onChanged: (value) {
                accountNumber = value;
              },
            ),
            SizedBox(height: 16.0),
            TextFormFieldWidget(
              controller: TextEditingController(),
              labelText: 'Enter Check Number',
              inputType: TextInputType.number,
              onChanged: (value) {
                checkNumber = value;
              },
            ),
            SizedBox(height: 32.0),
            ButtonWidget(
              text: 'Submit',
              backgroundColor: Color(0xff003679),
              width: MediaQuery.of(context).size.width * 0.3,
              function: () {
                _alertText = "aaaaa zzzz blocked";
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PinCodeScreen(
                        accountNumber: accountNumber,
                        checkNumber: checkNumber,
                        amount: widget.amount,
                        alertText: _alertText,
                      ),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
