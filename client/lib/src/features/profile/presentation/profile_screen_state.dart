import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenState {
  ProfileScreenState({
    required this.profileAsyncValue,
    required this.signOutAsyncValue,
  });
  final AsyncValue profileAsyncValue;
  final AsyncValue signOutAsyncValue;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileScreenState &&
        other.profileAsyncValue == profileAsyncValue &&
        other.signOutAsyncValue == signOutAsyncValue;
  }

  @override
  int get hashCode => profileAsyncValue.hashCode ^ signOutAsyncValue.hashCode;

  @override
  String toString() =>
      'ProfileScreenState(profileAsyncValue: $profileAsyncValue, signOutAsyncValue: $signOutAsyncValue)';

  ProfileScreenState copyWith({
    AsyncValue? profileAsyncValue,
    AsyncValue? signOutAsyncValue,
  }) {
    return ProfileScreenState(
      profileAsyncValue: profileAsyncValue ?? this.profileAsyncValue,
      signOutAsyncValue: signOutAsyncValue ?? this.signOutAsyncValue,
    );
  }
}
