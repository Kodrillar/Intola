import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/presentation/cart_screen_controller.dart';
import 'package:intola/src/features/shipping/presentation/screens/shipping_info_screen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class CartScreenBottomAppBar extends ConsumerWidget {
  const CartScreenBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartScreenControllerProvider);
    return BottomAppBar(
      elevation: 10,
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              state.isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : CustomRoundButton(
                      onTap: () async {
                        final totalPrice = await ref
                            .read(cartScreenControllerProvider.notifier)
                            .getCartTotalPrice();

                        if (totalPrice == null) return;

                        final checkout =
                            await CustomAlertDialog.showConfirmationAlertDialog(
                          context: context,
                          title: 'Total',
                          content: 'You\'re about to pay \$$totalPrice',
                          falseConfirmationWidget: const Text('cancel'),
                          truthyConfirmationWidget: const Text('proceed'),
                        );

                        if (checkout) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShippingInfoScreen(),
                            ),
                          );
                        }
                      },
                      buttonText: "Checkout",
                      buttonColor: kDarkBlue,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
