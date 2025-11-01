import 'package:flutter/material.dart';
import 'package:interactive_modal/interactive_modal.dart';

/// Simple example showing basic usage of InteractiveModal
void main() {
  runApp(const SimpleExampleApp());
}

/// Standalone app wrapper (only used when running this file directly)
class SimpleExampleApp extends StatelessWidget {
  const SimpleExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Interactive Modal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SimplePage(),
    );
  }
}

/// The actual example page
class SimplePage extends StatefulWidget {
  const SimplePage({super.key});

  @override
  State<SimplePage> createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  final InteractiveModalController _controller = InteractiveModalController();
  int _backgroundCounter = 0;
  int _modalCounter = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interactive Modal'),
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
          position: ModalPosition.top),
      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isVisible) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton(
            onPressed: () => _controller.show(),
            child: const Icon(Icons.open_in_new),
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
          colors: [Colors.blue[300]!, Colors.purple[300]!],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Interactive Background',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Counter: $_backgroundCounter',
              style: const TextStyle(fontSize: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _backgroundCounter++;
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Increment Background'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Try opening the modal and interacting\nwith both the modal and this background!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalContent() {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Modal Controls',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _controller.hide(),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              'Modal Counter: $_modalCounter',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _modalCounter++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _modalCounter = 0;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Notice how you can interact with both\nthe modal and the background simultaneously!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      )
    ]);
  }
}
