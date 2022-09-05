import 'package:flutter/material.dart';
import 'package:simposi_app_v4/bloc/app_setup/app_setup_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSetupErrorScreen extends StatelessWidget {
  final dynamic error;

  const AppSetupErrorScreen({Key? key, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SimposiAppColors.simposiDarkBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("Error initializing app: ${handleError(error, context)}"),
           ),
           const SizedBox(height: 10),
           TextButton(onPressed: () {
             context.read<AppSetupCubit>().load();
           }, child: const Text("Reload", style: TextStyle(color: Colors.white),))
         ],),
    );
  }
}
