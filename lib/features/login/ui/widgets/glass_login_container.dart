import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/features/login/logic/cubit/login_cubit.dart';
import 'package:promina/features/login/ui/widgets/blured_login_section.dart';

class GlassLoginContainer extends StatefulWidget {
  const GlassLoginContainer({super.key});

  @override
  State<GlassLoginContainer> createState() => _GlassLoginContainerState();
}

class _GlassLoginContainerState extends State<GlassLoginContainer> {
  late TextEditingController emailController;

  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = context.read<LoginCubit>().emailController;
    passwordController = context.read<LoginCubit>().passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2), // Adjust opacity as needed
      ),
      child: BluredLoginSection(
          emailController: emailController,
          passwordController: passwordController),
    );
  }
}
