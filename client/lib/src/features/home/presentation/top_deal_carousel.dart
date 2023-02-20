import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/presentation/home_controller.dart';
import 'package:intola/src/features/home/presentation/carousel_slider.dart';
import 'package:intola/src/widgets/error_display.dart';

class TopDealsCarousel extends StatelessWidget {
  const TopDealsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeScreenControllerProvider);
        return state.productCarouselAsyncValue.when(
          data: (data) => CustomCarouselSlider(
            carouselItems: data,
          ),
          error: (error, stackTrace) => ErrorDisplayWidget(
            onRetry: () => ref
                .read(homeScreenControllerProvider.notifier)
                .updateProductCarouselOnReload(),
            error: error,
          ),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
