// lib/utils/constants.dart

class Constants {
  // Coleções do Firestore
  static const String vehiclesCollection = 'vehicles';
  static const String fuelRecordsCollection = 'fuel_records';

  // Mensagens de erro
  static const String errorFetchingData = 'Erro ao carregar dados.';
  static const String errorAddingData = 'Erro ao adicionar dados.';

  // Mensagens de sucesso
  static const String vehicleAddedSuccess = 'Veículo adicionado com sucesso!';
  static const String fuelRecordAddedSuccess = 'Abastecimento registrado com sucesso!';

  // Formatação de datas
  static const String dateFormat = 'dd/MM/yyyy';
}
