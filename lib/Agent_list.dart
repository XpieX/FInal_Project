// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:final_project/Homepage.dart';
import 'package:final_project/Map_list.dart';
import 'package:final_project/Weapon_list.dart';
import 'package:flutter/material.dart';
import 'Agent.dart';
import 'Agent_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgentList extends StatefulWidget {
  final int selectedIndex;

  AgentList({this.selectedIndex = 1}); // Default ke "Agents" index

  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  late Future<List<Agent>> futureAgents;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    futureAgents = fetchAgents();
    _selectedIndex = widget.selectedIndex; // Mengambil indeks dari HomePage
  }

  Future<List<Agent>> fetchAgents() async {
    final response =
        await http.get(Uri.parse('https://valorant-api.com/v1/agents'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      Set<String> uniqueUuids = Set<String>();
      List<Agent> agents = [];

      for (var item in data) {
        if (item['isPlayableCharacter'] == true &&
            !uniqueUuids.contains(item['uuid'])) {
          uniqueUuids.add(item['uuid']);
          agents.add(Agent.fromJson(item));
        }
      }

      return agents;
    } else {
      throw Exception('Failed to load agents');
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
                builder: (context) => HomePage()), // Arahkan ke daftar agen
          );
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
          'Valorant Agents',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color(0xFFFF4655),
        automaticallyImplyLeading: false, // Menghapus tombol kembali
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Agent>>(
              future: futureAgents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final agent = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgentDetail(agent: agent),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[800],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: agent.fullPortrait.isNotEmpty
                                    ? Image.network(agent.displayIconSmall,
                                        fit: BoxFit.cover)
                                    : Container(color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      agent.displayName,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      agent.role,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Failed to load agents',
                          style: TextStyle(color: Colors.white)));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
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
