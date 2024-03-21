import 'package:flutter/material.dart';
import 'package:live_football_stats/core/utils/common_method.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

class PreviewContentWidget extends StatelessWidget {
  PreviewContentWidget({super.key, required this.matchPreview});
  MatchPreview matchPreview;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "Preview content",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 7, top: 5, left: 15, right: 15),
              child: Text(
                matchPreview.previewContent[index - 1].content,
                maxLines: null,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: CommonMethods.isHeadingContent(
                            matchPreview.previewContent[index - 1].content)
                        ? 18
                        : 16,
                    fontWeight: CommonMethods.isHeadingContent(
                            matchPreview.previewContent[index - 1].content)
                        ? FontWeight.bold
                        : FontWeight.w500),
              ),
            );
          }
        }, childCount: matchPreview.previewContent.length + 1),
      ),
    );
  }
}
