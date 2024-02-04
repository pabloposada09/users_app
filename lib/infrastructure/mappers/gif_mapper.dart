import 'package:users_app/domain/entities/gif.dart';
import 'package:users_app/infrastructure/models/search_gifs_response.dart';

class GifMapper {
  static Gif gifResponseToEntity(GifResponse gifData) => Gif(
        url: gifData.images.downsizedMedium.url,
        title: gifData.title,
        height: double.parse(gifData.images.downsizedMedium.height),
      );
}
