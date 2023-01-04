import 'package:flutter/material.dart';

class WeightForm extends StatefulWidget {
  final void Function(String weight) save;

  WeightForm(this.save);

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final _formkey = GlobalKey<FormState>();

  var _addedWeight = '';

  void _save() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState!.save();
      widget.save(
        _addedWeight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('weight'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                    ),
                    onSaved: (value) {
                      _addedWeight = value!;
                    },
                  ),
                  TextButton(
                    onPressed: _save,
                    child: Text('Add weight'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
