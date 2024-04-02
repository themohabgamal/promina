import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/core/helpers/fonts.dart';
import 'package:promina/features/home/home_screen.dart';
import 'package:promina/features/home/logic/cubit/home_cubit.dart';
import 'package:promina/features/login/logic/cubit/login_cubit.dart';
import 'package:promina/features/login/ui/widgets/glass_login_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 253, 160, 247),
              Color.fromARGB(255, 136, 0, 255),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('My \n Gallery',
                    textAlign: TextAlign.center, style: MyFonts.largeFont),
                const SizedBox(height: 20),
                const GlassLoginContainer(),
                BlocListener<LoginCubit, LoginState>(
                  listenWhen: (previous, current) =>
                      current is LoginLoadingState ||
                      current is LoginErrorState ||
                      current is LoginLoadedState,
                  listener: (context, state) {
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Error Logging in")),
                      );
                    } else if (state is LoginLoadedState) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => HomeCubit(context),
                          child: const HomeScreen(),
                        ),
                      ));
                    }
                  },
                  child: const SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
