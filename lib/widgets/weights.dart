import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Weights extends StatelessWidget {
  const Weights({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                  title: Text(
                    'Your weight: ' + docs[index]['weight'],
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
                              .doc(docs[index].id)
                              .delete();
                        },
                      ),
                    ],
                  )),
            );
          },
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
