import 'package:bytebank/screens/contact_list.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ContactList())),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 100,
                width: 150,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    Text(
                      'Contacts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
