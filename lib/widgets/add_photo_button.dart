import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

class AddPhotoButton extends StatefulWidget {
  // Set Variables
  final Function(String)? imageSelectCallback;
  final String? initialImage;

  const AddPhotoButton({
    this.imageSelectCallback,
    Key? key,
    this.initialImage,
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
                      showErrorToast(
                          AppLocalizations.of(context)!.imageSelectError);
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
                      showErrorToast(
                          AppLocalizations.of(context)!.imageSelectError);
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
        child: _getImage());
  }

  Widget _getImage() {
    if (_image == null && widget.initialImage == null) {
      return Image.asset('assets/images/addphoto.png', width: 100, height: 100);
    } else {
      return Stack(
        children: [
          _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ))
              : CachedNetworkImage(
                  imageUrl: widget.initialImage!,
                  width: 100,
                  height: 100,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      SizedBox(height: 25, child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.add_circle,
              size: 24,
              color: SimposiAppColors.simposiDarkBlue,
            ),
          )),
        ],
      );
    }
  }
}
