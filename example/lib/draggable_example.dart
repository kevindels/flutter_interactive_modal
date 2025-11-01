import 'package:flutter/material.dart';
import 'package:interactive_modal/interactive_modal.dart';

/// Example showing draggable modal functionality
void main() {
  runApp(const DraggableExampleApp());
}

/// Standalone app wrapper (only used when running this file directly)
class DraggableExampleApp extends StatelessWidget {
  const DraggableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Interactive Modal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DraggableExample(),
    );
  }
}

/// The actual example page
class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  final InteractiveModalController _controller = InteractiveModalController();
  bool _isDraggable = true;
  ModalPosition _position = ModalPosition.bottom;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Modal Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: InteractiveModal(
        controller: _controller,
        background: _buildBackground(),
        modalContent: _buildModalContent(),
        position: _position,
        isDraggable: _isDraggable,
        modalHeight: 250,
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isVisible) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton.extended(
            onPressed: () => _controller.show(),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Show Modal'),
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Interactive Background',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SwitchListTile(
                        title: const Text('Draggable Modal'),
                        subtitle: Text(_isDraggable
                            ? 'Modal can be dragged'
                            : 'Modal is fixed'),
                        value: _isDraggable,
                        onChanged: (value) {
                          setState(() {
                            _isDraggable = value;
                          });
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Initial Position'),
                        subtitle: Text(
                            _position == ModalPosition.top ? 'Top' : 'Bottom'),
                      ),
                      SegmentedButton<ModalPosition>(
                        segments: const [
                          ButtonSegment(
                            value: ModalPosition.top,
                            label: Text('Top'),
                            icon: Icon(Icons.arrow_upward),
                          ),
                          ButtonSegment(
                            value: ModalPosition.bottom,
                            label: Text('Bottom'),
                            icon: Icon(Icons.arrow_downward),
                          ),
                        ],
                        selected: {_position},
                        onSelectionChanged: (Set<ModalPosition> newSelection) {
                          setState(() {
                            _position = newSelection.first;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Open the modal and try dragging it around!\n(if draggable is enabled)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalContent() {
    return Column(
      children: [
        // Drag handle area (only this area is draggable)
        DragHandle(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Icon(
                  _isDraggable ? Icons.open_with : Icons.lock,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isDraggable ? 'Drag me anywhere!' : 'Fixed Modal',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _controller.hide(),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        // Scrollable content area
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 10),
              Icon(
                _isDraggable ? Icons.pan_tool : Icons.check_circle,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 20),
              Text(
                _isDraggable
                    ? 'Touch and drag the header to move this modal around the screen'
                    : 'This modal is fixed in place',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (_isDraggable)
                const Text(
                  'Try interacting with the background while moving the modal!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              const SizedBox(height: 20),
              // Additional content to demonstrate scrolling
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Features:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildFeatureItem('✓ Drag from header area'),
                      _buildFeatureItem('✓ Scroll through content'),
                      _buildFeatureItem('✓ Interactive background'),
                      _buildFeatureItem('✓ Smooth animations'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
