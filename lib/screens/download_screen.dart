import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jellyflix/components/download_item_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jellyflix/providers/download_provider.dart';
import 'package:jellyflix/services/database_service.dart';
import 'package:jellyflix/services/secure_storage_service.dart';

class DownloadScreen extends HookConsumerWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(AppLocalizations.of(context)!.downloads),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Beta',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_outlined),
            onPressed: () async {
              var settings = DatabaseService('settings', SecureStorageService());
              var currentPath = settings.get('download_directory') ?? 'Not set';
              
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Download Directory'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current directory:'),
                        Text(currentPath, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('To change the download directory:'),
                        const Text('1. Close the app'),
                        const Text('2. Edit config.txt in the app directory'),
                        const Text('3. Restart the app'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.read(getDownloadsProvider),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return DownloadItemTile(itemId: snapshot.data![index]);
              },
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.noDownloads),
            );
          }
        },
      ),
    );
  }
}
