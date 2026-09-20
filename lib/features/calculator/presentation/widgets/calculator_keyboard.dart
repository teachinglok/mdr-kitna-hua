import 'package:flutter/material.dart';

import 'calculator_button.dart';

class CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onButtonPressed;

  const CalculatorKeyboard({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableHeight = constraints.maxHeight;

        // Adapt the keyboard to the available screen height.
        final bool isSmallHeight = availableHeight < 520;
        final bool isVerySmallHeight = availableHeight < 450;

        final double normalButtonHeight = isVerySmallHeight
            ? 42
            : isSmallHeight
            ? 50
            : 60;

        final double largeButtonHeight = isVerySmallHeight
            ? 50
            : isSmallHeight
            ? 58
            : 72;

        final double rowSpacing = isVerySmallHeight
            ? 5
            : isSmallHeight
            ? 7
            : 10;

        final double horizontalPadding = isVerySmallHeight ? 8 : 16;

        return Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Column(
            children: [
              _buildClearButton(
                height: normalButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildRow(
                ['7', '8', '9'],
                height: normalButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildRow(
                ['4', '5', '6'],
                height: normalButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildRow(
                ['1', '2', '3'],
                height: normalButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildRow(
                ['0', '.', '⌫'],
                height: normalButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildPlusMinusRow(
                height: largeButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildRow(
                ['×', '÷', '%'],
                height: largeButtonHeight,
                bottomSpacing: rowSpacing,
              ),

              _buildEqualsButton(height: largeButtonHeight),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClearButton({
    required double height,
    required double bottomSpacing,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: SizedBox(
        width: double.infinity,
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
          ),
          child: Text(
            'CLEAR',
            style: TextStyle(
              fontSize: height < 50 ? 15 : 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlusMinusRow({
    required double height,
    required double bottomSpacing,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CalculatorButton(
                  label: '+',
                  onPressed: () => onButtonPressed('+'),
                  isPrimary: true,
                  isLarge: true,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CalculatorButton(
                  label: '−',
                  onPressed: () => onButtonPressed('−'),
                  isLarge: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEqualsButton({required double height}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: CalculatorButton(
          label: '=',
          onPressed: () => onButtonPressed('='),
          isSuccess: true,
          isLarge: true,
        ),
      ),
    );
  }

  Widget _buildRow(
    List<String> buttons, {
    required double height,
    required double bottomSpacing,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: SizedBox(
        height: height,
        child: Row(
          children: buttons.map((label) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CalculatorButton(
                  label: label,
                  onPressed: () => onButtonPressed(label),
                  isLarge: label == '×' || label == '÷' || label == '%',
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
