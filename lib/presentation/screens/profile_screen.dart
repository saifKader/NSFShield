import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsfsheild/logic/cubits/user/user_cubit.dart';
import 'package:nsfsheild/logic/cubits/user/user_state.dart';
import 'package:sizing/sizing.dart';
import '../widgets/button.dart';
import 'login.dart';

class ProfileScreen extends StatelessWidget {
  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final user = state.user.username;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(10.ss),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.ss),
                      bottomRight: Radius.circular(30.ss),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 30.ss,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 120.ss,
                            height: 120.ss,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 25.0,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/images/Profile.jpg'),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 36.ss,
                              height: 36.ss,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.secondary,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  // Handle edit action
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.ss),
                      Text(
                        _capitalizeFirstLetter(user),
                        style: textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.ss),
                    ],
                  ),
                ),
                SizedBox(height: 25.ss),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.ss),
                    child: Column(
                      children: [
                        CardItem(
                          icon: Icons.history,
                          title: 'Transactions History',
                          onTap: () {
                            // Handle transactions history action
                          },
                        ),
                        SizedBox(height: 20.ss),
                        CardItem(
                          icon: Icons.help,
                          title: 'Help and Assistance',
                          onTap: () {
                            // Handle help and assistance action
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            final token = state.accessToken;
                            await context.read<UserCubit>().logoutUser(token);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            padding: EdgeInsets.symmetric(vertical: 12.ss, horizontal: 30.ss),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.ss),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 18.ss,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.ss,
                                  child: Icon(
                                    Icons.exit_to_app,
                                    size: 30.ss,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 35.ss),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('User Not Authenticated'));
          }
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const CardItem({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.ss)),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.ss),
          leading: Icon(icon),
          title: Text(title, style: TextStyle(fontSize: 16.ss)),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
