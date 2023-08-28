import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountItemsContainer extends StatelessWidget {
  final String item;
  final String charge;
  final String dateString;
  final String type;
  final IconData icon;
  final Color color;

  AccountItemsContainer({
    required this.item,
    required this.charge,
    required this.dateString,
    required this.type,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Item clicked: $item');
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xFFF2F2F2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      dateString,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      charge,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: type == "Check" ? Colors.red : Colors.green,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Icon(icon, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
