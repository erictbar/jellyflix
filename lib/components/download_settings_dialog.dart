import 'package:flutter/material.dart';
import 'package:tentacle/tentacle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadSettingsDialog extends StatelessWidget {
  final BaseItemDto item;

  const DownloadSettingsDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final audioList = item.mediaSources![0].mediaStreams!
        .where((element) => element.type == MediaStreamType.audio)
        .toList();

    List<MediaStream> subtitleList = [
      MediaStream(
        (b) {
          b
            ..index = -1
            ..displayTitle = "None";
        },
      )
    ];

    subtitleList += item.mediaSources![0].mediaStreams!
        .where((element) => element.type == MediaStreamType.subtitle)
        .toList();

    MediaStream selectedAudio = audioList.first;
    MediaStream selectedSubtitle = subtitleList.first;

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.setAudioAndSubtitleLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          if (audioList.length > 1)
            DropdownMenu<int>(
              expandedInsets: EdgeInsets.zero,
              enableSearch: false,
              enableFilter: false,
              requestFocusOnTap: false,
              leadingIcon: const Icon(Icons.audiotrack),
              initialSelection: audioList.first.index!,
              label: Text(AppLocalizations.of(context)!.audio),
              dropdownMenuEntries: audioList
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e.index!,
                      labelWidget: Text(
                        e.displayTitle ?? AppLocalizations.of(context)!.none,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      label:
                          e.displayTitle ?? AppLocalizations.of(context)!.none,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                selectedAudio =
                    audioList.firstWhere((element) => element.index == value);
              },
            ),
          const SizedBox(height: 20),
          if (subtitleList.isNotEmpty)
            DropdownMenu<int>(
              expandedInsets: EdgeInsets.zero,
              enableSearch: false,
              enableFilter: false,
              requestFocusOnTap: false,
              leadingIcon: const Icon(Icons.subtitles_outlined),
              initialSelection: subtitleList.first.index!,
              label: Text(AppLocalizations.of(context)!.subtitles),
              dropdownMenuEntries: subtitleList
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e.index!,
                      labelWidget: Text(
                        e.displayTitle ?? AppLocalizations.of(context)!.none,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      label:
                          e.displayTitle ?? AppLocalizations.of(context)!.none,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                selectedSubtitle = subtitleList
                    .firstWhere((element) => element.index == value);
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, (null, null));
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
                context, (selectedAudio.index, selectedSubtitle.index));
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
