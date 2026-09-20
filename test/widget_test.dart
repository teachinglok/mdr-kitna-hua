import 'package:flutter_test/flutter_test.dart';
import 'package:merchant_calculator/app/app.dart';

void main() {
  testWidgets('MDR Kitna Hua app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MDRKitnaHuaApp());

    expect(find.text('MDR Kitna Hua'), findsOneWidget);
  });
}