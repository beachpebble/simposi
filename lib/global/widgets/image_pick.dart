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
          return SizedBox(
            height: 170,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title:
                    Text(AppLocalizations.of(context)!.imageDialogCamera),
                    onTap: () async {
                      Navigator.pop(context);
                      final image =
                      await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        fileSelectCallback(image);
                      } else {
                        showErrorToast(
                            AppLocalizations.of(context)!.imageSelectError);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(
                        AppLocalizations.of(context)!.imageDialogGallery),
                    onTap: () async {
                      Navigator.pop(context);
                      final imageFile =
                      await picker.pickImage(source: ImageSource.gallery, maxHeight: 640, maxWidth: 640, imageQuality: 80);
                      if (imageFile != null) {
                        fileSelectCallback(imageFile);
                      } else {
                        showErrorToast(
                            AppLocalizations.of(context)!.imageSelectError);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}