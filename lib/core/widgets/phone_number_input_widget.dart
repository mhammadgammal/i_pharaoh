import 'package:flutter/material.dart';
import 'package:i_pharaoh/core/theme/app_colors.dart';
import 'package:i_pharaoh/core/utils/localization/app_localization.dart';
import 'package:i_pharaoh/core/utils/localization/app_strings.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget(
      {super.key,
      required this.phoneController,
      required this.selectorNavigator,
      this.phoneNode,
      this.focus = false,
      this.onSubmitted,
      this.onSaved,
      this.onEditComplete});

  final PhoneController phoneController;
  final CountrySelectorNavigator selectorNavigator;
  final FocusNode? phoneNode;
  final bool focus;
  final void Function(String)? onSubmitted;
  final void Function(PhoneNumber?)? onSaved;
  final void Function()? onEditComplete;
  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      focusNode: phoneNode,
      autofocus: focus,
      controller: phoneController,
      isCountryButtonPersistent: true,
      countrySelectorNavigator: selectorNavigator,
      cursorColor: AppColors.goldSand,
      validator: _getValidator(context),
      autovalidateMode: AutovalidateMode.disabled,
      onEditingComplete: onEditComplete,
      onSubmitted: onSubmitted,
      decoration: const InputDecoration(
        hintText: '123-456-7890',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.goldSand, width: 3.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }

  PhoneNumberInputValidator? _getValidator(BuildContext context) {
    List<PhoneNumberInputValidator> validators = [];
    validators.addAll([
      PhoneValidator.required(context,
          errorText: AppLocalizations.of(context)
              .translate(AppStrings.phoneNumberIsRequired)),
      PhoneValidator.validMobile(context)
    ]);
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }
}
