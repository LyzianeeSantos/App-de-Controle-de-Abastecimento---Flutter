import 'package:flutter/material.dart';
import '../models/fuel_record.dart';
import '../services/firestore_service.dart';

class VehicleDetailScreen extends StatelessWidget {
  final String vehicleId;
  final String name;

  const VehicleDetailScreen({
    super.key,
    required this.vehicleId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes de $name')),
      body: StreamBuilder<List<FuelRecord>>(
        stream: FirestoreService().getFuelHistory(vehicleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar histórico'));
          }

          final fuelRecords = snapshot.data ?? [];
          return ListView.builder(
            itemCount: fuelRecords.length,
            itemBuilder: (context, index) {
              final record = fuelRecords[index];
              return ListTile(
                title: Text('Data: ${record.date}'),
                subtitle: Text('Litros: ${record.liters} - Quilometragem: ${record.mileage}'),
              );
            },
          );
        },
      ),
    );
  }
}
