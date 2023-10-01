import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsfsheild/logic/cubits/user/user_cubit.dart';
import 'package:nsfsheild/logic/cubits/user/user_state.dart';
import 'package:nsfsheild/presentation/router/routes.dart';
import 'package:nsfsheild/utils/strings.dart';
import 'package:nsfsheild/utils/theme.dart';
import 'package:sizing/sizing.dart';

import '../widgets/button.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_form_field.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) async {
          // Handle different user states here
          if (state is UserLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  dialogContext = context;
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (state is UserAuthenticated) {
            Navigator.pop(dialogContext!);
            // Navigate to the main screen
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainScreen()));
          } else if (state is UserError) {
            Navigator.pop(dialogContext!);
            showSnackBar(context, state.message);
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // Wrap with SingleChildScrollView
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.kbigSpace,
                  vertical: AppSizes.khugeSpace),
              color: theme.colorScheme.background,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.khugeSpace),
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: AppSizes.khugeImageSize,
                      width: AppSizes.khugeImageSize,
                    ),
                    Text(
                      AppStrings.ksignInPrompt,
                      style: GoogleFonts.pressStart2p(
                        color: theme.colorScheme.secondary,
                        fontSize: AppSizes.ktitleTextHeight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.kbigSpace),
                    TextFormFieldWidget(
                      controller: _usernameController,
                      labelText: AppStrings.kusername,
                      inputType: TextInputType.name,
                    ),
                    const SizedBox(height: AppSizes.kbigSpace),
                    TextFormFieldWidget(
                      controller: _passwordController,
                      labelText: AppStrings.kpassword,
                      inputType: TextInputType.visiblePassword,
                      //obscureText: true,
                    ),
                    const SizedBox(height: AppSizes.kbigSpace),
                    Center(
                      child: ButtonWidget(
                        text: AppStrings.klogin,
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle the login action
                            context.read<UserCubit>().loginUser(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                          }
                        },
                      ),
                    ),
                    // Add the remaining UI elements as needed
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
