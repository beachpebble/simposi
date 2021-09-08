import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/profile/bloc/profile_edit_cubit.dart';

abstract class RegistrationProfileScreen extends StatefulWidget {
  final bool editMode;

  const RegistrationProfileScreen({Key? key, required this.editMode })
      : super(key: key);
}

abstract class RegistrationProfileScreenState<T>
    extends State<RegistrationProfileScreen> {
  VoidCallback? continueAction();

  VoidCallback? saveAction();

  double progress();

  double getProgressValue() => widget.editMode ? 1 : progress();

  Widget registrationNextButton() {
    return ContinueButton(buttonAction: continueAction());
  }

  Widget getFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 40),
      child: Column(
        children: [
          widget.editMode ? profileEditNextButton() : registrationNextButton(),
        ],
      ),
    );
  }

  Widget profileEditNextButton() {
    return BlocConsumer<ProfileEditCubit, ProfileEditState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) Navigator.of(context).pop();
      },
      builder: (context, state) {
        return state is ProfileEditLoading
            ? AppProgressIndicator()
            : BigGBSelectButton(
                buttonLabel: 'Save',
                buttonAction: saveAction(),
              );
      },
    );
  }
}
