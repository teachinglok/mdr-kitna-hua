import 'package:flutter/material.dart';

class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            8,
          ),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: _buildChildrenWithDividers(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> items = [];

    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);

      if (i < children.length - 1) {
        items.add(
          const Divider(
            height: 1,
            thickness: 1,
            indent: 76,
            endIndent: 16,
            color: Color(0xFFE2E8F0),
          ),
        );
      }
    }

    return items;
  }
}