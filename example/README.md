# Interactive Modal Example

This example demonstrates how to use the `interactive_modal` package to create an interactive travel map with animated controls.

## Features Demonstrated

- Interactive map background (pan and zoom)
- Modal overlay with playback controls
- Speed selector (0.5x to 8x)
- Progress slider for manual navigation
- Auto-scrolling list synchronized with map
- Play/pause animation
- Reset functionality

## Running the Example

1. Navigate to the example directory:
```bash
cd example
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## How It Works

The example simulates a travel tracking application similar to GPS tracking apps. The modal shows:

- **Speed Control**: Adjust animation playback speed
- **Play/Pause Button**: Start or stop the animation
- **Slider**: Manually navigate through travel points
- **Reset Button**: Return to the beginning
- **Travel List**: Shows all points with details (speed, alarms, etc.)

The background map remains interactive - you can pan and zoom while the modal is open, and the route line updates in real-time as you navigate through the travel points.

## Key Implementation Details

- Uses `StatefulWidget` instead of GetX for state management
- `Timer.periodic` for animation playback
- `ScrollController` for list auto-scrolling
- `CustomPainter` for drawing travel routes
- Gesture detection for map interaction
