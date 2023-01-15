import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightDashboard extends StatelessWidget {
  final String weight;
  final String id;
  final bool isMe;
  WeightDashboard(this.weight, this.id, this.isMe);

  @override
  Widget build(BuildContext context) {
    return isMe
        ? Card(
            margin: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 7,
            ),
            color: Color.fromARGB(255, 225, 113, 150),
            shadowColor: Colors.pink,
            elevation: 3,
            child: ListTile(
              title: Text(
                'Your weight: ' + weight,
                style: Theme.of(context).textTheme.headline1,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(),
                    icon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 241, 160, 39),
                    ),
                    onPressed: () async {
                      // could not do it, i only manage to do it statically not dynamically :(
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 215, 22, 8),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('weights')
                          .doc(id)
                          .delete();
                    },
                  ),
                ],
              ),
            ),
          )
        : Center();
  }
}
