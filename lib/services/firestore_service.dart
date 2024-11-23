import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/vehicle.dart';
import '../models/fuel_record.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obter o usuário autenticado
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  // Adicionar um novo veículo
  Future<void> addVehicle(Map<String, dynamic> vehicleData) async {
    try {
      // Inclui o ID do usuário autenticado nos dados do veículo
      final userId = currentUserId;
      if (userId == null) throw Exception('Usuário não autenticado.');

      vehicleData['userId'] = userId; // Adiciona a referência ao usuário
      await _firestore.collection('vehicles').add(vehicleData);
    } catch (e) {
      throw Exception('Erro ao adicionar veículo: $e');
    }
  }

// Obter a lista de veículos do usuário autenticado como um Stream
Stream<List<Vehicle>> getVehicles() {
  final userId = currentUserId; // Obtém o ID do usuário autenticado
  if (userId == null) {
    throw Exception('Usuário não autenticado.');
  }

  return _firestore
      .collection('vehicles')
      .where('userId', isEqualTo: userId) // Filtra os veículos do usuário
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return Vehicle.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  });
}

  // Atualizar um veículo
  Future<void> updateVehicle(String id, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('vehicles').doc(id).update(updatedData);
    } catch (e) {
      throw Exception('Erro ao atualizar veículo: $e');
    }
  }

  // Excluir um veículo
  Future<void> deleteVehicle(String id) async {
    try {
      await _firestore.collection('vehicles').doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao excluir veículo: $e');
    }
  }

  // Adicionar um novo registro de abastecimento
  Future<void> addFuelRecord(String vehicleId, Map<String, dynamic> fuelData) async {
    try {
      await _firestore.collection('vehicles/$vehicleId/fuel_records').add(fuelData);
    } catch (e) {
      throw Exception('Erro ao adicionar registro de abastecimento: $e');
    }
  }

  // Obter o histórico de abastecimento de um veículo
  Stream<List<FuelRecord>> getFuelHistory(String vehicleId) {
    try {
      return _firestore
          .collection('vehicles/$vehicleId/fuel_records')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          try {
            return FuelRecord.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
          } catch (e) {
            throw Exception('Erro ao converter registro de abastecimento: $e');
          }
        }).toList();
      });
    } catch (e) {
      throw Exception('Erro ao obter histórico de abastecimento: $e');
    }
  }

  // Obter um veículo específico por ID
  Future<Vehicle?> getVehicleById(String id) async {
    try {
      final doc = await _firestore.collection('vehicles').doc(id).get();
      if (doc.exists) {
        return Vehicle.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao obter veículo: $e');
    }
  }
}
