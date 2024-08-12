// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:final_project/Map_list.dart';
import 'package:flutter/material.dart';
import 'Weapon.dart';
import 'Homepage.dart';
import 'Agent_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeaponList extends StatefulWidget {
  final int selectedIndex;

  WeaponList({this.selectedIndex = 2});
  @override
  _WeaponListState createState() => _WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  late Future<List<Weapon>> futureWeapons;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    futureWeapons = fetchWeapons();
    _selectedIndex = widget.selectedIndex;
  }

  Future<List<Weapon>> fetchWeapons() async {
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/weapons'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      List<Weapon> weapons = [];

      for (var item in data) {
        weapons.add(Weapon.fromJson(item));
      }

      return weapons;
    } else {
      throw Exception('Failed to load weapons');
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
                builder: (context) => HomePage()), // Arahkan ke homepage
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
                builder: (context) => MapList()), // Arahkan ke daftar senjata
            // Navigasi ke halaman Maps
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          'Valorant Weapons',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color(0xFFFF4655),
        automaticallyImplyLeading: false, // Menghapus tombol kembali
      ),
      body: FutureBuilder<List<Weapon>>(
        future: futureWeapons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:
                    3 / 1, // Mengubah rasio agar gambar tidak terlalu panjang
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final weapon = snapshot.data![index];
                return Card(
                  color: Colors.grey[800],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 75, // Mengurangi tinggi gambar
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(weapon.displayIcon),
                            fit: BoxFit.contain, // Mengubah cara gambar di-fit
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          weapon.displayName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Failed to load weapons',
                    style: TextStyle(color: Colors.white)));
          }
          return const Center(child: CircularProgressIndicator());
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
