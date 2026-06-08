import 'package:flutter/material.dart';

class ConnectionRetryWidget extends StatelessWidget {
  final void Function(BuildContext) onRetry;
  final bool internetStatus;
  final String lackInternetMessage;
  final String genericErrorMessage;

  const ConnectionRetryWidget({
    super.key,
    required this.onRetry,
    required this.internetStatus,
    required this.lackInternetMessage,
    required this.genericErrorMessage,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 150.0),
      child: Center(
        child: Column(
          children: [
            Icon(
              internetStatus ? Icons.car_crash_sharp : Icons.wifi_off_rounded,
              size: 100,
              color: Colors.grey.withAlpha(150),
            ),
            const SizedBox(height: 10),
            Text(
              !internetStatus ? lackInternetMessage : genericErrorMessage,
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
