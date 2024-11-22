import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle.dart';
import '../models/fuel_record.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Adicionar um novo veículo
  Future<void> addVehicle(Map<String, dynamic> vehicleData) async {
    await _firestore.collection('vehicles').add(vehicleData);
  }

  // Obter a lista de veículos como um Stream de lista de objetos Vehicle
  Stream<List<Vehicle>> getVehicles() {
    return _firestore.collection('vehicles').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vehicle.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Atualizar um veículo
  Future<void> updateVehicle(String id, Map<String, dynamic> updatedData) async {
    await _firestore.collection('vehicles').doc(id).update(updatedData);
  }

  // Excluir um veículo
  Future<void> deleteVehicle(String id) async {
    await _firestore.collection('vehicles').doc(id).delete();
  }

  // Adicionar um novo registro de abastecimento
  Future<void> addFuelRecord(String vehicleId, Map<String, dynamic> fuelData) async {
    await _firestore.collection('vehicles/$vehicleId/fuel_records').add(fuelData);
  }

  // Obter o histórico de abastecimento de um veículo como um Stream de lista de objetos FuelRecord
  Stream<List<FuelRecord>> getFuelHistory(String vehicleId) {
    return _firestore.collection('vehicles/$vehicleId/fuel_records').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FuelRecord.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
