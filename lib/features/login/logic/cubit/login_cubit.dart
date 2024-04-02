import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/core/networking/api_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BuildContext context;
  void login() async {
    emit(LoginLoadingState());
    try {
      await ApiService()
          .loginUser(context, emailController.text, passwordController.text)
          .then((value) {
        if (value == true) {
          emit(LoginLoadedState());
        } else {
          emit(LoginErrorState());
        }
      });
      print('Login successful cubit');
    } catch (e) {
      emit(LoginErrorState());
      print('Login failed cubit');
    }
  }
}
