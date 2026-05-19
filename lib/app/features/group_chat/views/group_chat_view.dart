import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/group_chat_view_model.dart';
import 'group_members_view.dart';

class GroupChatView extends GetView<GroupChatViewModel> {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return _GroupChatBody();
  }
}

class _GroupChatBody extends StatefulWidget {
  const _GroupChatBody({super.key});

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
      'avatar': '👤',
      'message': 'Good morning everyone! Ready for today\'s market analysis.',
      'time': '09:00 AM',
      'isTrader': true,
    },
    {
      'id': 2,
      'type': 'signal',
      'sender': 'John Martinez',
      'avatar': '👤',
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

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'id': messages.isEmpty ? 1 : (messages.last['id'] as int) + 1,
        'type': 'text',
        'sender': 'You',
        'avatar': '👤',
        'message': text,
        'time': 'Just now',
        'isTrader': false,
      });
      _chatController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    
    return Obx(() {
      AppColors.background;
      return Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false, // Handle padding manually to prevent "jumping"
        body: SafeArea(
          bottom: false,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                _ChatHeader(
                  isAdmin: isAdmin,
                  showSettings: showSettings,
                  onSettingsToggle: () => setState(() => showSettings = !showSettings),
                ),
                if (showSettings && isAdmin)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _AdminSettingsBar(
                      isEnabled: isChatEnabled,
                      onToggle: (v) => setState(() => isChatEnabled = v),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: messages.length,
                    itemBuilder: (_, i) => _MessageItem(
                      message: messages[i],
                      onVote: vote,
                    ),
                  ),
                ),
                _InputSection(
                  controller: _chatController,
                  isChatEnabled: isChatEnabled || isAdmin,
                  keyboardHeight: keyboardHeight,
                  onSend: _sendMessage,
                  onChanged: () => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ChatHeader extends GetView<GroupChatViewModel> {
  final bool isAdmin;
  final bool showSettings;
  final VoidCallback onSettingsToggle;

  const _ChatHeader({
    required this.isAdmin,
    required this.showSettings,
    required this.onSettingsToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          _IconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Get.back(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() {
              final group = controller.rxGroup.value;
              final String name = group?.groupName ?? 'Loading chat...';
              final String membersCount = group != null ? '${group.membersCount} members' : 'Loading details...';
              final String? icon = group?.groupIcon;
              final bool isUrl = icon != null &&
                  (icon.startsWith('http://') ||
                      icon.startsWith('https://') ||
                      icon.contains('/'));

              return InkWell(
                onTap: () {
                  if (group != null) {
                    Get.to(() => const GroupMembersView());
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Center(
                            child: icon != null && icon.isNotEmpty
                                ? (isUrl
                                    ? Image.network(
                                        icon,
                                        fit: BoxFit.cover,
                                        width: 40,
                                        height: 40,
                                        errorBuilder: (_, __, ___) => Icon(
                                          Icons.rocket_launch_rounded,
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                      )
                                    : Text(
                                        icon,
                                        style: const TextStyle(fontSize: 20),
                                      ))
                                : Icon(
                                    Icons.rocket_launch_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              membersCount,
                              style: TextStyle(
                                color: AppColors.mutedText,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(width: 8),
          if (isAdmin)
            _IconButton(
              icon: Icons.settings_outlined,
              onTap: onSettingsToggle,
            ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.text, size: 20),
      ),
    );
  }
}

class _MessageItem extends StatelessWidget {
  final Map<String, dynamic> message;
  final Function(int, String) onVote;

  const _MessageItem({required this.message, required this.onVote});

  @override
  Widget build(BuildContext context) {
    final isSignal = message['type'] == 'signal';
    final isTrader = message['isTrader'] == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(child: Icon(Icons.person_outline_rounded, color: Color(0xFFFBBF24), size: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      message['sender'],
                      style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    if (isTrader) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF14B8A6).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Trader',
                          style: TextStyle(color: Color(0xFF14B8A6), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),
                    Text(
                      message['time'],
                      style: TextStyle(color: AppColors.mutedText, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (!isSignal)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      message['message'],
                      style: TextStyle(color: AppColors.text, fontSize: 14, height: 1.4),
                    ),
                  )
                else
                  _SignalMessage(message: message, onVote: onVote),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalMessage extends StatelessWidget {
  final Map<String, dynamic> message;
  final Function(int, String) onVote;

  const _SignalMessage({required this.message, required this.onVote});

  @override
  Widget build(BuildContext context) {
    final votes = message['votes'] as Map<String, dynamic>;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
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
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13242C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.trending_up_rounded, color: Color(0xFF14B8A6), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['action'],
                        style: const TextStyle(color: Color(0xFF14B8A6), fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        message['pair'],
                        style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  message['leverage'],
                  style: const TextStyle(color: Color(0xFF14B8A6), fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SignalInfoCard(
            label: 'Entry Zone',
            value: message['entry'],
            isFullWidth: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SignalValueBox(
                  label: 'Take Profit',
                  values: message['tp'],
                  color: const Color(0xFF14B8A6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SignalValueBox(
                  label: 'Stop Loss',
                  values: [message['sl']],
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Community Feedback',
                style: TextStyle(color: AppColors.mutedText, fontSize: 12),
              ),
              Text(
                '85% Success',
                style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _VoteButton(icon: Icons.thumb_up_alt_outlined, value: votes['tpHit'], color: const Color(0xFF14B8A6), onTap: () => onVote(message['id'], 'tpHit'))),
              const SizedBox(width: 8),
              Expanded(child: _VoteButton(icon: Icons.thumb_down_alt_outlined, value: votes['slHit'], color: const Color(0xFFEF4444), onTap: () => onVote(message['id'], 'slHit'))),
              const SizedBox(width: 8),
              Expanded(child: _VoteButton(icon: Icons.track_changes_rounded, value: votes['targetAchieved'], color: const Color(0xFF14B8A6), onTap: () => onVote(message['id'], 'targetAchieved'))),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalInfoCard extends StatelessWidget {
  final String label, value;
  final bool isFullWidth;
  const _SignalInfoCard({required this.label, required this.value, this.isFullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}

class _SignalValueBox extends StatelessWidget {
  final String label;
  final List<dynamic> values;
  final Color color;

  const _SignalValueBox({required this.label, required this.values, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
          const SizedBox(height: 8),
          ...values.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              '${values.length > 1 ? "TP${e.key + 1}: " : "SL: "}${e.value}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )),
          if (values.length == 1) const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _VoteButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;
  final VoidCallback onTap;

  const _VoteButton({required this.icon, required this.value, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color.withValues(alpha: 0.8), size: 18),
            const SizedBox(width: 8),
            Text(
              '$value',
              style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isChatEnabled;
  final double keyboardHeight;
  final VoidCallback onSend;
  final VoidCallback onChanged;

  const _InputSection({
    required this.controller,
    required this.isChatEnabled,
    required this.keyboardHeight,
    required this.onSend,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!isChatEnabled) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_rounded, size: 14, color: AppColors.mutedText),
            const SizedBox(width: 8),
            Text('Only admins can send messages here', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
          ],
        ),
      );
    }

    return Container(
      color: AppColors.background, // Fill the space behind keyboard with background color
      padding: EdgeInsets.fromLTRB(16, 8, 16, (keyboardHeight > 0 ? keyboardHeight : 20) + 10),
      child: Row(
        children: [
          // Simplified attachment button to avoid "double border" look
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                shape: BoxShape.circle,
                // Removed border here to solve "double border" visual issue
              ),
              child: Icon(Icons.attach_file_rounded, color: AppColors.mutedText, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.2),
              ),
              child: TextField(
                controller: controller,
                onChanged: (_) => onChanged(),
                onSubmitted: (_) => onSend(),
                style: TextStyle(color: AppColors.text, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Color(0xFF64748B)),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF14B8A6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFF14B8A6).withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminSettingsBar extends StatelessWidget {
  final bool isEnabled;
  final Function(bool) onToggle;

  const _AdminSettingsBar({required this.isEnabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(isEnabled ? Icons.lock_open_rounded : Icons.lock_rounded, color: isEnabled ? Colors.green : Colors.red, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Member Chat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.text)),
                Text(isEnabled ? 'Members can send messages' : 'Only admins can send messages', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
              ],
            ),
          ),
          Transform.scale(scale: 0.7, child: Switch(value: isEnabled, onChanged: onToggle, activeColor: const Color(0xFF14B8A6))),
        ],
      ),
    );
  }
}
