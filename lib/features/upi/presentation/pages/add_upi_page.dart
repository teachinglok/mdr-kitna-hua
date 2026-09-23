import 'package:flutter/material.dart';

import '../../domain/entities/merchant_upi.dart';

class AddUpiPage extends StatefulWidget {
  final int currentUpiCount;
  final int freeUpiLimit;

  const AddUpiPage({
    super.key,
    this.currentUpiCount = 0,
    this.freeUpiLimit = 4,
  });

  @override
  State<AddUpiPage> createState() => _AddUpiPageState();
}

class _AddUpiPageState extends State<AddUpiPage> {
  final TextEditingController _upiIdController =
  TextEditingController();

  final TextEditingController _displayNameController =
  TextEditingController();

  bool _isVerifying = false;

  @override
  void dispose() {
    _upiIdController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _verifyUpi() async {
    FocusScope.of(context).unfocus();

    final String upiId =
    _upiIdController.text.trim();

    final String displayName =
    _displayNameController.text.trim();

    if (upiId.isEmpty) {
      _showMessage('Please enter your UPI ID.');
      return;
    }

    if (!_isValidUpiId(upiId)) {
      _showMessage('Please enter a valid UPI ID.');
      return;
    }

    if (displayName.isEmpty) {
      _showMessage('Please enter your display name.');
      return;
    }

    if (widget.currentUpiCount >= widget.freeUpiLimit) {
      _showMessage(
        'Your free UPI limit has been reached.',
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    /*
     * PROTOTYPE ONLY
     *
     * This delay represents a future real verification request.
     * It does NOT actually verify ownership of the UPI ID.
     *
     * Production:
     * Flutter → Backend → Authorized UPI verification service
     */
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) {
      return;
    }

    final DateTime now = DateTime.now();

    final MerchantUpi upi = MerchantUpi(
      id: 'local-${now.microsecondsSinceEpoch}',
      upiId: upiId,
      displayName: displayName,
      verified: true,
      active: true,
      isDefault: widget.currentUpiCount == 0,
      createdAt: now,
      updatedAt: now,
    );

    setState(() {
      _isVerifying = false;
    });

    Navigator.of(context).pop(upi);
  }

  bool _isValidUpiId(String value) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+$',
    ).hasMatch(value);
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
    final int remaining =
        widget.freeUpiLimit - widget.currentUpiCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add UPI ID',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
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
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _buildInfoCard(context),

              const SizedBox(height: 24),

              const Text(
                'UPI Details',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _upiIdController,
                keyboardType:
                TextInputType.emailAddress,
                textInputAction:
                TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                  hintText: 'example@upi',
                  prefixIcon: const Icon(
                    Icons.account_balance_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller:
                _displayNameController,
                textInputAction:
                TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  hintText:
                  'Your shop or business name',
                  prefixIcon: const Icon(
                    Icons.storefront_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'This name will appear as the payee name when '
                    'a customer scans your payment QR.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                  _isVerifying
                      ? null
                      : _verifyUpi,
                  icon: _isVerifying
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(
                    Icons.verified_outlined,
                  ),
                  label: Text(
                    _isVerifying
                        ? 'VERIFYING...'
                        : 'VERIFY UPI ID',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF1A2A6C),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                    const Color(0xFF94A3B8),
                    disabledForegroundColor:
                    Colors.white,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _buildSecurityNote(),

              const SizedBox(height: 20),

              Text(
                '$remaining free UPI '
                    '${remaining == 1 ? 'slot' : 'slots'} remaining',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
        ),
      ),
      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.account_balance_outlined,
            color: Color(0xFF1A2A6C),
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Add a UPI ID to receive customer payments. '
                  'Only verified and active UPI IDs can be used '
                  'for payment QR generation.',
              style: TextStyle(
                color: Color(0xFF334155),
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4AF37)
              .withValues(alpha: 0.35),
        ),
      ),
      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF8A6D00),
            size: 19,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Prototype verification is for testing only. '
                  'It does not confirm UPI ownership. Real verification '
                  'will be performed securely through the backend and '
                  'an authorized verification service.',
              style: TextStyle(
                color: Color(0xFF6B5700),
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}