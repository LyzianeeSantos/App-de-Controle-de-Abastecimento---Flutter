# **Vehicle Fuel Management App**

Este é um aplicativo Flutter para o gerenciamento de veículos e abastecimentos, desenvolvido com integração ao Firebase. Ele permite que os usuários autentiquem, registrem veículos, acompanhem o histórico de abastecimentos e calculem o consumo de combustível.

---

## **📋 Funcionalidades**

- **Autenticação de Usuário**: Registro e login de usuários via Firebase Authentication.
- **Gerenciamento de Veículos**:
  - Adicionar, visualizar, editar e excluir veículos.
  - Visualizar detalhes de cada veículo.
- **Histórico de Abastecimentos**:
  - Registrar novos abastecimentos para cada veículo.
  - Consultar o histórico de abastecimentos.
- **Cálculo de Consumo**:
  - Cálculo do consumo médio com base nos abastecimentos registrados.
- **Navegação Organizada**:
  - Navegação baseada em um Drawer para acesso rápido às telas principais.

---

## **📂 Estrutura do Projeto**

```plaintext
lib/
|-- main.dart
|-- screens/
|   |-- login_screen.dart          # Tela de login
|   |-- register_screen.dart       # Tela de registro
|   |-- home_screen.dart           # Tela inicial (dashboard)
|   |-- vehicle_list_screen.dart   # Tela para listar veículos
|   |-- vehicle_detail_screen.dart # Tela de detalhes do veículo
|   |-- add_vehicle_screen.dart    # Tela para adicionar veículos
|   |-- edit_vehicle_screen.dart   # Tela para editar veículos
|   |-- fuel_history_screen.dart   # Tela com histórico de abastecimentos
|   |-- profile_screen.dart        # Tela de perfil do usuário
|-- widgets/
|   |-- drawer_widget.dart         # Widget para a barra lateral de navegação
|   |-- vehicle_card.dart          # Widget para exibir veículos
|-- models/
|   |-- vehicle.dart               # Modelo para veículo
|   |-- fuel_record.dart           # Modelo para registros de abastecimento
|-- services/
|   |-- firebase_auth_service.dart # Serviço de autenticação Firebase
|   |-- firestore_service.dart     # Serviço para interagir com o Firestore
|-- utils/
|   |-- constants.dart             # Constantes globais do projeto
|   |-- validators.dart            # Validações de formulários
