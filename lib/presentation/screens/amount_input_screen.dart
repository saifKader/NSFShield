import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nsfsheild/presentation/screens/pinCode_screen.dart';

import '../../logic/cubits/check/check_cubit.dart';
import '../../logic/cubits/check/check_state.dart';
import '../../logic/cubits/user/user_cubit.dart'; // Import your UserCubit
import '../../logic/cubits/user/user_state.dart';

import '../widgets/button.dart';
import '../widgets/scan_done_screen.dart';
import '../widgets/text_form_field.dart';
import 'main_screen.dart'; // Import your UserState

class AmountInputScreen extends StatefulWidget {
  final File? scannedImage;

  AmountInputScreen({required this.scannedImage});

  @override
  _AmountInputScreenState createState() => _AmountInputScreenState();
}


class _AmountInputScreenState extends State<AmountInputScreen> {
  double _amount = 0;
  String accountNumber = '';
  String _alertText = '';


  @override
  void initState() {
    super.initState();
    context.read<CheckCubit>().resetCheckState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
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
          'Enter amount to block', // Replace with your title
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
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserAuthenticated) {
            return BlocConsumer<CheckCubit, CheckState>(
              listener: (context, checkState) {
                if (checkState is CheckIsFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(checkState.error),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 10),
                      action: SnackBarAction(
                        label: 'Try Again',
                        onPressed: () {
                          context.read<CheckCubit>().resetCheckState();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                }
              },
              builder: (context, checkState) {
                if (checkState is CheckLoadInProgress) {
                  return Center(
                    child: DoneScreen(
                      customPaintSize: 200.0,
                    ),
                  );
                } else if (checkState is CheckSuccess) {
                  _alertText = "\$$_amount blocked";
                  accountNumber = checkState.responseData;
                  print('hahouuuu $accountNumber');
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinCodeScreen(
                          accountNumber: accountNumber,
                          amount: _amount,
                          alertText: _alertText,
                        ),
                      ),
                    );
                  });
                  context.read<CheckCubit>().resetCheckState();
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Check issuance successful'),
                        SizedBox(height: 20),
                        // Display scan bar or other relevant UI
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(widget.scannedImage!),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormFieldWidget(
                            controller: TextEditingController(),
                            labelText: 'Enter Amount',
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              _amount = double.tryParse(value) ?? 0.0;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonWidget(
                          text: 'Next',
                          backgroundColor: Color(0xff003679),
                          width: MediaQuery.of(context).size.width * 0.3,
                          function: () {
                            // Show the confirmation dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text('Are you sure you want to block $_amount?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                        // Proceed with the action
                                        context.read<CheckCubit>().extractAccountNumber(widget.scannedImage!);
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                      ],
                    ),
                  );
                }
              },
            );
          } else {
            // Handle other user states if needed
            return Center(child: Text('User not authenticated'));
          }
        },
      ),
    );
  }

}
