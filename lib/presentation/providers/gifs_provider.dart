import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/entities/gif.dart';
import 'package:users_app/infrastructure/datasources/giphy_datasource.dart';
import 'package:users_app/infrastructure/errors/custom_error.dart';
import 'package:users_app/infrastructure/repositories/gifs_repository_imp.dart';

final gifsRepositoryProvider = Provider((ref) => GifsRepositoryImp(datasource: GiphyDatasource()));

final gifsProvider = StateNotifierProvider.autoDispose<SearchGifsNotifier, SearchGifsState>((ref) {
  final callback = ref.watch(gifsRepositoryProvider).searchGifsByText;

  return SearchGifsNotifier(loadGifs: callback);
});

typedef LoadGifsCallback = Future<List<Gif>> Function(String keyword);

class SearchGifsNotifier extends StateNotifier<SearchGifsState> {
  final LoadGifsCallback loadGifs;

  SearchGifsNotifier({required this.loadGifs}) : super(SearchGifsState());

  Future<void> searchGifs(String keyword) async {
    try {
      state = state.copyWith(loading: true, isPure: false, error: null);
      final gifs = await loadGifs(keyword);

      state = state.copyWith(
        gifs: gifs,
        loading: false,
        isPure: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: CustomError(message: 'Ups ocurrio un error, intentalo nuevamente'),
        isPure: false,
      );
    }
  }
}

class SearchGifsState {
  final List<Gif> gifs;
  final bool loading;
  final bool isPure;
  CustomError? error;

  SearchGifsState({this.gifs = const [], this.loading = true, this.error, this.isPure = true});

  SearchGifsState copyWith({List<Gif>? gifs, bool? loading, CustomError? error, bool? isPure}) => SearchGifsState(
        gifs: gifs ?? this.gifs,
        loading: loading ?? this.loading,
        isPure: isPure ?? this.isPure,
        error: error,
      );
}
