# Interactive Modal

<div align="center">

![Interactive Modal Demo](screenshots/interactive_video.gif)

</div>

A Flutter package that allows you to display an interactive modal overlay on top of other widgets while maintaining interaction with both the modal and background content.

<div align="center">

[![pub package](https://img.shields.io/pub/v/interactive_modal.svg)](https://pub.dev/packages/interactive_modal)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

## Features

- 🎯 **Interactive Background**: The background widget remains fully interactive while the modal is displayed
- 🎨 **Customizable Position**: Place the modal at the top, center, bottom, or custom position
- 🖐️ **Draggable Modal**: Optionally make the modal draggable to move it anywhere on screen
- ✨ **Smooth Animations**: Built-in slide animations with customizable duration
- 🎭 **Theme Support**: Automatically adapts to light and dark themes
- 📱 **Responsive**: Works seamlessly across different screen sizes
- 🔧 **Easy to Use**: Simple controller-based API

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  interactive_modal: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:interactive_modal/interactive_modal.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final InteractiveModalController _controller = InteractiveModalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveModal(
        controller: _controller,
        background: Container(
          color: Colors.blue,
          child: Center(
            child: Text('Interactive Background'),
          ),
        ),
        modalContent: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Modal Content'),
              ElevatedButton(
                onPressed: () => _controller.hide(),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.show(),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Advanced Example with Custom Position

```dart
InteractiveModal(
  controller: _controller,
  background: MyMapWidget(),
  modalContent: MyControlPanel(),
  position: ModalPosition.bottom,
  modalHeight: 300,
  animate: true,
  animationDuration: Duration(milliseconds: 400),
  modalBackgroundColor: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      spreadRadius: 5,
    ),
  ],
)
```

### Draggable Modal Example

```dart
InteractiveModal(
  controller: _controller,
  background: MyInteractiveContent(),
  modalContent: MyModalPanel(),
  position: ModalPosition.bottom,
  isDraggable: true, // Enable drag functionality
  modalHeight: 250,
)
```

When `isDraggable` is set to `true`, users can touch and drag the modal to move it anywhere on the screen. This is particularly useful for:
- Floating control panels
- Movable toolbars
- Customizable UI layouts
- Picture-in-picture style interfaces

#### Controlling Which Area is Draggable

You can use the `DragHandle` widget to specify which part of the modal should be draggable:

```dart
Widget _buildModalContent() {
  return Column(
    children: [
      // Only this area will be draggable
      DragHandle(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.drag_handle),
              Text('Drag from here'),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => controller.hide(),
              ),
            ],
          ),
        ),
      ),
      // This area will be scrollable, not draggable
      Expanded(
        child: ListView(
          children: [
            // Your scrollable content
          ],
        ),
      ),
    ],
  );
}
```

Without `DragHandle`, the entire modal will be draggable. With `DragHandle`, only the wrapped widget responds to drag gestures, allowing other parts (like scrollable lists) to work normally.

## Parameters

### InteractiveModal

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `background` | `Widget` | required | The background widget that remains interactive |
| `modalContent` | `Widget` | required | The content to display in the modal |
| `controller` | `InteractiveModalController` | required | Controller to manage modal visibility |
| `position` | `ModalPosition` | `ModalPosition.bottom` | Position of the modal on screen |
| `customPadding` | `EdgeInsets?` | `null` | Custom padding when using `ModalPosition.custom` |
| `modalHeight` | `double?` | `screen height / 4` | Height of the modal |
| `isDraggable` | `bool` | `false` | Whether the modal can be dragged around the screen |
| `animate` | `bool` | `true` | Whether to animate the modal appearance |
| `animationDuration` | `Duration` | `300ms` | Duration of the animation |
| `modalBackgroundColor` | `Color?` | `null` | Background color of the modal (auto-adapts to theme if null) |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(20)` | Border radius of the modal |
| `boxShadow` | `List<BoxShadow>?` | default shadow | Shadow for the modal |

### ModalPosition

```dart
enum ModalPosition {
  top,      // Modal appears at the top
  bottom,   // Modal appears at the bottom
}
```

### InteractiveModalController

```dart
// Show the modal
controller.show();

// Hide the modal
controller.hide();

// Toggle visibility
controller.toggle();

// Check if visible
bool isVisible = controller.isVisible;

// Listen to changes
controller.addListener(() {
  print('Modal visibility changed: ${controller.isVisible}');
});
```

## Complete Examples

The package includes three comprehensive examples demonstrating different use cases:

<div align="center">

| Main Menu | Simple Example | Travel Map |
|-----------|----------------|------------|
| ![Main Menu](screenshots/image_main.png) | ![Simple Example](screenshots/image_simple.png) | ![Travel Map](screenshots/image_map.png) |

| Draggable Modal |
|-----------------|
| ![Draggable Modal](screenshots/image_drag.png) |

</div>

### 1. Simple Example ([simple_example.dart](example/lib/simple_example.dart))
A basic implementation showing:
- Interactive background with counter
- Modal with independent counter
- Simultaneous interaction with both elements
- Basic show/hide controls

### 2. Travel Map Example ([travel_map_example.dart](example/lib/travel_map_example.dart))
An advanced implementation demonstrating:
- Interactive map background that can be panned and zoomed
- Modal with playback controls (play/pause, speed selector, slider)
- List of travel points with auto-scroll
- Synchronization between modal controls and map markers
- Real-time animation of travel route

### 3. Draggable Modal Example ([draggable_example.dart](example/lib/draggable_example.dart))
Shows the draggable functionality with:
- Modal that can be dragged anywhere on screen
- Toggle between draggable and fixed modes
- Configurable initial position (top/bottom)
- Interactive background settings panel

To run the examples:

```bash
cd example
flutter pub get
flutter run
```

The app will show a home page where you can select which example to explore.

## Real-World Use Cases

1. **Map Applications**: Display controls over an interactive map
2. **Video Players**: Show playback controls over video content
3. **Image Viewers**: Display tools while allowing image manipulation
4. **Data Visualization**: Show filters over interactive charts

## Key Differences from Standard Modals

Unlike `showModalBottomSheet` or `showDialog`:
- ✅ Background remains fully interactive
- ✅ No modal barrier blocking touches
- ✅ Both modal and background can be used simultaneously
- ✅ Perfect for coordinate manipulation scenarios

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created with ❤️ Kevin Dels for the Flutter community

## Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/kevindels/flutter_interactive_modal/)!
