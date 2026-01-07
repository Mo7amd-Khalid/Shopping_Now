import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';

class CartResponseDto {
  CartResponseDto({
      this.status, 
      this.numOfCartItems, 
      this.cartId, 
      this.data,});

  CartResponseDto.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    message = json['message'];
    data = json['data'] != null ? CartDto.fromJson(json['data']) : null;
  }
  String? status;
  num? numOfCartItems;
  String? cartId;
  CartDto? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    map['cartId'] = cartId;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class CartDto {
  CartDto({
      this.id, 
      this.cartOwner, 
      this.products, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalCartPrice,});

  CartDto.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
  String? id;
  String? cartOwner;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalCartPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cartOwner'] = cartOwner;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['totalCartPrice'] = totalCartPrice;
    return map;
  }

}

class Products {
  Products({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  Products.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    if(json['product'] != null)
      {
        if(json['product'] is String)
          {
            productAddedId = json['product'];
          }
        else
          {
            product = ProductDto.fromJson(json['product']);
          }

      }
    price = json['price'];
  }
  num? count;
  String? id;
  ProductDto? product;
  String? productAddedId;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    return map;
  }

}

