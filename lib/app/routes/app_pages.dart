import 'package:get/get.dart';

import 'app_routes.dart';
import '../features/auth/login/bindings/login_binding.dart';
import '../features/auth/login/views/login_view.dart';
import '../features/auth/register/bindings/register_binding.dart';
import '../features/auth/register/views/register_view.dart';
import '../features/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../features/auth/forgot_password/views/forgot_password_view.dart';
import '../features/auth/otp_verification/bindings/otp_verification_binding.dart';
import '../features/auth/otp_verification/views/otp_verification_view.dart';
import '../features/auth/role_selection/bindings/role_selection_binding.dart';
import '../features/auth/role_selection/views/role_selection_view.dart';
import '../features/home/bindings/home_binding.dart';
import '../features/home/views/home_view.dart';
import '../features/explore/bindings/explore_binding.dart';
import '../features/explore/views/explore_view.dart';
import '../features/group_detail/bindings/group_detail_binding.dart';
import '../features/group_detail/views/group_detail_view.dart';
import '../features/payment/bindings/payment_binding.dart';
import '../features/payment/views/payment_view.dart';
import '../features/chats_list/bindings/chats_list_binding.dart';
import '../features/chats_list/views/chats_list_view.dart';
import '../features/group_chat/bindings/group_chat_binding.dart';
import '../features/group_chat/views/group_chat_view.dart';
import '../features/user_profile/bindings/user_profile_binding.dart';
import '../features/user_profile/views/user_profile_view.dart';
import '../features/trader_profile/bindings/trader_profile_binding.dart';
import '../features/trader_profile/views/trader_profile_view.dart';
import '../features/trader_dashboard/bindings/trader_dashboard_binding.dart';
import '../features/trader_dashboard/views/trader_dashboard_view.dart';
import '../features/create_group/bindings/create_group_binding.dart';
import '../features/create_group/views/create_group_view.dart';
import '../features/apply_trader/bindings/apply_trader_binding.dart';
import '../features/apply_trader/views/apply_trader_view.dart';
import '../features/settings/bindings/settings_binding.dart';
import '../features/settings/views/settings_view.dart';
import '../features/trader_inbox/bindings/trader_inbox_binding.dart';
import '../features/trader_inbox/views/trader_inbox_view.dart';
import '../features/trader_account/bindings/trader_account_binding.dart';
import '../features/trader_account/views/trader_account_view.dart';
import '../features/edit_profile/bindings/edit_profile_binding.dart';
import '../features/edit_profile/views/edit_profile_view.dart';
import '../features/trader_edit_profile/bindings/trader_edit_profile_binding.dart';
import '../features/trader_edit_profile/views/trader_edit_profile_view.dart';
import '../features/trader_subscription/bindings/trader_subscription_binding.dart';
import '../features/trader_subscription/views/trader_subscription_view.dart';
import '../features/subscription_payment/bindings/subscription_payment_binding.dart';
import '../features/subscription_payment/views/subscription_payment_view.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.roleSelection,
      page: () => const RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.explore,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: AppRoutes.groupDetail,
      page: () => const GroupDetailView(),
      binding: GroupDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppRoutes.chats,
      page: () => const ChatsListView(),
      binding: ChatsListBinding(),
    ),
    GetPage(
      name: AppRoutes.groupChat,
      page: () => const GroupChatView(),
      binding: GroupChatBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.traderProfile,
      page: () => const TraderProfileView(),
      binding: TraderProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.traderDashboard,
      page: () => const TraderDashboardView(),
      binding: TraderDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.createGroup,
      page: () => const CreateGroupView(),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.applyTrader,
      page: () => const ApplyTraderView(),
      binding: ApplyTraderBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.traderInbox,
      page: () => const TraderInboxView(),
      binding: TraderInboxBinding(),
    ),
    GetPage(
      name: AppRoutes.traderAccount,
      page: () => const TraderAccountView(),
      binding: TraderAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.traderEditProfile,
      page: () => const TraderEditProfileView(),
      binding: TraderEditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.traderSubscription,
      page: () => const TraderSubscriptionView(),
      binding: TraderSubscriptionBinding(),
    ),
    GetPage(
      name: AppRoutes.subscriptionPayment,
      page: () => const SubscriptionPaymentView(),
      binding: SubscriptionPaymentBinding(),
    ),
  ];
}
