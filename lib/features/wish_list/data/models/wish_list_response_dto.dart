import 'package:route_e_commerce_v2/features/commerce/data/models/product_list_model/pageable_product_response_dto.dart';

class WishListResponseDto {
  WishListResponseDto({
      this.status, 
      this.count, 
      this.data,});

  WishListResponseDto.fromJson(dynamic json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDto.fromJson(v));
      });
    }
  }
  String? status;
  num? count;
  List<ProductDto>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

