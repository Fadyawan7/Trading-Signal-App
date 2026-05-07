import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../viewmodel/trader_profile_view_model.dart';

class TraderProfileView extends GetView<TraderProfileViewModel> {
  const TraderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TraderProfileBody();
  }
}

class _TraderProfileBody extends StatefulWidget {
  const _TraderProfileBody();

  @override
  State<_TraderProfileBody> createState() => _TraderProfileBodyState();
}

class _TraderProfileBodyState extends State<_TraderProfileBody> {
  int tab = 0;

  final List<Map<String, dynamic>> groups = [
    {
      'id': '1',
      'name': 'Premium Forex Signals',
      'members': '1250',
      'price': '4,999',
      'roi': '+24%',
      'rating': '4.9',
    },
    {
      'id': '2',
      'name': 'Free Trading Community',
      'members': '890',
      'price': 'Free',
      'roi': '+18%',
      'rating': '4.6',
    },
    {
      'id': '3',
      'name': 'Advanced Scalping',
      'members': '200',
      'price': '9,999',
      'roi': '+31%',
      'rating': '5.0',
    },
  ];

  final List<Map<String, dynamic>> signals = [
    {
      'pair': 'EUR/USD',
      'type': 'Buy',
      'entry': '1.0850',
      'tp': '1.0920',
      'result': '+70 pips',
      'win': true,
    },
    {
      'pair': 'GBP/USD',
      'type': 'Sell',
      'entry': '1.2640',
      'tp': '1.2580',
      'result': '+60 pips',
      'win': true,
    },
    {
      'pair': 'USD/JPY',
      'type': 'Buy',
      'entry': '148.20',
      'tp': '148.90',
      'result': '+70 pips',
      'win': true,
    },
    {
      'pair': 'EUR/GBP',
      'type': 'Sell',
      'entry': '0.8590',
      'tp': '0.8550',
      'result': '-40 pips',
      'win': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      AppColors.background;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _Header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  children: [
                    _ProfileHero(),
                    const SizedBox(height: 24),
                    _StatsRow(),
                    const SizedBox(height: 24),
                    _AboutSection(),
                    const SizedBox(height: 24),
                    _SectionTitle('Achievements'),
                    const SizedBox(height: 12),
                    _AchievementsList(),
                    const SizedBox(height: 24),
                    _Tabs(
                      current: tab,
                      onChanged: (v) => setState(() => tab = v),
                      groupCount: groups.length,
                    ),
                    const SizedBox(height: 16),
                    if (tab == 0) ...groups.map((g) => _GroupCard(group: g))
                    else ...signals.map((s) => _SignalCard(signal: s)),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 18),
            ),
          ),
          const Expanded(
            child: Text(
              'Trader Profile',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 44), // Spacer for centering
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF14B8A6), width: 2),
            image: const DecorationImage(
              image: NetworkImage('https://api.dicebear.com/7.x/avataaars/svg?seed=Ahmed'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Ahmed Khan',
                    style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.verified_rounded, color: Color(0xFF14B8A6), size: 18),
                ],
              ),
              Text('@ahmedtrader', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _InfoTag(icon: Icons.star_rounded, label: '4.8', color: Colors.amber),
                  const SizedBox(width: 12),
                  _InfoTag(icon: Icons.people_rounded, label: '2,340', color: AppColors.mutedText),
                  const SizedBox(width: 12),
                  _InfoTag(icon: Icons.calendar_today_rounded, label: 'Jan 2024', color: AppColors.mutedText),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoTag({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatBox(label: 'Win Rate', value: '87%', color: const Color(0xFF10B981))),
        const SizedBox(width: 12),
        Expanded(child: _StatBox(label: 'Monthly ROI', value: '+24.5%', color: const Color(0xFF14B8A6))),
        const SizedBox(width: 12),
        Expanded(child: _StatBox(label: 'Signals', value: '342', color: const Color(0xFF6366F1))),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;

  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: AppColors.mutedText, fontSize: 10, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFF14B8A6), size: 18),
              const SizedBox(width: 8),
              Text('About', style: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Professional forex trader with 8+ years of experience. Specialized in EUR/USD, GBP/USD scalping strategies. Risk management focused.',
            style: TextStyle(color: AppColors.mutedText, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold));
  }
}

class _AchievementsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final achievements = [
      {'icon': Icons.emoji_events_rounded, 'title': 'Top Trader 2025', 'desc': 'Ranked #12 globally'},
      {'icon': Icons.verified_user_rounded, 'title': 'Verified Expert', 'desc': 'Platform verified'},
      {'icon': Icons.trending_up_rounded, 'title': 'Best ROI Q1', 'desc': '+28% returns'},
    ];

    return Column(
      children: achievements.map((a) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF14B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(a['icon'] as IconData, color: const Color(0xFF14B8A6), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a['title'] as String, style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold)),
                    Text(a['desc'] as String, style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}

class _Tabs extends StatelessWidget {
  final int current;
  final Function(int) onChanged;
  final int groupCount;

  const _Tabs({required this.current, required this.onChanged, required this.groupCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _tabItem(0, 'Groups ($groupCount)')),
          Expanded(child: _tabItem(1, 'Recent Signals')),
        ],
      ),
    );
  }

  Widget _tabItem(int id, String label) {
    final active = current == id;
    return InkWell(
      onTap: () => onChanged(id),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active ? const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)]) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: active ? Colors.white : AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  const _GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.groupDetail, arguments: {'id': group['id']}),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(group['name'] as String, style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(group['roi'] as String, style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text('${group['members']} members • ', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                  const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                  Text(' ${group['rating']}', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    group['price'] == 'Free' ? 'Free' : 'Rs ${group['price']}/mo',
                    style: const TextStyle(color: Color(0xFF14B8A6), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF0D9488)]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('View', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  final Map<String, dynamic> signal;
  const _SignalCard({required this.signal});

  @override
  Widget build(BuildContext context) {
    final win = signal['win'] == true;
    final color = win ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(signal['pair'] as String, style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (signal['type'] == 'Buy' ? const Color(0xFF10B981) : const Color(0xFFEF4444)).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        signal['type'] as String,
                        style: TextStyle(color: signal['type'] == 'Buy' ? const Color(0xFF10B981) : const Color(0xFFEF4444), fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Text(signal['result'] as String, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Entry: ', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                Text(signal['entry'] as String, style: TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(width: 16),
                Text('TP: ', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                Text(signal['tp'] as String, style: TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
