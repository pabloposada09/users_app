import 'package:users_app/domain/datasources/gifs_datasource.dart';
import 'package:users_app/domain/entities/gif.dart';
import 'package:users_app/domain/repositories/gifs_repository.dart';

class GifsRepositoryImp implements GifsRepository {
  GifsDatasource datasource;

  GifsRepositoryImp({required this.datasource});

  @override
  Future<List<Gif>> searchGifsByText(String keyword) => datasource.searchGifsByText(keyword);
}
