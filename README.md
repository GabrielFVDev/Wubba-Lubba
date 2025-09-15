# 🛸 Wubba Lubba Dub Dub! - Rick and Morty App

<p align="center">
  <img src="assets/images/portal.png" alt="Rick and Morty Portal" width="200"/>
</p>

<p align="center">
  <strong>Aplicativo Flutter que explora o multiverso de Rick and Morty!</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.24.3-blue.svg" alt="Flutter Version"/>
  <img src="https://img.shields.io/badge/Dart-3.5.3-blue.svg" alt="Dart Version"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg" alt="Platform"/>
</p>

---

## 📱 Sobre o Projeto

Este projeto foi desenvolvido como parte de um **desafio técnico para desenvolvedor Flutter júnior**. O aplicativo consome a [Rick and Morty API](https://rickandmortyapi.com/) para exibir informações sobre personagens do universo da série.

### ✨ Funcionalidades

- 🎭 **Lista de Personagens**: Visualize todos os personagens com nome, imagem e status
- 🔍 **Busca Inteligente**: Pesquise personagens por nome em tempo real
- 📄 **Detalhes Completos**: Veja informações detalhadas de cada personagem
- 🎨 **Interface Moderna**: Design dark temático inspirado no universo Rick and Morty
- ⚡ **Animações Suaves**: Transições fluidas entre telas
- 🔄 **Pull to Refresh**: Atualize a lista com gesture nativo

---

## 🎯 Demonstração

### Splash Screen → Lista → Detalhes

```
🌀 Portal Animado → 📋 Lista de Personagens → 👤 Detalhes do Personagem
```

### Funcionalidades Principais:

- ✅ Splash screen com animação de portal e áudio
- ✅ Lista responsiva com busca
- ✅ Cards de personagens com status visual
- ✅ Tela de detalhes com informações completas
- ✅ Navegação fluida com animações customizadas

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.24.3 ou superior)
- [Dart SDK](https://dart.dev/get-dart) (versão 3.5.3 ou superior)
- Editor de código (VS Code, Android Studio, IntelliJ)

### Passos para Execução

1. **Clone o repositório**

   ```bash
   git clone https://github.com/GabrielFVDev/Wubba-Lubba.git
   cd Wubba-Lubba
   ```

2. **Instale as dependências**

   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**

   ```bash
   flutter run
   ```

4. **Para build de produção**

   ```bash
   # Android
   flutter build apk --release

   # iOS
   flutter build ios --release
   ```

---

## 🏗️ Arquitetura e Escolhas Técnicas

### 🎯 Clean Architecture

O projeto segue os princípios da **Clean Architecture**, organizando o código em camadas bem definidas:

```
lib/
├── app/
│   ├── data/          # 📊 Camada de Dados
│   ├── domain/        # 🎯 Regras de Negócio
│   └── presentation/  # 🎨 Interface do Usuário
├── core/             # ⚙️  Configurações Gerais
└── shared/           # 🔄 Recursos Compartilhados
```

### 🛠️ Stack Tecnológica

| Categoria                   | Tecnologia     | Justificativa                          |
| --------------------------- | -------------- | -------------------------------------- |
| **Gerenciamento de Estado** | `flutter_bloc` | Padrão robusto, testável e escalável   |
| **Navegação**               | `go_router`    | Navegação declarativa e type-safe      |
| **HTTP Client**             | `dio`          | Cliente HTTP poderoso com interceptors |
| **Áudio**                   | `just_audio`   | Reprodução de áudio para splash screen |
| **Comparação**              | `equatable`    | Comparação eficiente de objetos        |

### 🎨 Decisões de Design

- **Tema Dark**: Inspirado no universo sci-fi de Rick and Morty
- **Cores Temáticas**: Verde (alive), vermelho (dead), laranja (unknown)
- **Animações**: Transições suaves para melhor UX
- **Responsividade**: Interface adaptável para diferentes tamanhos de tela

---

## 📦 Estrutura do Projeto

### 🗂️ Organização por Feature

```
lib/app/presentation/
├── bloc/           # Estados e eventos do BLoC
├── home/           # Tela de listagem
├── details/        # Tela de detalhes
├── splash/         # Tela inicial
└── widgets/        # Componentes reutilizáveis
    ├── cards/      # Cards de personagens
    ├── chips/      # Status chips
    ├── titles/     # Títulos de seção
    └── app_bar/    # AppBar customizada
```

### 🔄 Fluxo de Dados

```
API → Repository → Use Cases → BLoC → UI
```

---

## 🧪 Testes

### Executar Testes

```bash
# Todos os testes
flutter test

# Testes com coverage
flutter test --coverage
```

### Cobertura de Testes

- ✅ Unit Tests (Use Cases, Repository)
- ✅ Widget Tests (Componentes UI)
- ✅ Integration Tests (Fluxos principais)

---

## 📋 Funcionalidades Implementadas

### ✅ Requisitos Obrigatórios

- [x] Lista de personagens com nome, imagem e status
- [x] Tela de detalhes com informações do personagem
- [x] Navegação entre telas
- [x] Clean Architecture
- [x] Consumo da Rick and Morty API

### 🚀 Extras Implementados

- [x] Splash screen com animação
- [x] Busca em tempo real
- [x] Pull to refresh
- [x] Animações de transição
- [x] Design system consistente
- [x] Widgets reutilizáveis
- [x] Loading states
- [x] Error handling

---

## 🎯 Possíveis Melhorias Futuras

- [ ] 📱 Cache offline com Hive/SQLite
- [ ] 🔍 Filtros avançados (espécie, origem, episódios)
- [ ] ⭐ Sistema de favoritos
- [ ] 🌐 Paginação infinita
- [ ] 🎨 Temas customizáveis
- [ ] 🔊 Mais efeitos sonoros temáticos
- [ ] 📊 Analytics e crashlytics

---

## 👨‍💻 Desenvolvedor

**Gabriel F. V.**

- 🐙 GitHub: [@GabrielFVDev](https://github.com/GabrielFVDev)

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<p align="center">
  <strong>🛸 "Wubba Lubba Dub Dub!" - Rick Sanchez</strong>
</p>

<p align="center">
  Feito com ❤️ e muito Flutter
</p>
