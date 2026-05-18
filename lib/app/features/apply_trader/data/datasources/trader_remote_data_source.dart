import '../../../../core/network/api_client.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/values/app_constants.dart';
import '../models/trader_message_response.dart';
import '../models/subscription_plan.dart';
import '../models/my_subscription.dart';

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
}
