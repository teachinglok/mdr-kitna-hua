import 'package:flutter/material.dart';

import '../../data/repositories/upi_repository_impl.dart';
import '../../domain/entities/merchant_upi.dart';
import '../../domain/services/upi_service.dart';
import '../widgets/add_upi_button.dart';
import '../widgets/upi_card.dart';
import 'add_upi_page.dart';

class UpiSettingsPage extends StatefulWidget {
  final UpiRepositoryImpl repository;

  const UpiSettingsPage({
    super.key,
    required this.repository,
  });

  @override
  State<UpiSettingsPage> createState() => _UpiSettingsPageState();
}

class _UpiSettingsPageState extends State<UpiSettingsPage> {
  late final UpiRepositoryImpl _repository;

  List<MerchantUpi> _upis = [];

  bool _isLoading = true;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    _repository = widget.repository;

    _loadUpis();
  }

  Future<void> _loadUpis() async {
    final List<MerchantUpi> upis =
    await _repository.getUpiAccounts();

    final List<MerchantUpi> normalizedUpis =
    UpiService().ensureDefaultUpi(upis);

    if (normalizedUpis.length != upis.length ||
        !_sameUpis(upis, normalizedUpis)) {
      for (final MerchantUpi upi in normalizedUpis) {
        await _repository.updateUpi(upi);
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _upis = normalizedUpis;
      _isLoading = false;
    });
  }

  Future<void> _addUpi() async {
    if (_upis.length >= UpiService.freeUpiLimit) {
      _showMessage(
        'Your free limit of '
            '${UpiService.freeUpiLimit} UPI IDs has been reached.',
      );
      return;
    }

    final MerchantUpi? result =
    await Navigator.of(context).push<MerchantUpi>(
      MaterialPageRoute(
        builder: (_) => AddUpiPage(
          currentUpiCount: _upis.length,
          freeUpiLimit: UpiService.freeUpiLimit,
        ),
      ),
    );

    if (!mounted || result == null) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      await _repository.addUpi(result);
      await _loadUpis();
    } on StateError catch (error) {
      _showMessage(error.message);
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _setDefault(MerchantUpi upi) async {
    if (!upi.isUsable || upi.isDefault) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      await _repository.setDefaultUpi(upi.id);
      await _loadUpis();

      _showMessage(
        '${upi.upiId} is now your default UPI.',
      );
    } on StateError catch (error) {
      _showMessage(error.message);
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _deactivate(MerchantUpi upi) async {
    if (!upi.active) {
      return;
    }

    final bool? confirmed =
    await _showDeactivateDialog(upi);

    if (!mounted || confirmed != true) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      await _repository.deactivateUpi(upi.id);
      await _loadUpis();

      _showMessage(
        '${upi.upiId} has been deactivated.',
      );
    } on StateError catch (error) {
      _showMessage(error.message);
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _activate(MerchantUpi upi) async {
    if (upi.active) {
      return;
    }

    final bool? shouldVerify =
    await _showActivateDialog(upi);

    if (!mounted || shouldVerify != true) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final bool verified =
      await _verifyUpiAgain(upi);

      if (!verified) {
        _showMessage(
          'UPI verification failed. The UPI ID remains inactive.',
        );
        return;
      }

      await _repository.activateUpi(upi.id);
      await _loadUpis();

      _showMessage(
        '${upi.upiId} has been verified and activated.',
      );
    } on StateError catch (error) {
      _showMessage(error.message);
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<bool> _verifyUpiAgain(
      MerchantUpi upi,
      ) async {
    // Prototype verification only.
    //
    // Real ownership verification will be connected
    // to the backend/payment verification service later.
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    return true;
  }

  Future<bool?> _showActivateDialog(
      MerchantUpi upi,
      ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Verify UPI Again?',
          ),
          content: Text(
            'To activate ${upi.upiId}, you need to '
                'verify ownership of this UPI ID again.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF1A2A6C),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'VERIFY & ACTIVATE',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showDeactivateDialog(
      MerchantUpi upi,
      ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Deactivate UPI?',
          ),
          content: Text(
            'You will no longer be able to use '
                '${upi.upiId} for new payment QR codes.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFFB91C1C),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'DEACTIVATE',
              ),
            ),
          ],
        );
      },
    );
  }

  bool _sameUpis(
      List<MerchantUpi> first,
      List<MerchantUpi> second,
      ) {
    if (first.length != second.length) {
      return false;
    }

    for (int i = 0; i < first.length; i++) {
      if (first[i].id != second[i].id ||
          first[i].isDefault != second[i].isDefault ||
          first[i].active != second[i].active ||
          first[i].verified != second[i].verified) {
        return false;
      }
    }

    return true;
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

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
    final int totalUpis = _upis.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'UPI Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF1A2A6C),
          ),
        )
            : RefreshIndicator(
          onRefresh: _loadUpis,
          child: SingleChildScrollView(
            physics:
            const AlwaysScrollableScrollPhysics(),
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
                _buildHeaderCard(totalUpis),
                const SizedBox(height: 24),
                if (_upis.isEmpty)
                  _buildEmptyState()
                else
                  _buildUpiList(),
                const SizedBox(height: 20),
                AddUpiButton(
                  onPressed:
                  _isProcessing ? null : _addUpi,
                ),
                const SizedBox(height: 16),
                _buildLimitNote(totalUpis),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(int totalUpis) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A6C),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.account_balance_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verified UPI IDs',
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalUpis / '
                      '${UpiService.freeUpiLimit}',
                  style: const TextStyle(
                    color: Color(0xFF1A2A6C),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpiList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR UPI IDs',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        ..._upis.map(
              (upi) => Padding(
            padding:
            const EdgeInsets.only(bottom: 12),
            child: UpiCard(
              upi: upi,
              onSetDefault: () => _setDefault(upi),
              onDeactivate: () => _deactivate(upi),
              onActivate: () => _activate(upi),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
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
      child: const Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            color: Color(0xFF94A3B8),
            size: 42,
          ),
          SizedBox(height: 12),
          Text(
            'No UPI ID added yet',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Add and verify a UPI ID to receive payments.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitNote(int totalUpis) {
    final bool limitReached =
        totalUpis >= UpiService.freeUpiLimit;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: limitReached
            ? const Color(0xFFFFF7ED)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: limitReached
              ? const Color(0xFFFED7AA)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            limitReached
                ? Icons.info_outline_rounded
                : Icons.verified_user_outlined,
            color: limitReached
                ? const Color(0xFFC2410C)
                : const Color(0xFF047857),
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              limitReached
                  ? 'Free UPI limit reached. Upgrade later '
                  'to add more UPI IDs.'
                  : 'You can add up to '
                  '${UpiService.freeUpiLimit} verified UPI IDs '
                  'on the free plan.',
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}