import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedAddress {
  const SavedAddress({
    required this.id,
    required this.label,
    required this.line,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String line;
  final bool isDefault;

  SavedAddress copyWith({
    String? id,
    String? label,
    String? line,
    bool? isDefault,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      label: label ?? this.label,
      line: line ?? this.line,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

const _sampleLine = 'Gates Square, Satayana Rd, D Ground';

class CheckoutAddressNotifier extends StateNotifier<List<SavedAddress>> {
  CheckoutAddressNotifier()
    : super([
        const SavedAddress(
          id: 'a1',
          label: 'Home',
          line: _sampleLine,
          isDefault: true,
        ),
        const SavedAddress(id: 'a2', label: 'office', line: _sampleLine),
        const SavedAddress(id: 'a3', label: 'Park', line: _sampleLine),
      ]);

  void add(SavedAddress a) {
    state = [...state, a];
  }

  void removeById(String id) {
    state = [...state.where((e) => e.id != id)];
  }

  void replace(String id, SavedAddress updated) {
    state = [
      for (final e in state)
        if (e.id == id) updated else e,
    ];
  }

  void setDefault(String id) {
    state = [for (final e in state) e.copyWith(isDefault: e.id == id)];
  }
}

final checkoutAddressListProvider =
    StateNotifierProvider<CheckoutAddressNotifier, List<SavedAddress>>(
      (ref) => CheckoutAddressNotifier(),
    );

final selectedCheckoutAddressIdProvider = StateProvider<String>((ref) => 'a1');
