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
      appBar: AppBar(
        title: Text('Detalhes de $name'),
        automaticallyImplyLeading: true, // Garante o botão de navegação
      ),
      body: StreamBuilder<List<FuelRecord>>(
        stream: FirestoreService().getFuelHistory(vehicleId),
        builder: (context, snapshot) {
          // Estado de carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Erro ao carregar dados
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro ao carregar histórico. Tente novamente mais tarde.',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          // Lista de registros
          final fuelRecords = snapshot.data ?? [];

          // Caso não haja registros
          if (fuelRecords.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum registro de abastecimento encontrado.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // Exibição dos registros em uma lista
          return ListView.builder(
            itemCount: fuelRecords.length,
            itemBuilder: (context, index) {
              final record = fuelRecords[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.local_gas_station, color: Colors.blue),
                  title: Text('Data: ${record.date}'),
                  subtitle: Text(
                    'Litros: ${record.liters}\nQuilometragem: ${record.mileage}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
