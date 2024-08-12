class Agent {
  final String uuid;
  final String displayName;
  final String description;
  final String fullPortrait;
  final String role;
  final String displayIconSmall;
  final String roleIcon; // Tambahkan properti roleIcon
  final List<Ability> abilities;

  Agent({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.fullPortrait,
    required this.role,
    required this.displayIconSmall,
    required this.roleIcon, // Inisialisasi roleIcon
    required this.abilities,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      uuid: json['uuid'],
      displayName: json['displayName'],
      description: json['description'],
      displayIconSmall: json['displayIconSmall'],
      fullPortrait: json['fullPortrait'] ?? '',
      role: json['role'] != null ? json['role']['displayName'] : 'Unknown',
      roleIcon: json['role'] != null
          ? json['role']['displayIcon']
          : '', // Ambil roleIcon jika ada
      abilities: (json['abilities'] as List)
          .map((abilityJson) => Ability.fromJson(abilityJson))
          .toList(),
    );
  }
}

class Ability {
  final String displayName;
  final String description;
  final String displayIcon;

  Ability({
    required this.displayName,
    required this.description,
    required this.displayIcon,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      displayName: json['displayName'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      displayIcon: json['displayIcon'] ?? '',
    );
  }
}
