// lib/models/vehicle.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String name;
  final String model;
  final int year;
  final String plate;

  Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
  });

  // Constrói um objeto Vehicle a partir dos dados do Firestore
  factory Vehicle.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Vehicle(
      id: documentId,
      name: data['name'] ?? '',
      model: data['model'] ?? '',
      year: data['year'] ?? 0,
      plate: data['plate'] ?? '',
    );
  }

  // Converte um Vehicle em um mapa de dados para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'year': year,
      'plate': plate,
    };
  }
}
