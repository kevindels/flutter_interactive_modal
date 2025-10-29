# Interactive Modal

A Flutter package that allows you to display an interactive modal overlay on top of other widgets while maintaining interaction with both the modal and background content.

## Features

- 🎯 **Interactive Background**: The background widget remains fully interactive while the modal is displayed
- 🎨 **Customizable Position**: Place the modal at the top, center, bottom, or custom position
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
| `animate` | `bool` | `true` | Whether to animate the modal appearance |
| `animationDuration` | `Duration` | `300ms` | Duration of the animation |
| `modalBackgroundColor` | `Color?` | `null` | Background color of the modal (auto-adapts to theme if null) |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(20)` | Border radius of the modal |
| `boxShadow` | `List<BoxShadow>?` | default shadow | Shadow for the modal |

### ModalPosition

```dart
enum ModalPosition {
  top,      // Modal appears at the top
  center,   // Modal appears in the center
  bottom,   // Modal appears at the bottom
  custom,   // Use customPadding for positioning
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

## Complete Example: Travel Map with Animated Controls

See the [example](example/lib/main.dart) folder for a complete implementation that demonstrates:

- Interactive map background that can be panned and zoomed
- Modal with playback controls (play/pause, speed selector, slider)
- List of travel points with auto-scroll
- Synchronization between modal controls and map markers
- Real-time animation of travel route

## Real-World Use Cases

1. **Map Applications**: Display controls over an interactive map
2. **Video Players**: Show playback controls over video content
3. **Image Viewers**: Display tools while allowing image manipulation
4. **Data Visualization**: Show filters over interactive charts
5. **Gaming**: Display UI elements over game canvas

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

Created with ❤️ for the Flutter community

## Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/yourusername/interactive_modal)!
