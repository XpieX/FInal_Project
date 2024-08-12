import 'package:final_project/Map_list.dart';
import 'package:final_project/Weapon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Agent_list.dart'; // Mengimpor AgentList

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Menyimpan indeks item yang dipilih pada navbar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          // Navigasi ke halaman Home
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
      backgroundColor:
          const Color(0xFF292929), // Background color untuk keseluruhan halaman
      appBar: AppBar(
        title: const Text(
          'ValBase.',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color(0xFFFF4655),
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 16), // Tambahkan jarak dari atas
              Image.asset(
                'images/icons8-valorant-144(-hdpi).png',
                height: 100, // Atur tinggi gambar sesuai kebutuhan
              ),
              const SizedBox(
                height: 16, // Jarak antara gambar dan teks
              ),
              const Text(
                'Selamat datang di aplikasi ValBase yang bebasis API',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Warna background navbar
        selectedItemColor: Colors.white, // Warna item terpilih
        unselectedItemColor: Colors.grey, // Warna item tidak terpilih
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Agents',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Weapons',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
            backgroundColor: Color(0xFFFF4655), // Warna untuk item ini
          ),
        ],
      ),
    );
  }
}
