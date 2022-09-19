/*
*  createevent2location.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/utils/location.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

import '../../app_router.dart';
import 'createevent2_location_cubit.dart';

class CreateEvent2 extends StatelessWidget {
  const CreateEvent2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CreateEvent2LocationCubit(editEventCubit: context.read())
              ..refreshInitial(),
        child: _CreateEvent2View());
  }
}

class _CreateEvent2View extends StatefulWidget {
  @override
  _CreateEvent2State createState() => _CreateEvent2State();
}

class _CreateEvent2State extends State<_CreateEvent2View> {
  double progress = 0.32;
  final _placeSearchController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final Completer<void> _initCompleter = Completer();

  @override
  void initState() {
    super.initState();
    determinePosition()
        .then((value) => context
            .read<CreateEvent2LocationCubit>()
            .selectInitialLocation(LatLng(value.latitude, value.longitude)))
        .catchError((e) {
      showErrorToast("There is no location permission");
      context.read<CreateEvent2LocationCubit>().noPermission();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 200));
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
      resizeToAvoidBottomInset: false,
      appBar: BasicFormAppBar(),
      body: BlocBuilder<CreateEvent2LocationCubit, CreateEvent2LocationState>(
        builder: (context, state) {
          return Column(
            children: [
              // Header
              Column(
                children: [
                  const SizedBox(height: 45),
                  LinearProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation(
                        SimposiAppColors.simposiDarkBlue),
                    backgroundColor: SimposiAppColors.simposiFadedBlue,
                  ),
                  const SizedBox(height: 70),
                  Text(
                    'I want to meet nearby...',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _searchBar(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Body
              Expanded(
                child: SizedBox(
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

              // Footer
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.address ?? ""),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ContinueButton(
                          buttonAction: state.selectedLocation != null
                              ? () {
                                  AutoRouter.of(context).push(
                                      const CreateEvent3ActivitiesRoute());
                                }
                              : null),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ));

  Widget _searchBar() {
    return TextField(
      controller: _placeSearchController,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(
        hintText: 'Search a location',
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (value) =>
          context.read<CreateEvent2LocationCubit>().searchPlace(value),
    );
  }

  Widget _googleMap(CreateEvent2LocationState state) {
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
                    context
                        .read<CreateEvent2LocationCubit>()
                        .selectLocation(loc);
                  },
                );
        });
  }

  Widget _searchResult(CreateEvent2LocationState state) {
    return Container(
      color: Colors.black26,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
            itemCount: state.searchResults.length,
            itemBuilder: (context, index) {
              return _searchItem(state.searchResults[index]);
            }),
      ),
    );
  }

  Widget _searchItem(PlacesSearchResult placesSearchResult) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              placesSearchResult.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              placesSearchResult.formattedAddress ?? "",
            ),
            onTap: () async {
              if (placesSearchResult.geometry != null) {
                final controller = await _controller.future;
                final newLoc = LatLng(placesSearchResult.geometry!.location.lat,
                    placesSearchResult.geometry!.location.lng);
                controller.animateCamera(CameraUpdate.newLatLng(newLoc));
                setState(() {
                  context
                      .read<CreateEvent2LocationCubit>()
                      .selectLocation(newLoc);
                  _placeSearchController.clear();
                });
              }
            },
          )),
    );
  }

  Set<Marker> _getMarkers(LatLng? location) => location == null
      ? {}
      : {
          Marker(
              markerId: const MarkerId("Selected"),
              position: location,
              draggable: true,
              onDragEnd: ((newPosition) {
                context
                    .read<CreateEvent2LocationCubit>()
                    .selectLocation(newPosition);
              }))
        };
}
