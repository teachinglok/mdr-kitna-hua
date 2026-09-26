import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../upi/data/repositories/upi_repository_impl.dart';
import '../../../upi/domain/entities/merchant_upi.dart';
import '../../../upi/presentation/pages/add_upi_page.dart';
import '../../../upi/presentation/widgets/upi_dropdown.dart';

class QrPaymentPage extends StatefulWidget {
  final double amount;
  final String shopName;
  final UpiRepositoryImpl repository;

  const QrPaymentPage({
    super.key,
    required this.amount,
    required this.shopName,
    required this.repository,
  });

  @override
  State<QrPaymentPage> createState() => _QrPaymentPageState();
}

class _QrPaymentPageState extends State<QrPaymentPage> {
  List<MerchantUpi> _upis = [];
  MerchantUpi? _selectedUpi;

  bool _isLoading = true;
  bool _qrGenerated = false;

  @override
  void initState() {
    super.initState();
    _loadUpis();
  }

  Future<void> _loadUpis() async {
    try {
      final List<MerchantUpi> usableUpis =
      await widget.repository.getUsableUpis();

      final MerchantUpi? defaultUpi =
      await widget.repository.getDefaultUpi();

      if (!mounted) {
        return;
      }

      setState(() {
        _upis = usableUpis;

        if (defaultUpi != null &&
            usableUpis.any(
                  (upi) => upi.id == defaultUpi.id,
            )) {
          _selectedUpi = defaultUpi;
        } else if (usableUpis.isNotEmpty) {
          _selectedUpi = usableUpis.first;
        } else {
          _selectedUpi = null;
        }

        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        'Unable to load your UPI accounts.',
      );
    }
  }

  Future<void> _openAddUpiPage() async {
    final List<MerchantUpi> existingUpis =
    await widget.repository.getUpiAccounts();

    if (!mounted) {
      return;
    }

    final MerchantUpi? newUpi =
    await Navigator.of(context).push<MerchantUpi>(
      MaterialPageRoute(
        builder: (_) => AddUpiPage(
          currentUpiCount: existingUpis.length,
        ),
      ),
    );

    if (newUpi == null || !mounted) {
      return;
    }

    try {
      final MerchantUpi savedUpi =
      await widget.repository.addUpi(newUpi);

      await _loadUpis();

      if (!mounted) {
        return;
      }

      setState(() {
        _selectedUpi = savedUpi;
        _qrGenerated = false;
      });

      _showMessage(
        '${savedUpi.upiId} added successfully.',
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage(
        error is StateError
            ? error.message
            : 'Unable to add your UPI ID.',
      );
    }
  }

  void _generateQr() {
    FocusScope.of(context).unfocus();

    if (_selectedUpi == null) {
      _showMessage(
        'Please add and verify a UPI ID first.',
      );
      return;
    }

    if (!_selectedUpi!.isUsable) {
      _showMessage(
        'Selected UPI ID is not available for QR payments.',
      );
      return;
    }

    if (widget.amount <= 0) {
      _showMessage(
        'Please calculate a valid amount first.',
      );
      return;
    }

    setState(() {
      _qrGenerated = true;
    });
  }

  String _buildUpiUri() {
    final String upiId =
    Uri.encodeComponent(_selectedUpi!.upiId);

    final String merchantName =
    Uri.encodeComponent(widget.shopName.trim());

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
    final String upiUri =
    _qrGenerated && _selectedUpi != null
        ? _buildUpiUri()
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payment'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
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
              _buildAmountCard(context),

              const SizedBox(height: 24),

              if (_upis.isEmpty)
                _buildNoUpiCard(context)
              else ...[
                Text(
                  'Payment Details',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                const SizedBox(height: 16),

                _buildMerchantCard(context),

                const SizedBox(height: 16),

                UpiDropdown(
                  upis: _upis,
                  selectedUpi: _selectedUpi,
                  onChanged: (MerchantUpi? upi) {
                    setState(() {
                      _selectedUpi = upi;
                      _qrGenerated = false;
                    });
                  },
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
                      backgroundColor:
                      const Color(0xFF1A2A6C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
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
        crossAxisAlignment:
        CrossAxisAlignment.start,
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

  Widget _buildMerchantCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A6C)
                  .withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: Color(0xFF1A2A6C),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Merchant',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.shopName.trim().isEmpty
                      ? 'Your Shop'
                      : widget.shopName.trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoUpiCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.account_balance_outlined,
              size: 30,
              color: Color(0xFF8A6D00),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Verified UPI ID',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add and verify at least one UPI ID '
                'to generate a payment QR.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _openAddUpiPage,
              icon: const Icon(
                Icons.add_rounded,
              ),
              label: const Text(
                'ADD UPI ID',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF1A2A6C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
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
          color: Theme.of(context)
              .colorScheme
              .outline,
        ),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.shopName.trim().isEmpty
                ? 'Your Shop'
                : widget.shopName.trim(),
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
            errorCorrectionLevel:
            QrErrorCorrectLevel.M,
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

          const Text(
            'Scan to pay',
          ),
        ],
      ),
    );
  }
}