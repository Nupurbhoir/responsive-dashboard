import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_dashboard/main.dart';

void main() {
  testWidgets('Responsive Dashboard app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveDashboardApp());

    // App should load successfully.
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Overview'), findsOneWidget);
  });
}
