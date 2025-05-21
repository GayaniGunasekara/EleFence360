import 'package:flutter_test/flutter_test.dart';
import 'package:notification_interface/main.dart';

void main() {
  testWidgets('Notification titles are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Elephants near the fence!'), findsOneWidget);
    expect(find.text('Electricity issues in the fence.'), findsOneWidget);
    expect(find.text('Fence Damages'), findsOneWidget);
    expect(find.text('Other Emergencies'), findsOneWidget);
  });
}
