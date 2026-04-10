#!/bin/zsh
set -e

cd "$(dirname "$0")"

make_feature() {
  folder="$1"
  class_name="$2"
  vm_name="$3"
  binding_name="$4"
  route_key="$5"
  title="$6"
  subtitle="$7"
  cta="$8"
  show_back="$9"
  show_bottom="${10}"
  nav_index="${11}"
  show_search="${12}"
  short="${folder##*/}"

  cat > "lib/app/features/$folder/viewmodel/${short}_view_model.dart" <<EOT
import '../../../core/base/base_view_model.dart';

class $vm_name extends BaseViewModel {
  final title = '$title';
  final subtitle = '$subtitle';
  final cta = '$cta';
}
EOT

  cat > "lib/app/features/$folder/bindings/${short}_binding.dart" <<EOT
import 'package:get/get.dart';

import '../viewmodel/${short}_view_model.dart';

class $binding_name extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<$vm_name>(() => $vm_name());
  }
}
EOT

  cat > "lib/app/features/$folder/views/${short}_view.dart" <<EOT
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/market_page_content.dart';
import '../../../../widgets/market_scaffold.dart';
import '../viewmodel/${short}_view_model.dart';

class $class_name extends GetView<$vm_name> {
  const $class_name({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScaffold(
      title: controller.title,
      showBack: $show_back,
      showBottomNav: $show_bottom,
      currentBottomNavIndex: $nav_index,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
      ],
      body: MarketPageContent(
        subtitle: controller.subtitle,
        cta: controller.cta,
        showSearch: $show_search,
      ),
    );
  }
}
EOT

  echo "import '../features/$folder/bindings/${short}_binding.dart';" >> /tmp/import_bindings.txt
  echo "import '../features/$folder/views/${short}_view.dart';" >> /tmp/import_views.txt
  echo "    GetPage(name: AppRoutes.$route_key, page: () => const $class_name(), binding: $binding_name())," >> /tmp/get_pages.txt
}

> /tmp/import_bindings.txt
> /tmp/import_views.txt
> /tmp/get_pages.txt

