import 'package:flutter/material.dart';

class OnTapScreen extends StatelessWidget {
  OnTapScreen(this.selectedlocation, {super.key});
  String selectedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedlocation),
      ),
      body: Center(
        child: Text(selectedlocation),
      ),
    );
  }
}
