import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "Verification",
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter the OTP send to your phone number",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.purple.shade200,
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                var isValid = _formKey.currentState?.validate();
                if (isValid != null && isValid) {
                  if (otpCode != '') {
                    sl.get<AuthBloc>().add(OtpVerify(
                        userOtp: otpCode,
                        verificationId: widget.verificationId));
                  } else {
                    //     showSnackBar(context, "Enter 6-Digit code");
                  }
                } else {}
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.appBorder),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Verify",
                  style: AppTextStyles.headingTextStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
