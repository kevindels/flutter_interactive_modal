import 'package:flutter/material.dart';
import 'package:interactive_modal/interactive_modal.dart';

/// Example showing backdrop overlay and callback functionality
void main() {
  runApp(const BackdropExampleApp());
}

/// Standalone app wrapper
class BackdropExampleApp extends StatelessWidget {
  const BackdropExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backdrop & Callbacks Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const BackdropExample(),
    );
  }
}

/// The actual example page
class BackdropExample extends StatefulWidget {
  const BackdropExample({super.key});

  @override
  State<BackdropExample> createState() => _BackdropExampleState();
}

class _BackdropExampleState extends State<BackdropExample> {
  final InteractiveModalController _controller = InteractiveModalController();

  // Settings
  bool _showBackdrop = true;
  double _backdropOpacity = 0.5;
  bool _backdropDismiss = true;
  bool _showDragIndicator = false;
  ModalPosition _position = ModalPosition.center;

  // Event logs
  final List<String> _eventLogs = [];
  final ScrollController _logScrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _logScrollController.dispose();
    super.dispose();
  }

  void _addLog(String message) {
    setState(() {
      _eventLogs.insert(
          0, '${DateTime.now().toString().substring(11, 19)} - $message');
      if (_eventLogs.length > 20) {
        _eventLogs.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backdrop & Callbacks Demo'),
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
        showBackdrop: _showBackdrop,
        backdropOpacity: _backdropOpacity,
        backdropDismiss: _backdropDismiss,
        showDragIndicator: _showDragIndicator,
        isDraggable: true,
        modalHeight: 400,
        modalWidth: 350,
        onShow: () => _addLog('Modal shown ✅'),
        onHide: () => _addLog('Modal hidden ❌'),
        onDragStart: () => _addLog('Drag started 🖐️'),
        onDragEnd: () => _addLog('Drag ended 🏁'),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interactive Settings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Show Backdrop'),
                        subtitle: const Text('Semi-transparent overlay'),
                        value: _showBackdrop,
                        onChanged: (value) {
                          setState(() => _showBackdrop = value);
                        },
                      ),
                      if (_showBackdrop) ...[
                        const Divider(),
                        ListTile(
                          title: const Text('Backdrop Opacity'),
                          subtitle: Slider(
                            value: _backdropOpacity,
                            onChanged: (value) {
                              setState(() => _backdropOpacity = value);
                            },
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            label: _backdropOpacity.toStringAsFixed(1),
                          ),
                        ),
                        SwitchListTile(
                          title: const Text('Backdrop Dismiss'),
                          subtitle: const Text('Tap backdrop to close'),
                          value: _backdropDismiss,
                          onChanged: (value) {
                            setState(() => _backdropDismiss = value);
                          },
                        ),
                      ],
                      const Divider(),
                      SwitchListTile(
                        title: const Text('Show Drag Indicator'),
                        subtitle: const Text('Visual drag handle'),
                        value: _showDragIndicator,
                        onChanged: (value) {
                          setState(() => _showDragIndicator = value);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Position'),
                        subtitle: SegmentedButton<ModalPosition>(
                          segments: const [
                            ButtonSegment(
                              value: ModalPosition.top,
                              label: Text('Top'),
                              icon: Icon(Icons.arrow_upward),
                            ),
                            ButtonSegment(
                              value: ModalPosition.center,
                              label: Text('Center'),
                              icon: Icon(Icons.center_focus_strong),
                            ),
                            ButtonSegment(
                              value: ModalPosition.bottom,
                              label: Text('Bottom'),
                              icon: Icon(Icons.arrow_downward),
                            ),
                          ],
                          selected: {_position},
                          onSelectionChanged: (Set<ModalPosition> selection) {
                            setState(() => _position = selection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Event Logs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Card(
                  child: _eventLogs.isEmpty
                      ? const Center(
                          child: Text(
                            'No events yet\nInteract with the modal to see logs',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          controller: _logScrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: _eventLogs.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return Text(
                              _eventLogs[index],
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                ),
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
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Modal Content',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _controller.hide(),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 48,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'This demo showcases:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  '🎪 Backdrop Overlay',
                  'Semi-transparent background that can be tapped to dismiss',
                ),
                _buildFeatureItem(
                  '🔔 Event Callbacks',
                  'onShow, onHide, onDragStart, and onDragEnd callbacks',
                ),
                _buildFeatureItem(
                  '📍 Drag Indicator',
                  'Visual handle to indicate draggable areas',
                ),
                _buildFeatureItem(
                  '📏 Custom Width',
                  'Control modal width independently',
                ),
                _buildFeatureItem(
                  '🎯 Center Position',
                  'New center positioning option',
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Tips:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Toggle backdrop to see the difference\n'
                        '• Try different opacity values\n'
                        '• Change positions and see animations\n'
                        '• Watch the event logs in the background',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
