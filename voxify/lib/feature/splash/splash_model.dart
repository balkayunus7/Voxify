import 'package:equatable/equatable.dart';

final class SplashState extends Equatable {
  const SplashState({
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  List<Object> get props => [isLoading];

  SplashState copyWith({
    bool? isLoading,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}