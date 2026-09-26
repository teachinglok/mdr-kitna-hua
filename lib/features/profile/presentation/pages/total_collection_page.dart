import 'package:flutter/material.dart';

enum CollectionPeriod {
  last24Hours,
  today,
  yesterday,
  thisWeek,
  thisMonth,
  custom,
}

class TotalCollectionPage extends StatefulWidget {
  const TotalCollectionPage({
    super.key,
  });

  @override
  State<TotalCollectionPage> createState() =>
      _TotalCollectionPageState();
}

class _TotalCollectionPageState
    extends State<TotalCollectionPage> {
  CollectionPeriod _selectedPeriod =
      CollectionPeriod.last24Hours;

  String get _periodLabel {
    switch (_selectedPeriod) {
      case CollectionPeriod.last24Hours:
        return 'Last 24 Hours';
      case CollectionPeriod.today:
        return 'Today';
      case CollectionPeriod.yesterday:
        return 'Yesterday';
      case CollectionPeriod.thisWeek:
        return 'This Week';
      case CollectionPeriod.thisMonth:
        return 'This Month';
      case CollectionPeriod.custom:
        return 'Custom Date Range';
    }
  }

  void _selectPeriod(CollectionPeriod period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  void _openPeriodSelector() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Collection Period',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildPeriodOption(
                  CollectionPeriod.last24Hours,
                  'Last 24 Hours',
                ),
                _buildPeriodOption(
                  CollectionPeriod.today,
                  'Today',
                ),
                _buildPeriodOption(
                  CollectionPeriod.yesterday,
                  'Yesterday',
                ),
                _buildPeriodOption(
                  CollectionPeriod.thisWeek,
                  'This Week',
                ),
                _buildPeriodOption(
                  CollectionPeriod.thisMonth,
                  'This Month',
                ),
                _buildPeriodOption(
                  CollectionPeriod.custom,
                  'Custom Date Range',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPeriodOption(
      CollectionPeriod period,
      String label,
      ) {
    final bool isSelected = _selectedPeriod == period;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        _selectPeriod(period);
        Navigator.of(context).pop();
      },
      leading: Icon(
        isSelected
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded,
        color: isSelected
            ? const Color(0xFF1A2A6C)
            : const Color(0xFF64748B),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? const Color(0xFF1A2A6C)
              : const Color(0xFF0F172A),
          fontSize: 15,
          fontWeight:
          isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Total Collection',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCollectionCard(),
              const SizedBox(height: 16),
              _buildSummaryCard(),
              const SizedBox(height: 16),
              _buildInformationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Collection',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹0.00',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _openPeriodSelector,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Color(0xFF1A2A6C),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _periodLabel,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: const Column(
        children: [
          _SummaryRow(
            icon: Icons.check_circle_outline_rounded,
            label: 'Received Transactions',
            value: '0',
          ),
          SizedBox(height: 16),
          _SummaryRow(
            icon: Icons.receipt_long_outlined,
            label: 'Total MDR',
            value: '₹0.00',
          ),
        ],
      ),
    );
  }

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4AF37),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF1A2A6C),
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Only successful payments are included in Total Collection. Failed payments and QR generation are not included.',
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF1A2A6C),
          size: 21,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}