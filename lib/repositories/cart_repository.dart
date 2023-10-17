import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/app_navigator.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:flutter/cupertino.dart';

abstract class CartRepository {
  Future<void> addToCart({required CartEntity cartEntity, required BuildContext context});

  Future<List<CartEntity>> getAllCart(int id);

  Future<void> deleteAllCart(int id);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<void> addToCart({required CartEntity cartEntity, required BuildContext context}) async {
    final CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
    final navigator = AppNavigator(context: context);
    try {
      await cartCollection
          .add(cartEntity.toJson())
          .then((value){
        navigator.showSuccessFlushbar(message: 'You have added the product to your cart');
      }).catchError((error){
        navigator.showErrorFlushbar(message: 'Adding product to cart failed');
      });
    } catch (e) {
      debugPrint('err 00 : $e');
    }
  }

  @override
  Future<List<CartEntity>> getAllCart(int id) async {
    final db = FirebaseFirestore.instance;
    List<CartEntity> cartList = [];
    await Future.delayed(const Duration(seconds: 2));
    await db.collection("Cart").where('idUser', isEqualTo: id).get().then(
      (querySnapshot) {
        querySnapshot.docs.map(
          (e) {
            final cart = CartEntity.fromJson(e.data());
            cartList.add(cart);
          },
        ).toList();
      },
    );

    return cartList;
  }

  @override
  Future<void> deleteAllCart(int id) async {
    CollectionReference cart = FirebaseFirestore.instance.collection('Cart');
    final deleteCards = await cart.where('idUser', isEqualTo: id).get();
    final futures = deleteCards.docs.map((e) => cart.doc(e.id).delete());
    await Future.wait(futures);
  }
}
