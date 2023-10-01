import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsfsheild/presentation/screens/account_entry_screen.dart';
import 'package:nsfsheild/presentation/screens/pinCode_screen.dart';
import 'package:sizing/sizing.dart';

import '../../logic/cubits/check/check_cubit.dart';
import '../../logic/cubits/check/check_state.dart';

import '../widgets/appBar.dart';
import '../widgets/button.dart';
import '../widgets/scan_done_screen.dart';
import '../widgets/text_form_field.dart';

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
  int failedAttempts = 0;
  String checkNumber = '';
  TextEditingController amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<CheckCubit>().resetCheckState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Amount",
          useRoundedShape: true,
          onBackPress: () {
            //pop
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<CheckCubit, CheckState>(
          listener: (context, checkState) {
            if (checkState is CheckIsFailure) {
              failedAttempts++; // Increase the failedAttempts count
            print('the failed attempts is ${checkState.error}');
              // NEW: Check if failedAttempts is equal to 2
              if (failedAttempts >= 1) {
                context.read<CheckCubit>().resetCheckState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManualEntryScreen(amount: _amount),
                  ),
                );
              }

              /*ScaffoldMessenger.of(context).showSnackBar(
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
              );*/
            }
          },
          builder: (context, checkState) {
            if (checkState is CheckLoadInProgress) {
              return const Center(
                child: DoneScreen(
                  customPaintSize: 200.0,
                ),
                /*child: Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_8xwzvz.json',
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill)*/
              );
            } else if (checkState is CheckOCRSuccess) {
              _alertText = "\$$_amount blocked";
              accountNumber = checkState.RIB;
              checkNumber = checkState.checkNumber;

              print('the account number is $accountNumber');
              print('the check number is $checkNumber');
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinCodeScreen(
                      accountNumber: accountNumber,
                      amount: _amount,
                      alertText: _alertText,
                      checkNumber: checkNumber,
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
              return SingleChildScrollView(
                child: Center(
                  heightFactor: 1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.file(
                        widget.scannedImage!,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormFieldWidget(
                          controller: amountController,
                          labelText: 'Enter Amount',
                          inputType: TextInputType.number,
                          icon: Text('DT',
                              style: TextStyle(
                                  color: theme.colorScheme.tertiary,
                                  fontSize: 18)),
                          onChanged: (value) {
                            _amount = double.tryParse(value) ?? 0.0;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: screenWidth * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF003679).withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ButtonWidget(
                          text: 'Next',
                          backgroundColor: Color(0xff003679),
                          width: MediaQuery.of(context).size.width * 0.3,
                          function: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text(
                                      'Are you sure you want to block ${_amount.toStringAsFixed(0)} DT?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}