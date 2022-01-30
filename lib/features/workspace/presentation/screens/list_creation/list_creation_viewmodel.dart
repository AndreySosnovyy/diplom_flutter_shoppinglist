import 'package:diplom/app/dependencies.dart';
import 'package:diplom/app/navigation/app_router.gr.dart';
import 'package:diplom/features/workspace/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';

class ListCreationViewModel extends ChangeNotifier {
  final router = sl.get<AppRouter>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final productController = TextEditingController();

  final products = <Product>[];

  void backButtonCallback() => router.pop();

  void onSearchChanged(String text) {}
}