import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsfsheild/presentation/screens/login.dart';
import 'package:nsfsheild/presentation/screens/scan_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../logic/cubits/check/check_cubit.dart';
import '../../logic/cubits/check/check_state.dart';
import '../../logic/cubits/user/user_cubit.dart';
import '../../logic/cubits/user/user_state.dart';
import '../router/routes.dart';
import '../widgets/button.dart';
import '../widgets/scan_done_screen.dart';
import 'main_screen.dart';

class PinCodeScreen extends StatefulWidget {
  final String accountNumber;
  final double amount;
  final String alertText;
  final String checkNumber;

  PinCodeScreen({
    required this.accountNumber,
    required this.amount,
    required this.alertText,
    required this.checkNumber,
  });

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController _pinController = TextEditingController();
  bool _isPinFilled = false;
  String pin = "";

  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      context.read<CheckCubit>().sendVerificationPin(widget.accountNumber);
    });
  }

  Future<void> _refreshUserData() async {
    final userCubit = context.read<UserCubit>();
    await userCubit.refreshUserData();
  }

  void _submit(String pin) async {
    print("check number is now: ${widget.checkNumber}");
    await context.read<CheckCubit>().issue_check(
          widget.accountNumber,
          widget.amount,
          pin,
          widget.checkNumber,
        );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        title: const Text(
          'Pin Code', // Replace with your title
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leadingWidth: screenWidth * 0.35,
        leading: InkWell(
          onTap: () {
            // Handle logo click if needed
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                SizedBox(
                  width: 35,
                  height: 35,
                  child:
                      Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CheckCubit, CheckState>(
          builder: (context, state) {
            if (state is CheckSuccess) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Check Success'),
                      content: Text(state.responseData),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => ScanScreen(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              });
              _refreshUserData();
            }
            else if (state is CheckIsFailure ){
Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Check Failed'),
                      content: Text(state.error),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => ScanScreen(),
                              ),
                                  (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                const Text(
                  'Please enter a 6-digit PIN to securely reserve funds for the scanned check.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Enter PIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 6,
                        cursorColor: Colors.black,
                        obscureText: true,
                        controller: _pinController,
                        onChanged: (pin) {
                          setState(() {
                            _isPinFilled = pin.length == 6;
                          });
                        },
                        onCompleted: (pin) {
                          //_submit(pin);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ButtonWidget(
                  backgroundColor: const Color(0xff003679),
                  width: screenWidth * 0.3,
                  text: 'Submit',
                  isDisabled: !_isPinFilled,
                  function: () {
                    print('Submit button pressed: ${_pinController.text}');
                    String enteredPin = _pinController.text;
                    if (enteredPin.length == 6) {
                      _submit(_pinController.text);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