make_feature 'auth/login' 'LoginView' 'LoginViewModel' 'LoginBinding' 'login' 'Welcome Back' 'Sign in to continue your trading journey.' 'Login' 'false' 'false' '0' 'false'
make_feature 'auth/register' 'RegisterView' 'RegisterViewModel' 'RegisterBinding' 'register' 'Create Account' 'Join premium groups and verified traders.' 'Register' 'true' 'false' '0' 'false'
make_feature 'auth/otp_verification' 'OtpVerificationView' 'OtpVerificationViewModel' 'OtpVerificationBinding' 'otpVerification' 'OTP Verification' 'Enter the secure code sent to your phone.' 'Verify OTP' 'true' 'false' '0' 'false'
make_feature 'auth/role_selection' 'RoleSelectionView' 'RoleSelectionViewModel' 'RoleSelectionBinding' 'roleSelection' 'Select Role' 'Choose your mode to personalize the experience.' 'Continue' 'true' 'false' '0' 'false'
make_feature 'home' 'HomeView' 'HomeViewModel' 'HomeBinding' 'home' 'Home' 'Discover high-performance trading communities.' 'Browse Groups' 'false' 'true' '0' 'true'
make_feature 'explore' 'ExploreView' 'ExploreViewModel' 'ExploreBinding' 'explore' 'Find Groups' 'Find groups by asset class and performance.' 'Open Group' 'false' 'true' '1' 'true'
make_feature 'group_detail' 'GroupDetailView' 'GroupDetailViewModel' 'GroupDetailBinding' 'groupDetail' 'Group Details' 'Transparent metrics, strategy, and trader profile.' 'Subscribe Now' 'true' 'false' '0' 'false'
make_feature 'payment' 'PaymentView' 'PaymentViewModel' 'PaymentBinding' 'payment' 'Payment' 'Review your plan and complete secure checkout.' 'Confirm Payment' 'true' 'false' '0' 'false'
make_feature 'chats_list' 'ChatsListView' 'ChatsListViewModel' 'ChatsListBinding' 'chats' 'Chats' 'Recent conversations from your joined groups.' 'Open Chat' 'false' 'true' '2' 'false'
make_feature 'group_chat' 'GroupChatView' 'GroupChatViewModel' 'GroupChatBinding' 'groupChat' 'Group Chat' 'Live trade insights and member discussion feed.' 'Send Message' 'true' 'true' '2' 'false'
make_feature 'user_profile' 'UserProfileView' 'UserProfileViewModel' 'UserProfileBinding' 'profile' 'My Profile' 'Track joined groups, ROI, and account details.' 'Edit Profile' 'false' 'true' '3' 'false'
make_feature 'trader_profile' 'TraderProfileView' 'TraderProfileViewModel' 'TraderProfileBinding' 'traderProfile' 'Trader Profile' 'Public trader metrics and active premium plans.' 'Follow Trader' 'true' 'false' '0' 'false'
make_feature 'trader_dashboard' 'TraderDashboardView' 'TraderDashboardViewModel' 'TraderDashboardBinding' 'traderDashboard' 'Trader Dashboard' 'Performance snapshot, subscribers, and signals.' 'Create Group' 'false' 'false' '0' 'false'
make_feature 'create_group' 'CreateGroupView' 'CreateGroupViewModel' 'CreateGroupBinding' 'createGroup' 'Create Group' 'Launch your premium signal community in minutes.' 'Publish Group' 'true' 'false' '0' 'false'
make_feature 'apply_trader' 'ApplyTraderView' 'ApplyTraderViewModel' 'ApplyTraderBinding' 'applyTrader' 'Apply as Trader' 'Submit your proof and become a verified trader.' 'Submit Application' 'true' 'false' '0' 'false'
make_feature 'settings' 'SettingsView' 'SettingsViewModel' 'SettingsBinding' 'settings' 'Settings' 'Manage preferences, notifications, and security.' 'Save Changes' 'true' 'false' '0' 'false'
make_feature 'trader_inbox' 'TraderInboxView' 'TraderInboxViewModel' 'TraderInboxBinding' 'traderInbox' 'Trader Inbox' 'Subscriber requests, approvals, and support.' 'Manage Messages' 'true' 'false' '0' 'false'
make_feature 'trader_account' 'TraderAccountView' 'TraderAccountViewModel' 'TraderAccountBinding' 'traderAccount' 'Trader Account' 'Payouts, balance, and account verification status.' 'Withdraw Funds' 'true' 'false' '0' 'false'
make_feature 'edit_profile' 'EditProfileView' 'EditProfileViewModel' 'EditProfileBinding' 'editProfile' 'Edit Profile' 'Update your bio, links, and account information.' 'Update Profile' 'true' 'false' '0' 'false'
make_feature 'trader_edit_profile' 'TraderEditProfileView' 'TraderEditProfileViewModel' 'TraderEditProfileBinding' 'traderEditProfile' 'Edit Trader Profile' 'Refine your public strategy and credentials.' 'Save Trader Profile' 'true' 'false' '0' 'false'
make_feature 'trader_subscription' 'TraderSubscriptionView' 'TraderSubscriptionViewModel' 'TraderSubscriptionBinding' 'traderSubscription' 'Trader Subscription' 'Manage your active plans and subscriber tiers.' 'Upgrade Plan' 'true' 'false' '0' 'false'
make_feature 'subscription_payment' 'SubscriptionPaymentView' 'SubscriptionPaymentViewModel' 'SubscriptionPaymentBinding' 'subscriptionPayment' 'Subscription Payment' 'Complete payment for your selected plan tier.' 'Pay Subscription' 'true' 'false' '0' 'false'

cat > lib/app/routes/app_pages.dart <<EOT
import 'package:get/get.dart';

import 'app_routes.dart';
$(cat /tmp/import_bindings.txt)
$(cat /tmp/import_views.txt)

class AppPages {
  static final pages = <GetPage<dynamic>>[
$(cat /tmp/get_pages.txt)
  ];
}
EOT
