import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text("Error", style: TextTheme.of(context).labelLarge),
            ],
          ),
          content: Text(message, style: TextTheme.of(context).bodyMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          actions: [
            TextButton(
              child: Text(
                "Close",
                style: TextTheme.of(
                  context,
                ).labelMedium?.copyWith(color: Colors.deepPurple),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}
