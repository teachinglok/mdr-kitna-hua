import 'package:flutter/material.dart';

class CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onButtonPressed;
  final VoidCallback? onQrPressed;
  final VoidCallback? onHomePressed;
  final VoidCallback? onHistoryPressed;

  const CalculatorKeyboard({
    super.key,
    required this.onButtonPressed,
    this.onQrPressed,
    this.onHomePressed,
    this.onHistoryPressed,
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
        availableHeight < 600 ? 6 : 10;
        final double spacing =
        availableHeight < 600 ? 5 : 8;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPadding,
            horizontalPadding,
            0,
          ),
          child: Column(
            children: [
              Expanded(
                child: _buildKeypad(
                  context,
                  spacing,
                ),
              ),
              SizedBox(height: spacing),
              _buildBottomNavigation(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeypad(
      BuildContext context,
      double spacing,
      ) {
    return Column(
      children: [
        // ROW 1
        Expanded(
          child: Row(
            children: [
              _buildOperatorCell(
                context,
                'AC',
                isAc: true,
              ),
              SizedBox(width: spacing),
              _buildOperatorCell(context, '÷'),
              SizedBox(width: spacing),
              _buildOperatorCell(context, '×'),
              SizedBox(width: spacing),
              _buildOperatorCell(context, '−'),
            ],
          ),
        ),

        SizedBox(height: spacing),

        // ROWS 2 + 3
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildNumberCell(context, '7'),
                    ),
                    SizedBox(height: spacing),
                    Expanded(
                      child: _buildNumberCell(context, '4'),
                    ),
                  ],
                ),
              ),

              SizedBox(width: spacing),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildNumberCell(context, '8'),
                    ),
                    SizedBox(height: spacing),
                    Expanded(
                      child: _buildNumberCell(context, '5'),
                    ),
                  ],
                ),
              ),

              SizedBox(width: spacing),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildNumberCell(context, '9'),
                    ),
                    SizedBox(height: spacing),
                    Expanded(
                      child: _buildNumberCell(context, '6'),
                    ),
                  ],
                ),
              ),

              SizedBox(width: spacing),

              Expanded(
                child: _buildPlusButton(context),
              ),
            ],
          ),
        ),

        SizedBox(height: spacing),

        // ROW 4
        Expanded(
          child: Row(
            children: [
              _buildNumberCell(context, '1'),
              SizedBox(width: spacing),
              _buildNumberCell(context, '2'),
              SizedBox(width: spacing),
              _buildNumberCell(context, '3'),
              SizedBox(width: spacing),
              _buildBackspaceCell(context),
            ],
          ),
        ),

        SizedBox(height: spacing),

        // ROW 5
        Expanded(
          child: Row(
            children: [
              _buildNumberCell(context, '0'),
              SizedBox(width: spacing),
              _buildNumberCell(context, '.'),
              SizedBox(width: spacing),
              Expanded(
                flex: 2,
                child: _buildCalculateButton(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberCell(
      BuildContext context,
      String label,
      ) {
    return Expanded(
      child: _buildButton(
        context,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        onPressed: () => onButtonPressed(label),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorCell(
      BuildContext context,
      String label, {
        bool isAc = false,
      }) {
    return Expanded(
      child: _buildButton(
        context,
        backgroundColor: isAc
            ? const Color(0xFFEF4444)
            : const Color(0xFF1A2A6C),
        foregroundColor: isAc
            ? Colors.white
            : const Color(0xFFFFF8E7),
        onPressed: () => onButtonPressed(
          isAc ? 'CLEAR' : label,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isAc
                ? Colors.white
                : const Color(0xFFFFF8E7),
            fontSize: isAc ? 20 : 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildPlusButton(
      BuildContext context,
      ) {
    return _buildButton(
      context,
      backgroundColor: const Color(0xFF1A2A6C),
      foregroundColor: const Color(0xFFFFF8E7),
      onPressed: () => onButtonPressed('+'),
      child: const Text(
        '+',
        style: TextStyle(
          color: Color(0xFFFFF8E7),
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildBackspaceCell(
      BuildContext context,
      ) {
    return Expanded(
      child: _buildButton(
        context,
        backgroundColor: const Color(0xFF1A2A6C),
        foregroundColor: Colors.white,
        onPressed: () => onButtonPressed('⌫'),
        child: const Icon(
          Icons.backspace_outlined,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildCalculateButton(
      BuildContext context,
      ) {
    return _buildButton(
      context,
      backgroundColor: const Color(0xFF10B981),
      foregroundColor: Colors.white,
      onPressed: () => onButtonPressed('='),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'CALCULATE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required Color backgroundColor,
        required Color foregroundColor,
        required VoidCallback onPressed,
        required Widget child,
      }) {
    return SizedBox.expand(
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withValues(
          alpha: 0.10,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(
      BuildContext context,
      ) {
    return SizedBox(
      height: 82,
      child: Row(
        children: [
          Expanded(
            child: _buildNavigationItem(
              icon: Icons.home_rounded,
              label: 'Home',
              isSelected: true,
              onPressed: onHomePressed,
            ),
          ),

          Expanded(
            child: _buildQrNavigationItem(context),
          ),

          Expanded(
            child: _buildNavigationItem(
              icon: Icons.history_outlined,
              label: 'HISTORY',
              isSelected: false,
              onPressed: onHistoryPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback? onPressed,
  }) {
    final Color color = isSelected
        ? const Color(0xFF1A2A6C)
        : const Color(0xFF64748B);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: color,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrNavigationItem(
      BuildContext context,
      ) {
    return InkWell(
      onTap: onQrPressed,
      borderRadius: BorderRadius.circular(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFF1A2A6C),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.qr_code_2_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'QR SCANNER',
            style: TextStyle(
              color: Color(0xFF1A2A6C),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}