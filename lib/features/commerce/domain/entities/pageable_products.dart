import 'package:E_Commerce/features/commerce/domain/entities/product.dart';

class PageableProducts {

  int currentPage;
  int numOfPages;
  List<Product> products;

  PageableProducts({
    required this.currentPage,
    required this.numOfPages,
    required this.products,
  });


}