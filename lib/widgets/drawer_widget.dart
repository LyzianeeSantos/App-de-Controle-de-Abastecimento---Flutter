import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/fuel_history_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/screens/vehicle_list_screen.dart';
import 'package:flutter_application_1/screens/add_vehicle_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_car, size: 50, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? 'Usuário',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VehicleListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('Meus Veículos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VehicleListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Adicionar Veículo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histórico de Abastecimentos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FuelHistoryScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
