import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoButton extends StatefulWidget {
  // Set Variables
  final Function(String)? imageSelectCallback;

  const AddPhotoButton({
    this.imageSelectCallback,
    Key? key,
  }) : super(key: key);

  @override
  _AddPhotoButtonState createState() => _AddPhotoButtonState();
}

class _AddPhotoButtonState extends State<AddPhotoButton> {
  PickedFile? _image;
  final _picker = ImagePicker();

  void _settingModalBottomSheet(
      context, Function(PickedFile) fileSelectCallback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title:
                      new Text(AppLocalizations.of(context)!.imageDialogCamera),
                  onTap: () async {
                    Navigator.pop(context);
                    PickedFile? image =
                        await _picker.getImage(source: ImageSource.camera);
                    if (image != null)
                      fileSelectCallback(image);
                    else
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.imageSelectError);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text(
                      AppLocalizations.of(context)!.imageDialogGallery),
                  onTap: () async {
                    Navigator.pop(context);
                    PickedFile? image =
                        await _picker.getImage(source: ImageSource.gallery);
                    if (image != null)
                      fileSelectCallback(image);
                    else
                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.imageSelectError);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _settingModalBottomSheet(context, (val) {
          setState(() {
            _image = val;
          });
          widget.imageSelectCallback?.call(val.path);
        });
      },
      child: _image == null
          ? Image.asset('assets/images/addphoto.png', width: 100, height: 100)
          : ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              )),
    );
  }
}
