# Interactive Modal Package - Quick Start Guide

<div align="center">

<img src="screenshots/interactive_video.gif" alt="Interactive Modal Demo" width="300"/>

*Modal interactivo en acción - Interactúa con ambos elementos simultáneamente*

</div>

## 📦 Instalación Inicial

Después de crear el paquete, necesitas instalar las dependencias:

```bash
cd /$HOME/$interactive_modal
flutter pub get
```

## 🚀 Ejecutar el Ejemplo

El paquete incluye tres ejemplos completos que demuestran diferentes características:

<div align="center">

### Vista Previa de los Ejemplos

| Página Principal | Ejemplo Simple |
|------------------|----------------|
| <img src="screenshots/image_main.png" alt="Main" width="280"/> | <img src="screenshots/image_simple.png" alt="Simple" width="280"/> |

| Travel Map | Modal Arrastrable |
|------------|-------------------|
| <img src="screenshots/image_map.png" alt="Map" width="280"/> | <img src="screenshots/image_drag.png" alt="Draggable" width="280"/> |

</div>

### Ejecutar Todos los Ejemplos (Recomendado)

```bash
cd example
flutter pub get
flutter run
```

Esto abrirá una aplicación con una página principal donde puedes seleccionar entre:

1. **Ejemplo Simple** - Demostración básica de interacción simultánea
2. **Travel Map** - Mapa interactivo con controles de animación avanzados
3. **Modal Arrastrable** - Modal que se puede mover por toda la pantalla

### Ejemplos Incluidos

#### 1. Ejemplo Simple
- Ubicación: `example/lib/simple_example.dart`
- Muestra la funcionalidad básica
- Contadores independientes en fondo y modal
- Perfecto para entender el concepto

#### 2. Travel Map (Complejo)
- Ubicación: `example/lib/travel_map_example.dart`
- Un mapa interactivo simulado que puedes mover con gestos
- Modal con controles de reproducción
- Lista de puntos de viaje con auto-scroll sincronizado
- Animación de recorrido en tiempo real

#### 3. Modal Arrastrable
- Ubicación: `example/lib/draggable_example.dart`
- Modal que puede arrastrarse a cualquier posición
- Toggle para activar/desactivar el arrastre
- Selector de posición inicial
- **Lo importante: ¡puedes usar el modal y el fondo al mismo tiempo!**

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
  bottom,   // Abajo (por defecto)
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
│   │   ├── main.dart                       # Página principal con selector de ejemplos
│   │   ├── simple_example.dart             # Ejemplo básico
│   │   ├── travel_map_example.dart         # Ejemplo completo (travel map)
│   │   └── draggable_example.dart          # Ejemplo de modal arrastrable
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
