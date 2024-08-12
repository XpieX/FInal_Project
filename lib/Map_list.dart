import 'package:final_project/Agent_list.dart';
import 'package:final_project/Homepage.dart';
import 'package:final_project/Weapon_list.dart';
import 'package:flutter/material.dart';
import 'Map.dart'; // Pastikan nama file dan nama kelas konsisten
import 'Map_detail.dart'; // Periksa apakah nama file dan kelas sesuai
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapList extends StatefulWidget {
  final int selectedIndex;

  MapList({this.selectedIndex = 3}); // Ubah dari AgentList menjadi MapList

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  late Future<List<ValorantMap>> futureMaps;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    futureMaps = fetchMaps();
    _selectedIndex = widget.selectedIndex;
  }

  Future<List<ValorantMap>> fetchMaps() async {
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/maps'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((mapData) => ValorantMap.fromJson(mapData)).toList();
    } else {
      throw Exception('Failed to load maps');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()), // Arahkan ke halaman homepage
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgentList()), // Arahkan ke daftar agen
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WeaponList()), // Arahkan ke daftar senjata
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapList()), // Arahkan ke daftar peta
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      appBar: AppBar(
        title: Text(
          'Valorant Maps',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color(0xFFFF4655),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<ValorantMap>>(
        future: futureMaps,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom dalam grid
                childAspectRatio: 1.0, // Proporsi lebar:tinggi setiap item
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final map = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapDetail(map: map),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[800],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (map.splash.isNotEmpty)
                          Expanded(
                            child: Image.network(
                              map.splash,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            map.displayName,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load maps',
                  style: TextStyle(color: Colors.white)),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Warna background navbar
        selectedItemColor: Colors.white, // Warna item terpilih
        unselectedItemColor: Colors.grey, // Warna item tidak terpilih
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Agents',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Weapons',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
        ],
      ),
    );
  }
}
