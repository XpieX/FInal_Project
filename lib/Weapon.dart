class Weapon {
  final String displayName;
  final String displayIcon;
  final String category; // Category of the weapon
  final Map<String, dynamic> shopData; // Shop data related to the weapon
  final Map<String, dynamic> weaponStats; // Weapon stats

  Weapon({
    required this.displayName,
    required this.displayIcon,
    required this.category,
    required this.shopData,
    required this.weaponStats,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      displayName: json['displayName'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      category: json['category'] ?? '',
      shopData: json['shopData'] ?? {},
      weaponStats: json['weaponStats'] ?? {},
    );
  }
}
