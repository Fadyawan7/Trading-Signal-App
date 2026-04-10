import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/group_chat_view_model.dart';

class GroupChatView extends GetView<GroupChatViewModel> {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GroupChatBody();
  }
}

class _GroupChatBody extends StatefulWidget {
  const _GroupChatBody();

  @override
  State<_GroupChatBody> createState() => _GroupChatBodyState();
}

class _GroupChatBodyState extends State<_GroupChatBody> {
  bool isChatEnabled = true;
  bool isAdmin = true;
  bool showSettings = false;
  final TextEditingController _chatController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'id': 1,
      'type': 'text',
      'sender': 'John Martinez',
      'avatar': '👨‍💼',
      'message': 'Good morning everyone! Ready for today\'s market analysis.',
      'time': '09:00 AM',
      'isTrader': true,
    },
    {
      'id': 2,
      'type': 'signal',
      'sender': 'John Martinez',
      'avatar': '👨‍💼',
      'action': 'BUY',
      'pair': 'BTC/USDT',
      'entry': '42,500 - 42,800',
      'tp': ['43,500', '44,200', '45,000'],
      'sl': '41,800',
      'leverage': '5x',
      'votes': {'tpHit': 45, 'slHit': 8, 'targetAchieved': 32},
      'time': '09:15 AM',
      'isTrader': true,
    },
    {
      'id': 3,
      'type': 'text',
      'sender': 'Alex Smith',
      'avatar': '👤',
      'message': 'Thanks for the signal! Just entered at 42,650',
      'time': '09:20 AM',
      'isTrader': false,
    },
  ];

  void vote(int id, String key) {
    setState(() {
      final idx = messages.indexWhere((m) => m['id'] == id);
      if (idx == -1) return;
      final v = Map<String, dynamic>.from(
        messages[idx]['votes'] as Map<String, dynamic>,
      );
      v[key] = (v[key] as int) + 1;
      messages[idx] = {...messages[idx], 'votes': v};
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  String _nowLabel() {
    final now = TimeOfDay.now();
    final hour12 = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour12:$minute $period';
  }

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'id': (messages.last['id'] as int) + 1,
        'type': 'text',
        'sender': 'You',
        'avatar': '🙂',
        'message': text,
        'time': _nowLabel(),
        'isTrader': false,
      });
      _chatController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSafeInset = MediaQuery.paddingOf(context).bottom;
    final composerBottomInset = keyboardInset > 0
        ? keyboardInset
        : bottomSafeInset;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoutes.chats),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Stack(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.accent],
                              ),
                            ),
                            child: const Text(
                              '🚀',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
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
                              child: const Text(
                                '👨‍💼',
                                style: TextStyle(fontSize: 9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Crypto Elite Signals',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'John Martinez • 850 members',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isAdmin)
                      GestureDetector(
                        onTap: () =>
                            setState(() => showSettings = !showSettings),
                        child: Icon(
                          Icons.settings,
                          size: 20,
                          color: AppColors.mutedText,
                        ),
                      ),
                  ],
                ),
                if (showSettings && isAdmin) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isChatEnabled ? Icons.lock_open : Icons.lock,
                          color: isChatEnabled ? Colors.green : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Member Chat',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                isChatEnabled
                                    ? 'Members can send messages'
                                    : 'Only admins can send messages',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.mutedText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale:
                              0.7, // 👈 size decrease (0.6 = smaller, 0.8 = medium)
                          child: Switch(
                            value: isChatEnabled,
                            onChanged: (v) => setState(() => isChatEnabled = v),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];
                final isSignal = m['type'] == 'signal';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                        ),
                        child: Text(m['avatar'] as String),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  m['sender'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (m['isTrader'] == true) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.accent,
                                        ],
                                      ),
                                    ),
                                    child: const Text(
                                      'Trader',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                const SizedBox(width: 6),
                                Text(
                                  m['time'] as String,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.mutedText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            if (!isSignal)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  m['message'] as String,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              )
                            else
                              _SignalCard(message: m, onVote: vote),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: composerBottomInset),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              // decoration: BoxDecoration(
              //   color: AppColors.card,
              //   border: Border(top: BorderSide(color: AppColors.border)),
              // ),
              child: isChatEnabled || isAdmin
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                              //   Icon(
                              //     Icons.sentiment_satisfied_alt,
                              //     size: 21,
                              //     color: AppColors.mutedText,
                              //   ),
                              //  const SizedBox(width: 6),
                                Expanded(
                                  child: TextField(
                                    
                                    controller: _chatController,
                                    onChanged: (_) => setState(() {}),
                                    onSubmitted: (_) => _sendMessage(),
                                    textInputAction: TextInputAction.send,
                                    style: const TextStyle(fontSize: 14),
                                    
                                   decoration: InputDecoration(
  hintText: 'Type a message',
  filled: true,
  fillColor: AppColors.secondary,
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(60),
      bottomLeft: Radius.circular(60),
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(60),
      bottomLeft: Radius.circular(60),
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(60),
      bottomLeft: Radius.circular(60),
    ),
  ),
  isDense: true,
  hintStyle: const TextStyle(color: AppColors.mutedText),
)

                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.attach_file,
                                  size: 20,
                                  color: AppColors.mutedText,
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: AppColors.mutedText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: _sendMessage,
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [AppColors.primary, AppColors.accent],
                              ),
                            ),
                            child: Icon(
                              _chatController.text.trim().isEmpty
                                  ? Icons.chat
                                  : Icons.send,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 14,
                            color: AppColors.mutedText,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Only admins can send messages in this group',
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({required this.message, required this.onVote});

  final Map<String, dynamic> message;
  final void Function(int id, String key) onVote;

  @override
  Widget build(BuildContext context) {
    final buy = message['action'] == 'BUY';
    final votes = message['votes'] as Map<String, dynamic>;
    final total = (votes['tpHit'] as int) + (votes['slHit'] as int);
    final pct = total == 0 ? 0 : ((votes['tpHit'] as int) * 100 ~/ total);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: buy
                          ? const LinearGradient(
                              colors: [Color(0xFF22C55E), Color(0xFF10B981)],
                            )
                          : const LinearGradient(
                              colors: [Color(0xFFEF4444), Color(0xFFF97316)],
                            ),
                    ),
                    child: Icon(
                      buy ? Icons.trending_up : Icons.trending_down,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['action'] as String,
                        style: TextStyle(
                          color: buy ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        message['pair'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message['leverage'] as String,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _line('Entry Zone', message['entry'] as String),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Take Profit',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.mutedText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...(message['tp'] as List<dynamic>).asMap().entries.map(
                        (e) => Text(
                          'TP${e.key + 1}: ${e.value}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stop Loss',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.mutedText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'SL: ${message['sl']}',
                        style: const TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Community Feedback',
                style: TextStyle(fontSize: 10, color: AppColors.mutedText),
              ),
              Text(
                '$pct% Success',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _voteBtn(
                  Icons.thumb_up,
                  Colors.green,
                  votes['tpHit'] as int,
                  () => onVote(message['id'] as int, 'tpHit'),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _voteBtn(
                  Icons.thumb_down,
                  Colors.red,
                  votes['slHit'] as int,
                  () => onVote(message['id'] as int, 'slHit'),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _voteBtn(
                  Icons.gps_fixed,
                  AppColors.primary,
                  votes['targetAchieved'] as int,
                  () => onVote(message['id'] as int, 'targetAchieved'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.mutedText),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _voteBtn(IconData icon, Color color, int value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
