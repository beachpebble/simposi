/*
*  signup6location.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/utils/location.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:simposi_app_v4/widgets/progress.dart';

import 'signup6_location_cubit.dart';

class SignUpForm6 extends StatefulWidget {
  @override
  _SignUpForm6State createState() => _SignUpForm6State();
}

class _SignUpForm6State extends State<SignUpForm6> {
  double progress = 0.85;
  final _placeSearchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  Completer<void> _initCompleter = Completer();

  @override
  void initState() {
    super.initState();
    determinePosition()
        .then((value) => context
            .read<Signup6LocationCubit>()
            .selectLocation(LatLng(value.latitude, value.longitude)))
        .catchError((e) {
      showErrorToast("There is no location permission");
      context.read<Signup6LocationCubit>().noPermission();
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 200));
      _initCompleter.complete();
    });
  }

  @override
  void dispose() {
    _placeSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: BasicFormAppBar(),
      body: BlocBuilder<Signup6LocationCubit, Signup6LocationState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 45),
              Container(
                child: LinearProgressIndicator(
                  value: progress,
                  valueColor:
                      AlwaysStoppedAnimation(SimposiAppColors.simposiDarkBlue),
                  backgroundColor: SimposiAppColors.simposiFadedBlue,
                ),
              ),
              SizedBox(height: 70),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      // Header Title
                      Text(
                        'I want to meet nearby...',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: SimposiAppColors.simposiDarkGrey,
                        ),
                      ),
                      SizedBox(height: 20),
                      _searchBar(),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: state.selectedLocation == null
                              ? Center(child: AppProgressIndicator())
                              : Stack(
                                  children: [
                                    _googleMap(state),
                                    if (state.searchResults.isNotEmpty)
                                      _searchResult(state)
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _rangeSlider(state)
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    ContinueButton(
                        buttonAction: state.selectedLocation != null
                            ? () {
                                Navigator.of(context).pushNamed('/signup7');
                              }
                            : null),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          );
        },
      ));

  Widget _rangeSlider(Signup6LocationState state) {
    String units = localeIsImperial ? "miles" : "km";
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text("${state.range.round()} $units from home"),
        SizedBox(
          height: 10,
        ),
        Slider(
          value: state.range,
          min: 1,
          max: 150,
          divisions: 100,
          label: "${state.range.round()} $units",
          onChanged: (double value) {
            context.read<Signup6LocationCubit>().selectRange(value);
          },
        )
      ],
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _placeSearchController,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        hintText: 'Search place',
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (value) =>
          context.read<Signup6LocationCubit>().searchPlace(value),
    );
  }

  Widget _googleMap(Signup6LocationState state) {
    double range = localeIsImperial ? state.range * 1.6 : state.range;
    return FutureBuilder(
        future: _initCompleter.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: AppProgressIndicator())
    : GoogleMap(
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: state.selectedLocation!, zoom: 11),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _getMarkers(state.selectedLocation),
        onTap: (loc) {
          context.read<Signup6LocationCubit>().selectLocation(loc);
        },
        circles: _getCircle(state.selectedLocation, range));
        });
  }

  Widget _searchResult(Signup6LocationState state) {
    return Container(
      child: ListView.builder(
          itemCount: state.searchResults.length,
          itemBuilder: (context, index) {
            return _searchItem(state.searchResults[index]);
          }),
    );
  }

  Widget _searchItem(PlacesSearchResult placesSearchResult) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: ListTile(
            title: Text(
              placesSearchResult.name,
            ),
            subtitle: Text(
              placesSearchResult.formattedAddress ?? "",
            ),
            onTap: () async {
              if (placesSearchResult.geometry != null) {
                final GoogleMapController controller = await _controller.future;
                var newLoc = LatLng(placesSearchResult.geometry!.location.lat,
                    placesSearchResult.geometry!.location.lng);
                controller.animateCamera(CameraUpdate.newLatLng(newLoc));
                setState(() {
                  context.read<Signup6LocationCubit>().selectLocation(newLoc);
                  _placeSearchController.clear();
                });
              }
            },
          )),
    );
  }

  Set<Circle> _getCircle(LatLng? location, double range) => location == null
      ? {}
      : Set.from([
          Circle(
            strokeColor: SimposiAppColors.simposiLightBlue,
            strokeWidth: 1,
            fillColor: SimposiAppColors.simposiLightBlue.withOpacity(0.5),
            circleId: CircleId("myplace"),
            center: location,
            radius: range * 1000,
          )
        ]);

  Set<Marker> _getMarkers(LatLng? location) => location == null
      ? {}
      : Set.from([
          Marker(
              markerId: MarkerId("Selected"),
              position: location,
              draggable: true,
              onDragEnd: ((newPosition) {
                context
                    .read<Signup6LocationCubit>()
                    .selectLocation(newPosition);
              }))
        ]);

  static bool get localeIsImperial {
    final String defaultLocale = Platform.localeName;
    return defaultLocale.endsWith("US");
  }
}
