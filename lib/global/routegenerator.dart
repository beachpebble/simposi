/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/affinityindex/affinityratingcards.dart';
import 'package:simposi_app_v4/affinityindex/reportuser.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup1_create_account/signup1_create_account_cubit.dart';

// Create Profile
import 'package:simposi_app_v4/authentication/createprofile/signup1_create_account/signup1createaccount.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup2gender.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup3generation.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup4income.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5/signup5activities.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6/signup6_location_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6/signup6location.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup7covid.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8/signup8validate.dart';
import 'package:simposi_app_v4/authentication/login/change_password/change_password_screen.dart';

// Login
import 'package:simposi_app_v4/authentication/login/getstartedscreen.dart';
import 'package:simposi_app_v4/authentication/login/loginscreen/loginscreen.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_complete_cubit.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_screen.dart';
import 'package:simposi_app_v4/authentication/login/splash_screen.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup3iwanttomeet.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup4generation.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5income.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6/signup6_activities_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6/signup6activities.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup7/signup7_location_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup7/signup7location.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8covid.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup9/signup9_validate_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup9/signup9validate.dart';
import 'package:simposi_app_v4/authentication/login/change_password/change_password_screen.dart';

// Login
import 'package:simposi_app_v4/authentication/login/getstartedscreen.dart';
import 'package:simposi_app_v4/authentication/login/loginscreen/loginscreen.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_complete_cubit.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_screen.dart';
import 'package:simposi_app_v4/authentication/login/splash_screen.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/calendar/simposicalendar.dart';

// Check In
import 'package:simposi_app_v4/checkin/firsttoarrivemodal.dart';
import 'package:simposi_app_v4/checkin/groupfinder.dart';
import 'package:simposi_app_v4/checkin/groupfinderchat.dart';

// Discover
import 'package:simposi_app_v4/discover/discoverscreen.dart';

// POS
import 'package:simposi_app_v4/eventdetails/createeventform.dart';
import 'package:simposi_app_v4/eventdetails/eventdetails.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/cancelrsvp.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/proposenewtime.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/reportevent.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/formappbar.dart';
import 'package:simposi_app_v4/notifications/adminalert.dart';

// Alerts & Notifications
import 'package:simposi_app_v4/notifications/alertsscreen.dart';
import 'package:simposi_app_v4/notifications/newtimesuggestedalert.dart';
import 'package:simposi_app_v4/notifications/youlikeeachother.dart';
import 'package:simposi_app_v4/pos/pickinvitation.dart';
import 'package:simposi_app_v4/pos/subscriptionpurchase.dart';
import 'package:simposi_app_v4/profile/editprofileform.dart';
import 'package:simposi_app_v4/profile/emergencycontact.dart';
import 'package:simposi_app_v4/profile/faqscreen.dart';
import 'package:simposi_app_v4/profile/invitationsettings.dart';
import 'package:simposi_app_v4/profile/privacy.dart';
import 'package:simposi_app_v4/profile/profilemenu.dart';

// Manage Profile
import 'package:simposi_app_v4/profile/profilescreen.dart';
import 'package:simposi_app_v4/profile/subscribe.dart';
import 'package:simposi_app_v4/profile/termsofuse.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';

// Calendar (Home)
import 'theme/elements/simposihome.dart';

