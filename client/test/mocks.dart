import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}
