import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  late Stream<String> _tokenStream;
  String? token;

  late StreamSubscription setupSubscription;

  FcmBloc(AppSetupCubit appSetupCubit) : super(FcmInitial()) {
    setupSubscription = appSetupCubit.stream.listen((state) {
      if (state is AppSetupLoaded) {
        final messaging = FirebaseMessaging.instance;

        messaging
            .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
            .then((settings) {
          if (settings.authorizationStatus == AuthorizationStatus.authorized) {
            print('User granted permission');
          } else if (settings.authorizationStatus ==
              AuthorizationStatus.provisional) {
            print('User granted provisional permission');
          } else {
            print('User declined or has not accepted permission');
          }
        });

        FirebaseMessaging.instance.getToken().then(setToken);
        _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
        _tokenStream.listen(setToken);

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          final notification = message.notification;
          print(
              "Notification! ${notification?.title ?? "--"} ${notification?.body ?? "--"} ");
          if (notification?.body != null) {
            if (notification?.body == ':New event') {
              add(NewRsvp());
            }
          }
          // AndroidNotification? android = message.notification?.android;
          // if (notification != null && android != null) {
          //   print("Android notification! ");
          // }
          // AppleNotification? apple = message.notification?.apple;
          // if (apple != null && android != null) {
          //   print("Apple notification! ");
          // }
        });
      }
    });

    on<FcmEvent>((event, emit) {
      if (event is FcmNewToken) {
        emit(FcmTokenUpdated(event.token));
      } else if (event is NewRsvp) {
        emit(NewRsvpReceived());
      }
    });
  }

  void setToken(String? token) {
    this.token = token;
    if (token != null) add(FcmNewToken(token));
  }

  @override
  Future<void> close() {
    setupSubscription.cancel();
    return super.close();
  }
}
