// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SplashScreen());
    },
    GetStartedScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: GetStartedScreen());
    },
    ChangePasswordScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ChangePasswordScreen());
    },
    ResetPasswordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordScreenRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ResetPasswordScreen(key: args.key, phone: args.phone));
    },
    LoginScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: LoginScreen());
    },
    SignUpForm1Route.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SignUpForm1());
    },
    SignUpForm2Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm2RouteArgs>(
          orElse: () => const SignUpForm2RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SignUpForm2(editMode: args.editMode));
    },
    SignUpForm3Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm3RouteArgs>(
          orElse: () => const SignUpForm3RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SignUpForm3(editMode: args.editMode));
    },
    SignUpForm4Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm4RouteArgs>(
          orElse: () => const SignUpForm4RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SignUpForm4(editMode: args.editMode));
    },
    SignUpForm5Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm5RouteArgs>(
          orElse: () => const SignUpForm5RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: SignUpForm5(key: args.key, editMode: args.editMode));
    },
    SignUpForm6Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm6RouteArgs>(
          orElse: () => const SignUpForm6RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: SignUpForm6(key: args.key, editMode: args.editMode));
    },
    SignUpForm7Route.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SignUpForm7());
    },
    SignUpForm8Route.name: (routeData) {
      final args = routeData.argsAs<SignUpForm8RouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: SignUpForm8(
              key: args.key, validateParameters: args.validateParameters));
    },
    SimposiHomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SimposiHome());
    },
    ProfileMenuRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: ProfileMenu());
    },
    ProfileScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ProfileScreen());
    },
    EventSettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EventSettings());
    },
    InvitationSettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const InvitationSettings());
    },
    EmergencyContactRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: EmergencyContact());
    },
    FAQScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: FAQScreen());
    },
    PrivacyScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PrivacyScreen());
    },
    TermsOfUseRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: TermsOfUse());
    },
    SubscriptionPurchaseRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SubscriptionPurchase());
    },
    SimposiSubscribeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SimposiSubscribe());
    },
    EditProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: EditProfile());
    },
    CreateEvent1Route.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent1());
    },
    CreateEvent2Route.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent2());
    },
    CreateEvent3ActivitiesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent3Activities());
    },
    CreateEvent4Route.name: (routeData) {
      final args = routeData.argsAs<CreateEvent4RouteArgs>(
          orElse: () => const CreateEvent4RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent4(editMode: args.editMode));
    },
    CreateEvent5GenerationsRoute.name: (routeData) {
      final args = routeData.argsAs<CreateEvent5GenerationsRouteArgs>(
          orElse: () => const CreateEvent5GenerationsRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: CreateEvent5Generations(editMode: args.editMode));
    },
    CreateEvent6Route.name: (routeData) {
      final args = routeData.argsAs<CreateEvent6RouteArgs>(
          orElse: () => const CreateEvent6RouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent6(editMode: args.editMode));
    },
    CreateEvent7Route.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateEvent7());
    },
    EventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: EventDetails(key: args.key, eventModel: args.eventModel));
    },
    GroupFinderRoute.name: (routeData) {
      final args = routeData.argsAs<GroupFinderRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: GroupFinder(key: args.key, event: args.event));
    },
    SurveyScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SurveyScreen());
    },
    YouLikeEachOtherRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: YouLikeEachOther());
    },
    ReportUserRoute.name: (routeData) {
      final args = routeData.argsAs<ReportUserRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              ReportUser(key: args.key, surveyRequired: args.surveyRequired));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashScreenRoute.name, path: '/'),
        RouteConfig(GetStartedScreenRoute.name, path: '/get-started-screen'),
        RouteConfig(ChangePasswordScreenRoute.name,
            path: '/change-password-screen'),
        RouteConfig(ResetPasswordScreenRoute.name,
            path: '/reset-password-screen'),
        RouteConfig(LoginScreenRoute.name, path: '/login-screen'),
        RouteConfig(SignUpForm1Route.name, path: '/sign-up-form1'),
        RouteConfig(SignUpForm2Route.name, path: '/sign-up-form2'),
        RouteConfig(SignUpForm3Route.name, path: '/sign-up-form3'),
        RouteConfig(SignUpForm4Route.name, path: '/sign-up-form4'),
        RouteConfig(SignUpForm5Route.name, path: '/sign-up-form5'),
        RouteConfig(SignUpForm6Route.name, path: '/sign-up-form6'),
        RouteConfig(SignUpForm7Route.name, path: '/sign-up-form7'),
        RouteConfig(SignUpForm8Route.name, path: '/sign-up-form8'),
        RouteConfig(SimposiHomeRoute.name, path: '/simposi-home'),
        RouteConfig(ProfileMenuRoute.name, path: '/profile-menu'),
        RouteConfig(ProfileScreenRoute.name, path: '/profile-screen'),
        RouteConfig(EventSettingsRoute.name, path: '/event-settings'),
        RouteConfig(InvitationSettingsRoute.name, path: '/invitation-settings'),
        RouteConfig(EmergencyContactRoute.name, path: '/emergency-contact'),
        RouteConfig(FAQScreenRoute.name, path: '/f-aq-screen'),
        RouteConfig(PrivacyScreenRoute.name, path: '/privacy-screen'),
        RouteConfig(TermsOfUseRoute.name, path: '/terms-of-use'),
        RouteConfig(SubscriptionPurchaseRoute.name,
            path: '/subscription-purchase'),
        RouteConfig(SimposiSubscribeRoute.name, path: '/simposi-subscribe'),
        RouteConfig(EditProfileRoute.name, path: '/edit-profile'),
        RouteConfig(CreateEvent1Route.name, path: '/create-event1'),
        RouteConfig(CreateEvent2Route.name, path: '/create-event2'),
        RouteConfig(CreateEvent3ActivitiesRoute.name,
            path: '/create-event3-activities'),
        RouteConfig(CreateEvent4Route.name, path: '/create-event4'),
        RouteConfig(CreateEvent5GenerationsRoute.name,
            path: '/create-event5-generations'),
        RouteConfig(CreateEvent6Route.name, path: '/create-event6'),
        RouteConfig(CreateEvent7Route.name, path: '/create-event7'),
        RouteConfig(EventDetailsRoute.name, path: '/event-details'),
        RouteConfig(GroupFinderRoute.name, path: '/group-finder'),
        RouteConfig(SurveyScreenRoute.name, path: '/survey-screen'),
        RouteConfig(YouLikeEachOtherRoute.name, path: '/you-like-each-other'),
        RouteConfig(ReportUserRoute.name, path: '/report-user')
      ];
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [GetStartedScreen]
class GetStartedScreenRoute extends PageRouteInfo<void> {
  const GetStartedScreenRoute()
      : super(GetStartedScreenRoute.name, path: '/get-started-screen');

