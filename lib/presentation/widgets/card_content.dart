import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class CardContent extends StatelessWidget {
  final String title;
  final String date;
  final Color colorText;
  final double balance;
  final double blockedBalance;

  CardContent(this.title, this.date, this.colorText, this.balance, this.blockedBalance);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalBalance = balance + blockedBalance;
    final availableBalance = totalBalance - blockedBalance;
    final numberFormat = NumberFormat('#,##0.00', 'en_US');
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.secondary, Colors.blue[700]!],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondary,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/images/visa.png',
                width: 40, // Adjust the width
                height: 40, // Adjust the height
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Adjust the spacing
          Text(
            r"$" + (title == "Balance" ? numberFormat.format(totalBalance) : numberFormat.format(blockedBalance)),
            style: GoogleFonts.lato(
              color: colorText,
              fontSize: MediaQuery.of(context).size.width * 0.09,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8.0), // Adjust the spacing
          Text(
            "Today $date",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 16.0), // Adjust the spacing
          const Divider(
            color: Colors.white38,
            thickness: 1,
          ),
          const SizedBox(height: 8.0), // Adjust the spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Available Balance",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Text(
                r"$" + numberFormat.format(availableBalance), // Format to two decimal places
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


