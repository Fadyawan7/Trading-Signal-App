import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_bottom_nav.dart';
import '../viewmodel/chats_list_view_model.dart';

class ChatsListView extends GetView<ChatsListViewModel> {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'id': 'official',
        'groupName': 'TradeConnect Official',
        'lastMessage': 'New features released! Check them out',
        'time': '10m ago',
        'unread': 2,
        'groupIcon': Icons.track_changes_rounded,
        'initials': 'TC',
        'isOfficial': true,
      },
      {
        'id': 'defi',
        'groupName': 'DeFi Trading Hub',
        'lastMessage': 'New DeFi opportunities this week',
        'time': '30m ago',
        'unread': 5,
        'groupIcon': Icons.public_rounded,
        'initials': 'AT',
        'isOfficial': false,
      },
      {
        'id': '1',
        'groupName': 'Crypto Elite Signals',
        'lastMessage': 'BTC/USDT Buy Signal posted',
        'time': '2m ago',
        'unread': 3,
        'groupIcon': Icons.rocket_launch_rounded,
        'initials': 'JM',
        'isOfficial': false,
      },
      {
        'id': '2',
        'groupName': 'Forex Masters Club',
        'lastMessage': 'Market analysis for today',
        'time': '15m ago',
        'unread': 1,
        'groupIcon': Icons.payments_rounded,
        'initials': 'SC',
        'isOfficial': false,
      },
      {
        'id': '3',
        'groupName': 'Gold Trading Pro',
        'lastMessage': 'Thanks for the signal!',
        'time': '1h ago',
        'unread': 0,
        'groupIcon': Icons.emoji_events_rounded,
        'initials': 'MJ',
        'isOfficial': false,
      },
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        bottomNavigationBar: const MarketBottomNav(currentIndex: 2),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.backgroundSecondary,
                      AppColors.background,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const _Header(),
                  const SizedBox(height: 12),
                  const _SearchBar(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final c = chats[index];
                        return _ChatCard(
                          name: c['groupName'] as String,
                          lastMessage: c['lastMessage'] as String,
                          time: c['time'] as String,
                          unread: c['unread'] as int,
                          icon: c['groupIcon'] as IconData,
                          initials: c['initials'] as String,
                          isOfficial: c['isOfficial'] as bool,
                          onTap: () => Get.toNamed(
                            AppRoutes.groupChat,
                            arguments: {'groupId': c['id']},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          'Messages',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.mutedText, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                style: TextStyle(color: AppColors.text, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search chats...',
                  hintStyle: TextStyle(color: AppColors.mutedText, fontSize: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final IconData icon;
  final String initials;
  final bool isOfficial;
  final VoidCallback onTap;

  const _ChatCard({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.icon,
    required this.initials,
    required this.isOfficial,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isOfficial ? AppColors.primary.withValues(alpha: 0.3) : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Icon(icon, color: AppColors.primary, size: 24),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isOfficial) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.auto_awesome, color: Color(0xFF14B8A6), size: 10),
                                SizedBox(width: 4),
                                Text(
                                  'Official',
                                  style: TextStyle(
                                    color: Color(0xFF14B8A6),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: TextStyle(
                            color: AppColors.mutedText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (unread > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$unread',
                              style: TextStyle(
                                color: AppColors.buttonText,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
  }
}
