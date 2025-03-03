abstract class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}
final class OnboardingPageChangeState extends OnboardingState {
final  int index;

  OnboardingPageChangeState(this.index);
}
