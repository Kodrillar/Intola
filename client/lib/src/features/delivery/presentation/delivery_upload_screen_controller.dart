import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/delivery/data/repository/delivery_repository.dart';
import 'package:intola/src/features/delivery/presentation/delivery_upload_screen_state.dart';

class DeliveryUploadScreenController
    extends StateNotifier<DeliveryUploadScreenState> {
  DeliveryUploadScreenController({required this.deliveryRepository})
      : super(
          DeliveryUploadScreenState(asyncValue: const AsyncData(null)),
        );

  DeliveryRepository deliveryRepository;

  Future<bool> addDelivery(
      {required String weight,
      required String price,
      required String description,
      required String location,
      required String contact}) async {
    state = state.copyWith(asyncValue: const AsyncLoading());
    final asyncValue =
        await AsyncValue.guard(() => deliveryRepository.addDelivery(
              weight: weight,
              price: price,
              description: description,
              location: location,
              contact: contact,
              imagePath: state.imagePath,
            ));
    if (mounted) {
      state = state.copyWith(asyncValue: asyncValue);
      return !state.asyncValue.hasError;
    }

    return false;
  }

  void updateImagePath({required String imagePath}) {
    state = state.copyWith(imagePath: imagePath);
  }
}

final deliveryUploadScreenControllerProvider = StateNotifierProvider
    .autoDispose<DeliveryUploadScreenController, DeliveryUploadScreenState>(
        (ref) => DeliveryUploadScreenController(
            deliveryRepository: ref.watch(deliveryRespositoryProvider)));
