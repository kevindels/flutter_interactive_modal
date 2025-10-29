import 'package:flutter/material.dart';

/// Controller for managing the state of an InteractiveModal
class InteractiveModalController extends ChangeNotifier {
  bool _isVisible = false;

  /// Whether the modal is currently visible
  bool get isVisible => _isVisible;

  /// Show the modal
  void show() {
    _isVisible = true;
    notifyListeners();
  }

  /// Hide the modal
  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  /// Toggle the modal visibility
  void toggle() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
