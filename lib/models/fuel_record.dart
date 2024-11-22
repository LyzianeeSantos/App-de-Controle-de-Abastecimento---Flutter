import 'package:cloud_firestore/cloud_firestore.dart'; // Importando Timestamp

class FuelRecord {
  final String id;
  final double liters;
  final double mileage;
  final DateTime date;

  FuelRecord({
    required this.id,
    required this.liters,
    required this.mileage,
    required this.date,
  });

  // Constrói um objeto FuelRecord a partir dos dados do Firestore
  factory FuelRecord.fromFirestore(Map<String, dynamic> data, String documentId) {
    return FuelRecord(
      id: documentId,
      liters: data['liters']?.toDouble() ?? 0.0,
      mileage: data['mileage']?.toDouble() ?? 0.0,
      date: (data['date'] as Timestamp).toDate(),  // Corrigido para Timestamp
    );
  }

  // Converte um FuelRecord em um mapa de dados para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'liters': liters,
      'mileage': mileage,
      'date': date,
    };
  }
}
