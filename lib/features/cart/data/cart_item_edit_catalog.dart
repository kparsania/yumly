/// Rich display + edit metadata for cart lines.
///
/// Add entries to [kItemEditByFoodName] keyed by exact dish name ([CartItem.foodName]).
/// Unknown dishes use [defaultItemEditProfile] plus optional stored detail text.
class ItemEditProfile {
  const ItemEditProfile({
    required this.description,
    this.isVeg = true,
    this.isSpicy = false,
    this.cookingQuickTags = const [],
    this.highlyReordered = false,
    this.heroImageUrl,
  });

  /// Shown under the title (ingredients / what’s included).
  final String description;
  final bool isVeg;
  final bool isSpicy;
  final List<String> cookingQuickTags;
  final bool highlyReordered;
  final String? heroImageUrl;
}

/// Default chips for items that don’t define their own list.
const List<String> kDefaultCookingQuickTags = [
  'No Coriander',
  'No onion',
  'No garlic',
  'Extra spicy',
  'Less oil',
  'No sugar',
];

const ItemEditProfile defaultItemEditProfile = ItemEditProfile(
  description:
      'Chef’s special preparation. Customize with a cooking request below.',
  isVeg: true,
  isSpicy: false,
  cookingQuickTags: kDefaultCookingQuickTags,
  highlyReordered: false,
);

/// Key = exact dish name. Extend this map as you add menu items.
final Map<String, ItemEditProfile> kItemEditByFoodName = {
  'Punjabi Fix Lunch': ItemEditProfile(
    description:
        '1 Paneer Prep, 1 Veg Preparation, Dal Fry, Jeera Rice, Butter Roti-3, Papad, Butter Milk, Sweet',
    isVeg: true,
    isSpicy: true,
    cookingQuickTags: [
      'No Coriander',
      'No onion',
      'No garlic',
      'Extra spicy',
      'Less oil',
      'Pack cutlery',
    ],
    highlyReordered: true,
  ),
  'Masala Chaas': ItemEditProfile(
    description: 'Chilled spiced buttermilk — refreshing side.',
    isVeg: true,
    isSpicy: false,
    cookingQuickTags: kDefaultCookingQuickTags,
  ),
  'Peri Peri Fries': ItemEditProfile(
    description: 'Crispy fries tossed in peri-peri spice.',
    isVeg: true,
    isSpicy: true,
    cookingQuickTags: kDefaultCookingQuickTags,
  ),
  'Gulab Jamun (2)': ItemEditProfile(
    description: 'Soft milk dumplings in rose syrup (2 pcs).',
    isVeg: true,
    isSpicy: false,
    cookingQuickTags: ['Extra syrup', 'Warm', 'Packed separately'],
  ),
  'Gulab Jamun': ItemEditProfile(
    description: 'Soft milk dumplings in rose syrup (2 pcs).',
    isVeg: true,
    isSpicy: false,
    cookingQuickTags: ['Extra syrup', 'Warm', 'Packed separately'],
  ),
  'Cold Coffee': ItemEditProfile(
    description: 'Chilled coffee with milk — sweetened to taste.',
    isVeg: true,
    isSpicy: false,
    cookingQuickTags: kDefaultCookingQuickTags,
  ),
};

ItemEditProfile resolveItemEditProfile({
  required String foodName,
  required String detailDescription,
}) {
  final base = kItemEditByFoodName[foodName] ?? defaultItemEditProfile;
  final tags = base.cookingQuickTags.isNotEmpty
      ? base.cookingQuickTags
      : kDefaultCookingQuickTags;
  final desc = detailDescription.isNotEmpty
      ? detailDescription
      : base.description;
  return ItemEditProfile(
    description: desc,
    isVeg: base.isVeg,
    isSpicy: base.isSpicy,
    cookingQuickTags: tags,
    highlyReordered: base.highlyReordered,
    heroImageUrl: base.heroImageUrl,
  );
}
