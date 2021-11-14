import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/authentication/createprofile/signup8validate/signup8_validate_cubit.dart';
import 'package:simposi_app_v4/calendar/event_model.dart';
import 'package:simposi_app_v4/eventdetails/create_event3/createevent3_activities.dart';
import 'package:simposi_app_v4/profile/profilescreen.dart';

import 'authentication/createprofile/signup1createaccount/signup1createaccount.dart';
import 'authentication/createprofile/signup2gender.dart';
import 'authentication/createprofile/signup3generation.dart';
import 'authentication/createprofile/signup4income.dart';
import 'authentication/createprofile/signup5activities/signup5activities.dart';
import 'authentication/createprofile/signup6location/signup6location.dart';
import 'authentication/createprofile/signup7covid.dart';
import 'authentication/createprofile/signup8validate/signup8validate.dart';
import 'authentication/login/change_password/change_password_screen.dart';
import 'authentication/login/getstartedscreen.dart';
import 'authentication/login/loginscreen/loginscreen.dart';
import 'authentication/login/reset_password_complete/reset_password_screen.dart';
import 'authentication/login/splash_screen.dart';
import 'checkin/groupfinder.dart';
import 'eventdetails/createevent1.dart';
import 'eventdetails/createevent2/createevent2location.dart';
import 'eventdetails/createevent4gender.dart';
import 'eventdetails/createevent5generations.dart';
import 'eventdetails/createevent6income.dart';
import 'eventdetails/createevent7pickinvitation.dart';
import 'eventdetails/eventdetails.dart';
import 'global/theme/elements/simposihome.dart';
import 'profile/accountmenu.dart';
import 'profile/editprofileform.dart';
import 'profile/emergency_contact_screen.dart';
import 'profile/faqscreen.dart';
import 'profile/privacy.dart';
import 'profile/subscribe.dart';
import 'profile/subscriptionpurchase.dart';
import 'profile/termsofuse.dart';
import 'profile/whoami_menu.dart';
import 'profile/whoiwanttomeet_menu.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    //START
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: GetStartedScreen),
    AutoRoute(page: ChangePasswordScreen),
    AutoRoute(page: ResetPasswordScreen),

    //SIGNUP
    AutoRoute(page: LoginScreen),
    AutoRoute(page: SignUpForm1),
    AutoRoute(page: SignUpForm2),
    AutoRoute(page: SignUpForm3),
    AutoRoute(page: SignUpForm4),
    AutoRoute(page: SignUpForm5),
    AutoRoute(page: SignUpForm6),
    AutoRoute(page: SignUpForm7),
    AutoRoute(page: SignUpForm8),

    //MAIN
    AutoRoute(page: SimposiHome),

    //SETTINGS - PROFILE
    AutoRoute(page: ProfileMenu),
    AutoRoute(page: ProfileScreen),
    AutoRoute(page: EventSettings),
    AutoRoute(page: InvitationSettings),
    AutoRoute(page: EmergencyContact),
    AutoRoute(page: FAQScreen),
    AutoRoute(page: PrivacyScreen),
    AutoRoute(page: TermsOfUse),
    AutoRoute(page: SubscriptionPurchase),
    AutoRoute(page: SimposiSubscribe),
    AutoRoute(page: EditProfile),

    //CREATE EVENT
    AutoRoute(page: CreateEvent1),
    AutoRoute(page: CreateEvent2),
    AutoRoute(page: CreateEvent3Activities),
    AutoRoute(page: CreateEvent4),
    AutoRoute(page: CreateEvent5Generations),
    AutoRoute(page: CreateEvent6),
    AutoRoute(page: CreateEvent7),

    //EVENT STUFF
    AutoRoute(page: EventDetails),

    //ON EVENT
    AutoRoute(page: GroupFinder),

  ],
)
class AppRouter extends _$AppRouter{}