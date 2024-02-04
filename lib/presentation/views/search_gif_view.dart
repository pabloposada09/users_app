import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:users_app/presentation/providers/gifs_provider.dart';

class SearchGifView extends ConsumerWidget {
  SearchGifView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextFormField(
              onChanged: (value) {
                ref.read(gifsProvider.notifier).searchGifs(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // Cambia el estilo del borde
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: theme.primary),
                ),
                hintText: 'Buscar Gifs',
                hintStyle: TextStyle(color: theme.primary),
                filled: true,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const Expanded(
            child: _GifsGrid(),
          )
        ],
      ),
    );
  }
}

class _GifsGrid extends ConsumerWidget {
  const _GifsGrid({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context).colorScheme;
    final gifsState = ref.watch(gifsProvider);

    if (gifsState.error != null) {
      return Center(
        child: Text(gifsState.error!.message),
      );
    }

    if (gifsState.isPure) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Busca tus Gifs favoritos",
          style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      );
    }

    if (gifsState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (gifsState.gifs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "No se encontraron resultados :c",
          style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      );
    }

    return SingleChildScrollView(
      child: StaggeredGrid.count(
        axisDirection: AxisDirection.down,
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: gifsState.gifs
            .map(
              (gif) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  gif.url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: gif.height / 2,
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
