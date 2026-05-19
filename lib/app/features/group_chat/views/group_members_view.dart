import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_loading_overlay.dart';
import '../../apply_trader/data/models/single_group_response.dart';
import '../../apply_trader/data/models/group_members_response.dart';
import '../viewmodel/group_chat_view_model.dart';

class GroupMembersView extends GetView<GroupChatViewModel> {
  const GroupMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoadingData.value;
      final isRoleUpdating = controller.isRoleUpdating.value;
      final group = controller.rxGroup.value;

      return AppLoadingOverlay(
        isLoading: isRoleUpdating,
        message: 'Updating member role...',
        child: Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: true,

          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : group == null
                  ? _buildEmptyState()
                  : _buildBody(context, group),
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 54, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Failed to load group details',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 2,
              ),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () => controller.loadAllData(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SingleGroupData group) {
    return RefreshIndicator(
      onRefresh: () => controller.loadAllData(),
      color: AppColors.primary,
      backgroundColor: AppColors.card,
      child: CustomScrollView(
        slivers: [
          // Dynamic Header
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 2,
            backgroundColor: AppColors.background,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _CircularButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Get.back(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _CircularButton(
                  icon: Icons.refresh_rounded,
                  onTap: () => controller.loadAllData(),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeaderBackground(group),
              titlePadding: const EdgeInsets.symmetric(horizontal: 56, vertical: 14),
              title: LayoutBuilder(
                builder: (context, constraints) {
                  final isCollapsed = constraints.biggest.height <= kToolbarHeight + 60;
                  return isCollapsed
                      ? Text(
                          group.groupName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),

          // Core Stats, About Card, Search & Members
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Stat Cards Section
                  _buildStatCardsRow(group),
                  const SizedBox(height: 20),

                  // Beautiful About Group Card
                  _buildAboutCard(group),
                  const SizedBox(height: 24),

                  // Header and search bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            'Members • ${controller.rxFilteredMembers.length}',
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Group Members dynamic list
          Obx(() {
            final members = controller.rxFilteredMembers;
            if (members.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: Text(
                      'No members found in this group',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final member = members[index];
                    return _buildMemberTile(context, member);
                  },
                  childCount: members.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground(SingleGroupData group) {
    final bool isUrl = group.groupIcon != null &&
        (group.groupIcon!.startsWith('http://') ||
            group.groupIcon!.startsWith('https://') ||
            group.groupIcon!.contains('/'));

    return Stack(
      fit: StackFit.expand,
      children: [
        // Premium gradient mesh background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.background,
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Beautiful glowing avatar border
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    width: 2.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Center(
                    child: group.groupIcon != null && group.groupIcon!.isNotEmpty
                        ? (isUrl
                            ? Image.network(
                                group.groupIcon!,
                                fit: BoxFit.cover,
                                width: 96,
                                height: 96,
                                errorBuilder: (_, __, ___) => Icon(
                                      Icons.group_rounded,
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                              )
                            : Text(
                                group.groupIcon!,
                                style: const TextStyle(fontSize: 44),
                              ))
                        : Icon(
                            Icons.group_rounded,
                            size: 40,
                            color: AppColors.primary,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  group.groupName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Created date pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                ),
                child: Text(
                  'Created ${group.createdAt != null ? group.createdAt!.split("T")[0] : "recently"}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCardsRow(SingleGroupData group) {
    final double capacityProgress = group.maximumMembers > 0
        ? (group.membersCount / group.maximumMembers).clamp(0.0, 1.0)
        : 0.0;

    return Row(
      children: [
        // 1. Pricing Stat Card
        Expanded(
          child: _buildGlassStatCard(
            title: 'Pricing Plan',
            value: group.isPaid ? '\$${group.price}' : 'Free Plan',
            icon: Icons.monetization_on_rounded,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        // 2. Access Stat Card
        Expanded(
          child: _buildGlassStatCard(
            title: 'Messaging',
            value: group.onlyAdminCanMessage ? 'Admin Only' : 'Everyone',
            icon: group.onlyAdminCanMessage ? Icons.lock_rounded : Icons.chat_bubble_rounded,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 10),
        // 3. Members Limit Stat Card
        Expanded(
          child: _buildGlassStatCard(
            title: 'Capacity',
            value: '${group.membersCount}/${group.maximumMembers}',
            icon: Icons.people_alt_rounded,
            color: Colors.cyan,
            progress: capacityProgress,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    double? progress,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 14),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (progress != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3.5,
                backgroundColor: color.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ],
      ),
    );
  }

Widget _buildAboutCard(SingleGroupData group) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          // Vertical accent strip
          Positioned(
            left: 0,
            top: 16,
            bottom: 16,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),
          // Content padding
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Group',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  group.description.isNotEmpty ? group.description : 'No description set for this trading group.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: AppColors.mutedText, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: (val) {
                controller.rxSearchQuery.value = val;
                controller.performSearch(val);
              },
              style: TextStyle(color: AppColors.text, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search members...',
                hintStyle: TextStyle(color: AppColors.mutedText, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          Obx(() {
            final hasQuery = controller.rxSearchQuery.value.isNotEmpty;
            return hasQuery
                ? GestureDetector(
                    onTap: () {
                      controller.searchController.clear();
                      controller.rxSearchQuery.value = '';
                      controller.performSearch('');
                    },
                    child: Icon(Icons.close_rounded, color: AppColors.mutedText, size: 18),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, GroupMemberItem member) {
    final initials = member.user.name.isNotEmpty
        ? member.user.name
            .trim()
            .split(' ')
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase()
        : '??';

    final bool isOwner = member.role == 'owner';
    final bool isAdmin = member.role == 'admin';

    // Premium dynamic role gradients
    LinearGradient avatarGradient = const LinearGradient(
      colors: [Color(0xFF64748B), Color(0xFF475569)],
    );
    Color tagBorderColor = Colors.grey.withValues(alpha: 0.3);
    Color tagBgColor = Colors.grey.withValues(alpha: 0.05);
    Color tagTextColor = Colors.grey;

    if (isOwner) {
      avatarGradient = const LinearGradient(
        colors: [Color(0xFFF43F5E), Color(0xFFE11D48)], // Elegant rose gradient
      );
      tagBorderColor = Colors.redAccent.withValues(alpha: 0.3);
      tagBgColor = Colors.redAccent.withValues(alpha: 0.1);
      tagTextColor = Colors.redAccent;
    } else if (isAdmin) {
      avatarGradient = const LinearGradient(
        colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)], // Slick sky blue gradient
      );
      tagBorderColor = AppColors.primary.withValues(alpha: 0.3);
      tagBgColor = AppColors.primary.withValues(alpha: 0.1);
      tagTextColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // WhatsApp style profile initials circle with dynamic role gradient
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: avatarGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: (isOwner ? Colors.red : (isAdmin ? AppColors.primary : Colors.grey))
                      .withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User details info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        member.user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (isOwner || isAdmin) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: tagBgColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: tagBorderColor),
                        ),
                        child: Text(
                          isOwner ? 'Owner' : 'Admin',
                          style: TextStyle(
                            color: tagTextColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  member.user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!isOwner)
            IconButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: AppColors.mutedText,
              ),
              onPressed: () => _showMemberActionSheet(context, member),
            ),
        ],
      ),
    );
  }

  void _showMemberActionSheet(BuildContext context, GroupMemberItem member) {
    final bool isAdmin = member.role == 'admin';

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Manage Member',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Update role for ${member.user.name}',
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.back();
                controller.updateMemberRole(member, isAdmin ? 'member' : 'admin');
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      isAdmin ? Icons.person_remove_rounded : Icons.verified_user_rounded,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isAdmin ? 'Dismiss as Admin' : 'Make Group Admin',
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Get.back();
                _showRemoveMemberDialog(context, member);
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_off_rounded,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Remove Member',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRemoveMemberDialog(BuildContext context, GroupMemberItem member) {
    final reasonController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.1),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 1.5),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Beautiful Warning Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange.shade400,
                        Colors.orange.shade900,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person_remove_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 24),
                Text(
                  'Remove Member?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.mutedText,
                    ),
                    children: [
                      const TextSpan(text: 'Are you sure you want to remove '),
                      TextSpan(
                        text: member.user.name,
                        style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' from this group? Please provide a reason below:'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.text, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Reason for removal...',
                    hintStyle: TextStyle(color: AppColors.mutedText.withValues(alpha: 0.5), fontSize: 13),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.orange.withValues(alpha: 0.5), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final reason = reasonController.text.trim();
                        if (reason.isEmpty) {
                          Get.snackbar(
                            'Required',
                            'Please provide a reason to remove this member',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.orange.withValues(alpha: 0.15),
                            colorText: Colors.white,
                          );
                          return;
                        }
                        
                        // Close keyboard
                        FocusScope.of(context).unfocus();
                        
                        final success = await controller.removeMember(member, reason);
                        if (success) {
                          Get.back(); // Close dialog on success
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Remove Member',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircularButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.card,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.text, size: 18),
      ),
    );
  }
}
