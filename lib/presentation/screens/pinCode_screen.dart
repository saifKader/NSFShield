import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsfsheild/presentation/screens/login.dart';
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

  PinCodeScreen({
    required this.accountNumber,
    required this.amount,
  });

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController _pinController = TextEditingController();
  bool _isPinFilled = false;

  void _submit() async {
    final userState = context.read<UserCubit>().state; // Assuming you have a UserCubit for managing user states
    if (userState is UserAuthenticated) {
      // If the user is authenticated, send the image and amount to the backend
      await context.read<CheckCubit>().sendImageAndAmountToBackend(
        widget.accountNumber,
        widget.amount,
        userState.accessToken,
      );
    } else {
      // Display a snackbar indicating the need to re-login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please login to proceed'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Login',
            onPressed: () {
              // Navigate to the login screen
              Navigator.of(context).pushReplacementNamed(AppRoutes.signInScreen);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0xff00A152),
        centerTitle: true,
        title: Text(
          'Pin Code', // Replace with your title
          style: const TextStyle(
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
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                ),
                const SizedBox(width: 5),
                const Text(
                  'NSFShield',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const IconButton(
              icon: Icon(
                Icons.notifications,
                size: 24,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CheckCubit, CheckState>(
          builder: (context, state) {
            if (state is CheckSuccess) {
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const MainScreen()
                  ),
                      (route) => false,
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
                          // Handle PIN entry completion
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
                    String enteredPin = _pinController.text;
                    if (enteredPin.length == 6) {
                      _submit();
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