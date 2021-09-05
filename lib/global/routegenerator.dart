/*
*  main.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

// Global
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/widgets/formappbar.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';

// Create Profile
import 'package:simposi_app_v4/authentication/createprofile/signup1createaccount/signup1createaccount.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup1createaccount/signup1_create_account_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup2gender.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup3generation.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup4income.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5activities/signup5_activities_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup5activities/signup5activities.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6location/signup6_location_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup6location/signup6location.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup7covid.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8validate.dart';
import 'package:simposi_app_v4/authentication/login/change_password/change_password_screen.dart';

// Login
import 'package:simposi_app_v4/authentication/login/getstartedscreen.dart';
import 'package:simposi_app_v4/authentication/login/loginscreen/loginscreen.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_complete_cubit.dart';
import 'package:simposi_app_v4/authentication/login/reset_password_complete/reset_password_screen.dart';
import 'package:simposi_app_v4/authentication/login/splash_screen.dart';
import 'package:simposi_app_v4/bloc/auth/authentication_bloc.dart';
import 'package:simposi_app_v4/calendar/simposicalendar.dart'; // Home/Socials

// Manage Profile
import 'package:simposi_app_v4/profile/profilescreen.dart';
import 'package:simposi_app_v4/profile/accountmenu.dart';
import 'package:simposi_app_v4/profile/editprofileform.dart';
import 'package:simposi_app_v4/profile/emergencycontact.dart';
import 'package:simposi_app_v4/profile/faqscreen.dart';
import 'package:simposi_app_v4/profile/subscribe.dart';
import 'package:simposi_app_v4/profile/whoami_menu.dart';
import 'package:simposi_app_v4/profile/whoiwanttomeet_menu.dart';
import 'package:simposi_app_v4/profile/privacy.dart';
import 'package:simposi_app_v4/profile/termsofuse.dart';
import 'package:simposi_app_v4/repository/profile_repository.dart';
import 'package:simposi_app_v4/profile/subscriptionpurchase.dart';

// Alerts & Notifications
import 'package:simposi_app_v4/notifications/alertsscreen.dart';
import 'package:simposi_app_v4/notifications/newtimesuggestedalert.dart';
import 'package:simposi_app_v4/notifications/youlikeeachother.dart';
import 'package:simposi_app_v4/notifications/adminalert.dart';

// Calendar & Events (Home)
import 'widgets/simposihome.dart';
import 'package:simposi_app_v4/eventdetails/eventdetails.dart';
import 'package:simposi_app_v4/eventdetails/eventwidgets/invitationcard.dart';
import 'package:simposi_app_v4/eventdetails/reportevent.dart';

// Create Event
import 'package:simposi_app_v4/eventdetails/createevent1.dart';
import 'package:simposi_app_v4/eventdetails/createevent2location.dart';
import 'package:simposi_app_v4/eventdetails/createevent3tags.dart';
import 'package:simposi_app_v4/eventdetails/createevent4gender.dart';
import 'package:simposi_app_v4/eventdetails/createevent5generations.dart';
import 'package:simposi_app_v4/eventdetails/createevent6income.dart';
import 'package:simposi_app_v4/eventdetails/createevent7pickinvitation.dart';


// Check In
import 'package:simposi_app_v4/checkin/firsttoarrivemodal.dart';
import 'package:simposi_app_v4/checkin/groupfinder.dart';
import 'package:simposi_app_v4/checkin/groupfinderchat.dart';
import 'package:simposi_app_v4/affinityindex/affinityratingcards.dart';
import 'package:simposi_app_v4/affinityindex/reportuser.dart';

// Discover
import 'package:simposi_app_v4/discover/discoverscreen.dart';



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
      case '/signup5activities':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => Signup5ActivitiesCubit(
                  context.read<AuthenticationBloc>().masterData.interests,
                  context.read()),
              child: SignUpForm5()),
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

      // Manage Profile
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
      case '/eventsettings':
        return MaterialPageRoute(builder: (_) => EventSettings());
      case '/emergencycontact':
        return MaterialPageRoute(builder: (_) => EmergencyContact());
      case '/faq':
        return MaterialPageRoute(builder: (_) => FAQScreen());
      case '/privacy' :
        return MaterialPageRoute(builder: (_) => PrivacyScreen());
      case '/tou':
        return MaterialPageRoute(builder: (_) => TermsOfUse());
      case '/subscriptionpurchase' :
        return MaterialPageRoute(builder: (_) => SubscriptionPurchase());

      // Calendar
      case '/home':
        return MaterialPageRoute(builder: (_) => SimposiHome());
      case '/eventlist':
        return MaterialPageRoute(builder: (_) => SimposiCalendar());
      case '/eventdetails':
        return MaterialPageRoute(builder: (_) => EventDetails());
      case '/invitationcard':
        return MaterialPageRoute(builder: (_) => InvitationCard());
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

    // Create Event
      case '/createevent1' :
        return MaterialPageRoute(builder: (_) => CreateEvent1());
      case '/createevent2' :
        return MaterialPageRoute(builder: (_) => CreateEvent2());
      case '/createevent3' :
        return MaterialPageRoute(builder: (_) => CreateEvent3());
      case '/createevent4' :
        return MaterialPageRoute(builder: (_) => CreateEvent4());
      case '/createevent5' :
        return MaterialPageRoute(builder: (_) => CreateEvent5());
      case '/createevent6' :
        return MaterialPageRoute(builder: (_) => CreateEvent6());
      case '/createevent7' :
        return MaterialPageRoute(builder: (_) => CreateEvent7());

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
