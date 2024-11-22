import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/drawer_widget.dart';

class FuelHistoryScreen extends StatelessWidget {
  const FuelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Abastecimentos')),
      drawer: const DrawerWidget(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collectionGroup('fuel_records').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final fuelRecords = snapshot.data!.docs;
          return ListView.builder(
            itemCount: fuelRecords.length,
            itemBuilder: (context, index) {
              final record = fuelRecords[index];
              return ListTile(
                title: Text('Litros: ${record['liters']}'),
                subtitle: Text(
                  'Quilometragem: ${record['mileage']} - Data: ${record['date']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
