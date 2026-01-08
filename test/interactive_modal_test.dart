import 'package:flutter/material.dart';
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

  group('InteractiveModal Widget', () {
    testWidgets('should render background and modal when visible',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
          ),
        ),
      );

      // Background should always be visible
      expect(find.text('Background'), findsOneWidget);

      // Modal should not be visible initially
      expect(find.text('Modal Content'), findsNothing);

      // Show the modal
      controller.show();
      await tester.pumpAndSettle();

      // Modal should now be visible
      expect(find.text('Modal Content'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('should call onShow callback when modal is shown',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();
      bool onShowCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            onShow: () {
              onShowCalled = true;
            },
          ),
        ),
      );

      controller.show();
      await tester.pump();

      expect(onShowCalled, true);

      controller.dispose();
    });

    testWidgets('should call onHide callback when modal is hidden',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();
      bool onHideCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            onHide: () {
              onHideCalled = true;
            },
          ),
        ),
      );

      controller.show();
      await tester.pump();

      controller.hide();
      await tester.pump();

      expect(onHideCalled, true);

      controller.dispose();
    });

    testWidgets('should show backdrop when showBackdrop is true',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            showBackdrop: true,
            backdropColor: Colors.red,
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // Find container with backdrop color
      final backdropContainer = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(AnimatedOpacity),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(backdropContainer.color, Colors.red);

      controller.dispose();
    });

    testWidgets('should dismiss modal when backdrop is tapped',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            showBackdrop: true,
            backdropDismiss: true,
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      expect(controller.isVisible, true);

      // Tap on backdrop
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(controller.isVisible, false);

      controller.dispose();
    });

    testWidgets('should show drag indicator when enabled',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            isDraggable: true,
            showDragIndicator: true,
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      // Should find the drag indicator column structure
      expect(find.byType(Column), findsWidgets);

      controller.dispose();
    });

    testWidgets('should support ModalPosition.center',
        (WidgetTester tester) async {
      final controller = InteractiveModalController();

      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveModal(
            controller: controller,
            background: const Text('Background'),
            modalContent: const Text('Modal Content'),
            position: ModalPosition.center,
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      expect(find.text('Modal Content'), findsOneWidget);

      controller.dispose();
    });
  });
}
