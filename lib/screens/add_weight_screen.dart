

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_weight_form.dart';

class AddWeightForm extends StatefulWidget {
  static const routeName = '/add';

  @override
  State<AddWeightForm> createState() => _AddWeightFormState();
}

class _AddWeightFormState extends State<AddWeightForm> {
  void _save(
    String weight,
  ) {
    FirebaseFirestore.instance.collection('weights').add({
      'weight': weight,
      'createdAt': Timestamp.now(),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Weight'),
      ),
      body: WeightForm(_save),
    );
  }
}
