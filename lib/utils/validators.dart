// lib/utils/validators.dart

class Validators {
  /// Valida se o email é válido
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email.';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, insira um email válido.';
    }
    return null;
  }

  /// Valida se a senha atende aos requisitos de tamanho
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  /// Valida se o campo não está vazio
  static String? validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  /// Valida se o ano fornecido é válido
  static String? validateYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ano é obrigatório.';
    }
    final year = int.tryParse(value);
    if (year == null || year < 1886 || year > DateTime.now().year) {
      return 'Ano inválido.';
    }
    return null;
  }

  /// Valida se o número é positivo
  static String? validatePositiveNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório.';
    }
    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return '$fieldName deve ser maior que zero.';
    }
    return null;
  }
}
