import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('App boots to login route', (WidgetTester tester) async {
    await tester.pumpWidget(const TradingGroupsApp());
    await tester.pumpAndSettle();

    expect(find.text('TradeConnect'), findsOneWidget);
  });
}
