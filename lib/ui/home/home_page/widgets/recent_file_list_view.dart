import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/providers/recent_file_notifier.dart';
import 'package:note_sharing_project/ui/home/home_page/widgets/home_page_caroucel.dart';

class RecentFileLitView extends ConsumerStatefulWidget {
  const RecentFileLitView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RecentFileLitView> createState() => _RecentFileLitViewState();
}

class _RecentFileLitViewState extends ConsumerState<RecentFileLitView> {
  @override
  void initState() {
    ref.read(recentFileNotifierProvider).getRecentFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recentFileList = ref.watch(recentFileNotifierProvider).recentFileList;
    if (recentFileList.isEmpty) {
      return const Center(
        child: Text("No Recent Files Found."),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recentFileList.length,
      itemBuilder: ((context, index) {
        return FolderHorizontalCard(
          subject: recentFileList[index],
        );
      }),
    );
  }
}
