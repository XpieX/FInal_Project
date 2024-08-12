// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Agent.dart';

class AgentDetail extends StatelessWidget {
  final Agent agent;

  AgentDetail({required this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF292929), // Background color untuk keseluruhan halaman
      appBar: AppBar(
        title: Text(
          agent.displayName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF4655), // Warna background AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Color(0xFF292929), // Warna background header
          ),
          // Konten Utama
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (agent.fullPortrait.isNotEmpty)
                    Image.network(agent.fullPortrait, fit: BoxFit.cover),
                  SizedBox(height: 16.0),
                  Text(
                    agent.displayName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Warna teks nama agen
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[800], // Warna latar belakang kotak deskripsi
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      agent.description,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white), // Warna teks deskripsi
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      if (agent.roleIcon.isNotEmpty)
                        Image.network(agent.roleIcon, width: 40, height: 40),
                      SizedBox(width: 8.0),
                      Text(
                        'Role: ${agent.role}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Warna teks role
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Abilities:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Warna teks abilities
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: agent.abilities.map((ability) {
                      return Card(
                        color: Colors
                            .grey[800], // Warna latar belakang kartu abilities
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: ability.displayIcon.isNotEmpty
                              ? Image.network(ability.displayIcon,
                                  width: 40, height: 40)
                              : Container(
                                  width: 40, height: 40, color: Colors.grey),
                          title: Text(
                            ability.displayName,
                            style: TextStyle(
                                color: Colors.white), // Warna teks nama ability
                          ),
                          subtitle: Text(
                            ability.description,
                            style: TextStyle(
                                color: Colors
                                    .white70), // Warna teks deskripsi ability
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          // Footer
        ],
      ),
    );
  }
}
