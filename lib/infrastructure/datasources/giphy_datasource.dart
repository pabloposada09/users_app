import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:users_app/domain/datasources/gifs_datasource.dart';
import 'package:users_app/domain/entities/gif.dart';
import 'package:dio/dio.dart';
import 'package:users_app/infrastructure/mappers/gif_mapper.dart';
import 'package:users_app/infrastructure/models/search_gifs_response.dart';

class GiphyDatasource implements GifsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.giphy.com/v1/gifs',
    queryParameters: {
      'api_key': dotenv.env['GIPHY_KEY'],
      'limit': 20,
    },
  ));

  @override
  Future<List<Gif>> searchGifsByText(String keyword) async {
    try {
      final response = await dio.get('/search', queryParameters: {'q': keyword});

      print(response.data);

      final SearchGifsResponde gifsResponse = SearchGifsResponde.fromJson(response.data);

      final List<Gif> gifsList = gifsResponse.data.map((gif) => GifMapper.gifResponseToEntity(gif)).toList();

      return gifsList;
    } on DioException {
      throw Exception();
    }
  }
}
