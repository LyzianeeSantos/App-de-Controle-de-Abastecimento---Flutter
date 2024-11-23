import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../screens/edit_vehicle_screen.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;

  const VehicleCard({super.key, required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.car_repair, size: 40),
        title: Text(vehicle.name, style: const TextStyle(fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${vehicle.model}'),
            Text('Ano: ${vehicle.year}'),
            Text('Placa: ${vehicle.plate}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final updatedVehicle = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditVehicleScreen(vehicle: vehicle),
                  ),
                );

                // Exibe uma mensagem caso o veículo seja atualizado
                if (updatedVehicle != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veículo atualizado com sucesso!')),
                  );
                }
              },
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
