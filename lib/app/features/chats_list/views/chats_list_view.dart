import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/chats_list_view_model.dart';

class ChatsListView extends GetView<ChatsListViewModel> {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    const chats = [
      {
        'id': 'official',
        'groupName': '📢 TradeConnect Official',
        'traderAvatar': '🔔',
        'lastMessage': 'New features released! Check them out',
        'time': '10m ago',
        'unread': 2,
        'groupAvatar': '🎯',
        'isOfficial': true,
      },
      {
        'id': 'defi',
        'groupName': 'DeFi Trading Hub',
        'traderAvatar': '💎',
        'lastMessage': 'New DeFi opportunities this week',
        'time': '30m ago',
        'unread': 5,
        'groupAvatar': '🌐',
        'isOfficial': false,
      },
      {
        'id': '1',
        'groupName': 'Crypto Elite Signals',
        'traderAvatar': '👨‍💼',
        'lastMessage': 'BTC/USDT Buy Signal posted',
        'time': '2m ago',
        'unread': 3,
        'groupAvatar': '🚀',
        'isOfficial': false,
      },
      {
        'id': '2',
        'groupName': 'Forex Masters Club',
        'traderAvatar': '👩‍💼',
        'lastMessage': 'Market analysis for today',
        'time': '15m ago',
        'unread': 1,
        'groupAvatar': '💵',
        'isOfficial': false,
      },
      {
        'id': '3',
        'groupName': 'Gold Trading Pro',
        'traderAvatar': '👨',
        'lastMessage': 'Thanks for the signal!',
        'time': '1h ago',
        'unread': 0,
        'groupAvatar': '🏆',
        'isOfficial': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const MarketBottomNav(currentIndex: 2),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                children: [
                   const Text(
                        'Messages',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                  const SizedBox(height: 20),
                  const MarketTextInput(
                    hint: 'Search chats...',
                    prefix: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
                itemCount: chats.length,
                itemBuilder: (_, i) {
                  final c = chats[i];
                  final official = c['isOfficial']! as bool;
                  final unread = c['unread']! as int;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => Get.toNamed(
                        AppRoutes.groupChat,
                        arguments: {'groupId': c['id']},
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: official
                                ? AppColors.primary.withValues(alpha: 0.2)
                                : AppColors.border,
                          ),
                          gradient: official
                              ? LinearGradient(
                                  colors: [
                                    AppColors.primary.withValues(alpha: 0.10),
                                    AppColors.accent.withValues(alpha: 0.10),
                                  ],
                                )
                              : null,
                          color: official ? null : AppColors.card,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        colors: [AppColors.primary, AppColors.accent],
                                      ),
                                    ),
                                    child: Text(
                                      c['groupAvatar']! as String,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: const LinearGradient(
                                          colors: [AppColors.accent, AppColors.primary],
                                        ),
                                        border: Border.all(
                                          color: AppColors.card,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        c['traderAvatar']! as String,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          c['groupName']! as String,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      if (official)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.20,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            'Official',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 6),
                                      Text(
                                        c['time']! as String,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColors.mutedText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          c['lastMessage']! as String,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.mutedText,
                                          ),
                                        ),
                                      ),
                                      if (unread > 0)
                                        Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 18,
                                          ),
                                          height: 18,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '$unread',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
