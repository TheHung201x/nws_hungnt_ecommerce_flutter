import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/entities/cart/cart_entity.dart';
import 'package:ecommerce/models/entities/user/user_entity.dart';

abstract class CartRepository {
  Future<String> addToCart({required CartEntity cartEntity});

  Future<List<CartEntity>> getAllCart(UserEntity userEntity);

  Future<void> deleteAllCart(UserEntity userEntity);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<String> addToCart({required CartEntity cartEntity}) async {
    final CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
    try {
      await cartCollection
          .add(cartEntity.toJson())
          .then((value) => print("Cart Added"))
          .catchError((error) => print("Failed to add cart: $error"));
      return '200';
    } catch (e) {
      return 'lỗi: $e';
    }
  }

  @override
  Future<List<CartEntity>> getAllCart(UserEntity userEntity) async {
    final db = FirebaseFirestore.instance;
    List<CartEntity> cartList = [];
    await Future.delayed(const Duration(seconds: 2));
    print('id ${userEntity.id}');
    await db.collection("Cart").where('idUser', isEqualTo: 1).get().then(
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
  Future<void> deleteAllCart(UserEntity userEntity) async {
    CollectionReference cart = FirebaseFirestore.instance.collection('Cart');
    final deleteCards = await cart.where('idUser', isEqualTo: 1).get();
    final futures = deleteCards.docs.map((e) => cart.doc(e.id).delete());
    await Future.wait(futures);
  }
}
