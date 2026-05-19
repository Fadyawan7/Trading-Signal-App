import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_view_model.dart';
import '../../apply_trader/domain/repositories/trader_repository.dart';
import '../../apply_trader/data/models/single_group_response.dart';
import '../../apply_trader/data/models/group_members_response.dart';
import '../../../core/network/api_exception.dart';

class GroupChatViewModel extends BaseViewModel {
  final _traderRepository = Get.find<TraderRepository>();

  final rxGroup = Rxn<SingleGroupData>();
  final rxMembers = <GroupMemberItem>[].obs;
  final rxFilteredMembers = <GroupMemberItem>[].obs;
  final rxSearchQuery = ''.obs;
  
  final isLoadingData = false.obs;
  final isRoleUpdating = false.obs;

  final searchController = TextEditingController();
  int? groupId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['groupId'] != null) {
      groupId = int.tryParse(args['groupId'].toString());
      if (groupId != null) {
        loadAllData();
      }
    }
  }

  Future<void> loadAllData() async {
    if (groupId == null) return;
    isLoadingData.value = true;
    try {
      await fetchGroupDetails();
      await fetchGroupMembers();
    } catch (e) {
      final errorMsg = e is ApiException ? e.message : e.toString();
      showError('Failed to load group details: $errorMsg');
    } finally {
      isLoadingData.value = false;
    }
  }

  Future<void> fetchGroupDetails() async {
    if (groupId == null) return;
    final res = await _traderRepository.getSingleGroup(groupId!);
    if (res.status && res.data != null) {
      rxGroup.value = res.data;
    }
  }

  Future<void> fetchGroupMembers({String? query}) async {
    if (groupId == null) return;
    final res = await _traderRepository.getGroupMembers(
      groupId: groupId!,
      search: query,
    );
    if (res.status && res.data != null) {
      rxMembers.assignAll(res.data!.list);
      rxFilteredMembers.assignAll(res.data!.list);
    }
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      rxFilteredMembers.assignAll(rxMembers);
    } else {
      final lowercaseQuery = query.toLowerCase();
      rxFilteredMembers.assignAll(
        rxMembers.where((m) =>
            m.user.name.toLowerCase().contains(lowercaseQuery) ||
            m.user.email.toLowerCase().contains(lowercaseQuery)),
      );
    }
  }

  Future<void> updateMemberRole(GroupMemberItem member, String newRole) async {
    if (groupId == null) return;
    isRoleUpdating.value = true;
    try {
      final res = await _traderRepository.changeGroupMemberRole(
        groupId: groupId!,
        userId: member.user.userId,
        role: newRole,
      );

      if (res.status) {
        showSuccess(res.message.isNotEmpty ? res.message : 'Role updated successfully');
        await fetchGroupMembers(query: searchController.text.trim());
      } else {
        showError(res.message.isNotEmpty ? res.message : 'Could not change member role.');
      }
    } catch (e) {
      final errorMsg = e is ApiException ? e.message : e.toString();
      showError(errorMsg);
    } finally {
      isRoleUpdating.value = false;
    }
  }

  Future<bool> removeMember(GroupMemberItem member, String reason) async {
    if (groupId == null) return false;
    isRoleUpdating.value = true;
    try {
      final res = await _traderRepository.removeGroupMemberRequest(
        groupId: groupId!,
        userId: member.user.userId,
        reason: reason,
      );

      if (res.status) {
        showSuccess(res.message.isNotEmpty ? res.message : 'Removal request sent successfully');
        return true;
      } else {
        showError(res.message.isNotEmpty ? res.message : 'Could not send removal request.');
      }
    } catch (e) {
      final errorMsg = e is ApiException ? e.message : e.toString();
      showError(errorMsg);
    } finally {
      isRoleUpdating.value = false;
    }
    return false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
