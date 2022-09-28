import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class HomeRepository {
  HomeRepository({required this.secureStorage});
  final SecureStorage secureStorage;
  Future<String?> fetchUserName() async {
    var name = await secureStorage.read(key: "userName");
    return name;
  }
}

final homeRepositoryProvider = Provider.autoDispose<HomeRepository>(
    (ref) => HomeRepository(secureStorage: SecureStorage()));
final fetchUserNameProvider = FutureProvider.autoDispose<String?>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.fetchUserName();
});
