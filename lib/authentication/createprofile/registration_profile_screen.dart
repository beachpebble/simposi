import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simposi_app_v4/bloc/profile/profile_bloc.dart';
import 'package:simposi_app_v4/global/theme/elements/simposibuttons.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/utils/toast_utils.dart';

abstract class RegistrationProfileScreen extends StatefulWidget {
  final bool editMode;

  const RegistrationProfileScreen({Key? key, required this.editMode})
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
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileEditSuccess) {
          Navigator.of(context).pop();
        } else if (state is ProfileEditError) {
          showErrorToast(handleError(state.error, context));
        }
      },
      builder: (context, state) {
        return state is ProfileEditLoading
            ? const AppProgressIndicator()
            : ContinueButton(
                buttonLabel: 'Save',
                buttonAction: saveAction(),
              );
      },
    );
  }
}
