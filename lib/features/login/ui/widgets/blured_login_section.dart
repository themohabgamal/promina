import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina/core/helpers/fonts.dart';
import 'package:promina/features/login/logic/cubit/login_cubit.dart';
import 'package:promina/features/login/ui/widgets/expanded_button.dart';
import 'package:promina/features/login/ui/widgets/general_text_field.dart';

class BluredLoginSection extends StatelessWidget {
  const BluredLoginSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur amount
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent, // Transparent color
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "LOG IN",
                style: MyFonts.mediumFont,
              ),
              SizedBox(height: 20.h),
              GeneralTextField(
                  isObsecure: false,
                  hintText: "User Name",
                  controller: emailController),
              SizedBox(height: 20.h),
              GeneralTextField(
                  isObsecure: true,
                  hintText: "Password",
                  controller: passwordController),
              SizedBox(height: 20.h),
              ExpandedButton(
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
