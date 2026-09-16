import 'package:flutter/material.dart';
import '../models/address_model.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key, this.address, this.initialFullName = ''});

  final AddressModel? address;
  final String initialFullName;

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  late final TextEditingController _label;
  late final TextEditingController _fullName;
  late final TextEditingController _phone;
  late final TextEditingController _line1;
  late final TextEditingController _line2;
  late final TextEditingController _city;
  late final TextEditingController _postcode;
  late final TextEditingController _state;
  late final TextEditingController _country;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _label = TextEditingController(text: address?.label ?? '');
    _fullName = TextEditingController(
      text: address?.fullName ?? widget.initialFullName,
    );
    _phone = TextEditingController(text: address?.phoneNumber ?? '');
    _line1 = TextEditingController(text: address?.addressLine1 ?? '');
    _line2 = TextEditingController(text: address?.addressLine2 ?? '');
    _city = TextEditingController(text: address?.city ?? '');
    _postcode = TextEditingController(text: address?.postcode ?? '');
    _state = TextEditingController(text: address?.state ?? '');
    _country = TextEditingController(text: address?.country ?? '');
    _isDefault = address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _label.dispose();
    _fullName.dispose();
    _phone.dispose();
    _line1.dispose();
    _line2.dispose();
    _city.dispose();
    _postcode.dispose();
    _state.dispose();
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: Text(
          widget.address == null ? 'Add Address' : 'Edit Address',
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          AddressInput(
            controller: _label,
            label: 'Label',
            hint: 'e.g. Home, Office',
          ),
          AddressInput(
            controller: _fullName,
            label: 'Full Name',
            hint: 'Sarah Johnson',
          ),
          AddressInput(
            controller: _phone,
            label: 'Phone Number',
            hint: '+60 12-345 6789',
          ),
          AddressInput(
            controller: _line1,
            label: 'Address Line 1',
            hint: 'House / Block / Unit No.',
          ),
          AddressInput(
            controller: _line2,
            label: 'Address Line 2',
            hint: 'Street Name',
          ),
          AddressInput(
            controller: _city,
            label: 'City / Town',
            hint: 'Petaling Jaya',
          ),
          AddressInput(controller: _postcode, label: 'Postcode', hint: '47300'),
          AddressInput(controller: _state, label: 'State', hint: 'Selangor'),
          AddressInput(
            controller: _country,
            label: 'Country',
            hint: 'Cambodia',
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _isDefault,
            onChanged: (value) => setState(() => _isDefault = value ?? false),
            title: const Text('Set as default address'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: const Color(0xFFFF6338),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 56,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFF6338),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.address == null ? 'Save Address' : 'Save Changes',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 4,
        onTap: _ignoreNavigation,
      ),
    );
  }

  static void _ignoreNavigation(int index) {}

  void _save() {
    final values = <String, String>{
      'label': _label.text.trim(),
      'fullName': _fullName.text.trim(),
      'phoneNumber': _phone.text.trim(),
      'addressLine1': _line1.text.trim(),
      'addressLine2': _line2.text.trim(),
      'city': _city.text.trim(),
      'postcode': _postcode.text.trim(),
      'state': _state.text.trim(),
      'country': _country.text.trim(),
      'isDefault': '$_isDefault',
    };
    if (values['label']!.isEmpty ||
        values['fullName']!.isEmpty ||
        values['addressLine1']!.isEmpty ||
        values['city']!.isEmpty ||
        values['postcode']!.isEmpty ||
        values['state']!.isEmpty ||
        values['country']!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }
    Navigator.pop(context, values);
  }
}

class AddressInput extends StatelessWidget {
  const AddressInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 64,
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 16, color: Color(0xFF172033)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF97939C)),
                filled: true,
                fillColor: const Color(0xFFF3EEEB),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF6338),
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.onSetDefault,
    required this.onEdit,
    required this.onDelete,
  });

  final AddressModel address;
  final VoidCallback onSetDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: address.isDefault
              ? const Color(0xFFFF6338)
              : const Color(0xFFE8E5E3),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                address.label == 'Home'
                    ? Icons.home_outlined
                    : Icons.business_outlined,
                size: 16,
                color: const Color(0xFFFF6338),
              ),
              const SizedBox(width: 5),
              Text(
                address.label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 8),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFEEE8),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        color: Color(0xFFFF6338),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
              const Spacer(),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert, size: 18),
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            address.fullName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            address.formattedAddress,
            style: const TextStyle(
              color: Color(0xFF858A99),
              fontSize: 13,
              height: 1.3,
            ),
          ),
          if (!address.isDefault) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: onSetDefault,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: const Color(0xFFFF6338),
              ),
              child: const Text('Set as Default'),
            ),
          ],
        ],
      ),
    );
  }
}
