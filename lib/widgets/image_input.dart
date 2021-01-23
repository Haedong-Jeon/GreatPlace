import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'dart:io';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takePicture() async {
    print("camera!");
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final Directory appDir = await sysPaths.getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFile.path);

    // final File savedImage =
    //     await File(imageFile.path).copy('${File(imageFile.path)}');

    widget.onSelectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('no image!'),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
