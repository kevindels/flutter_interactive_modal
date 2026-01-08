## 0.1.0

* **NEW FEATURES:**
  - ✨ Added `ModalPosition.center` for centered modals
  - 🎪 Added backdrop overlay with `showBackdrop`, `backdropColor`, `backdropOpacity`, and `backdropDismiss` parameters
  - 📍 Added visual drag indicator with `showDragIndicator` and customizable `dragIndicator` widget
  - 📏 Added `modalWidth` parameter for custom modal width
  - 🔔 Added event callbacks: `onShow`, `onHide`, `onDragStart`, `onDragEnd`
  - 🎯 Enhanced drag functionality with proper drag end callback support
* **IMPROVEMENTS:**
  - Improved draggable modal positioning logic
  - Better animation handling for center position
  - Enhanced theme adaptation for backdrop
* **TESTS:**
  - Added comprehensive widget tests for new features
  - Added tests for backdrop functionality
  - Added tests for event callbacks
  - Added tests for drag indicator
  - Improved overall test coverage
* **DOCUMENTATION:**
  - Updated README.md with new features and examples
  - Updated README_ES.md with Spanish documentation
  - Added detailed parameter descriptions
  - Added usage examples for backdrop and callbacks

## 0.0.1

* Initial release
* InteractiveModal widget with customizable positioning (top, bottom)
* InteractiveModalController for managing modal visibility
* Support for smooth slide animations with customizable duration
* Ability to interact with both modal and background widgets simultaneously
* **Draggable modal functionality** - Move modals anywhere on screen
* **DragHandle widget** - Control which areas are draggable vs scrollable
* Multiple comprehensive examples:
  - Simple example: Basic interactive modal usage
  - Travel Map example: Advanced map interaction with animated controls
  - Draggable example: Demonstrates draggable modal features
* Theme-aware design (automatically adapts to light/dark mode)
* No external dependencies (pure Flutter implementation)
* Fully documented API with dartdoc comments
* Complete test coverage

