import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/market_ui.dart';
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

  @override
  Widget build(BuildContext context) {
    const groups = [
      {'id': '1', 'name': 'Premium Forex Signals', 'members': '1250', 'price': '4,999', 'roi': '+24%', 'rating': '4.9'},
      {'id': '2', 'name': 'Free Trading Community', 'members': '890', 'price': 'Free', 'roi': '+18%', 'rating': '4.6'},
      {'id': '3', 'name': 'Advanced Scalping', 'members': '200', 'price': '9,999', 'roi': '+31%', 'rating': '5.0'},
    ];

    const signals = [
      {'pair': 'EUR/USD', 'type': 'Buy', 'entry': '1.0850', 'tp': '1.0920', 'result': '+70 pips', 'win': true},
      {'pair': 'GBP/USD', 'type': 'Sell', 'entry': '1.2640', 'tp': '1.2580', 'result': '+60 pips', 'win': true},
      {'pair': 'USD/JPY', 'type': 'Buy', 'entry': '148.20', 'tp': '148.90', 'result': '+70 pips', 'win': true},
      {'pair': 'EUR/GBP', 'type': 'Sell', 'entry': '0.8590', 'tp': '0.8550', 'result': '-40 pips', 'win': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trader Profile',),
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
        
      ),
        backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: [
           
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network('https://api.dicebear.com/7.x/avataaars/svg?seed=Ahmed', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text('Ahmed Khan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
                    Icon(Icons.verified, color: AppColors.primary, size: 18),
                  ]),
                  Text('@ahmedtrader', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                  SizedBox(height: 6),
                  Row(children: [
                    Icon(Icons.star, color: Colors.amber, size: 14), SizedBox(width: 2), Text('4.8'), SizedBox(width: 10),
                    Icon(Icons.groups, size: 14, color: AppColors.mutedText), SizedBox(width: 2), Text('2,340', style: TextStyle(color: AppColors.mutedText, fontSize: 12)), SizedBox(width: 10),
                    Icon(Icons.calendar_month, size: 14, color: AppColors.mutedText), SizedBox(width: 2), Text('Jan 2024', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                  ]),
                ]),
              ),
            ]),
            const SizedBox(height: 12),
            const Row(children: [
              Expanded(child: _Stat(label: 'Win Rate', value: '87%', color: Colors.green)),
              SizedBox(width: 8),
              Expanded(child: _Stat(label: 'Monthly ROI', value: '+24.5%', color: AppColors.primary)),
              SizedBox(width: 8),
              Expanded(child: _Stat(label: 'Signals', value: '342', color: AppColors.accent)),
            ]),
            const SizedBox(height: 12),
            const MarketPanel(
              radius: 12,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Icon(Icons.emoji_events, color: AppColors.primary, size: 16), SizedBox(width: 6), Text('About', style: TextStyle(fontWeight: FontWeight.w600))]),
                SizedBox(height: 6),
                Text('Professional forex trader with 8+ years of experience. Specialized in EUR/USD, GBP/USD scalping strategies. Risk management focused.', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 12),
            const Text('Achievements', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            ...[
              {'icon': '🏆', 'title': 'Top Trader 2025', 'desc': 'Ranked #12 globally'},
              {'icon': '⭐', 'title': 'Verified Expert', 'desc': 'Platform verified'},
              {'icon': '📈', 'title': 'Best ROI Q1', 'desc': '+28% returns'},
            ].map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: MarketPanel(
                    radius: 12,
                    padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      Text(a['icon']! as String, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(a['title']! as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(a['desc']! as String, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
                      ])),
                    ]),
                  ),
                )),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _tab('Groups (${groups.length})', tab == 0, () => setState(() => tab = 0))),
              const SizedBox(width: 8),
              Expanded(child: _tab('Recent Signals', tab == 1, () => setState(() => tab = 1))),
            ]),
            const SizedBox(height: 8),
            if (tab == 0)
              ...groups.map((g) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoutes.groupDetail, arguments: {'id': g['id']}),
                      child: MarketPanel(
                        radius: 12,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(child: Text(g['name']! as String, style: const TextStyle(fontWeight: FontWeight.w600))),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Text(g['roi']! as String, style: const TextStyle(color: Colors.green, fontSize: 11))),
                          ]),
                          const SizedBox(height: 4),
                          Text('${g['members']} members • ⭐ ${g['rating']}', style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
                          const SizedBox(height: 6),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(g['price'] == 'Free' ? 'Free' : 'Rs ${g['price']}/mo', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent])), child: const Text('View', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                          ]),
                        ]),
                      ),
                    ),
                  ))
            else
              ...signals.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: MarketPanel(
                      radius: 12,
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(children: [
                            Text(s['pair']! as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: (s['type'] == 'Buy' ? Colors.green : Colors.red).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(s['type']! as String, style: TextStyle(fontSize: 10, color: s['type'] == 'Buy' ? Colors.green : Colors.red)),
                            ),
                          ]),
                          Text(s['result']! as String, style: TextStyle(color: s['win']! as bool ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                        ]),
                        const SizedBox(height: 4),
                        Text('Entry: ${s['entry']}  •  TP: ${s['tp']}', style: const TextStyle(color: AppColors.mutedText, fontSize: 11)),
                      ]),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: active ? AppColors.primary : AppColors.border)),
        child: Center(child: Text(text, style: TextStyle(fontSize: 11, color: active ? AppColors.primary : AppColors.mutedText, fontWeight: FontWeight.w600))),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MarketPanel(
      radius: 10,
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w700)),
        Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 10)),
      ]),
    );
  }
}
