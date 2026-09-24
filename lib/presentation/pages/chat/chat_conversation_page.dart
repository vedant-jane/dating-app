import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final bool isGift;
  final String? giftTitle;
  final String? reactedTo;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.isGift = false,
    this.giftTitle,
    this.reactedTo,
  });
}

class ChatConversationPage extends StatefulWidget {
  final String userName;
  final String userImage;
  final String? initialCompliment;
  final String? initialGift;

  const ChatConversationPage({
    super.key,
    this.userName = 'Aanya',
    this.userImage =
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    this.initialCompliment,
    this.initialGift,
  });

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    final compliment = widget.initialCompliment ??
        "If you're as fun in person as your profile, I'm in.";

    _messages.addAll([
      ChatMessage(
        text: compliment,
        isMe: true,
        time: '1:04 PM',
        reactedTo: "${widget.userName}'s About",
      ),
      ChatMessage(
        text: '"A little something to brighten your day 🌹"',
        isMe: true,
        time: '1:04 PM',
        isGift: true,
        giftTitle: 'Rose • 10 coins',
      ),
    ]);
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isMe: true,
          time: '1:05 PM',
        ),
      );
      _msgController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate reply after 1.5s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'Aw thank you so much! 😊 How is your week going?',
            isMe: false,
            time: '1:06 PM',
          ),
        );
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: CachedNetworkImageProvider(widget.userImage),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.onlineGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PLATINUM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_outlined, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Relationship Progress & Venue Card Header
            _buildProgressAndVenueHeader(),

            // Chat Feed
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildMessageItem(msg);
                },
              ),
            ),

            // Chat Input Bar
            _buildChatInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressAndVenueHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Milestone Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RELATIONSHIP PROGRESS',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'LEVEL 5',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '🎯 Milestone reached: Premium Badge unlocked',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          // Tabs: Gifts 12, Compliments, Date Invites
          Row(
            children: [
              _buildHeaderTab('🎁 Gifts 12', isActive: true),
              const SizedBox(width: 8),
              _buildHeaderTab('💬 Compliments'),
              const SizedBox(width: 8),
              _buildHeaderTab('📅 Date Invites'),
            ],
          ),
          const SizedBox(height: 12),

          // Date / Meeting Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primaryBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.primary, size: 18),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Meet at the venue • your exact location stays private.\nHave a great date!',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12.5,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Venue Pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('📍', style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Text(
                        'Blue Tokai',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Add to calendar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.divider),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Get directions',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTab(String title, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primarySoft : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.divider,
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage msg) {
    if (msg.isGift) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.centerRight,
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.primaryBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('🌹', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(
                        msg.giftTitle ?? 'Rose',
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'SENT',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                msg.text,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (msg.reactedTo != null) ...[
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'TODAY',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6, bottom: 4),
            child: Text(
              'You reacted to ${msg.reactedTo}:',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: msg.isMe ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(msg.isMe ? 20 : 4),
              bottomRight: Radius.circular(msg.isMe ? 4 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                msg.text,
                style: TextStyle(
                  color: msg.isMe ? Colors.white : AppColors.textDark,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                msg.time,
                style: TextStyle(
                  color: msg.isMe ? Colors.white70 : AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.card_giftcard_rounded,
                color: AppColors.primary, size: 24),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Message ${widget.userName}...',
                        hintStyle: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const Text('😊', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
