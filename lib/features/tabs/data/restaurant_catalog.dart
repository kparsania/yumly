import '../../../core/utils/Constants.dart';

/// Restaurants shown on the dashboard, without duplicate names.
List<Map<String, dynamic>> dashboardRestaurants() {
  final seen = <String>{};
  final items = <Map<String, dynamic>>[];
  for (final source in [topRatedRestaurants, restaurants]) {
    for (final raw in source) {
      final item = Map<String, dynamic>.from(raw as Map);
      final name = (item['restaurant'] ?? '').toString().trim();
      if (name.isEmpty || !seen.add(name)) continue;
      items.add(item);
    }
  }
  return items;
}

/// Restaurants whose name, category, or menu matches [query].
List<Map<String, dynamic>> restaurantsForQuery(
  String query, {
  List<Map<String, dynamic>>? source,
}) {
  final needle = query.trim().toLowerCase();
  final items = source ?? dashboardRestaurants();
  if (needle.isEmpty) return items;
  return items.where((item) => _blob(item).contains(needle)).toList();
}

/// Restaurants that belong to a dashboard category such as Pizza or Cakes.
List<Map<String, dynamic>> restaurantsForCategory(String title) {
  final needles = _categoryNeedles(title);
  return dashboardRestaurants().where((item) {
    final blob = _blob(item);
    return needles.any(blob.contains);
  }).toList();
}

List<String> _categoryNeedles(String title) {
  switch (title.toLowerCase()) {
    case 'burgers':
      return ['burger', 'fast food'];
    case 'fries':
      return ['fries', 'fast food', 'snack'];
    case 'cakes':
      return ['cake', 'dessert'];
    case 'icecream':
      return ['ice cream', 'dessert'];
    case 'noodles':
      return ['noodle', 'pasta', 'chinese'];
    case 'momos':
      return ['momo'];
    default:
      return [title.toLowerCase()];
  }
}

String _blob(Map<String, dynamic> item) {
  final buffer = StringBuffer()
    ..write(item['restaurant'])
    ..write(' ')
    ..write(item['categories'])
    ..write(' ')
    ..write(item['description'])
    ..write(' ')
    ..write(item['location'])
    ..write(' ')
    ..write(item['address']);
  final menu = item['menu'];
  if (menu is List) {
    for (final entry in menu) {
      if (entry is Map) buffer.write(' ${entry['name']}');
    }
  }
  return buffer.toString().toLowerCase();
}
