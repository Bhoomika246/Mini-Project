import 'package:flutter_test/flutter_test.dart';
import 'package:raitha_mithra/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RaithaMithraApp());
    expect(find.text('Raitha Mithra Login - Coming Soon'), findsOneWidget);
  });
}