import 'package:users_app/domain/entities/gif.dart';

abstract class GifsDatasource {
  Future<List<Gif>> searchGifsByText(String keyword);
}
