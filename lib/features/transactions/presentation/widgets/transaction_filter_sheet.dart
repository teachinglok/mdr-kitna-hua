import 'package:flutter/material.dart';

import '../../domain/entities/payment_transaction.dart';

class TransactionFilterSheet extends StatefulWidget {
  final DateTime? initialFromDate;
  final DateTime? initialToDate;
  final TimeOfDay? initialFromTime;
  final TimeOfDay? initialToTime;
  final double? initialMinimumAmount;
  final double? initialMaximumAmount;
  final PaymentTransactionStatus? initialStatus;

  const TransactionFilterSheet({
    super.key,
    this.initialFromDate,
    this.initialToDate,
    this.initialFromTime,
    this.initialToTime,
    this.initialMinimumAmount,
    this.initialMaximumAmount,
    this.initialStatus,
  });

  @override
  State<TransactionFilterSheet> createState() =>
      _TransactionFilterSheetState();
}

class _TransactionFilterSheetState
    extends State<TransactionFilterSheet> {
  DateTime? _fromDate;
  DateTime? _toDate;

  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  final TextEditingController _minimumAmountController =
  TextEditingController();

  final TextEditingController _maximumAmountController =
  TextEditingController();

  PaymentTransactionStatus? _status;

  @override
  void initState() {
    super.initState();

    _fromDate = widget.initialFromDate;
    _toDate = widget.initialToDate;

    _fromTime = widget.initialFromTime;
    _toTime = widget.initialToTime;

    _minimumAmountController.text =
        widget.initialMinimumAmount?.toString() ?? '';

    _maximumAmountController.text =
        widget.initialMaximumAmount?.toString() ?? '';

    _status = widget.initialStatus;
  }

  @override
  void dispose() {
    _minimumAmountController.dispose();
    _maximumAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectFromDate() async {
    final DateTime? selectedDate =
    await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _fromDate = selectedDate;
    });
  }

  Future<void> _selectToDate() async {
    final DateTime? selectedDate =
    await showDatePicker(
      context: context,
      initialDate: _toDate ?? _fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _toDate = selectedDate;
    });
  }

  Future<void> _selectFromTime() async {
    final TimeOfDay? selectedTime =
    await showTimePicker(
      context: context,
      initialTime:
      _fromTime ?? const TimeOfDay(hour: 0, minute: 0),
    );

    if (selectedTime == null) {
      return;
    }

    setState(() {
      _fromTime = selectedTime;
    });
  }

  Future<void> _selectToTime() async {
    final TimeOfDay? selectedTime =
    await showTimePicker(
      context: context,
      initialTime:
      _toTime ?? const TimeOfDay(hour: 23, minute: 59),
    );

    if (selectedTime == null) {
      return;
    }

    setState(() {
      _toTime = selectedTime;
    });
  }

  void _clearFilters() {
    setState(() {
      _fromDate = null;
      _toDate = null;
      _fromTime = null;
      _toTime = null;
      _minimumAmountController.clear();
      _maximumAmountController.clear();
      _status = null;
    });
  }

  void _applyFilters() {
    final double? minimumAmount =
    double.tryParse(
      _minimumAmountController.text.trim(),
    );

    final double? maximumAmount =
    double.tryParse(
      _maximumAmountController.text.trim(),
    );

    Navigator.of(context).pop(
      TransactionFilterResult(
        fromDate: _fromDate,
        toDate: _toDate,
        fromTime: _fromTime,
        toTime: _toTime,
        minimumAmount: minimumAmount,
        maximumAmount: maximumAmount,
        status: _status,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Select date';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) {
      return 'Select time';
    }

    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Filter History',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Clear'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'DATE',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    icon: Icons.calendar_today_rounded,
                    label: _formatDate(_fromDate),
                    onPressed: _selectFromDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FilterButton(
                    icon: Icons.calendar_today_rounded,
                    label: _formatDate(_toDate),
                    onPressed: _selectToDate,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'TIME',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    icon: Icons.access_time_rounded,
                    label: _formatTime(_fromTime),
                    onPressed: _selectFromTime,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FilterButton(
                    icon: Icons.access_time_rounded,
                    label: _formatTime(_toTime),
                    onPressed: _selectToTime,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'AMOUNT RANGE',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minimumAmountController,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      prefixText: '₹ ',
                      hintText: 'Minimum',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _maximumAmountController,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      prefixText: '₹ ',
                      hintText: 'Maximum',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'STATUS',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<
                PaymentTransactionStatus?>(
              initialValue: _status,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('All'),
              items: const [
                DropdownMenuItem<
                    PaymentTransactionStatus?>(
                  value: null,
                  child: Text('All'),
                ),
                DropdownMenuItem<
                    PaymentTransactionStatus>(
                  value: PaymentTransactionStatus.received,
                  child: Text('Received'),
                ),
                DropdownMenuItem<
                    PaymentTransactionStatus>(
                  value: PaymentTransactionStatus.failed,
                  child: Text('Failed'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value;
                });
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF1A2A6C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionFilterResult {
  final DateTime? fromDate;
  final DateTime? toDate;

  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;

  final double? minimumAmount;
  final double? maximumAmount;

  final PaymentTransactionStatus? status;

  const TransactionFilterResult({
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.minimumAmount,
    this.maximumAmount,
    this.status,
  });

  bool get hasFilters {
    return fromDate != null ||
        toDate != null ||
        fromTime != null ||
        toTime != null ||
        minimumAmount != null ||
        maximumAmount != null ||
        status != null;
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _FilterButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          48,
        ),
        foregroundColor: const Color(0xFF1A2A6C),
        side: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}