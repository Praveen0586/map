import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SelectPicture extends StatefulWidget {
  const SelectPicture({required this.onselectedimgae, super.key});

  final void Function(File imgae) onselectedimgae;
  State<SelectPicture> createState() {
    return _SelectPictureState();
  }
}

class _SelectPictureState extends State<SelectPicture> {
  File? _selectedimage;
  void _takeimage() async {
    var imagepicker = ImagePicker();
    final _pickedimage =
        await imagepicker.pickImage(source: ImageSource.camera);

    if (_pickedimage == null) {
      return;
    }
    setState(() {
      _selectedimage = File(_pickedimage.path);
    });
    widget.onselectedimgae(_selectedimage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
        onPressed: _takeimage,
        icon: Icon(Icons.camera),
        label: const Text(
          'Take Picture',
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ));
    if (_selectedimage != null) {
      content = GestureDetector(
        onTap: _takeimage,
        child: Image.file(
          _selectedimage!,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.primary)),
      height: 250,
      width: double.infinity,
      child: Center(child: content),
    );
  }
}
