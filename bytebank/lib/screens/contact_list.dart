import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text(
                  'Johnny',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                subtitle: Text(
                  '1000',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){}
      ),
    );
  }
}
