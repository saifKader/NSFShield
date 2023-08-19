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
import '../widgets/loading_screen.dart';
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


  @override
  void initState() {
    super.initState();
    context.read<CheckCubit>().resetCheckState();
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
        backgroundColor: const Color(0xff00A152),
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
                // Handle state changes if needed
              },
              builder: (context, checkState) {
                if (checkState is CheckLoadInProgress) {
                  return Center(
                    child: DoneScreen(
                      customPaintSize: 200.0,
                    ),
                  );
                } else if (checkState is CheckSuccess) {
                  accountNumber = checkState.responseData;
                  print('hahouuuu $accountNumber');
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinCodeScreen(
                          accountNumber: accountNumber,
                          amount: _amount,
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
                } else if (checkState is CheckIsFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Check issuance failed: ${checkState.error}'),
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
                            context.read<CheckCubit>().extractAccountNumber(widget.scannedImage!);
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
