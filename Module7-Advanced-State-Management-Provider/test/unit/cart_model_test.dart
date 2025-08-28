import 'package:flutter_test/flutter_test.dart';
import 'package:provider_shop/features/cart/cart_model.dart';
import 'package:provider_shop/shared/models/product.dart';

void main() {
  group('CartModel', () {
    late CartModel cartModel;
    late Product testProduct;

    setUp(() {
      cartModel = CartModel();
      testProduct = const Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'https://example.com/image.jpg',
        category: 'Test',
      );
    });

    group('Initial state', () {
      test('should start with empty cart', () {
        expect(cartModel.items, isEmpty);
        expect(cartModel.itemCount, equals(0));
        expect(cartModel.totalPrice, equals(0.0));
        expect(cartModel.isEmpty, isTrue);
        expect(cartModel.isNotEmpty, isFalse);
      });
    });

    group('Adding items', () {
      test('should add new item to cart', () {
        cartModel.addItem(testProduct);

        expect(cartModel.items.length, equals(1));
        expect(cartModel.itemCount, equals(1));
        expect(cartModel.totalPrice, equals(10.0));
        expect(cartModel.isEmpty, isFalse);
        expect(cartModel.isNotEmpty, isTrue);
      });

      test('should increment quantity when adding same product', () {
        cartModel.addItem(testProduct);
        cartModel.addItem(testProduct);

        expect(cartModel.items.length, equals(1));
        expect(cartModel.itemCount, equals(2));
        expect(cartModel.totalPrice, equals(20.0));
        expect(cartModel.getQuantity(testProduct.id), equals(2));
      });

      test('should handle multiple different products', () {
        final product2 = const Product(
          id: '2',
          name: 'Test Product 2',
          description: 'Test Description 2',
          price: 15.0,
          imageUrl: 'https://example.com/image2.jpg',
          category: 'Test',
        );

        cartModel.addItem(testProduct);
        cartModel.addItem(product2);

        expect(cartModel.items.length, equals(2));
        expect(cartModel.itemCount, equals(2));
        expect(cartModel.totalPrice, equals(25.0));
        expect(cartModel.getQuantity(testProduct.id), equals(1));
        expect(cartModel.getQuantity(product2.id), equals(1));
      });
    });

    group('Removing items', () {
      test('should remove item when quantity becomes zero', () {
        cartModel.addItem(testProduct);
        cartModel.removeItem(testProduct.id);

        expect(cartModel.items, isEmpty);
        expect(cartModel.itemCount, equals(0));
        expect(cartModel.totalPrice, equals(0.0));
      });

      test('should decrement quantity when removing item with quantity > 1', () {
        cartModel.addItem(testProduct);
        cartModel.addItem(testProduct);
        cartModel.removeItem(testProduct.id);

        expect(cartModel.items.length, equals(1));
        expect(cartModel.itemCount, equals(1));
        expect(cartModel.totalPrice, equals(10.0));
        expect(cartModel.getQuantity(testProduct.id), equals(1));
      });

      test('should do nothing when removing non-existent item', () {
        cartModel.removeItem('non-existent');

        expect(cartModel.items, isEmpty);
        expect(cartModel.itemCount, equals(0));
      });
    });

    group('Setting quantity', () {
      test('should set quantity for existing item', () {
        cartModel.addItem(testProduct);
        cartModel.setQuantity(testProduct.id, 3);

        expect(cartModel.getQuantity(testProduct.id), equals(3));
        expect(cartModel.totalPrice, equals(30.0));
      });

      test('should remove item when quantity is zero or negative', () {
        cartModel.addItem(testProduct);
        cartModel.setQuantity(testProduct.id, 0);

        expect(cartModel.items, isEmpty);
        expect(cartModel.getQuantity(testProduct.id), equals(0));
      });

      test('should do nothing when setting quantity for non-existent item', () {
        cartModel.setQuantity('non-existent', 5);

        expect(cartModel.items, isEmpty);
        expect(cartModel.getQuantity('non-existent'), equals(0));
      });
    });

    group('Clearing cart', () {
      test('should clear all items', () {
        cartModel.addItem(testProduct);
        cartModel.clear();

        expect(cartModel.items, isEmpty);
        expect(cartModel.itemCount, equals(0));
        expect(cartModel.totalPrice, equals(0.0));
      });
    });

    group('Checkout', () {
      test('should return error when cart is empty', () async {
        final result = await cartModel.checkout();

        expect(result.isError, isTrue);
        expect(result.errorMessage, equals('Cart is empty'));
      });

      test('should return success with order ID when cart has items', () async {
        cartModel.addItem(testProduct);
        final result = await cartModel.checkout();

        expect(result.isSuccess, isTrue);
        expect(result.data, isNotNull);
        expect(result.data!.startsWith('ORDER-'), isTrue);
      });

      test('should clear cart after successful checkout', () async {
        cartModel.addItem(testProduct);
        await cartModel.checkout();

        expect(cartModel.items, isEmpty);
        expect(cartModel.itemCount, equals(0));
      });
    });
  });
}
