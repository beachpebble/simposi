import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/image_pick.dart';

class ProfilePhotoPickButton extends StatefulWidget {
  final Function(String)? imageSelectCallback;
  final String? initialImage;

  const ProfilePhotoPickButton({
    this.imageSelectCallback,
    Key? key,
    this.initialImage,
  }) : super(key: key);

  @override
  _ProfilePhotoPickButtonState createState() => _ProfilePhotoPickButtonState();
}

class _ProfilePhotoPickButtonState extends State<ProfilePhotoPickButton> {
  XFile? _image;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ImagePick.settingModalBottomSheet(context, _picker, (val) {
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
      return Stack(
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: SimposiAppColors.simposiDarkGrey.withOpacity(0.5),
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
