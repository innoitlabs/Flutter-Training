import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/features/cart/cart_model.dart';
import 'package:provider_shop/features/cart/widgets/cart_badge.dart';
import 'package:provider_shop/shared/models/product.dart';

void main() {
  group('CartBadge', () {
    late CartModel cartModel;

    setUp(() {
      cartModel = CartModel();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: ChangeNotifierProvider<CartModel>.value(
          value: cartModel,
          child: const Scaffold(
            body: CartBadge(),
          ),
        ),
      );
    }

    testWidgets('should show shopping cart icon', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('should not show badge when cart is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('should show badge with correct count when cart has items', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Add item to cart
      final testProduct = const Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/image.jpg',
        category: 'Test',
      );

      cartModel.addItem(testProduct);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should update badge count when cart changes', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final testProduct = const Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/image.jpg',
        category: 'Test',
      );

      // Add first item
      cartModel.addItem(testProduct);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      // Add second item
      cartModel.addItem(testProduct);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Remove one item
      cartModel.removeItem(testProduct.id);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsNothing);
    });

    testWidgets('should hide badge when cart becomes empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final testProduct = const Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/image.jpg',
        category: 'Test',
      );

      // Add item
      cartModel.addItem(testProduct);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      // Remove item
      cartModel.removeItem(testProduct.id);
      await tester.pump();

      expect(find.text('1'), findsNothing);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('should handle multiple products correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final product1 = const Product(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 10.0,
        imageUrl: 'https://example.com/image1.jpg',
        category: 'Test',
      );

      final product2 = const Product(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 15.0,
        imageUrl: 'https://example.com/image2.jpg',
        category: 'Test',
      );

      // Add two different products
      cartModel.addItem(product1);
      cartModel.addItem(product2);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      // Add more of first product
      cartModel.addItem(product1);
      await tester.pump();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should have correct styling for badge', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final testProduct = const Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/image.jpg',
        category: 'Test',
      );

      cartModel.addItem(testProduct);
      await tester.pump();

      // Find the badge container
      final badgeFinder = find.byType(Container).last;
      final badgeWidget = tester.widget<Container>(badgeFinder);

      // Check that it has the correct constraints
      expect(badgeWidget.constraints, isNotNull);
      expect(badgeWidget.constraints!.minWidth, equals(16));
      expect(badgeWidget.constraints!.minHeight, equals(16));
    });
  });
}
