# Widget da Home Screen - Routine Helper

## 📱 Visão Geral

O widget da home screen permite que sua aplicação Flutter se comunique com Android e exiba informações diretamente na tela inicial do telefone, sem necessidade de abrir o app.

## 🔧 Como Funciona

### Arquitetura

```
Flutter (Dart) ← → Home Widget Library ← → Android (Kotlin)
                                             ↓
                                        AppWidget.kt (Glance)
```

### Componentes

1. **AppWidget.kt** - Widget visual que aparece na home screen (Android/Kotlin)
2. **HomeWidgetReceiver.kt** - Receptor que escuta atualizações do widget
3. **home_widget_updater.dart** - Funções Dart para atualizar o widget
4. **home_widget_provider.xml** - Configuração do widget (tamanho, atualização, etc)

## 🚀 Como Usar

### 1. Inicializar o Widget

No seu main.dart ou quando a app inicia:

```dart
import 'package:project/home_widget_updater.dart';

void main() {
  // Inicializa o widget com valores padrão
  updateHomeWidget(
    title: "Meu App",
    description: "Status do app",
    counter: 0,
  );
  runApp(MyApp());
}
```

### 2. Atualizar Dados do Widget

#### Atualização Completa
```dart
updateHomeWidget(
  title: "Novo Título",
  description: "Nova descrição",
  counter: 42,
);
```

#### Incrementar Contador
```dart
await incrementWidgetCounter();
```

#### Decrementar Contador
```dart
await decrementWidgetCounter();
```

#### Resetar Widget
```dart
await resetHomeWidget();
```

### 3. Exemplo Prático

Veja `lib/presentation-view/ui/widget_example.dart` para um exemplo completo de como integrar o widget em sua interface.

## 📊 O que o Widget Exibe

O widget mostra:
- **Título** - Seu título customizável
- **Descrição** - Uma descrição de status
- **Contador** - Um número que pode ser incrementado/decrementado

## 🎨 Customização

Para customizar a aparência do widget, edite `android/app/src/main/kotlin/com/example/project/glance/AppWidget.kt`:

```kotlin
// Alterar cores
background(ColorProvider(light = Color.White, night = Color.Black))

// Alterar tamanho da fonte
style = TextStyle(fontSize = 18.sp)

// Alterar layout
Column() { ... }
```

## 📐 Configurações do Widget

No arquivo `android/app/src/main/res/xml/home_widget_provider.xml`:

- `minWidth` - Largura mínima (padrão: 180dp)
- `minHeight` - Altura mínima (padrão: 180dp)
- `updatePeriodMillis` - Frequência de atualização (padrão: 30 minutos)

## ⚠️ Requisitos

- Android 5.0+ (API 21)
- Flutter 3.0+
- Dependência: `home_widget: ^0.9.0`

## 🐛 Troubleshooting

### O widget não aparece
1. Reinstale o app: `flutter clean && flutter pub get`
2. Pressione e segure a home screen → "Widgets" → procure seu app
3. Arraste para adicionar à home screen

### O widget não atualiza
1. Verifique se `updateHomeWidget()` está sendo chamado
2. Veja os logs: `flutter logs`
3. Certifique-se de que a biblioteca `home_widget` está instalada

### Erro de compilação
- Execute: `flutter clean && flutter pub get && flutter run`
- Atualize o Flutter: `flutter upgrade`

## 📚 Recursos Adicionais

- [Home Widget Plugin](https://pub.dev/packages/home_widget)
- [Android App Widgets](https://developer.android.com/guide/topics/appwidgets)
- [Glance Documentation](https://developer.android.com/develop/ui/compose/glance)
