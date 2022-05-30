/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

// Global
import 'package:flutter/material.dart';
// Discover
import 'package:simposi_app_v4/discover/discoverscreen.dart';
import 'package:simposi_app_v4/eventdetails/reportevent.dart';
import 'package:simposi_app_v4/notifications/adminalert.dart';
// Alerts & Notifications
import 'package:simposi_app_v4/notifications/alertsscreen.dart';
import 'package:simposi_app_v4/notifications/newtimesuggestedalert.dart';
import 'package:simposi_app_v4/notifications/youlikeeachother.dart';

@deprecated
class RouteGenerator {
  static const String FORGOT_PASSWORD_DL = "/ResetPassword?token=";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    print("!!! route ${settings.name}");
    switch (settings.name) {
      // Calendar
      // case '/eventlist':
      //   return MaterialPageRoute(builder: (_) => SimposiCalendar());
      // case '/cancelrsvp':
      //   return MaterialPageRoute(builder: (_) => CancelRSVP());
      // case '/eventdetails':
      //   return MaterialPageRoute(builder: (_) => EventDetails());
      // case '/invitationcard':
      //   return MaterialPageRoute(builder: (_) => InvitationCard());
      // case '/proposenewtime':
      //   return MaterialPageRoute(builder: (_) => ProposeNewTime());
      case '/reportevent':
        return MaterialPageRoute(builder: (_) => ReportEvent());

      // Check In
      // case '/firsttoarrive':
      //   return MaterialPageRoute(builder: (_) => FirstToArrive());
      // case '/groupfinder':
      //   return MaterialPageRoute(builder: (_) => GroupFinder());
      // case '/groupfinderchat':
      //   return MaterialPageRoute(builder: (_) => GroupFinderChat());
      // case '/affinityrating':
      //   return MaterialPageRoute(builder: (_) => AffinityRatingCard());
      // case '/reportuser':
      //   return MaterialPageRoute(builder: (_) => ReportUser());
      // case '/connect':
      //   return MaterialPageRoute(builder: (_) => YouLikeEachOther());

      // Create Event
      // case '/createevent1':
      //   return MaterialPageRoute(builder: (_) => CreateEvent1());
      // Discover
      case '/discoverscreen':
        return MaterialPageRoute(builder: (_) => const DiscoverScreen());

      // Alerts & Notifications
      case '/adminalert':
        return MaterialPageRoute(builder: (_) => AdminAlert());
      case '/alertsscreen':
        return MaterialPageRoute(builder: (_) => AlertsScreen());
      case '/newtimesuggested':
        return MaterialPageRoute(builder: (_) => NewTimeSuggestedAlert());
      case '/youlikeeachother':
        return MaterialPageRoute(builder: (_) => YouLikeEachOther());

      // Default Error Message
    }
    return null;
  }
}
