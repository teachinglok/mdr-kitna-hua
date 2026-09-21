import 'package:flutter/material.dart';

class CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onButtonPressed;
  final VoidCallback? onQrPressed;

  const CalculatorKeyboard({
    super.key,
    required this.onButtonPressed,
    this.onQrPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableHeight = constraints.maxHeight;
        final double availableWidth = constraints.maxWidth;

        final double horizontalPadding =
        availableWidth < 360 ? 8 : 12;

        final double verticalPadding =
        availableHeight < 500 ? 6 : 10;

        final double rowSpacing =
        availableHeight < 500 ? 5 : 8;

        final double usableHeight =
            availableHeight -
                (verticalPadding * 2) -
                (rowSpacing * 7);

        final double rowHeight =
        (usableHeight / 8).clamp(38.0, 72.0);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            children: [
              _buildStandardRow(
                context,
                ['AC', '(', ')'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildStandardRow(
                context,
                ['7', '8', '9'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildStandardRow(
                context,
                ['4', '5', '6'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildStandardRow(
                context,
                ['1', '2', '3'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildStandardRow(
                context,
                ['0', '.', '⌫'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildStandardRow(
                context,
                ['×', '÷', '%'],
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildMinusPlusRow(
                context,
                rowHeight,
              ),

              SizedBox(height: rowSpacing),

              _buildBottomRow(
                context,
                rowHeight,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStandardRow(
      BuildContext context,
      List<String> buttons,
      double height,
      ) {
    return SizedBox(
      height: height,
      child: Row(
        children: buttons.map((label) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: _buildButton(
                context,
                label,
                height,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMinusPlusRow(
      BuildContext context,
      double height,
      ) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: _buildButton(
                context,
                '−',
                height,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: _buildButton(
                context,
                '+',
                height,
                isPrimary: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow(
      BuildContext context,
      double height,
      ) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: _buildQrButton(
                context,
                height,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: _buildCalculateButton(
                context,
                height,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrButton(
      BuildContext context,
      double height,
      ) {
    return Material(
      color: const Color(0xFF38BDF8),
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: const Color(0xFF38BDF8).withValues(
        alpha: 0.30,
      ),
      child: InkWell(
        onTap: onQrPressed ?? () {},
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: height,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: height < 48 ? 22 : 28,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'QR SCANNER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height < 48 ? 10 : 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton(
      BuildContext context,
      double height,
      ) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () => onButtonPressed('='),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'CALCULATE',
            style: TextStyle(
              fontSize: height < 48 ? 18 : 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String label,
      double height, {
        bool isPrimary = false,
      }) {
    if (label == 'AC') {
      return SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: () => onButtonPressed('CLEAR'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.zero,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'AC',
              style: TextStyle(
                fontSize: height < 48 ? 16 : 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () => onButtonPressed(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? const Color(0xFF1A2A6C)
              : Theme.of(context).colorScheme.surface,
          foregroundColor: isPrimary
              ? Colors.white
              : Theme.of(context).colorScheme.onSurface,
          elevation: isPrimary ? 2 : 0,
          side: isPrimary
              ? null
              : BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              fontSize: height < 48 ? 20 : 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}