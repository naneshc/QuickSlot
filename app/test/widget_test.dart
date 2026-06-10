import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quickslot_app/core/widgets/loading_widget.dart';

void main() {
  testWidgets('QuickLoadingWidget displays loading message and spinner', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QuickLoadingWidget(message: 'Loading venues...'),
        ),
      ),
    );

    // Verify that the message text is displayed
    expect(find.text('Loading venues...'), findsOneWidget);
    
    // Verify that the circular indicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
