import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPaymentPage extends StatefulWidget {
  final double amount;

  const QrPaymentPage({
    super.key,
    required this.amount,
  });

  @override
  State<QrPaymentPage> createState() => _QrPaymentPageState();
}

class _QrPaymentPageState extends State<QrPaymentPage> {
  final TextEditingController _upiIdController =
  TextEditingController();

  final TextEditingController _merchantNameController =
  TextEditingController();

  bool _qrGenerated = false;

  @override
  void dispose() {
    _upiIdController.dispose();
    _merchantNameController.dispose();
    super.dispose();
  }

  void _generateQr() {
    FocusScope.of(context).unfocus();

    final String upiId = _upiIdController.text.trim();
    final String merchantName =
    _merchantNameController.text.trim();

    if (upiId.isEmpty) {
      _showMessage('Please enter your UPI ID.');
      return;
    }

    if (!_isValidUpiId(upiId)) {
      _showMessage('Please enter a valid UPI ID.');
      return;
    }

    if (merchantName.isEmpty) {
      _showMessage('Please enter your merchant name.');
      return;
    }

    setState(() {
      _qrGenerated = true;
    });
  }

  bool _isValidUpiId(String value) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+$',
    ).hasMatch(value);
  }

  String _buildUpiUri() {
    final String upiId =
    Uri.encodeComponent(_upiIdController.text.trim());

    final String merchantName =
    Uri.encodeComponent(_merchantNameController.text.trim());

    final String amount =
    widget.amount.toStringAsFixed(2);

    return 'upi://pay'
        '?pa=$upiId'
        '&pn=$merchantName'
        '&am=$amount'
        '&cu=INR';
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString();
    }

    return amount.toStringAsFixed(2);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final String upiUri = _qrGenerated
        ? _buildUpiUri()
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            24,
            20,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAmountCard(context),

              const SizedBox(height: 24),

              Text(
                'Merchant Details',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _merchantNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Merchant Name',
                  hintText: 'Enter your shop or business name',
                  prefixIcon: const Icon(
                    Icons.storefront_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _upiIdController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                  hintText: 'example@upi',
                  prefixIcon: const Icon(
                    Icons.account_balance_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _generateQr,
                  icon: const Icon(
                    Icons.qr_code_2_rounded,
                  ),
                  label: const Text(
                    'GENERATE QR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2A6C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              if (_qrGenerated) ...[
                const SizedBox(height: 32),
                _buildQrCard(
                  context,
                  upiUri,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
        ),
      ),
      child: Column(
        children: [
          Text(
            'CUSTOMER PAYS',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${_formatAmount(widget.amount)}',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A2A6C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCard(
      BuildContext context,
      String upiUri,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _merchantNameController.text.trim(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          QrImageView(
            data: upiUri,
            version: QrVersions.auto,
            size: 240,
            backgroundColor: Colors.white,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
          ),

          const SizedBox(height: 20),

          Text(
            '₹${_formatAmount(widget.amount)}',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A2A6C),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Scan to pay',
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),

          const SizedBox(height: 16),

          Text(
            _upiIdController.text.trim(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}