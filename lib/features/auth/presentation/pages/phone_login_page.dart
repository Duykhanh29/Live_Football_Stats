import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';

import '../../../../core/constants/app_routes_name.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'VI';
  PhoneNumber number = PhoneNumber();
  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'VI');

  //   setState(() {
  //     this.number = number;
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        title: Text(
          "Login with Phone",
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InternationalPhoneNumberInput(
                onInputChanged: (value) {
                  setState(() {
                    number = value;
                  });
                },
                selectorTextStyle: AppTextStyles.headingTextStyle(),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useBottomSheetSafeArea: true,
                ),
                initialValue: number,
                textFieldController: controller,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (PhoneNumber phoneNumber) {
                  print('On Saved: $number');
                  // setState(() {
                  //   number = phoneNumber;
                  // });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // final isValid = formKey.currentState?.validate();
                  // if (isValid!) {
                  //   formKey.currentState?.save();
                  // getPhoneNumber(controller.text);
                  sl
                      .get<AuthBloc>()
                      .add(SignInWithPhone(phone: number.phoneNumber!));
                  // }
                },
                child: Text(
                  'Send',
                  style: AppTextStyles.headingTextStyle(),
                ),
              ),
            ],
          ),
        ),
        listener: (context, state) {
          if (state is IsOTPVerified) {
            goRouter.pushNamed(AppRoutesName.otpPage,
                extra: state.verificationId);
          }
        },
      ),
    );
  }
}
