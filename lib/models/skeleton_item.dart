import 'package:built_collection/built_collection.dart';
import 'package:tentacle/tentacle.dart';

class SkeletonItem {
  static generateBlurHashes() {
    BaseItemDtoImageBlurHashesBuilder blurhashes =
        BaseItemDtoImageBlurHashesBuilder();
    blurhashes.backdrop = MapBuilder({
      "0": "L5H2EC=PM+yV0g-mq.wG9GofR*of",
    });
    blurhashes.primary = MapBuilder({
      "0": "L5H2EC=PM+yV0g-mq.wG9GofR*of",
    });
    blurhashes.banner = MapBuilder({
      "0": "L5H2EC=PM+yV0g-mq.wG9GofR*of",
    });
    return blurhashes;
  }

  static final BaseItemDto baseItemDto = BaseItemDto((p0) => p0
    ..name = 'Captain America: The Winter Soldier'
    ..overview =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. adipiscing elit. quisque vitae nisi vitae nisi'
    ..genres = ListBuilder<String>()
    ..communityRating = 5.5
    ..officialRating = 'FSK-18'
    ..productionYear = 2100
    ..backdropImageTags = ListBuilder<String>()
    ..imageBlurHashes = generateBlurHashes()
    ..id = 'abcdefc-1234-5678-9012-abcdefabcdef'
    ..imageTags = MapBuilder<String, String>()
    ..people = ListBuilder<BaseItemPerson>()
    ..episodeTitle = 'Episode 1'
    ..seasonName = 'Season 1'
    ..seasonId = 'abcdefc-1234-5678-9012-abcdefabcdef'
    ..seriesName = 'Series 1'
    ..seriesId = 'abcdefc-1234-5678-9012-abcdefabcdef'
    ..mediaSources = ListBuilder<MediaSourceInfo>());
}
