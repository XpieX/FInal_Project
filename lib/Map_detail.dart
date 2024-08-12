import 'package:flutter/material.dart';
import 'Map.dart';

class MapDetail extends StatelessWidget {
  final ValorantMap map;

  MapDetail({required this.map});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4655), // Warna background AppBar
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          // Full background image
          if (map.stylizedBackgroundImage.isNotEmpty)
            Positioned.fill(
              child: Image.network(
                map.stylizedBackgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          // Content on top of the background
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (map.displayIcon.isNotEmpty)
                  Text(
                    map.displayName,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.network(
                    map.displayIcon,
                    width: 729, // Adjust the size of the displayIcon
                    height: 729,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
