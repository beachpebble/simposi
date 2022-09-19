/*
*  eventdetails.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/bloc/rsvp_action/rsvp_action_bloc.dart';
import 'package:simposi_app_v4/calendar/calendarwidgets/tags_cloud.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/eventappbars.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  final EventModel eventModel;

  const EventDetails({Key? key, required this.eventModel}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final Completer<void> _initCompleter = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      _initCompleter.complete();
    });
    context
        .read<RsvpActionBloc>()
        .add(RsvpActionOpened(widget.eventModel.rsvp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: // InvitationAppBar(),
          EventAppBar(eventModel: widget.eventModel),
      // add logic to change app bar based on status
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        shrinkWrap: true,
        children: [
          if (widget.eventModel.showInvite)
            Row(
              children: [
                //INVITATION CARD
                InvitationCard(
                  eventModel: widget.eventModel,
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 200, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: CachedNetworkImage(
                    imageUrl: widget.eventModel.rsvp.image,
                    height: 438,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: AppProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),

          // EVENT DETAILS SECTION
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eventModel.rsvp.title,
                          style: const TextStyle(
                            fontSize: 21,
                            color: SimposiAppColors.simposiDarkGrey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // DATE & TIME
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('EEEE, MMMM dd')
                                      .format(widget.eventModel.rsvp.fullDate),
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  DateFormat('hh:mm')
                                      .format(widget.eventModel.rsvp.fullDate),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // LOCATION
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.eventModel.rsvp.event.locationName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: SimposiAppColors.simposiDarkGrey,
                                  ),
                                ),
                                Text(widget.eventModel.addressRepresentaion),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // RSVP COUNTS
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Who\'s Going',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: SimposiAppColors.simposiDarkGrey,
                                  ),
                                ),
                                // TODO: Pull Counts of RSVPs where Status = Accepted (I think we have a count field scoped for this so status might not be relevant)
                                Text('TODO: 1 Women, 2 Men, 1 LGBTQ'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),

          // ORGANIZED FOR
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Organized for',
                  style: TextStyle(
                    fontSize: 21,
                    color: SimposiAppColors.simposiDarkGrey,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    //TODO make common view
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                        ),
                        const SizedBox(width: 10),
                        Flexible(child: Text(widget.eventModel.gendersString)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            widget.eventModel.generationsString,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Icon(Icons.circle,
                              color: SimposiAppColors.simposiDarkBlue,
                              size: 10),
                        ),
                        const SizedBox(width: 10),
                        Flexible(child: Text(widget.eventModel.earningsString)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),

          // DESCRIPTION
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 21,
                    color: SimposiAppColors.simposiDarkGrey,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                Text(widget.eventModel.rsvp.event.description),
                const SizedBox(height: 10),
                TagsCloud(
                  interests: widget.eventModel.rsvp.event.wantToMeetInterests,
                ),
                const SizedBox(height: 10),
                if (widget.eventModel.longitude != null &&
                    widget.eventModel.latitude != null)
                  _googleMap(LatLng(widget.eventModel.latitude!,
                      widget.eventModel.longitude!)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _googleMap(LatLng loc) {
    return FutureBuilder(
        future: _initCompleter.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: AppProgressIndicator())
              : SizedBox(
                  height: 150,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    scrollGesturesEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition:
                        CameraPosition(target: loc, zoom: 11),
                    onTap: (loc) async {
                      final mapSchema = 'geo:${loc.latitude},${loc.longitude}';
                      if (await canLaunch(mapSchema)) {
                        await launch(mapSchema);
                      } else {
                        showErrorToast("Cant launch Maps app");
                      }
                    },
                    markers: _getMarkers(loc),
                  ),
                );
        });
  }

  Set<Marker> _getMarkers(LatLng? location) => location == null
      ? {}
      : {
          Marker(
            markerId: const MarkerId("Selected"),
            position: location,
            draggable: false,
          )
        };
}
