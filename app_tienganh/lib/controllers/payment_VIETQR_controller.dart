import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app_tienganh/widgets/navbar.dart';

class VietqQRScreen extends StatefulWidget {
  final double totalPrice;
  final String orderId;
  final VoidCallback onPaymentSuccess;
  final VoidCallback onPaymentFailed;

  const VietqQRScreen({
    super.key,
    required this.totalPrice,
    required this.orderId,
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
  });

  @override
  State<VietqQRScreen> createState() => _VietQRScreenState();
}

class _VietQRScreenState extends State<VietqQRScreen> {
  String? _paymentUrl;
  String? _errorMessage;
  bool _isLoading = true;
  int? _paymentId;
  String _paymentStatus = 'PENDING';
  Timer? _statusCheckTimer;

  @override
  void initState() {
    super.initState();
    _generatePaymentLink();
    // Tự động mở WebView khi có URL
    _autoOpenWebViewWhenReady();
  }

  Future<void> _autoOpenWebViewWhenReady() async {
    // Chờ tối đa 5 giây để có paymentUrl
    int attempts = 0;
    while (_paymentUrl == null && attempts < 50) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }

    if (_paymentUrl != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => WebViewScreen(
                paymentUrl: _paymentUrl!,
                onPaymentSuccess: widget.onPaymentSuccess,
                onPaymentFailed: widget.onPaymentFailed,
              ),
        ),
      );
    }
  }

  Future<void> _generatePaymentLink() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _createPaymentLink(
        name: "Thanh toán đơn hàng ${widget.orderId}",
        price: widget.totalPrice,
        quantity: 1,
      );

      setState(() {
        _paymentUrl = result['url'];
        _paymentId = result['id'];
        _isLoading = false;
      });

      if (_paymentUrl != null && !_paymentUrl!.startsWith('http')) {
        _paymentUrl = 'https://$_paymentUrl';
      }

      if (_paymentId != null) {
        _startPaymentStatusCheck();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi khi tạo link thanh toán: $e';
        _isLoading = false;
      });
      widget.onPaymentFailed();
    }
  }

  Future<Map<String, dynamic>> _createPaymentLink({
    required String name,
    required double price,
    required int quantity,
  }) async {
    const String apiUrl =
        'http://13.212.35.60:8084/api/payment/create-payment-link';

    final requestBody = {'name': name, 'price': price, 'quantity': quantity};

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return {
        'url': jsonResponse['data']['url'] as String,
        'id': jsonResponse['data']['id'] as int,
      };
    } else {
      throw Exception(
        'Failed to create payment link: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<void> _checkPaymentStatus() async {
    if (_paymentId == null) return;

    const String apiUrl =
        'http://13.212.35.60:8084/api/payment/payment-information';

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?id=$_paymentId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final status = jsonResponse['status'] as String;

        setState(() {
          _paymentStatus = status;
        });

        if (status == 'PAID') {
          widget.onPaymentSuccess();
          _statusCheckTimer?.cancel();
          if (mounted) Navigator.pop(context);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi khi kiểm tra trạng thái thanh toán: $e';
      });
    }
  }

  void _startPaymentStatusCheck() {
    const maxDuration = Duration(minutes: 2);
    const checkInterval = Duration(seconds: 1);
    int elapsedSeconds = 0;

    _statusCheckTimer = Timer.periodic(checkInterval, (timer) async {
      if (elapsedSeconds >= maxDuration.inSeconds) {
        timer.cancel();
        if (_paymentStatus != 'PAID') {
          widget.onPaymentFailed();
          if (mounted) {
            setState(() {
              _errorMessage = 'Hết thời gian chờ thanh toán';
            });
          }
        }
        return;
      }

      await _checkPaymentStatus();
      elapsedSeconds += checkInterval.inSeconds;
    });
  }

  @override
  void dispose() {
    _statusCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: 'Thanh toán VietQR',
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          widget.onPaymentFailed();
          Navigator.pop(context);
        },
      ),
      body: Center(
        child:
            _isLoading
                ? const CircularProgressIndicator()
                : _errorMessage != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Quay lại'),
                    ),
                  ],
                )
                : const CircularProgressIndicator(),
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    String validUrl = widget.paymentUrl;
    if (!validUrl.startsWith('http')) {
      validUrl = 'https://$validUrl';
    }

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (progress == 100) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
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
          ..loadRequest(Uri.parse(validUrl));
  }

  bool _verifyPaymentResult(Map<String, String> queryParams) {
    const String payosHashSecret = "YOUR_PAYOS_HASH_SECRET";
    String? signature = queryParams['signature'];
    queryParams.remove('signature');

    var sortedKeys = queryParams.keys.toList()..sort();
    String queryString = sortedKeys
        .map((key) => "$key=${Uri.encodeComponent(queryParams[key]!)}")
        .join("&");
    var hmac = Hmac(sha512, utf8.encode(payosHashSecret));
    var digest = hmac.convert(utf8.encode(queryString));
    String computedHash = digest.toString().toUpperCase();

    return signature == computedHash && queryParams['status'] == 'PAID';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán VietQR'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onPaymentFailed();
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
