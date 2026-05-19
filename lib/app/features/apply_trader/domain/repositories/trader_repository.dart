import '../../data/models/trader_message_response.dart';
import '../../data/models/subscription_plan.dart';
import '../../data/models/my_subscription.dart';
import '../../../trader_dashboard/data/models/trader_dashboard_response.dart';
import '../../../create_group/data/models/group_categories_response.dart';
import '../../../create_group/data/models/create_group_response.dart';
import '../../../create_group/data/models/all_trader_groups_response.dart';
import '../../data/models/single_group_response.dart';
import '../../data/models/group_members_response.dart';

abstract class TraderRepository {
  Future<TraderMessageResponse> applyAsTrader({
    required String fullName,
    required String tradingExperience,
    required String specialization,
    required String winRate,
    required String tradingStrategy,
    required String identityFront,
    String? identityBack,
    required List<String> tradingProofs,
    String? twitter,
    String? telegram,
    String? whyTradeConnect,
  });

  Future<TraderSubscriptionPlansResponse> getSubscriptionPlans({
    String? type,
    int? perPage,
    int? page,
  });

  Future<TraderMessageResponse> buySubscriptionPlan({
    required String planId,
  });

  Future<MySubscriptionsResponse> getMySubscriptions({
    String? status,
    int? perPage,
    int? page,
  });

  Future<TraderDashboardResponse> getTraderDashboard();

  Future<GroupCategoriesResponse> getGroupCategories();

  Future<CreateGroupResponse> createTraderGroup({
    required String groupName,
    required int categoryId,
    required bool isPaid,
    required double price,
    required bool hasTrial,
    required int trialDays,
    required int maximumMembers,
    required String description,
    required List<String> groupFeatures,
    required bool onlyAdminCanMessage,
    String? groupIcon,
  });

  Future<AllTraderGroupsResponse> getAllTraderGroups({
    String? search,
    int? perPage,
    int? page,
  });

  Future<TraderMessageResponse> deleteTraderGroup({
    required int groupId,
    required String reason,
  });

  Future<SingleGroupResponse> getSingleGroup(int groupId);

  Future<GroupMembersResponse> getGroupMembers({
    required int groupId,
    String? search,
    int? perPage,
  });

  Future<TraderMessageResponse> changeGroupMemberRole({
    required int groupId,
    required int userId,
    required String role,
  });

  Future<TraderMessageResponse> removeGroupMemberRequest({
    required int groupId,
    required int userId,
    required String reason,
  });
}
