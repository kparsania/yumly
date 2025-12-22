class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final String description;
  final String address;
  final List<RestaurantReview> restaurantReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.address,
    required this.restaurantReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      restaurantReviews: (json['restaurant_reviews'] as List<dynamic>? ?? [])
          .map((e) => RestaurantReview.fromJson(e))
          .toList(),
    );
  }

  /// Calculate average rating directly from the model
  double get averageRating {
    if (restaurantReviews.isEmpty) return 0;
    final total = restaurantReviews.fold<int>(0, (sum, r) => sum + r.rating);
    return total / restaurantReviews.length;
  }
}

class RestaurantReview {
  final int id;
  final int rating;
  final String content;
  final int restaurantId;
  final int userId;

  RestaurantReview({
    required this.id,
    required this.rating,
    required this.content,
    required this.restaurantId,
    required this.userId,
  });

  factory RestaurantReview.fromJson(Map<String, dynamic> json) {
    return RestaurantReview(
      id: json['id'],
      rating: json['rating'],
      content: json['content'] ?? '',
      restaurantId: json['restaurant_id'],
      userId: json['user_id'],
    );
  }
}
