import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/weights_dashboard.dart';

class Weights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final userData = FirebaseAuth.instance.currentUser;
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) => WeightDashboard(
            docs[index]['weight'],
            docs[index].id,
            docs[index]['userId'] == userData!.uid,
          ),
        );
      },
      stream: FirebaseFirestore.instance
          .collection('weights')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
    );
  }
}
