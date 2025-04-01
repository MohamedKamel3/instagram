import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  static const String routeName = '/error';

  const ErrorPage({super.key, this.errorMessage});
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 3),
          Center(
            child: Column(
              children: [
                Icon(Icons.error_outline, size: 50, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Back to Home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
