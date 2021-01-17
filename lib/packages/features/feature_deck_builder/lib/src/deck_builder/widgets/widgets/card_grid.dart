import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_duel_disk/packages/core/core_data_manager/core_data_manager_interface/lib/core_data_manager_interface.dart';
import 'package:smart_duel_disk/packages/features/feature_deck_builder/lib/src/deck_builder/deck_builder_viewmodel.dart';
import 'package:smart_duel_disk/packages/ui_components/lib/ui_components.dart';
import 'package:smart_duel_disk/packages/wrappers/wrapper_assets/wrapper_assets_interface/lib/wrapper_assets_interface.dart';

class CardGrid extends StatelessWidget {
  final Iterable<YugiohCard> yugiohCards;

  const CardGrid({
    @required this.yugiohCards,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoScrollGlowBehavior(),
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(AppDimensions.screenMarginSmall),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: AppDimensions.gridMainAxisSpacing,
            crossAxisSpacing: AppDimensions.gridCrossAxisSpacing,
            childAspectRatio: 168 / 246,
          ),
          itemCount: yugiohCards.length,
          itemBuilder: (context, index) {
            return _GridCard(yugiohCard: yugiohCards.elementAt(index));
          },
        ),
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final YugiohCard yugiohCard;

  const _GridCard({
    @required this.yugiohCard,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DeckBuilderViewModel>(context);
    final assetsProvider = Provider.of<AssetsProvider>(context);

    return GestureDetector(
      onTap: () {
        final currentFocus = WidgetsBinding.instance.focusManager.primaryFocus;
        if (currentFocus != null) {
          currentFocus.unfocus();
        }

        vm.onYugiohCardPressed(yugiohCard);
      },
      child: Hero(
        tag: yugiohCard.id,
        child: CachedNetworkImage(
          imageUrl: yugiohCard.imageSmallUrl,
          fit: BoxFit.fitWidth,
          placeholder: (_, __) => ImagePlaceholder(imageAssetId: assetsProvider.cardBack),
          errorWidget: (_, __, dynamic ___) => const ImageError(),
        ),
      ),
    );
  }
}