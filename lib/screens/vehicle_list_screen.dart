// lib/screens/vehicle_list_screen.dart
import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../widgets/vehicle_card.dart';
import '../services/firestore_service.dart';
import 'vehicle_detail_screen.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Veículos')),
      body: StreamBuilder<List<Vehicle>>(
        stream: FirestoreService().getVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar veículos'));
          }

          final vehicles = snapshot.data ?? [];
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return VehicleCard(
                vehicle: vehicle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleDetailScreen(
                        vehicleId: vehicle.id,
                        name: vehicle.name,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
