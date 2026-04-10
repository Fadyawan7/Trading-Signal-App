import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'market_widgets.dart';

class MarketPageContent extends StatelessWidget {
  const MarketPageContent({
    super.key,
    required this.subtitle,
    required this.cta,
    this.showSearch = false,
  });

  final String subtitle;
  final String cta;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    Widget bodyByType() {
      switch (cta) {
        case 'Register':
          return const _AuthForm(isRegister: true);
        case 'Verify OTP':
          return const _OtpBlock();
        case 'Open Group':
          return const _ExploreList();
        case 'Subscribe Now':
          return const _GroupDetail();
        case 'Confirm Payment':
        case 'Pay Subscription':
          return const _PaymentForm();
        case 'Open Chat':
          return const _ChatsList();
        case 'Send Message':
          return const _GroupChat();
        case 'Follow Trader':
          return const _TraderProfile();
        case 'Create Group':
        case 'Publish Group':
          return const _CreateGroupForm();
        case 'Submit Application':
          return const _ApplyTraderForm();
        case 'Save Changes':
          return const _SettingsBody();
        case 'Manage Messages':
          return const _TraderInbox();
        case 'Withdraw Funds':
          return const _TraderAccount();
        case 'Edit Profile':
        case 'Update Profile':
        case 'Save Trader Profile':
          return const _EditProfileForm();
        case 'Upgrade Plan':
          return const _SubscriptionPlans();
        default:
          return const _DefaultFeed();
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.mutedText, fontSize: 14),
          ),
          const SizedBox(height: 16),
          if (showSearch && cta != 'Open Group') ...[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search trading groups, traders, symbols',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(6),
                  child: _SearchFilterPill(),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Wrap(
              spacing: 8,
              children: [
                _Tag(text: 'Crypto'),
                _Tag(text: 'Forex'),
                _Tag(text: 'Gold'),
                _Tag(text: 'Stocks'),
              ],
            ),
            const SizedBox(height: 16),
          ],
          bodyByType(),
          const SizedBox(height: 16),
          AccentButton(label: cta, onTap: null),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _SearchFilterPill extends StatelessWidget {
  const _SearchFilterPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
      ),
      child: const Icon(Icons.tune_rounded, size: 18, color: Colors.white),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.title,
    required this.stats,
    required this.description,
  });

  final String title;
  final String stats;
  final String description;

  @override
  Widget build(BuildContext context) {
    return MarketCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.accent,
                child: Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.star_rounded, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            stats,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(color: AppColors.mutedText)),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(
            Icons.check_circle_rounded,
            color: AppColors.primary,
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(color: AppColors.mutedText)),
        ),
      ],
    );
  }
}

class _DefaultFeed extends StatelessWidget {
  const _DefaultFeed();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Featured Groups'),
        SizedBox(height: 10),
        _GroupCard(
          title: 'Alpha Snipers',
          stats: '+32% ROI  |  1.2K Members',
          description: 'High-conviction setups with strict risk management.',
        ),
        SizedBox(height: 10),
        _GroupCard(
          title: 'Momentum Pulse',
          stats: '+18% ROI  |  680 Members',
          description: 'Intraday momentum alerts and macro event breakdowns.',
        ),
      ],
    );
  }
}

class _AuthForm extends StatelessWidget {
  const _AuthForm({required this.isRegister});

  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: isRegister ? 'Full name' : 'Email',
          ),
        ),
        const SizedBox(height: 10),
        const TextField(decoration: InputDecoration(hintText: 'Email')),
        const SizedBox(height: 10),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password'),
        ),
        if (isRegister) ...[
          const SizedBox(height: 10),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Confirm password'),
          ),
        ],
      ],
    );
  }
}

class _OtpBlock extends StatelessWidget {
  const _OtpBlock();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        6,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExploreList extends StatelessWidget {
  const _ExploreList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search groups...',
            prefixIcon: Icon(Icons.search_rounded),
            suffixIcon: Padding(
              padding: EdgeInsets.all(6),
              child: _SearchFilterPill(),
            ),
          ),
        ),
        SizedBox(height: 10),
        _GroupCard(
          title: 'Forex Masters Club',
          stats: '+24% ROI  |  720 Members',
          description: 'Verified trader, daily setups, live room access.',
        ),
        SizedBox(height: 10),
        _GroupCard(
          title: 'Gold Trading Pro',
          stats: '+18% ROI  |  450 Members',
          description: 'XAUUSD focus with strict risk model and journal.',
        ),
      ],
    );
  }
}

class _GroupDetail extends StatelessWidget {
  const _GroupDetail();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GroupCard(
          title: 'Crypto Elite Signals',
          stats: '+127% ROI  |  850/1000 Members',
          description: 'Scalp and swing strategies with transparent history.',
        ),
        SizedBox(height: 10),
        MarketCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Benefit(
                text: 'Daily entries, SL/TP levels, and post-trade review',
              ),
              SizedBox(height: 8),
              _Benefit(text: 'Premium private chat and weekly Q&A session'),
              SizedBox(height: 8),
              _Benefit(text: 'Verified stats and risk management framework'),
            ],
          ),
        ),
      ],
    );
  }
}

