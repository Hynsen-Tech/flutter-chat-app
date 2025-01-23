import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });
      widget.onPickImage(_pickedImageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CircleAvatar(
            radius: 80,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
            child: const Icon(
              Icons.account_circle,
              size: 140,
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton.icon(
              label: const Text('Image'),
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
            ),
          )
        ],
      ),
    );
  }
}
