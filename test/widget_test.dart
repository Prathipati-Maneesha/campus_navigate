import 'package:flutter_test/flutter_test.dart';

import 'package:campus_navigate/main.dart';

void main() {
  testWidgets('app loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NaviGateApp());

    expect(find.text('NaviGate • LBRCE'), findsOneWidget);
    expect(find.text('Campus Blocks'), findsOneWidget);
  });
}
