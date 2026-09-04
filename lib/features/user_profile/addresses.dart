import 'package:flutter/material.dart';
import 'data/address_data.dart';
import 'models/address_model.dart';
import 'widgets/address_widgets.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key, this.initialFullName = ''});

  final String initialFullName;

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final _repository = AddressRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text(
          'My Addresses',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _addAddress,
            icon: const Icon(Icons.add),
            tooltip: 'Add address',
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFFF6338),
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: StreamBuilder<List<AddressModel>>(
        stream: _repository.watchAddresses(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Unable to load addresses.\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              for (final address in snapshot.data!) ...[
                AddressCard(
                  address: address,
                  onSetDefault: () => _setDefault(address),
                  onEdit: () => _editAddress(address),
                  onDelete: () => _deleteAddress(address),
                ),
                const SizedBox(height: 12),
              ],
              OutlinedButton.icon(
                onPressed: _addAddress,
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  foregroundColor: const Color(0xFFFF6338),
                  side: const BorderSide(color: Color(0xFFFF6338)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _setDefault(AddressModel address) async {
    await _runRequest(() => _repository.setDefault(address));
  }

  Future<void> _addAddress() async {
    final values = await _showAddressForm();
    if (values == null) return;
    await _runRequest(
      () => _repository.addAddress(
        label: values['label']!,
        fullName: values['fullName']!,
        phoneNumber: values['phoneNumber']!,
        addressLine1: values['addressLine1']!,
        addressLine2: values['addressLine2']!,
        city: values['city']!,
        postcode: values['postcode']!,
        state: values['state']!,
        country: values['country']!,
        isDefault: values['isDefault'] == 'true',
      ),
    );
  }

  Future<void> _editAddress(AddressModel address) async {
    final values = await _showAddressForm(address: address);
    if (values == null) return;
    await _runRequest(
      () => _repository.updateAddress(
        address: address,
        label: values['label']!,
        fullName: values['fullName']!,
        phoneNumber: values['phoneNumber']!,
        addressLine1: values['addressLine1']!,
        addressLine2: values['addressLine2']!,
        city: values['city']!,
        postcode: values['postcode']!,
        state: values['state']!,
        country: values['country']!,
      ),
    );
  }

  Future<void> _deleteAddress(AddressModel address) async {
    await _runRequest(() => _repository.deleteAddress(address));
  }

  Future<Map<String, String>?> _showAddressForm({AddressModel? address}) {
    return Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (_) => AddressFormScreen(
          address: address,
          initialFullName: widget.initialFullName,
        ),
      ),
    );
  }

  Future<void> _runRequest(Future<void> Function() request) async {
    try {
      await request();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
