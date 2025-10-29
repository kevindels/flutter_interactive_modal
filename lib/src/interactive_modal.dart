import 'package:flutter/material.dart';
import 'interactive_modal_controller.dart';

/// Position of the modal on the screen
enum ModalPosition { top, center, bottom, custom }

/// A widget that displays an interactive modal overlay on top of background content
/// while allowing interaction with both the modal and the background.
class InteractiveModal extends StatefulWidget {
  /// The background widget that remains interactive
  final Widget background;

  /// The modal content to display
  final Widget modalContent;

  /// Controller to manage modal visibility
  final InteractiveModalController controller;

  /// Position of the modal on the screen
  final ModalPosition position;

  /// Custom positioning when position is set to ModalPosition.custom
  final EdgeInsets? customPadding;

  /// Height of the modal (defaults to 1/4 of screen height)
  final double? modalHeight;

  /// Whether to animate the modal appearance
  final bool animate;

  /// Duration of the animation
  final Duration animationDuration;

  /// Background color of the modal
  final Color? modalBackgroundColor;

  /// Border radius of the modal
  final BorderRadius? borderRadius;

  /// Shadow for the modal
  final List<BoxShadow>? boxShadow;

  const InteractiveModal({
    super.key,
    required this.background,
    required this.modalContent,
    required this.controller,
    this.position = ModalPosition.bottom,
    this.customPadding,
    this.modalHeight,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.modalBackgroundColor,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  State<InteractiveModal> createState() => _InteractiveModalState();
}

class _InteractiveModalState extends State<InteractiveModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _updateSlideAnimation();

    widget.controller.addListener(_onControllerChanged);
  }

  void _updateSlideAnimation() {
    Offset begin;
    switch (widget.position) {
      case ModalPosition.top:
        begin = const Offset(0, -1);
        break;
      case ModalPosition.bottom:
        begin = const Offset(0, 1);
        break;
      case ModalPosition.center:
        begin = const Offset(0, 1);
        break;
      case ModalPosition.custom:
        begin = const Offset(0, 1);
        break;
    }

    _slideAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onControllerChanged() {
    if (widget.controller.isVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildModal(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final modalHeight = widget.modalHeight ?? screenHeight / 4;

    EdgeInsets padding;
    switch (widget.position) {
      case ModalPosition.top:
        padding = const EdgeInsets.only(left: 10, right: 10, top: 60);
        break;
      case ModalPosition.center:
        padding = EdgeInsets.symmetric(
          horizontal: 10,
          vertical: (screenHeight - modalHeight) / 2,
        );
        break;
      case ModalPosition.bottom:
        padding = const EdgeInsets.only(left: 10, right: 10, bottom: 20);
        break;
      case ModalPosition.custom:
        padding = widget.customPadding ?? const EdgeInsets.all(10);
        break;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        widget.modalBackgroundColor ??
        (isDark ? const Color(0xFF2C2C2C) : Colors.white);

    Widget modalWidget = Container(
      height: modalHeight,
      decoration: BoxDecoration(
        boxShadow:
            widget.boxShadow ??
            const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 30.0,
                spreadRadius: 5.0,
              ),
            ],
        color: backgroundColor,
        borderRadius:
            widget.borderRadius ?? const BorderRadius.all(Radius.circular(20)),
      ),
      child: widget.modalContent,
    );

    if (widget.animate) {
      modalWidget = SlideTransition(
        position: _slideAnimation,
        child: modalWidget,
      );
    }

    return Positioned.fill(
      child: Padding(
        padding: padding,
        child: Align(alignment: _getAlignment(), child: modalWidget),
      ),
    );
  }

  Alignment _getAlignment() {
    switch (widget.position) {
      case ModalPosition.top:
        return Alignment.topCenter;
      case ModalPosition.center:
        return Alignment.center;
      case ModalPosition.bottom:
        return Alignment.bottomCenter;
      case ModalPosition.custom:
        return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background widget (always interactive)
        widget.background,

        // Modal overlay (only shown when controller.isVisible is true)
        AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            if (!widget.controller.isVisible &&
                !_animationController.isAnimating) {
              return const SizedBox.shrink();
            }
            return _buildModal(context);
          },
        ),
      ],
    );
  }
}
