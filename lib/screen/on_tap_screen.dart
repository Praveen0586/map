import 'package:flutter/material.dart';
import 'package:map/data/locationdatas.dart';

class OnTapScreen extends StatelessWidget {
  OnTapScreen(this.selectedlocation, {super.key});
  Locationdatas selectedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedlocation.title),
        ),
        body: Stack(
          children: [
            Image.file(
              selectedlocation.imgae,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            )
          ],
        ));
  }
}
