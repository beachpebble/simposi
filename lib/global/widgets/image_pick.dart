import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

class ImagePick {
  static   void settingModalBottomSheet(
      context, ImagePicker picker, Function(XFile) fileSelectCallback) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 170,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.camera),
                    title:
                    new Text(AppLocalizations.of(context)!.imageDialogCamera),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
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
                      XFile? imageFile =
                      await picker.pickImage(source: ImageSource.gallery, maxHeight: 640, maxWidth: 640, imageQuality: 80);
                      if (imageFile != null)
                        fileSelectCallback(imageFile);
                      else
                        showErrorToast(
                            AppLocalizations.of(context)!.imageSelectError);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}