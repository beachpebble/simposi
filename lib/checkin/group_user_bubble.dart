import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/checkin/bloc/group_finder_bloc.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

class GroupUserBubble extends StatelessWidget {
  final GroupUserWithRange user;
  final VoidCallback? onTap;

  const GroupUserBubble({Key? key, required this.user, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user.user.name, style: TextStyle().copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),),
            CachedNetworkImage(
              imageUrl: user.user.imageUrl,
              width: 50,
              height: 50,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: SimposiAppColors.simposiPink),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  SizedBox(height: 25, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          ],
        ),
      ),
    );
  }
}
