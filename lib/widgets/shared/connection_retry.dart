import 'package:flutter/material.dart';

class ConnectionRetryWidget extends StatelessWidget {
  final Future<void> Function(BuildContext) onRetry;
  final String message;

  const ConnectionRetryWidget({
    super.key,
    required this.onRetry,
    this.message = 'Ups, algo salió mal. Por favor, intenta de nuevo.',
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 150.0),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 100,
              color: Colors.grey.withAlpha(150),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withAlpha(150),
              ),
            ),
            const SizedBox(height: 30),
            FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              onPressed: () async => onRetry(context),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: const Icon(Icons.refresh, color: Color.fromARGB(255, 255, 0, 140)),
            ),
          ],
        ),
      ),
    );
}
