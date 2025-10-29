import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_modal/interactive_modal.dart';

void main() {
  group('InteractiveModalController', () {
    test('should start with isVisible as false', () {
      final controller = InteractiveModalController();
      expect(controller.isVisible, false);
      controller.dispose();
    });

    test('show() should set isVisible to true', () {
      final controller = InteractiveModalController();
      controller.show();
      expect(controller.isVisible, true);
      controller.dispose();
    });

    test('hide() should set isVisible to false', () {
      final controller = InteractiveModalController();
      controller.show();
      controller.hide();
      expect(controller.isVisible, false);
      controller.dispose();
    });

    test('toggle() should change visibility state', () {
      final controller = InteractiveModalController();
      expect(controller.isVisible, false);

      controller.toggle();
      expect(controller.isVisible, true);

      controller.toggle();
      expect(controller.isVisible, false);

      controller.dispose();
    });

    test('should notify listeners when state changes', () {
      final controller = InteractiveModalController();
      var notificationCount = 0;

      controller.addListener(() {
        notificationCount++;
      });

      controller.show();
      expect(notificationCount, 1);

      controller.hide();
      expect(notificationCount, 2);

      controller.toggle();
      expect(notificationCount, 3);

      controller.dispose();
    });
  });
}
