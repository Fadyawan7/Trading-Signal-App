import '../../domain/repositories/trader_repository.dart';
import '../datasources/trader_remote_data_source.dart';
import '../models/trader_message_response.dart';
import '../models/subscription_plan.dart';
import '../models/my_subscription.dart';
import '../../../trader_dashboard/data/models/trader_dashboard_response.dart';
import '../../../create_group/data/models/group_categories_response.dart';
import '../../../create_group/data/models/create_group_response.dart';
import '../../../create_group/data/models/all_trader_groups_response.dart';
import '../models/single_group_response.dart';
import '../models/group_members_response.dart';

class TraderRepositoryImpl implements TraderRepository {
  TraderRepositoryImpl({required TraderRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final TraderRemoteDataSource _remoteDataSource;

  @override
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
  }) {
    return _remoteDataSource.applyAsTrader(
      fullName: fullName,
      tradingExperience: tradingExperience,
      specialization: specialization,
      winRate: winRate,
      tradingStrategy: tradingStrategy,
      identityFront: identityFront,
      identityBack: identityBack,
      tradingProofs: tradingProofs,
      twitter: twitter,
      telegram: telegram,
      whyTradeConnect: whyTradeConnect,
    );
  }

  @override
  Future<TraderSubscriptionPlansResponse> getSubscriptionPlans({
    String? type,
    int? perPage,
    int? page,
  }) {
    return _remoteDataSource.getSubscriptionPlans(
      type: type,
      perPage: perPage,
      page: page,
    );
  }

  @override
  Future<TraderMessageResponse> buySubscriptionPlan({
    required String planId,
  }) {
    return _remoteDataSource.buySubscriptionPlan(planId: planId);
  }

  @override
  Future<MySubscriptionsResponse> getMySubscriptions({
    String? status,
    int? perPage,
    int? page,
  }) {
    return _remoteDataSource.getMySubscriptions(
      status: status,
      perPage: perPage,
      page: page,
    );
  }

  @override
  Future<TraderDashboardResponse> getTraderDashboard() {
    return _remoteDataSource.getTraderDashboard();
  }

  @override
  Future<GroupCategoriesResponse> getGroupCategories() {
    return _remoteDataSource.getGroupCategories();
  }

  @override
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
  }) {
    return _remoteDataSource.createTraderGroup(
      groupName: groupName,
      categoryId: categoryId,
      isPaid: isPaid,
      price: price,
      hasTrial: hasTrial,
      trialDays: trialDays,
      maximumMembers: maximumMembers,
      description: description,
      groupFeatures: groupFeatures,
      onlyAdminCanMessage: onlyAdminCanMessage,
      groupIcon: groupIcon,
    );
  }

  @override
  Future<AllTraderGroupsResponse> getAllTraderGroups({
    String? search,
    int? perPage,
    int? page,
  }) {
    return _remoteDataSource.getAllTraderGroups(
      search: search,
      perPage: perPage,
      page: page,
    );
  }

  @override
  Future<TraderMessageResponse> deleteTraderGroup({
    required int groupId,
    required String reason,
  }) {
    return _remoteDataSource.deleteTraderGroup(
      groupId: groupId,
      reason: reason,
    );
  }

  @override
  Future<SingleGroupResponse> getSingleGroup(int groupId) {
    return _remoteDataSource.getSingleGroup(groupId);
  }

  @override
  Future<GroupMembersResponse> getGroupMembers({
    required int groupId,
    String? search,
    int? perPage,
  }) {
    return _remoteDataSource.getGroupMembers(
      groupId: groupId,
      search: search,
      perPage: perPage,
    );
  }

  @override
  Future<TraderMessageResponse> changeGroupMemberRole({
    required int groupId,
    required int userId,
    required String role,
  }) {
    return _remoteDataSource.changeGroupMemberRole(
      groupId: groupId,
      userId: userId,
      role: role,
    );
  }

  @override
  Future<TraderMessageResponse> removeGroupMemberRequest({
    required int groupId,
    required int userId,
    required String reason,
  }) {
    return _remoteDataSource.removeGroupMemberRequest(
      groupId: groupId,
      userId: userId,
      reason: reason,
    );
  }
}
