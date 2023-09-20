import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/word/presentation/controllers/word_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dictionary_words/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.testMode = true;
  });

  testWidgets('Teste de rolagem infinita na tab de Words.',
      (WidgetTester tester) async {
    app.main();

    const rpScroll = 5;

    // Tempo para abrir a Home
    await tester.pumpAndSettle(const Duration(milliseconds: 1500));

    for (var i = 0; i < rpScroll; i++) {
      await tester.drag(find.byType(WillPopScope), Offset(0, -Get.height));
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await tester.pumpAndSettle();

    final homeController = Get.find<HomeController>();

    String text = homeController.testCurrentWordScrol;

    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Verifica se uma palavra abre uma página e possui informações.',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    const word = 'a';

    await tester.pumpAndSettle(const Duration(milliseconds: 1500));

    await tester.tap(find.byKey(const Key(word)));

    await tester.pumpAndSettle();

    final homeController = Get.find<HomeController>();

    await tester.pumpAndSettle();

    if (homeController.testCurrentWordOpen != null) {
      if (homeController.testCurrentWordOpen!.results != null) {
        if (homeController.testCurrentWordOpen!.results![0].definition !=
            null) {
          expect(
              find.text(
                  homeController.testCurrentWordOpen!.results![0].definition!),
              findsOneWidget);
        }
      }
      if (homeController.testCurrentWordOpen!.pronunciation != null) {
        expect(
            find.text(homeController.testCurrentWordOpen!.pronunciation!.all!),
            findsOneWidget);
      }
    }
    await tester.pumpAndSettle();
  });

  testWidgets('Verifica Funcionalidade de favoritar.',
      (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    const word = 'a';
    // Fazendo Login com uma conta existente
    const email = 'teste@gmail.com'; //Email já cadastrado
    const password = '*123Abcd'; //senha

    await tester.pumpAndSettle(const Duration(milliseconds: 1500));

    await tester.pumpAndSettle();

    final homeController = Get.find<HomeController>();

    if (homeController.auth!.currentUser == null) {
      await tester.tap(find.text('Favorites'));

      await tester.pumpAndSettle();

      await tester.tap(find.text('SingIn/SingUp'));

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('email')), email);

      await tester.enterText(find.byKey(const Key('password')), password);

      await tester.pumpAndSettle();

      await tester.tap(find.text('Entrar'));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('home_tab')));

      await tester.pumpAndSettle();
    }

    await tester.tap(find.byKey(const Key(word)));

    await tester.pumpAndSettle();

    final wordController = Get.find<WordController>();

    if (wordController.isFavorit) {
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));

      await tester.pumpAndSettle();

      await tester.tap(find.text('Favorites'));

      await tester.pumpAndSettle();

      expect(find.text(word), findsNothing);
    } else {
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));

      await tester.pumpAndSettle();

      await tester.tap(find.text('Favorites'));

      await tester.pumpAndSettle();

      expect(find.text(word), findsOneWidget);
    }
    await tester.pumpAndSettle();
  });

  testWidgets('Verifica Funcionalidade de cache.', (WidgetTester tester) async {
    app.main();

    const word = 'a';
    await tester.pumpAndSettle();

    await tester.pumpAndSettle(const Duration(milliseconds: 1500));

    await tester.tap(find.byKey(const Key(word)));

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.close));

    await tester.pumpAndSettle();

    await tester.tap(find.text('History'));

    await tester.pumpAndSettle();

    expect(find.text(word), findsOneWidget);
  });
}
