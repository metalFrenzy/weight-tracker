import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/weights.dart';
import '../screens/add_weight_screen.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DASHBOARD',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
            label: Text(
              'logOut',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Weights(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddWeightForm.routeName);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