class RouteGenerator {
  static const String FORGOT_PASSWORD_DL = "/ResetPassword?token=";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Login
      // TODO: Build validation on GetStarted Screen to check if user has device token and ask for device permissions
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/start':
        return MaterialPageRoute(
            builder: (_) => GetStartedScreen(),
            settings: RouteSettings(name: "start"));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/resetPassword':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ResetPasswordCompleteCubit(
                      profileRepository: context.read<ProfileRepository>(),
                      phone: settings.arguments as String),
                  child: ResetPasswordScreen(),
                ));
      // Create Profile
      case '/signup1':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => Signup1CreateAccountCubit(
                      registrationCubit: context.read(),
                      profileRepository: context.read()),
                  child: SignUpForm1(),
                ),
            settings: RouteSettings(name: "signup1"));
      case '/signup2':
        return MaterialPageRoute(builder: (_) => SignUpForm2());
      case '/signup2edit':
        return MaterialPageRoute(builder: (_) => SignUpForm2(editMode: true));
      case '/signup3':
        return MaterialPageRoute(builder: (_) => SignUpForm3());
      case '/signup4':
        return MaterialPageRoute(builder: (_) => SignUpForm4());
      case '/signup5':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => Signup5ActivitiesCubit(
                  context.read<AuthenticationBloc>().masterData.interests, context.read()),
              child:SignUpForm5() ),
        );
      case '/signup6':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      Signup6LocationCubit(registrationCubit: context.read()),
                  child: SignUpForm6(),
                ));
      case '/signup7':
        return MaterialPageRoute(builder: (_) => SignUpForm7());
      case '/signup8':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => Signup8ValidateCubit(
                      validateParameters:
                          settings.arguments as ValidateParameters,
                      authenticationBloc: context.read(),
                      profileRepository: context.read()),
                  child: SignUpForm8(),
                ));
      // Profile Screen
      case '/profilescreen':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/subscribe':
        return MaterialPageRoute(builder: (_) => SimposiSubscribe());
      case '/profilemenu':
        return MaterialPageRoute(builder: (_) => ProfileMenu());
      case '/editprofile':
        return MaterialPageRoute(builder: (_) => EditProfile());
      case '/invitationsettings':
        return MaterialPageRoute(builder: (_) => InvitationSettings());
      case '/emergencycontact':
        return MaterialPageRoute(builder: (_) => EmergencyContact());
      case '/faq':
        return MaterialPageRoute(builder: (_) => FAQScreen());
      case '/tou':
        return MaterialPageRoute(builder: (_) => TermsOfUse());
      // Calendar
      case '/home':
        return MaterialPageRoute(builder: (_) => SimposiHome());
      case '/eventlist':
        return MaterialPageRoute(builder: (_) => SimposiCalendar());
      case '/cancelrsvp':
        return MaterialPageRoute(builder: (_) => CancelRSVP());
      case '/eventdetails':
        return MaterialPageRoute(builder: (_) => EventDetails());
      case '/invitationcard':
        return MaterialPageRoute(builder: (_) => InvitationCard());
      case '/proposenewtime':
        return MaterialPageRoute(builder: (_) => ProposeNewTime());
      case '/reportevent':
        return MaterialPageRoute(builder: (_) => ReportEvent());
      // Check In
      case '/firsttoarrive':
        return MaterialPageRoute(builder: (_) => FirstToArrive());
      case '/groupfinder':
        return MaterialPageRoute(builder: (_) => GroupFinder());
      case '/groupfinderchat':
        return MaterialPageRoute(builder: (_) => GroupFinderChat());
      case '/affinityrating':
        return MaterialPageRoute(builder: (_) => AffinityRatingCards());
      case '/reportuser':
        return MaterialPageRoute(builder: (_) => ReportUser());
      case '/connect':
        return MaterialPageRoute(builder: (_) => YouLikeEachOther());
      // Discover
      case '/discoverscreen':
        return MaterialPageRoute(builder: (_) => DiscoverScreen());
      // Alerts & Notifications
      case '/adminalert':
        return MaterialPageRoute(builder: (_) => AdminAlert());
      case '/alertsscreen':
        return MaterialPageRoute(builder: (_) => AlertsScreen());
      case '/newtimesuggested':
        return MaterialPageRoute(builder: (_) => NewTimeSuggestedAlert());
      case '/youlikeeachother':
        return MaterialPageRoute(builder: (_) => YouLikeEachOther());
      // POS
      case '/createevent':
        return MaterialPageRoute(builder: (_) => CreateEventForm());
      case '/pickinvitation':
        return MaterialPageRoute(builder: (_) => PickInvitation());
      case '/subscriptionpurchase':
        return MaterialPageRoute(builder: (_) => SubscriptionPurchase());
      // About
      case '/privacy':
        return MaterialPageRoute(builder: (_) => PrivacyScreen());
      case '/termsofuse':
        return MaterialPageRoute(builder: (_) => TermsOfUse());

      // Default Error Message
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: BasicFormAppBar(),
          body: Center(
            child: Text(
              'Page Route Error',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: SimposiAppColors.simposiPink,
              ),
            ),
          ));
    });
  }
}
