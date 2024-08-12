class ValorantMap {
  final String displayName;
  final String splash;
  final String coordinates;
  final String displayIcon;
  final String regionName;
  final String stylizedBackgroundImage;

  ValorantMap({
    required this.displayName,
    required this.splash,
    required this.coordinates,
    required this.displayIcon,
    required this.regionName,
    required this.stylizedBackgroundImage,
  });

  factory ValorantMap.fromJson(Map<String, dynamic> json) {
    return ValorantMap(
      displayName: json['displayName'] ?? '',
      splash: json['splash'] ?? '',
      coordinates: json['coordinates'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      regionName: json['regionName'] ?? 'Unknown Region',
      stylizedBackgroundImage: json['stylizedBackgroundImage'] ?? '',
    );
  }
}
