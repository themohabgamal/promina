import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/core/networking/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuildContext context;
  HomeCubit(this.context) : super(HomeInitial());
  Future<void> uploadImage() async {
    emit(HomeLoading());
    try {
      await ApiService().uploadImageFromGallery(context);

      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError());
    }
  }
}
