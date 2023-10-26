import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:flutter/foundation.dart';

abstract class CartRepository {
  Future<void> addToCart(
      {required CartEntity cartEntity});

  Future<List<CartEntity>> getAllCart(int id);

  Future<void> deleteAllCart(int id);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<void> addToCart(
      {required CartEntity cartEntity,}) async {
    await Future.delayed(const Duration(seconds: 2));
    final CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
      await cartCollection.add(cartEntity.toJson()).then((value) {
        if(kDebugMode){
          print('add to cart success');
        }
      }).catchError((error) {
        if(kDebugMode){
          print('add to cart fail');
        }
      });
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
