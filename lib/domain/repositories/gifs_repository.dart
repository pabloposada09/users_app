import 'package:users_app/domain/entities/gif.dart';

abstract class GifsRepository {
  Future<List<Gif>> searchGifsByText(String keyword);
}
