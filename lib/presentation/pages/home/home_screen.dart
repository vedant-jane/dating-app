import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/user_profile.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../../widgets/swipable_hero_card.dart';
import '../../widgets/compliment_sheet.dart';
import '../notifications/notifications_screen.dart';
import '../chat/chat_conversation_page.dart';
import 'widgets/profile_detail_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final homeBloc = context.read<HomeBloc>();
      if (homeBloc.state is HomeInitial) {
        homeBloc.add(const LoadHomeUsers());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _openComplimentSheet(
      BuildContext context, String title, UserProfile user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return ComplimentBottomSheet(
          title: title,
          onSend: (compliment, giftType) {
            context.read<HomeBloc>().add(
                  SendComplimentEvent(
                    compliment: compliment,
                    giftType: giftType,
                  ),
                );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Text('🌹', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$giftType + Comment sent! Opening chat...',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.black87,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );

            Future.delayed(const Duration(milliseconds: 600), () {
              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatConversationPage(
                      userName: user.name,
                      userImage: user.primaryImageUrl,
                      initialCompliment: compliment,
                      initialGift: giftType,
                    ),
                  ),
                );
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: _buildTopCircleButton(
              icon: Icons.menu_rounded,
              onTap: () {},
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 3.5,
                backgroundColor: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                'Daily 25',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        actions: [
          _buildTopCircleButton(
            icon: Icons.bolt_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _buildTopCircleButton(
            icon: Icons.tune_rounded,
            iconSize: 20,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _buildTopCircleButton(
            icon: Icons.notifications_none_rounded,
            hasBadge: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return _buildSkeletonLoader();
            }

            if (state is HomeError) {
              return _buildErrorState(context, state.message);
            }

            if (state is HomeLoaded) {
              final user = state.currentUser;
              if (user == null) {
                return _buildAllCaughtUp(context);
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final double cardHeight = constraints.maxHeight - 16;
                  return RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async {
                      context.read<HomeBloc>().add(const RefreshHomeUsers());
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Interactive Swipable Top Card
                          SwipableHeroCard(
                            key: ValueKey(user.id),
                            user: user,
                            canUndo: state.canUndo,
                            height: cardHeight,
                            onSwipeLeft: () {
                              context.read<HomeBloc>().add(const SwipeLeftUser());
                              _scrollToTop();
                            },
                            onSwipeRight: () {
                              context.read<HomeBloc>().add(const SwipeRightUser());
                              _scrollToTop();
                            },
                            onUndo: () {
                              context.read<HomeBloc>().add(const UndoSwipeUser());
                              _scrollToTop();
                            },
                            onRoseTap: () {
                              _openComplimentSheet(context, 'Profile Photo', user);
                            },
                          ),
                          const SizedBox(height: 16),

                          // Scrollable Details
                          ProfileDetailContent(
                            user: user,
                            onComplimentTap: (title) =>
                                _openComplimentSheet(context, title, user),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTopCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    double iconSize = 22,
    bool hasBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: AppColors.textDark, size: iconSize),
            if (hasBadge)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: const Color(0xFFECEAE4),
          borderRadius: BorderRadius.circular(28),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Finding your matches...',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.primary,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(const LoadHomeUsers());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCaughtUp(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Text('🎉', style: TextStyle(fontSize: 48)),
          ),
          const SizedBox(height: 16),
          const Text(
            "You're all caught up!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check back soon or pull down to discover more profiles.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(const LoadHomeUsers());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Refresh Profiles',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
