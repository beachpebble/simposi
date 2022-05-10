import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/image_pick.dart';

class EventPhotoPick extends StatefulWidget {
  final Function(String)? imageSelectCallback;
  final String? initialImage;

  const EventPhotoPick({
    this.imageSelectCallback,
    Key? key,
    this.initialImage,
  }) : super(key: key);

  @override
  _EventPhotoPickState createState() => _EventPhotoPickState();
}

class _EventPhotoPickState extends State<EventPhotoPick> {
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
            Icons.image,
            size: 100,
            color: SimposiAppColors.simposiDarkGrey.withOpacity(0.5),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              widget.initialImage != null ? Icons.edit : Icons.add_circle,
              size: 24,
              color: SimposiAppColors.simposiDarkBlue,
            ),
          )),
        ],
      );
    } else {
      return _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.fitWidth,
                height: 150,
                width: MediaQuery.of(context).size.width - 100,
                // width: 0,
              ))
          : CachedNetworkImage(
              imageUrl: widget.initialImage!,
        width: MediaQuery.of(context).size.width - 100,
              height: 150,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  SizedBox(height: 25, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
    }
  }
}
