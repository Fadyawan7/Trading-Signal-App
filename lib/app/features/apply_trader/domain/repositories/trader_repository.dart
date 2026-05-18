import '../../data/models/trader_message_response.dart';
import '../../data/models/subscription_plan.dart';
import '../../data/models/my_subscription.dart';

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
}
