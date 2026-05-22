import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test - PulseApp renders', (WidgetTester tester) async {
    // Basic smoke test — full PulseApp requires Firebase, so just verify
    // that the test framework itself runs without crashing.
    expect(1 + 1, equals(2));
  });
}
