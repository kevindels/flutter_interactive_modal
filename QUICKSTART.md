# Interactive Modal Package - Quick Start Guide

## 📦 Instalación Inicial

Después de crear el paquete, necesitas instalar las dependencias:

```bash
cd /Users/kevinlandaetaacosta/Documents/facilwwwpro/v3/interactive_modal
flutter pub get
```

## 🚀 Ejecutar el Ejemplo

### Ejemplo Completo (Travel Map)

```bash
cd example
flutter pub get
flutter run
```

Este ejemplo muestra:
- Un mapa interactivo simulado que puedes mover con gestos
- Modal con controles de animación (play/pause, velocidad, slider)
- Lista de puntos de viaje con auto-scroll sincronizado
- Animación de recorrido en tiempo real

### Ejemplo Simple

Para ver el ejemplo simple, modifica `example/lib/main.dart` y cambia:

```dart
import 'simple_example.dart' as simple;

void main() {
  simple.main();
}
```

## 🧪 Ejecutar Tests

```bash
flutter test
```

## 📝 Características Principales

### 1. InteractiveModal Widget

El widget principal que permite mostrar un modal sobre contenido de fondo mientras ambos permanecen interactivos.

**Ventajas sobre modales estándar:**
- ✅ El fondo permanece totalmente interactivo
- ✅ No hay barrera modal que bloquee toques
- ✅ Ambos (modal y fondo) pueden usarse simultáneamente
- ✅ Perfecto para escenarios de manipulación coordinada

### 2. InteractiveModalController

Controlador simple para gestionar la visibilidad del modal:

```dart
final controller = InteractiveModalController();

// Mostrar
controller.show();

// Ocultar
controller.hide();

// Alternar
controller.toggle();

// Verificar estado
bool visible = controller.isVisible;
```

### 3. Posicionamiento Flexible

```dart
enum ModalPosition {
  top,      // Arriba
  center,   // Centro
  bottom,   // Abajo (por defecto)
  custom,   // Personalizado con customPadding
}
```

### 4. Animaciones Personalizables

- Animaciones de slide suaves
- Duración configurable
- Opción de desactivar animaciones

## 🎯 Casos de Uso Reales

1. **Aplicaciones de Mapas**: Mostrar controles sobre un mapa interactivo
2. **Reproductores de Video**: Controles de reproducción sobre video
3. **Visores de Imágenes**: Herramientas sobre imágenes manipulables
4. **Visualización de Datos**: Filtros sobre gráficos interactivos
5. **Juegos**: Elementos de UI sobre canvas de juego

## 📖 Estructura del Proyecto

```
interactive_modal/
├── lib/
│   ├── interactive_modal.dart              # Archivo de exportación principal
│   └── src/
│       ├── interactive_modal.dart          # Widget principal
│       └── interactive_modal_controller.dart # Controlador
├── example/
│   ├── lib/
│   │   ├── main.dart                       # Ejemplo completo (travel map)
│   │   └── simple_example.dart             # Ejemplo básico
│   ├── pubspec.yaml
│   └── README.md
├── test/
│   └── interactive_modal_test.dart         # Tests unitarios
├── CHANGELOG.md                            # Historial de cambios
├── LICENSE                                 # Licencia MIT
├── PUBLISHING.md                           # Guía de publicación
├── README.md                               # Documentación principal
├── analysis_options.yaml                   # Opciones de análisis
└── pubspec.yaml                           # Dependencias del paquete
```

## 🔧 Diferencias con tu Código Original

### Cambios Realizados:

1. **Sin GetX**: Usamos `StatefulWidget` y `ChangeNotifier` en lugar de GetX
2. **Controller Simplificado**: `InteractiveModalController` reemplaza a `TravelControllerMap`
3. **Widget Reutilizable**: `InteractiveModal` es genérico y acepta cualquier contenido
4. **Posicionamiento Flexible**: Soporta top, center, bottom, y custom
5. **Ejemplo Desacoplado**: El ejemplo está completamente separado del widget principal

### Similitudes Mantenidas:

- ✅ Modal interactivo sobre fondo interactivo (usando `Stack`)
- ✅ Animaciones suaves (usando `SlideTransition`)
- ✅ Control de visibilidad mediante controller
- ✅ Ejemplo con mapa y controles de reproducción
- ✅ Play/pause, slider, velocidad, lista sincronizada

## 🎨 Personalización

### Colores y Estilos

```dart
InteractiveModal(
  controller: controller,
  background: MyBackground(),
  modalContent: MyModal(),
  modalBackgroundColor: Colors.blue,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 20,
      spreadRadius: 10,
    ),
  ],
)
```

### Altura y Posición

```dart
InteractiveModal(
  controller: controller,
  background: MyBackground(),
  modalContent: MyModal(),
  position: ModalPosition.center,
  modalHeight: 400,
  customPadding: EdgeInsets.all(20),
)
```

### Animaciones

```dart
InteractiveModal(
  controller: controller,
  background: MyBackground(),
  modalContent: MyModal(),
  animate: true,
  animationDuration: Duration(milliseconds: 500),
)
```

## 📱 Soporte de Plataformas

El paquete es compatible con:
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🐛 Resolución de Problemas

### Error: Target of URI doesn't exist

**Solución**: Ejecuta `flutter pub get` en la carpeta del paquete y en la carpeta example.

```bash
cd interactive_modal
flutter pub get

cd example
flutter pub get
```

### Error: Missing dependencies

**Solución**: Asegúrate de que el `pubspec.yaml` del ejemplo tenga la referencia correcta:

```yaml
dependencies:
  interactive_modal:
    path: ../
```

## 📦 Próximos Pasos para Publicar

1. **Actualiza URLs**: Modifica `homepage`, `repository` en `pubspec.yaml`
2. **Crea Repositorio Git**: Sube el código a GitHub
3. **Tests**: Asegúrate de que todos los tests pasen
4. **Análisis**: Ejecuta `flutter analyze` sin errores
5. **Dry Run**: `flutter pub publish --dry-run`
6. **Publica**: `flutter pub publish`

Ver `PUBLISHING.md` para instrucciones detalladas.

## 💡 Consejos de Desarrollo

1. **Mantén la API Simple**: No agregues complejidad innecesaria
2. **Documenta Todo**: Usa comentarios dartdoc en todas las APIs públicas
3. **Ejemplos Claros**: Proporciona ejemplos variados y fáciles de entender
4. **Tests Completos**: Mantén alta cobertura de tests
5. **Versionado Semántico**: Sigue las reglas de versionado semántico

## 🤝 Contribuciones

Para contribuir al paquete:

1. Fork el repositorio
2. Crea una rama para tu feature
3. Escribe tests para tu código
4. Asegúrate de que todo pase: `flutter test && flutter analyze`
5. Crea un Pull Request

## 📄 Licencia

MIT License - Ver archivo `LICENSE` para más detalles.

## 🎉 ¡Listo!

Tu paquete está completo y listo para usar. Para probarlo inmediatamente:

```bash
cd /Users/kevinlandaetaacosta/Documents/facilwwwpro/v3/interactive_modal/example
flutter pub get
flutter run
```

¡Disfruta creando modales interactivos! 🚀