class _PaymentForm extends StatelessWidget {
  const _PaymentForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MarketCard(
          child: Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: AppColors.primary),
              SizedBox(width: 10),
              Expanded(child: Text('Premium Plan  •  \$99/month')),
            ],
          ),
        ),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Card number')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Card holder name')),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(decoration: InputDecoration(hintText: 'MM/YY')),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(decoration: InputDecoration(hintText: 'CVV')),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChatsList extends StatelessWidget {
  const _ChatsList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ChatTile(
          name: 'Crypto Elite Signals',
          message: 'BTC setup posted 2m ago',
        ),
        SizedBox(height: 8),
        _ChatTile(
          name: 'Forex Masters Club',
          message: 'EURUSD update and risk note',
        ),
        SizedBox(height: 8),
        _ChatTile(
          name: 'Gold Trading Pro',
          message: 'XAUUSD TP reached +70 pips',
        ),
      ],
    );
  }
}

class _GroupChat extends StatelessWidget {
  const _GroupChat();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Bubble(
          text: 'Buy EURUSD at 1.0850, SL 1.0820, TP 1.0920',
          mine: false,
        ),
        SizedBox(height: 8),
        _Bubble(text: 'Entry done, thanks trader.', mine: true),
        SizedBox(height: 8),
        _Bubble(text: 'Move SL to breakeven once +20 pips.', mine: false),
      ],
    );
  }
}

class _TraderProfile extends StatelessWidget {
  const _TraderProfile();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundImage: NetworkImage(
            'https://api.dicebear.com/7.x/avataaars/png?seed=Ahmed',
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ahmed Khan',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: _StatBox(label: 'Win Rate', value: '87%'),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _StatBox(label: 'Monthly ROI', value: '+24%'),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _StatBox(label: 'Signals', value: '342'),
            ),
          ],
        ),
      ],
    );
  }
}

class _CreateGroupForm extends StatelessWidget {
  const _CreateGroupForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextField(decoration: InputDecoration(hintText: 'Group name')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Monthly price')),
        SizedBox(height: 10),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(hintText: 'Group description'),
        ),
      ],
    );
  }
}

class _ApplyTraderForm extends StatelessWidget {
  const _ApplyTraderForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Trading experience (years)'),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Main markets (Forex/Crypto/etc)',
          ),
        ),
        SizedBox(height: 10),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Share your track record details',
          ),
        ),
      ],
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SettingTile(title: 'Push Notifications', value: true),
        SizedBox(height: 8),
        _SettingTile(title: 'Trade Alerts', value: true),
        SizedBox(height: 8),
        _SettingTile(title: 'Dark Theme', value: true),
      ],
    );
  }
}

class _TraderInbox extends StatelessWidget {
  const _TraderInbox();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ChatTile(
          name: 'User Request',
          message: 'Please review my subscription payment.',
        ),
        SizedBox(height: 8),
        _ChatTile(name: 'Support', message: 'KYC verification approved.'),
      ],
    );
  }
}

class _TraderAccount extends StatelessWidget {
  const _TraderAccount();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MarketCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: TextStyle(color: AppColors.mutedText),
              ),
              SizedBox(height: 4),
              Text(
                '\$12,640',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextField(decoration: InputDecoration(hintText: 'Full name')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Email')),
        SizedBox(height: 10),
        TextField(decoration: InputDecoration(hintText: 'Phone')),
        SizedBox(height: 10),
        TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Bio')),
      ],
    );
  }
}

class _SubscriptionPlans extends StatelessWidget {
  const _SubscriptionPlans();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _PlanCard(
          name: 'Starter',
          price: '\$29/mo',
          features: 'Basic signals, community access',
        ),
        SizedBox(height: 8),
        _PlanCard(
          name: 'Pro',
          price: '\$99/mo',
          features: 'All signals, private chat, risk dashboard',
        ),
        SizedBox(height: 8),
        _PlanCard(
          name: 'Elite',
          price: '\$199/mo',
          features: '1:1 calls, premium strategy reviews',
        ),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.name, required this.message});

  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MarketCard(
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.accent,
            child: Icon(Icons.chat_bubble_outline_rounded, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.mine});

  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 260),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mine
              ? AppColors.primary.withValues(alpha: 0.18)
              : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(text),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.title, required this.value});

  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return MarketCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          IgnorePointer(
            child: Switch(value: value, onChanged: (_) {}),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.features,
  });

  final String name;
  final String price;
  final String features;

  @override
  Widget build(BuildContext context) {
    return MarketCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  features,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            price,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
