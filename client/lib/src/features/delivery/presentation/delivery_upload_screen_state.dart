import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryUploadScreenState {
  DeliveryUploadScreenState({
    required this.asyncValue,
    this.imagePath,
  });
  final AsyncValue<void> asyncValue;
  final String? imagePath;

  DeliveryUploadScreenState copyWith({
    AsyncValue? asyncValue,
    String? imagePath,
  }) {
    return DeliveryUploadScreenState(
        asyncValue: asyncValue ?? this.asyncValue,
        imagePath: imagePath ?? this.imagePath);
  }

  @override
  String toString() =>
      'DeliveryUploadScreenState(asyncValue: $asyncValue, imagePath: $imagePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeliveryUploadScreenState &&
        other.asyncValue == asyncValue &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode => asyncValue.hashCode ^ imagePath.hashCode;
}
