/*
*  privacy.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/


import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';

class PrivacyScreen extends StatelessWidget {
  final double progress = 0.22;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicFormAppBar(),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            // TODO: Insert variable to pull Privacy from Admin Dashboard
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eros donec ac odio tempor orci dapibus ultrices in. Adipiscing commodo elit at imperdiet dui accumsan sit. Felis bibendum ut tristique et. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Facilisi nullam vehicula ipsum a. Viverra nam libero justo laoreet sit amet cursus. Fames ac turpis egestas sed tempus. Consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat. Aliquam malesuada bibendum arcu vitae elementum curabitur. Urna condimentum mattis pellentesque id nibh tortor. A scelerisque purus semper eget duis at tellus. Molestie at elementum eu facilisis sed odio morbi quis commodo. Ridiculus mus mauris vitae ultricies leo integer malesuada nunc vel. Sapien eget mi proin sed libero enim sed. Morbi quis commodo odio aenean sed adipiscing diam donec. Pellentesque elit eget gravida cum sociis natoque penatibus et magnis. Sagittis aliquam malesuada bibendum arcu vitae elementum curabitur vitae nunc. Lobortis feugiat vivamus at augue eget arcu dictum. Tristique nulla aliquet enim tortor at auctor.',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      );
}
