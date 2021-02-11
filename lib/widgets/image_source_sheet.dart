import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  void imageSelected(File image) async {
    if (image != null) {
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 1,
        maxWidth: 1,
      );
      onImageSelected(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Text(
              'Câmera',
            ),
            onPressed: () async {
              // ignore: deprecated_member_use
              File image = await ImagePicker.pickImage(
                source: ImageSource.camera,
              );
              imageSelected(image);
            },
          ),
          FlatButton(
            child: Text(
              'Galeria',
            ),
            onPressed: () async {
              // ignore: deprecated_member_use
              File image = await ImagePicker.pickImage(
                source: ImageSource.gallery,
              );
              imageSelected(image);
            },
          ),
        ],
      ),
    );
  }
}