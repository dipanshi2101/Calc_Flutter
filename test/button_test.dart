import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calc/main.dart';

void main() {
  testWidgets("computations", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CalcApp()));
    //var textField = find.byType(Text);
    //expect(textField, findsOneWidget);
    //await tester.enterText(textField, '');
    //expect(find.text(''), findsOneWidget);
    //var button = find.byElementType();
    //expect(button, findsOneWidget);
    var buttonFinder = find.byKey(Key('output'));

    var button = find.text("1");
    await tester.tap(button);
    await tester.tap(find.text('+'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('='));
    await tester.pump();
    var text1 = buttonFinder.evaluate().single.widget as Text;
    // print(text1.data);
    expect(text1.data, '3');
  });

  //expect(find.text('1+2'), findsOneWidget);
  //expect(find.text('3'), findsOneWidget);
  // });
}
