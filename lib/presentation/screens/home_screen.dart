import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../logic/cubits/user/user_cubit.dart';
import '../../logic/cubits/user/user_state.dart';
import '../widgets/account_items_container.dart';
import 'package:flip_card/flip_card.dart';

import '../widgets/card_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshUserData();
  }

  Future<void> _refreshUserData() async {
    final userCubit = context.read<UserCubit>();
    await userCubit.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00A152),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final user = state.user;
            final balance = user.accounts?[0].balance ?? 0.0;
            final blockedBalance = user.accounts?[0].blockedBalance ?? 0.0;
            String formattedDate = DateFormat("dd MMM").format(DateTime.now());

            return Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: CardContent("Balance", formattedDate, Colors.white,
                          balance, blockedBalance),
                      back: CardContent("Blocked balance", formattedDate,
                          Colors.red[900]!, balance, blockedBalance),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: displayAccountList(),
                  ),
                ),
              ],
            );
          } else {
            // Handle other user states or show a loading/error state
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget displayAccountList() {
    return ListView(
      children: <Widget>[
        AccountItemsContainer(
          item: "Trevello App",
          charge: r"+ $ 4,946.00",
          dateString: "28-04-16",
          type: "credit",
          icon: Icons.add,
        ),
        AccountItemsContainer(
          item: "Creative Studios",
          charge: r'+ $ 5,428.00',
          dateString: "26-04-16",
          type: "credit",
          icon: Icons.add,
        ),
        AccountItemsContainer(
          item: "Amazon EU",
          charge: r"+ $ 746.00",
          dateString: "25-04-16",
          type: "Payment",
          icon: Icons.add,
        ),
        // Add more AccountItemsContainer widgets here
      ],
    );
  }
}
