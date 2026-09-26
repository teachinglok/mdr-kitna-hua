import 'package:flutter/material.dart';

import '../widgets/transaction_filter_sheet.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
  });

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return const TransactionFilterSheet();
      },
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
          'History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _openFilterSheet(context);
            },
            icon: const Icon(
              Icons.filter_list_rounded,
            ),
            tooltip: 'Filter',
          ),
        ],
      ),
      body: const _HistoryContent(),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        24,
      ),
      children: const [
        _TransactionCard(
          amount: '₹5,021',
          status: 'Amount Received',
          dateTime: '12/09/2026 12:20 PM',
          received: true,
        ),
        SizedBox(height: 12),
        _TransactionCard(
          amount: '₹2,500',
          status: 'Payment Failed',
          dateTime: '12/09/2026 11:45 AM',
          received: false,
        ),
        SizedBox(height: 12),
        _TransactionCard(
          amount: '₹1,200',
          status: 'Amount Received',
          dateTime: '11/09/2026 08:15 PM',
          received: true,
        ),
      ],
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final String amount;
  final String status;
  final String dateTime;
  final bool received;

  const _TransactionCard({
    required this.amount,
    required this.status,
    required this.dateTime,
    required this.received,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = received
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            amount,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                received
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                size: 18,
                color: statusColor,
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dateTime,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}