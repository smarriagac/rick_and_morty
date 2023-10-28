import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/character/character.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../global/extensions/widgets.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Result;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              data.name,
              style: context.textTheme.titleLarge,
            ),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: data.image,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                      child: SizedBox(
                        width: context.wd,
                        child: ExtendedImage.network(
                          data.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(15).copyWith(bottom: 10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            stops: [
                              0.2,
                              0.6,
                              1,
                            ],
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                              Colors.black45,
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 60.0,
            delegate: SliverChildListDelegate(
              [
                ItemsDescription(
                  title: 'Nombre',
                  content: data.name,
                ),
                ItemsDescription(
                  title: 'Género',
                  content: data.gender,
                ),
                ItemsDescription(
                  title: 'Ubicación',
                  content: data.location.name,
                ),
                ItemsDescription(
                  title: 'Especie',
                  content: data.species,
                ),
                ItemsDescription(
                  title: 'Estado',
                  content: data.status,
                ),
                ItemsDescription(
                  title: 'Origen',
                  content: data.origin.name,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10).asSliveToBoxAdapter,
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Episodios',
              style: context.textTheme.labelLarge,
            ),
          ).asSliveToBoxAdapter,
          const SizedBox(height: 10).asSliveToBoxAdapter,
          SliverList.builder(
            itemCount: data.episode.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  data.episode[i],
                  style: context.textTheme.titleMedium,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemsDescription extends StatelessWidget {
  const ItemsDescription({
    super.key,
    this.title = '',
    this.content = '',
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.labelLarge,
          ),
          Text(
            content,
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
