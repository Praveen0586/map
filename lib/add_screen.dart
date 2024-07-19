import 'package:flutter/material.dart';
import 'package:map/data/locationdatas.dart';

class Add_Screen extends StatefulWidget {
  const Add_Screen({super.key});

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  void _savefuction() {
    _formkey.currentState!.save();
    Navigator.of(context).pop(
      Locationdatas(typedtext, DateTime.now().toString()),
    );
  }

  var _formkey = GlobalKey<FormState>();
  String typedtext = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Place',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(key: _formkey,
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              initialValue: '',
              decoration: const InputDecoration(
                label: Text('Location'),
              ),
              // validator: (value) {
              //   if (value == null || value.trim().isEmpty) {
              //     return 'Enter a valid value';
              //   }
              //   return value;
              // },
              onSaved: (newValue) {
              
                setState(() {
                  typedtext = newValue!;
                });
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _savefuction,
              child: Text('Add',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          )
        ],
      )),
    );
  }
}