  static const String name = 'GetStartedScreenRoute';
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordScreenRoute extends PageRouteInfo<void> {
  const ChangePasswordScreenRoute()
      : super(ChangePasswordScreenRoute.name, path: '/change-password-screen');

  static const String name = 'ChangePasswordScreenRoute';
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordScreenRoute
    extends PageRouteInfo<ResetPasswordScreenRouteArgs> {
  ResetPasswordScreenRoute({Key? key, required String phone})
      : super(ResetPasswordScreenRoute.name,
            path: '/reset-password-screen',
            args: ResetPasswordScreenRouteArgs(key: key, phone: phone));

  static const String name = 'ResetPasswordScreenRoute';
}

class ResetPasswordScreenRouteArgs {
  const ResetPasswordScreenRouteArgs({this.key, required this.phone});

  final Key? key;

  final String phone;

  @override
  String toString() {
    return 'ResetPasswordScreenRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(LoginScreenRoute.name, path: '/login-screen');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [SignUpForm1]
class SignUpForm1Route extends PageRouteInfo<void> {
  const SignUpForm1Route()
      : super(SignUpForm1Route.name, path: '/sign-up-form1');

  static const String name = 'SignUpForm1Route';
}

/// generated route for
/// [SignUpForm2]
class SignUpForm2Route extends PageRouteInfo<SignUpForm2RouteArgs> {
  SignUpForm2Route({bool editMode = false})
      : super(SignUpForm2Route.name,
            path: '/sign-up-form2',
            args: SignUpForm2RouteArgs(editMode: editMode));

  static const String name = 'SignUpForm2Route';
}

class SignUpForm2RouteArgs {
  const SignUpForm2RouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'SignUpForm2RouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [SignUpForm3]
class SignUpForm3Route extends PageRouteInfo<SignUpForm3RouteArgs> {
  SignUpForm3Route({bool editMode = false})
      : super(SignUpForm3Route.name,
            path: '/sign-up-form3',
            args: SignUpForm3RouteArgs(editMode: editMode));

  static const String name = 'SignUpForm3Route';
}

class SignUpForm3RouteArgs {
  const SignUpForm3RouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'SignUpForm3RouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [SignUpForm4]
class SignUpForm4Route extends PageRouteInfo<SignUpForm4RouteArgs> {
  SignUpForm4Route({bool editMode = false})
      : super(SignUpForm4Route.name,
            path: '/sign-up-form4',
            args: SignUpForm4RouteArgs(editMode: editMode));

  static const String name = 'SignUpForm4Route';
}

class SignUpForm4RouteArgs {
  const SignUpForm4RouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'SignUpForm4RouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [SignUpForm5]
class SignUpForm5Route extends PageRouteInfo<SignUpForm5RouteArgs> {
  SignUpForm5Route({Key? key, bool editMode = false})
      : super(SignUpForm5Route.name,
            path: '/sign-up-form5',
            args: SignUpForm5RouteArgs(key: key, editMode: editMode));

  static const String name = 'SignUpForm5Route';
}

class SignUpForm5RouteArgs {
  const SignUpForm5RouteArgs({this.key, this.editMode = false});

  final Key? key;

  final bool editMode;

  @override
  String toString() {
    return 'SignUpForm5RouteArgs{key: $key, editMode: $editMode}';
  }
}

/// generated route for
/// [SignUpForm6]
class SignUpForm6Route extends PageRouteInfo<SignUpForm6RouteArgs> {
  SignUpForm6Route({Key? key, bool editMode = false})
      : super(SignUpForm6Route.name,
            path: '/sign-up-form6',
            args: SignUpForm6RouteArgs(key: key, editMode: editMode));

  static const String name = 'SignUpForm6Route';
}

class SignUpForm6RouteArgs {
  const SignUpForm6RouteArgs({this.key, this.editMode = false});

  final Key? key;

  final bool editMode;

  @override
  String toString() {
    return 'SignUpForm6RouteArgs{key: $key, editMode: $editMode}';
  }
}

/// generated route for
/// [SignUpForm7]
class SignUpForm7Route extends PageRouteInfo<void> {
  const SignUpForm7Route()
      : super(SignUpForm7Route.name, path: '/sign-up-form7');

  static const String name = 'SignUpForm7Route';
}

/// generated route for
/// [SignUpForm8]
class SignUpForm8Route extends PageRouteInfo<SignUpForm8RouteArgs> {
  SignUpForm8Route({Key? key, required ValidateParameters validateParameters})
      : super(SignUpForm8Route.name,
            path: '/sign-up-form8',
            args: SignUpForm8RouteArgs(
                key: key, validateParameters: validateParameters));

  static const String name = 'SignUpForm8Route';
}

class SignUpForm8RouteArgs {
  const SignUpForm8RouteArgs({this.key, required this.validateParameters});

  final Key? key;

  final ValidateParameters validateParameters;

  @override
  String toString() {
    return 'SignUpForm8RouteArgs{key: $key, validateParameters: $validateParameters}';
  }
}

/// generated route for
/// [SimposiHome]
class SimposiHomeRoute extends PageRouteInfo<void> {
  const SimposiHomeRoute()
      : super(SimposiHomeRoute.name, path: '/simposi-home');

  static const String name = 'SimposiHomeRoute';
}

/// generated route for
/// [ProfileMenu]
class ProfileMenuRoute extends PageRouteInfo<void> {
  const ProfileMenuRoute()
      : super(ProfileMenuRoute.name, path: '/profile-menu');

  static const String name = 'ProfileMenuRoute';
}

/// generated route for
/// [ProfileScreen]
class ProfileScreenRoute extends PageRouteInfo<void> {
  const ProfileScreenRoute()
      : super(ProfileScreenRoute.name, path: '/profile-screen');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [EventSettings]
class EventSettingsRoute extends PageRouteInfo<void> {
  const EventSettingsRoute()
      : super(EventSettingsRoute.name, path: '/event-settings');

  static const String name = 'EventSettingsRoute';
}

/// generated route for
/// [InvitationSettings]
class InvitationSettingsRoute extends PageRouteInfo<void> {
  const InvitationSettingsRoute()
      : super(InvitationSettingsRoute.name, path: '/invitation-settings');

  static const String name = 'InvitationSettingsRoute';
}

/// generated route for
/// [EmergencyContact]
class EmergencyContactRoute extends PageRouteInfo<void> {
  const EmergencyContactRoute()
      : super(EmergencyContactRoute.name, path: '/emergency-contact');

  static const String name = 'EmergencyContactRoute';
}

/// generated route for
/// [FAQScreen]
class FAQScreenRoute extends PageRouteInfo<void> {
  const FAQScreenRoute() : super(FAQScreenRoute.name, path: '/f-aq-screen');

  static const String name = 'FAQScreenRoute';
}

/// generated route for
/// [PrivacyScreen]
class PrivacyScreenRoute extends PageRouteInfo<void> {
  const PrivacyScreenRoute()
      : super(PrivacyScreenRoute.name, path: '/privacy-screen');

  static const String name = 'PrivacyScreenRoute';
}

/// generated route for
/// [TermsOfUse]
class TermsOfUseRoute extends PageRouteInfo<void> {
  const TermsOfUseRoute() : super(TermsOfUseRoute.name, path: '/terms-of-use');

  static const String name = 'TermsOfUseRoute';
}

/// generated route for
/// [SubscriptionPurchase]
class SubscriptionPurchaseRoute extends PageRouteInfo<void> {
  const SubscriptionPurchaseRoute()
      : super(SubscriptionPurchaseRoute.name, path: '/subscription-purchase');

  static const String name = 'SubscriptionPurchaseRoute';
}

/// generated route for
/// [SimposiSubscribe]
class SimposiSubscribeRoute extends PageRouteInfo<void> {
  const SimposiSubscribeRoute()
      : super(SimposiSubscribeRoute.name, path: '/simposi-subscribe');

  static const String name = 'SimposiSubscribeRoute';
}

/// generated route for
/// [EditProfile]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: '/edit-profile');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [CreateEvent1]
class CreateEvent1Route extends PageRouteInfo<void> {
  const CreateEvent1Route()
      : super(CreateEvent1Route.name, path: '/create-event1');

  static const String name = 'CreateEvent1Route';
}

/// generated route for
/// [CreateEvent2]
class CreateEvent2Route extends PageRouteInfo<void> {
  const CreateEvent2Route()
      : super(CreateEvent2Route.name, path: '/create-event2');

  static const String name = 'CreateEvent2Route';
}

/// generated route for
/// [CreateEvent3Activities]
class CreateEvent3ActivitiesRoute extends PageRouteInfo<void> {
  const CreateEvent3ActivitiesRoute()
      : super(CreateEvent3ActivitiesRoute.name,
            path: '/create-event3-activities');

  static const String name = 'CreateEvent3ActivitiesRoute';
}

/// generated route for
/// [CreateEvent4]
class CreateEvent4Route extends PageRouteInfo<CreateEvent4RouteArgs> {
  CreateEvent4Route({bool editMode = false})
      : super(CreateEvent4Route.name,
            path: '/create-event4',
            args: CreateEvent4RouteArgs(editMode: editMode));

  static const String name = 'CreateEvent4Route';
}

class CreateEvent4RouteArgs {
  const CreateEvent4RouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'CreateEvent4RouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [CreateEvent5Generations]
class CreateEvent5GenerationsRoute
    extends PageRouteInfo<CreateEvent5GenerationsRouteArgs> {
  CreateEvent5GenerationsRoute({bool editMode = false})
      : super(CreateEvent5GenerationsRoute.name,
            path: '/create-event5-generations',
            args: CreateEvent5GenerationsRouteArgs(editMode: editMode));

  static const String name = 'CreateEvent5GenerationsRoute';
}

class CreateEvent5GenerationsRouteArgs {
  const CreateEvent5GenerationsRouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'CreateEvent5GenerationsRouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [CreateEvent6]
class CreateEvent6Route extends PageRouteInfo<CreateEvent6RouteArgs> {
  CreateEvent6Route({bool editMode = false})
      : super(CreateEvent6Route.name,
            path: '/create-event6',
            args: CreateEvent6RouteArgs(editMode: editMode));

  static const String name = 'CreateEvent6Route';
}

class CreateEvent6RouteArgs {
  const CreateEvent6RouteArgs({this.editMode = false});

  final bool editMode;

  @override
  String toString() {
    return 'CreateEvent6RouteArgs{editMode: $editMode}';
  }
}

/// generated route for
/// [CreateEvent7]
class CreateEvent7Route extends PageRouteInfo<void> {
  const CreateEvent7Route()
      : super(CreateEvent7Route.name, path: '/create-event7');

  static const String name = 'CreateEvent7Route';
}

/// generated route for
/// [EventDetails]
class EventDetailsRoute extends PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({Key? key, required EventModel eventModel})
      : super(EventDetailsRoute.name,
            path: '/event-details',
            args: EventDetailsRouteArgs(key: key, eventModel: eventModel));

  static const String name = 'EventDetailsRoute';
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({this.key, required this.eventModel});

  final Key? key;

  final EventModel eventModel;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{key: $key, eventModel: $eventModel}';
  }
}

/// generated route for
/// [GroupFinder]
class GroupFinderRoute extends PageRouteInfo<GroupFinderRouteArgs> {
  GroupFinderRoute({Key? key, required Event event})
      : super(GroupFinderRoute.name,
            path: '/group-finder',
            args: GroupFinderRouteArgs(key: key, event: event));

  static const String name = 'GroupFinderRoute';
}

class GroupFinderRouteArgs {
  const GroupFinderRouteArgs({this.key, required this.event});

  final Key? key;

  final Event event;

  @override
  String toString() {
    return 'GroupFinderRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [SurveyScreen]
class SurveyScreenRoute extends PageRouteInfo<void> {
  const SurveyScreenRoute()
      : super(SurveyScreenRoute.name, path: '/survey-screen');

  static const String name = 'SurveyScreenRoute';
}

/// generated route for
/// [YouLikeEachOther]
class YouLikeEachOtherRoute extends PageRouteInfo<void> {
  const YouLikeEachOtherRoute()
      : super(YouLikeEachOtherRoute.name, path: '/you-like-each-other');

  static const String name = 'YouLikeEachOtherRoute';
}

/// generated route for
/// [ReportUser]
class ReportUserRoute extends PageRouteInfo<ReportUserRouteArgs> {
  ReportUserRoute({Key? key, required SurveyRequired surveyRequired})
      : super(ReportUserRoute.name,
            path: '/report-user',
            args:
                ReportUserRouteArgs(key: key, surveyRequired: surveyRequired));

  static const String name = 'ReportUserRoute';
}

class ReportUserRouteArgs {
  const ReportUserRouteArgs({this.key, required this.surveyRequired});

  final Key? key;

  final SurveyRequired surveyRequired;

  @override
  String toString() {
    return 'ReportUserRouteArgs{key: $key, surveyRequired: $surveyRequired}';
  }
}
