import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class OnboardingEvent {}

class OnboardingCompleted extends OnboardingEvent {}

// States
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}
class OnboardingComplete extends OnboardingState {}

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingCompleted>(_onOnboardingCompleted);
  }

  void _onOnboardingCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) async {
    // Save that onboarding has been shown
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    
    emit(OnboardingComplete());
  }

  // Helper method to mark onboarding as shown (simplified for your current implementation)
  void markOnboardingShown() {
    add(OnboardingCompleted());
  }
}