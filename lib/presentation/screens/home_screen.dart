import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../logic/cubits/check/transaction_cubit.dart';
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
            final token = state.accessToken;
            context.read<TransactionCubit>().loadCheckTransactions(token);
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
                    child: displayAccountTransactions(),
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

  Widget displayAccountTransactions() {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          final transactions = state.transactions;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return AccountItemsContainer(
                item: "Check Transaction",
                // Customize as needed
                charge: "- \$ ${transaction.amount}",
                // Assuming amount is a double
                dateString: DateFormat("dd-MM-yyyy")
                    .format(transaction.transactionDate),
                type: "Check",
                // Customize as needed
                icon: Icons.add,
              );
            },
          );
        } else if (state is TransactionLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TransactionError) {
          return Center(child: Text("Error loading transactions."));
        } else {
          // Handle other transaction states or show a loading/error state
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
