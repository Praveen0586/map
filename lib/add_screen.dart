import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map/data/locationdatas.dart';
import 'package:map/providers/list_provider.dart';
import 'package:map/widget/camera.dart';
import 'dart:io';

import 'package:map/widget/location_selector.dart';

class Add_Screen extends ConsumerStatefulWidget {
  const Add_Screen({super.key});

  @override
  ConsumerState<Add_Screen> createState() => Add_ScreenState();
}

class Add_ScreenState extends ConsumerState<Add_Screen> {
  LocationDetails? _selectedlocation;
  File? _selectedimage;
  final textContriller = TextEditingController();
  @override
  void dispose() {
    textContriller.dispose();
    super.dispose();
  }

  void _saveit() {
    final enterdtext = textContriller.text;

    if (enterdtext.isEmpty) {
      return;
    }
    ref
        .read(addplacenotifier.notifier)
        .additem(enterdtext, _selectedimage!, _selectedlocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Place',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                  controller: textContriller,
                  decoration: const InputDecoration(
                    label: Text('Place'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SelectPicture(
                  onselectedimgae: (imgae) {
                    _selectedimage = imgae;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                LocationSelector(
                  onSelectedLocation: (location) {
                    _selectedlocation = location;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: _saveit, child: const Text('Add')),
                )
              ],
            )));
  }
}

 // String typedtext = '';
  // var _formkey = GlobalKey<FormState>();
 // void _savefuction() {
  //   if (_formkey.currentState!.validate()) {
  //     _formkey.currentState!.save();
  //     Navigator.of(context).pop(
  //       Locationdatas(typedtext),
  //     );
  //   }
  // }

 // Form(
      //     key: _formkey,
      //     child: Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(12),
      //           child: TextFormField(
      //             initialValue: '',
      //             decoration: const InputDecoration(
      //               label: Text('Location'),
      //             ),
      //             validator: (value) {
      //               if (value == null || value.trim().isEmpty) {
      //                 return 'Enter a valid value';
      //               }
      //               return null;
      //             },
      //             onSaved: (newValue) {
      //               setState(() {
      //                 typedtext = newValue!;
      //               });
      //             },
      //           ),
      //         ),
      //         Center(
      //           child: ElevatedButton(
      //             onPressed: _savefuction,
      //             child: Text('Add',
      //                 style: TextStyle(
      //                     color: Theme.of(context).colorScheme.onBackground)),
      //           ),
      //         )
      //       ],
      //     )),
