class Weapon {
  final String displayName;
  final String displayIcon;

  Weapon({
    required this.displayName,
    required this.displayIcon,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      displayName: json['displayName'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}
