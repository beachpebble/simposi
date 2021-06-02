/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:simposi_app_v4/affinityindex/affinityratingcards.dart';
import 'package:simposi_app_v4/profile/invitationsettings.dart';
import 'package:simposi_app_v4/profile/privacy.dart';
import 'package:simposi_app_v4/profile/termsofuse.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
// Login
import 'package:simposi_app_v4/authentication/login/getstartedscreen.dart';
import 'package:simposi_app_v4/authentication/login/loginscreen.dart';
import 'package:simposi_app_v4/authentication/login/resetpasswordscreen.dart';
// Create Profile
import 'package:simposi_app_v4/authentication/createprofile/signup1createaccount.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup2gender.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup4generation.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup3iwanttomeet.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5whoearn.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6activities.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup7location.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8covid.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup9validate.dart';
// Manage Profile
import 'package:simposi_app_v4/profile/profilescreen.dart';
import 'package:simposi_app_v4/profile/profilemenu.dart';
import 'package:simposi_app_v4/profile/editprofileform.dart';
import 'package:simposi_app_v4/profile/emergencycontact.dart';
import 'package:simposi_app_v4/profile/faqscreen.dart';
import 'package:simposi_app_v4/profile/subscribe.dart';
// Calendar (Home)
import 'theme/elements/simposihome.dart';
import 'package:simposi_app_v4/calendar/simposicalendar.dart';
import 'package:simposi_app_v4/eventdetails/eventdetails.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/cancelrsvp.dart';
import 'package:simposi_app_v4/calendar/calendarwidgets/calendarcards.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/proposenewtime.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/reportevent.dart';
// Discover
import 'package:simposi_app_v4/discover/discoverscreen.dart';
// Alerts & Notifications
import 'package:simposi_app_v4/notifications/alertsscreen.dart';
import 'package:simposi_app_v4/notifications/newtimesuggestedalert.dart';
import 'package:simposi_app_v4/notifications/youlikeeachother.dart';
import 'package:simposi_app_v4/notifications/adminalert.dart';
// Check In
import 'package:simposi_app_v4/checkin/firsttoarrivemodal.dart';
import 'package:simposi_app_v4/checkin/groupfinder.dart';
import 'package:simposi_app_v4/checkin/groupfinderchat.dart';
import 'package:simposi_app_v4/affinityindex/affinityratingcards.dart';
import 'package:simposi_app_v4/affinityindex/reportuser.dart';
import 'package:simposi_app_v4/notifications/youlikeeachother.dart';
// POS
import 'package:simposi_app_v4/eventdetails/createeventform.dart';
import 'package:simposi_app_v4/pos/pickinvitation.dart';
import 'package:simposi_app_v4/pos/subscriptionpurchase.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // TODO: Do we put the variables in here? I couldn't figure out how to do it


    switch (settings.name) {
      // Login
        // TODO: Build validation on GetStarted Screen to check if user has device token and ask for device permissions
      case '/' :
        return MaterialPageRoute(builder: (_) => GetStartedScreen());
      case '/login' :
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/resetpassword' :
        return MaterialPageRoute(builder: (_) => ResetPassword());
      // Create Profile
      case '/signup1' :
        return MaterialPageRoute(builder: (_) => SignUpForm1());
      case '/signup2' :
        return MaterialPageRoute(builder: (_) => SignUpForm2());
      case '/signup3' :
        return MaterialPageRoute(builder: (_) => SignUpForm3());
      case '/signup4' :
        return MaterialPageRoute(builder: (_) => SignUpForm4());
      case '/signup5' :
        return MaterialPageRoute(builder: (_) => SignUpForm5());
      case '/signup6' :
        return MaterialPageRoute(builder: (_) => SignUpForm6());
      case '/signup7' :
        return MaterialPageRoute(builder: (_) => SignUpForm7());
      case '/signup8' :
        return MaterialPageRoute(builder: (_) => SignUpForm8());
      case '/signup9' :
        return MaterialPageRoute(builder: (_) => SignUpForm9());
      // Profile Screen
      case '/profilescreen' :
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/subscribe' :
        return MaterialPageRoute(builder: (_) => SimposiSubscribe());
      case '/profilemenu' :
        return MaterialPageRoute(builder: (_) => ProfileMenu());
      case '/editprofile' :
        return MaterialPageRoute(builder: (_) => EditProfile());
      case '/invitationsettings' :
        return MaterialPageRoute(builder: (_) => InvitationSettings());
      case '/emergencycontact' :
        return MaterialPageRoute(builder: (_) => EmergencyContact());
      case '/faq' :
        return MaterialPageRoute(builder: (_) => FAQScreen());
      case '/tou' :
        return MaterialPageRoute(builder: (_) => TermsOfUse());
      // Calendar
      case '/home' :
        return MaterialPageRoute(builder: (_) => SimposiHome());
      case '/eventlist' :
        return MaterialPageRoute(builder: (_) => SimposiCalendar());
      case '/cancelrsvp' :
        return MaterialPageRoute(builder: (_) => CancelRSVP());
      case '/eventdetails' :
        return MaterialPageRoute(builder: (_) => EventDetails());
      case '/invitationcard' :
        return MaterialPageRoute(builder: (_) => InvitationCard());
      case '/proposenewtime' :
        return MaterialPageRoute(builder: (_) => ProposeNewTime());
      case '/reportevent' :
        return MaterialPageRoute(builder: (_) => ReportEvent());
      // Check In
      case '/firsttoarrive' :
        return MaterialPageRoute(builder: (_) => FirstToArrive());
      case '/groupfinder' :
        return MaterialPageRoute(builder: (_) => GroupFinder());
      case '/groupfinderchat' :
        return MaterialPageRoute(builder: (_) => GroupFinderChat());
      case '/affinityrating' :
        return MaterialPageRoute(builder: (_) => AffinityRatingCards());
      case '/reportuser' :
        return MaterialPageRoute(builder: (_) => ReportUser());
      case '/connect' :
        return MaterialPageRoute(builder: (_) => YouLikeEachOther());
      // Discover
      case '/discoverscreen' :
        return MaterialPageRoute(builder: (_) => DiscoverScreen());
      // Alerts & Notifications
      case '/adminalert' :
        return MaterialPageRoute(builder: (_) => AdminAlert());
      case '/alertsscreen' :
        return MaterialPageRoute(builder: (_) => AlertsScreen());
      case '/newtimesuggested' :
        return MaterialPageRoute(builder: (_) => NewTimeSuggestedAlert());
      case '/youlikeeachother' :
        return MaterialPageRoute(builder: (_) => YouLikeEachOther());
      // POS
      case '/createevent' :
        return MaterialPageRoute(builder: (_) => CreateEventForm());
      case '/pickinvitation' :
        return MaterialPageRoute(builder: (_) => PickInvitation());
      case '/subscriptionpurchase' :
        return MaterialPageRoute(builder: (_) => SubscriptionPurchase());
        // About
      case '/privacy' :
        return MaterialPageRoute(builder: (_) => PrivacyScreen());
      case '/termsofuse' :
        return MaterialPageRoute(builder: (_) => TermsOfUse());

      // Default Error Message
        default:
          return  _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: BasicFormAppBar(),
        body: Center(
          child:
          Text('Page Route Error',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: SimposiAppColors.simposiPink,
          ),),
        )
      );
    });
  }


}