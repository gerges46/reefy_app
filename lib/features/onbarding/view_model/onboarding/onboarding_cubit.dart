

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefy/features/onbarding/view_model/onboarding/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  PageController controller = PageController();
  int currentPage=0;
  void next(int index){
    currentPage=index;
emit(OnboardingPageChangeState(index));
  }
}
