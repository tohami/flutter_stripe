import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_checkout/src/platforms/checkout.dart';
import 'package:stripe_checkout/src/platforms/stripe_checkout.dart';

Future<CheckoutResponse?> redirectToCheckout({
  required BuildContext context,
  required String sessionId,
  required String publishableKey,
  String? stripeAccountId,
  String? successUrl,
  String? canceledUrl,
  String? initialPageUrl,
}) async {
  assert(() {
    assert(
    successUrl != null,
    'successUrl can not be null when using checkout inside a webview',
    );
    assert(
    canceledUrl != null,
    'canceledUrl can not be null when using checkout inside a webview',
    );
    return true;
  }());
  final response = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CheckoutPage(
        sessionId: sessionId,
        publishableKey: publishableKey,
        stripeAccountId: stripeAccountId,
        onCompleted: (response) => Navigator.of(context).pop(response),
        successUrl: successUrl!,
        canceledUrl: canceledUrl!,
        initialPageUrl: initialPageUrl
      ),
    ),
  );
  return response ?? const CheckoutResponse.canceled();
}
