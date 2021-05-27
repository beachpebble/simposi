/*
*  creaeeventform.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';


class CreateEventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    child: Scaffold(
      appBar: BasicFormAppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [

        Form(
          child: Column(
            children: [
              // TODO: Hide this container if an image has been uploaded
              // IMAGE UPLOAD BUTTON CONTAINER
              Container(
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: AddEventImageButton(),
                    ),
                    SizedBox(height: 10),
                    Text('Create an Activity',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: SimposiAppColors.simposiDarkGrey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Post an activity and we\’ll invite everyone \nwho matches your activity settings.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // TODO: Show the Event image for the full height and width of the container if uploaded
              // TODO: Enable tap on image to open the image uploader (replace image)
              // IMAGE UPLOADED CONTAINER
//          Container(
//            height: 260,
//            child: ,
//          ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    _eventTitle(),
                    _eventDescription(),
                    _eventDateTime(),
                    _eventTags(),
                  ],
                )),

              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Text('Who do you want to invite'),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    _eventGender(),
                    _eventGenerations(),
                    _eventIncome(),
                    SizedBox(height: 30),
                    BigButton(
                        buttonLabel: 'Create Activity',
                        buttonAction: () => {
                          Navigator.of(context).pushNamed('/pickinvitation'),
                        },
                        buttonColor: SimposiAppColors.simposiLightGrey,
                        textColor: SimposiAppColors.simposiDarkGrey,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),

            ],
          ),
        ),
        ],

      ),
    ),
  );
}


// ACTIVITY TITLE
Widget _eventTitle() => TextFormField(
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
  enableSuggestions: true,
  autocorrect: true,
  maxLength: 60,
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Title',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);


// DESCRIPTION
Widget _eventDescription() => TextFormField(
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
  enableSuggestions: true,
  autocorrect: true,
  maxLength: 500,
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Description',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);

// DATE/TIME FIELD
Widget _eventDateTime() => TextFormField(
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Date & Time',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 40, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    suffixIcon: Icon(Icons.chevron_right),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);

// ACTIVITY TAGS
Widget _eventTags() => TextFormField(
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Who Like',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 40, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    suffixIcon: Icon(Icons.chevron_right),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);


// GENDER
Widget _eventGender() => TextFormField(
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Who Identify As',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 40, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    suffixIcon: Icon(Icons.chevron_right),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);


// GENERATIONS
Widget _eventGenerations() => TextFormField(
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Who Are',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 40, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    suffixIcon: Icon(Icons.chevron_right),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);


// INCOME
Widget _eventIncome() => TextFormField(
  style: TextStyle(
    fontWeight: FontWeight.w500,
    color: SimposiAppColors.simposiLightText,
  ),
  decoration: InputDecoration(
    labelText: 'Who Earn',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.fromLTRB(0, 40, 0, 5),
    labelStyle: TextStyle(
      fontSize: 17,
      color: SimposiAppColors.simposiDarkGrey,
      fontWeight: FontWeight.w900,
      height: 0.4,
    ),
    suffixIcon: Icon(Icons.chevron_right),
    focusColor: SimposiAppColors.simposiDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SimposiAppColors.simposiDarkBlue,
      ),
    ),
  ),
);