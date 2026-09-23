import 'package:flutter/material.dart';

import '../widgets/profile_avatar.dart';

class EditProfilePage extends StatefulWidget {
  final String shopName;
  final String email;
  final String? avatarUrl;

  const EditProfilePage({
    super.key,
    required this.shopName,
    required this.email,
    this.avatarUrl,
  });

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {
  late final TextEditingController _shopNameController;

  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _shopNameController = TextEditingController(
      text: widget.shopName,
    );
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String updatedShopName =
    _shopNameController.text.trim();

    Navigator.of(context).pop(updatedShopName);
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
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              24,
              20,
              32,
            ),
            child: Column(
              children: [
                ProfileAvatar(
                  shopName: _shopNameController.text,
                  avatarUrl: widget.avatarUrl,
                  size: 96,
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Profile photo upload will be available soon.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                  label: const Text(
                    'CHANGE PHOTO',
                  ),
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SHOP / BUSINESS NAME',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _shopNameController,
                  textCapitalization:
                  TextCapitalization.words,
                  maxLength: 120,
                  decoration: InputDecoration(
                    hintText:
                    'Enter shop or business name',
                    prefixIcon: const Icon(
                      Icons.storefront_outlined,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1A2A6C),
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final String name =
                        value?.trim() ?? '';

                    if (name.isEmpty) {
                      return 'Shop / Business Name is required';
                    }

                    if (name.length < 2) {
                      return 'Enter at least 2 characters';
                    }

                    return null;
                  },
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EMAIL ADDRESS',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: widget.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      size: 19,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email changes will be handled through account settings.',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF1A2A6C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}