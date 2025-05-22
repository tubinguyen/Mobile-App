import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:vnpay_flutter/vnpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Thay thế flutter_webview_plugin
import 'package:app_tienganh/widgets/navbar.dart';

class VNPayScreen extends StatefulWidget {
  final double totalPrice;
  final String orderId;
  final VoidCallback onPaymentSuccess;
  final VoidCallback onPaymentFailed;

  const VNPayScreen({
    super.key,
    required this.totalPrice,
    required this.orderId,
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
  });

  @override
  State<VNPayScreen> createState() => _VNPayScreenState();
}

class _VNPayScreenState extends State<VNPayScreen> {
  // Thông tin VNPay (thay bằng thông tin thực tế từ Sandbox)
  static const String vnpTmnCode = "GCTEKMDY";
  static const String vnpHashSecret = "FNFSJI2456MV7GASYYQXZWUUKJ41O59D";
  static const String vnpUrl =
      "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
  static const String vnpReturnUrl = "yourapp://payment-result";
  static const String vnpIpnUrl = "https://9030-14-169-15-220.ngrok-free.app";

  String _generatePaymentUrl() {
    final Map<String, String> params = {
      "vnp_Version": "2.1.0",
      "vnp_Command": "pay",
      "vnp_TmnCode": vnpTmnCode,
      "vnp_Amount": (widget.totalPrice * 100).toInt().toString(),
      "vnp_CurrCode": "VND",
      "vnp_TxnRef": widget.orderId,
      "vnp_OrderInfo": "Thanh toán đơn hàng ${widget.orderId}",
      "vnp_OrderType": "250000",
      "vnp_Locale": "vn",
      "vnp_ReturnUrl": vnpReturnUrl,
      "vnp_IpnUrl": vnpIpnUrl,
      "vnp_IpAddr": "127.0.0.1",
      "vnp_CreateDate": DateTime.now()
          .toIso8601String()
          .replaceAll(RegExp(r'[-:T.]'), '')
          .substring(0, 14),
    };

    var sortedKeys = params.keys.toList()..sort();
    String queryString = sortedKeys
        .map((key) => "$key=${Uri.encodeComponent(params[key]!)}")
        .join("&");
    var hmac = Hmac(sha512, utf8.encode(vnpHashSecret));
    var digest = hmac.convert(utf8.encode(queryString));
    String secureHash = digest.toString().toUpperCase();

    return "$vnpUrl?$queryString&vnp_SecureHash=$secureHash";
  }

  @override
  Widget build(BuildContext context) {
    final paymentUrl = _generatePaymentUrl();

    return Scaffold(
      appBar: CustomNavBar(
        title: 'Thanh toán VNPay',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thanh toán ${widget.totalPrice.toStringAsFixed(0)} VNĐ",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            QrImageView(
              data: paymentUrl,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WebViewScreen(
                          paymentUrl: paymentUrl,
                          onPaymentSuccess: widget.onPaymentSuccess,
                          onPaymentFailed: widget.onPaymentFailed,
                        ),
                  ),
                );
              },
              child: const Text("Mở cổng thanh toán VNPay"),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final VoidCallback onPaymentSuccess;
  final VoidCallback onPaymentFailed;

  const WebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                if (request.url.startsWith("yourapp://payment-result")) {
                  final uri = Uri.parse(request.url);
                  final queryParams = uri.queryParameters;
                  if (_verifyPaymentResult(queryParams)) {
                    widget.onPaymentSuccess();
                  } else {
                    widget.onPaymentFailed();
                  }
                  Navigator.pop(context);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  bool _verifyPaymentResult(Map<String, String> queryParams) {
    const String vnpHashSecret =
        "FNFSJI2456MV7GASYYQXZWUUKJ41O59D"; // Thay bằng hash secret của bạn
    String? secureHash = queryParams['vnp_SecureHash'];
    queryParams.remove('vnp_SecureHash');

    var sortedKeys = queryParams.keys.toList()..sort();
    String queryString = sortedKeys
        .map((key) => "$key=${Uri.encodeComponent(queryParams[key]!)}")
        .join("&");
    var hmac = Hmac(sha512, utf8.encode(vnpHashSecret));
    var digest = hmac.convert(utf8.encode(queryString));
    String computedHash = digest.toString().toUpperCase();

    return secureHash == computedHash &&
        queryParams['vnp_ResponseCode'] == '00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán VNPay")),
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
