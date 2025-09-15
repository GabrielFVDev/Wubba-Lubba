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

Queria agradecer a Way Data Solutions pelo desafio! Muito obrigado por terem me selecionado para o desafio técnico.

### ✨ Funcionalidades

- 🎭 **Lista de Personagens**: Visualize todos os personagens com nome, imagem e status
- 🔍 **Busca Inteligente**: Pesquise personagens por nome em tempo real
- 📄 **Detalhes Completos**: Veja informações detalhadas de cada personagem
- 🎨 **Interface Moderna**: Design dark temático inspirado no universo Rick and Morty
- ⚡ **Animações Suaves**: Transições fluidas entre telas
- 🔄 **Pull to Refresh**: Atualize a lista com gesture nativo
- ♿ **Acessibilidade Completa**: Suporte a leitores de tela e navegação assistiva
- 📱 **Responsividade**: Adaptação automática para celulares de todos os tamanhos

### 🌟 Acessibilidade e Inclusão

- **🔊 Screen Readers**: Suporte completo para TalkBack (Android) e VoiceOver (iOS)
- **🔍 Navegação por Foco**: Navegação otimizada por teclado e gestos
- **📏 Escalabilidade**: Fontes e elementos se adaptam ao tamanho da tela
- **🎯 Semântica Rica**: Labels e hints descritivos para cada elemento
- **⚡ Feedback Tátil**: Tooltips e splash radius responsivos
- **🔄 Estados Anunciados**: Mudanças de estado comunicadas aos assistivos

### 📱 Responsividade Multi-Dispositivo

| Tamanho         | Largura       | Exemplos                          | Adaptações                              |
| --------------- | ------------- | --------------------------------- | --------------------------------------- |
| **Extra Small** | < 320px       | iPhone SE (1ª gen)                | Elementos compactos, fonte menor        |
| **Small**       | 320px - 375px | iPhone SE, Galaxy S5              | Layout otimizado para telas pequenas    |
| **Medium**      | 375px - 414px | iPhone 8, X, Galaxy S8            | Tamanhos padrão, boa legibilidade       |
| **Large**       | 414px - 480px | iPhone Plus, Galaxy Note          | Elementos maiores, mais espaçamento     |
| **Extra Large** | > 480px       | Tablets pequenos, Android grandes | Layout expandido, melhor aproveitamento |

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

**Por que Clean Architecture?**

- ✅ **Separação de responsabilidades**: Cada camada tem uma função específica
- ✅ **Testabilidade**: Facilita a criação de testes unitários
- ✅ **Manutenibilidade**: Código mais organizado e fácil de modificar
- ✅ **Escalabilidade**: Permite crescimento do projeto sem comprometer a estrutura
- ✅ **Independência**: Business logic não depende de frameworks ou APIs

### 🛠️ Stack Tecnológica

| Categoria                   | Tecnologia     | Por que escolhi?                                                                                     |
| --------------------------- | -------------- | ---------------------------------------------------------------------------------------------------- |
| **Gerenciamento de Estado** | `flutter_bloc` | ✅ Padrão robusto usado pela comunidade<br>✅ Facilita testes<br>✅ Previsível e debugável           |
| **Navegação**               | `go_router`    | ✅ Navegação declarativa moderna<br>✅ Type-safe<br>✅ Suporte nativo a deep links                   |
| **HTTP Client**             | `dio`          | ✅ Interceptors para logs e erros<br>✅ Cancelamento de requisições<br>✅ Retry automático           |
| **Áudio**                   | `just_audio`   | ✅ Controle preciso de reprodução<br>✅ Suporte multiplataforma<br>✅ Boa performance                |
| **Comparação**              | `equatable`    | ✅ Evita rebuilds desnecessários<br>✅ Facilita comparação de estados<br>✅ Melhora performance BLoC |

### 🎨 Decisões de Design e UX

#### **Interface do Usuário**

- **Tema Dark**:

  - ✅ Inspirado no universo sci-fi de Rick and Morty
  - ✅ Menos cansativo para os olhos
  - ✅ Destaca melhor as cores dos status dos personagens

- **Cores Temáticas por Status**:
  - 🟢 **Verde** (Alive): Transmite vida e energia
  - 🔴 **Vermelho** (Dead): Indica claramente o status
  - 🟠 **Laranja** (Unknown): Neutro para status indefinido

#### **Animações e Transições**

```dart
// Por que implementar animações customizadas?
// ✅ Melhora a percepção de qualidade do app
// ✅ Feedback visual para ações do usuário
// ✅ Torna a navegação mais fluida e intuitiva

CustomTransitionPage(
  child: HomeScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return SlideTransition(/* Animação suave de slide */);
  },
)
```

#### **Componentização**

- **Widgets Reutilizáveis**:
  - ✅ `CharacterCardWidget`: Consistência visual em toda lista
  - ✅ `StatusChipWidget`: Padronização de status
  - ✅ `CustomAppBarWidget`: AppBar personalizada reutilizável
  - ✅ `InfoCardWidget`: Cards de informação uniformes

**Por que componentizar?**

- ✅ **DRY (Don't Repeat Yourself)**: Evita duplicação de código
- ✅ **Consistência**: Mesmo design em todo o app
- ✅ **Manutenção**: Mudanças centralizadas em um lugar
- ✅ **Testabilidade**: Testa componentes isoladamente

### 🔧 Tratamento de Erros

#### **Estratégia Simples e Eficaz**

```dart
// Por que essa abordagem?
// ✅ Mensagens amigáveis ao usuário
// ✅ Diferenciação de tipos de erro
// ✅ Ações de recovery (Retry)

String _getErrorMessage(dynamic error) {
  if (errorString.contains('network')) return 'Sem conexão com a internet';
  if (errorString.contains('timeout')) return 'Conexão demorou muito';
  if (errorString.contains('server')) return 'Erro no servidor';
  return 'Algo deu errado. Tente novamente';
}
```

#### **User Experience de Erro**

- ✅ **SnackBar com ação**: Permite retry imediato
- ✅ **Botões de retry**: Na tela de erro principal
- ✅ **Estados específicos**: Loading, Empty, Error bem definidos
- ✅ **Feedback visual**: Usuário sempre sabe o que está acontecendo

### 📱 Responsividade e Performance

#### **Decisões de Performance**

- ✅ **ListView.separated**: Renderização otimizada para listas grandes
- ✅ **BlocConsumer**: Escuta estados sem rebuilds desnecessários
- ✅ **Cached Network Images**: (Implícito no Image.network com cache)
- ✅ **Estados granulares**: Só rebuilda o que precisa

#### **Experiência Mobile**

- ✅ **Pull to Refresh**: Gesto nativo esperado pelos usuários
- ✅ **Search em tempo real**: Feedback imediato na busca
- ✅ **Loading states**: Feedback visual durante carregamentos
- ✅ **Safe Area**: Respeita notch e barras do sistema

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
