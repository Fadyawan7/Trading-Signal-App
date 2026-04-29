import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
import '../viewmodel/trader_inbox_view_model.dart';

class TraderInboxView extends GetView<TraderInboxViewModel> {
  const TraderInboxView({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      {
        'title': 'New Member Joined',
        'message': 'Sarah Johnson joined Crypto Elite Signals',
        'time': '5 min ago',
        'icon': Icons.person_add,
        'unread': true,
      },
      {
        'title': 'Payment Received',
        'message': '\$99 subscription payment from Michael Chen',
        'time': '15 min ago',
        'icon': Icons.attach_money,
        'unread': true,
      },
      {
        'title': 'New Message',
        'message': 'Alex Turner: Great signal! Made 15% profit',
        'time': '1 hour ago',
        'icon': Icons.message_outlined,
        'unread': true,
      },
      {
        'title': 'Group Performance',
        'message': 'Crypto Elite Signals reached 85% success rate this month',
        'time': '2 hours ago',
        'icon': Icons.trending_up,
        'unread': false,
      },
      {
        'title': 'Membership Milestone',
        'message': 'Your group reached 500 members! 🎉',
        'time': '5 hours ago',
        'icon': Icons.person_add_alt_1,
        'unread': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'Stay updated with your trading groups',
              style: TextStyle(color: AppColors.mutedText, fontSize: 10),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        centerTitle: true,
        surfaceTintColor: AppColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: AppColors.text,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Icon(Icons.notifications, size: 18),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 12,
                    height: 12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Mark All Read',
                    icon: Icon(Icons.check, size: 14),
                    onTap: () {},
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: MarketPanel(
                      radius: 12,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.clear, size: 14),
                          SizedBox(width: 6),
                          Text(
                            'Clear All',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...list.map(
              (n) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MarketPanel(
                  radius: 14,
                  color: n['unread']! as bool
                      ? AppColors.primary.withValues(alpha: 0.06)
                      : AppColors.card,
                  borderColor: n['unread']! as bool
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : AppColors.border,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                        ),
                        child: Icon(n['icon']! as IconData),
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
                                    n['title']! as String,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                if (n['unread']! as bool)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              n['message']! as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.mutedText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n['time']! as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
