import '../../../../core/network/api_client.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/values/app_constants.dart';
import '../../../trader_dashboard/data/models/trader_dashboard_response.dart';
import '../../../create_group/data/models/group_categories_response.dart';
import '../../../create_group/data/models/create_group_response.dart';
import '../../../create_group/data/models/all_trader_groups_response.dart';
import '../models/trader_message_response.dart';
import '../models/subscription_plan.dart';
import '../models/my_subscription.dart';
import '../models/single_group_response.dart';
import '../models/group_members_response.dart';

class TraderRemoteDataSource {
  TraderRemoteDataSource({
    required ApiClient apiClient,
    required SessionService sessionService,
  })  : _apiClient = apiClient,
        _sessionService = sessionService;

  final ApiClient _apiClient;
  final SessionService _sessionService;

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
  }) async {
    final fields = {
      'full_name': fullName,
      'trading_experince': tradingExperience,
      'specialization': specialization,
      'win_rate': winRate,
      'trading_strategy': tradingStrategy,
      if (twitter != null) 'twitter': twitter,
      if (telegram != null) 'telegram': telegram,
      if (whyTradeConnect != null) 'why_trade_connect': whyTradeConnect,
    };

    final files = {
      'identity_front': identityFront,
      if (identityBack != null && identityBack.isNotEmpty) 'identity_back': identityBack,
    };

    for (int i = 0; i < tradingProofs.length; i++) {
      files['trading_proofs[$i]'] = tradingProofs[i];
    }

    final response = await _apiClient.postMultipart(
      ApiEndpoints.applyTrader,
      fields: fields,
      files: files,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return TraderMessageResponse.fromJson(response);
  }

  Future<TraderSubscriptionPlansResponse> getSubscriptionPlans({
    String? type,
    int? perPage,
    int? page,
  }) async {
    final queryParams = <String, String>{
      if (type != null) 'type': type,
      if (perPage != null) 'per_page': perPage.toString(),
      if (page != null) 'page': page.toString(),
    };
    
    final uri = Uri(path: ApiEndpoints.getTraderSubscriptions, queryParameters: queryParams);
    
    final response = await _apiClient.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return TraderSubscriptionPlansResponse.fromJson(response);
  }

  Future<TraderMessageResponse> buySubscriptionPlan({
    required String planId,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.buyTraderSubscription,
      body: {
        'plan_id': planId,
      },
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return TraderMessageResponse.fromJson(response);
  }

  Future<MySubscriptionsResponse> getMySubscriptions({
    String? status,
    int? perPage,
    int? page,
  }) async {
    final queryParams = <String, String>{
      if (status != null) 'status': status,
      if (perPage != null) 'per_page': perPage.toString(),
      if (page != null) 'page': page.toString(),
    };

    final uri = Uri(path: ApiEndpoints.getMyTraderSubscription, queryParameters: queryParams);

    final response = await _apiClient.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return MySubscriptionsResponse.fromJson(response);
  }

  Future<TraderDashboardResponse> getTraderDashboard() async {
    final response = await _apiClient.get(
      ApiEndpoints.getTraderDashboard,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return TraderDashboardResponse.fromJson(response);
  }

  Future<GroupCategoriesResponse> getGroupCategories() async {
    final response = await _apiClient.get(
      ApiEndpoints.getGroupCategories,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );
    return GroupCategoriesResponse.fromJson(response);
  }

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
  }) async {
    final fields = {
      'group_name': groupName,
      'category_id': categoryId.toString(),
      'is_paid': isPaid ? '1' : '0',
      'price': price.toString(),
      'has_trial': hasTrial ? '1' : '0',
      if (hasTrial) 'trial_days': trialDays.toString(),
      'maximum_members': maximumMembers.toString(),
      'description': description,
      'only_admin_can_message': onlyAdminCanMessage ? '1' : '0',
    };

    for (int i = 0; i < groupFeatures.length; i++) {
      fields['group_feature[$i]'] = groupFeatures[i];
    }

    final files = {
      if (groupIcon != null && groupIcon.isNotEmpty) 'group_icon': groupIcon,
    };

    final response = await _apiClient.postMultipart(
      ApiEndpoints.createTraderGroup,
      fields: fields,
      files: files,
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return CreateGroupResponse.fromJson(response);
  }

  Future<AllTraderGroupsResponse> getAllTraderGroups({
    String? search,
    int? perPage,
    int? page,
  }) async {
    final queryParams = <String, String>{
      if (search != null) 'search': search,
      if (perPage != null) 'per_page': perPage.toString(),
      if (page != null) 'page': page.toString(),
    };

    final uri = Uri(path: ApiEndpoints.getAllTraderGroups, queryParameters: queryParams);

    final response = await _apiClient.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return AllTraderGroupsResponse.fromJson(response);
  }

  Future<TraderMessageResponse> deleteTraderGroup({
    required int groupId,
    required String reason,
  }) async {
    final response = await _apiClient.delete(
      'api/trader/groups/$groupId',
      body: {
        'reason': reason,
      },
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );

    return TraderMessageResponse.fromJson(response);
  }

  Future<SingleGroupResponse> getSingleGroup(int groupId) async {
    final response = await _apiClient.get(
      'api/trader/groups/$groupId',
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );
    return SingleGroupResponse.fromJson(response);
  }

  Future<GroupMembersResponse> getGroupMembers({
    required int groupId,
    String? search,
    int? perPage,
  }) async {
    final queryParams = {
      'group_id': groupId.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
      if (perPage != null) 'per_page': perPage.toString(),
    };

    final uri = Uri(path: 'api/trader/groups/members', queryParameters: queryParams);

    final response = await _apiClient.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );
    return GroupMembersResponse.fromJson(response);
  }

  Future<TraderMessageResponse> changeGroupMemberRole({
    required int groupId,
    required int userId,
    required String role,
  }) async {
    final response = await _apiClient.post(
      'api/trader/groups/change-status',
      body: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
        'role': role,
      },
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );
    return TraderMessageResponse.fromJson(response);
  }

  Future<TraderMessageResponse> removeGroupMemberRequest({
    required int groupId,
    required int userId,
    required String reason,
  }) async {
    final response = await _apiClient.post(
      'api/trader/groups/remove-member-request',
      body: {
        'group_id': groupId.toString(),
        'user_id': userId.toString(),
        'reason': reason,
      },
      headers: {'Authorization': 'Bearer ${_sessionService.authToken ?? ''}'},
    );
    return TraderMessageResponse.fromJson(response);
  }
}

