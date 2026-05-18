import '../../domain/repositories/trader_repository.dart';
import '../datasources/trader_remote_data_source.dart';
import '../models/trader_message_response.dart';
import '../models/subscription_plan.dart';
import '../models/my_subscription.dart';

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
}
