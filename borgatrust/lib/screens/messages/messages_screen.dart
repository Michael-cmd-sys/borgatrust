// File: lib/screens/messages/messages_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/african_pattern_container.dart';
import 'chat_detail_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _conversations = [
    {
      "name": "Kwame Mensah",
      "avatar": "assets/images/provider_web_dev.jpg",
      "lastMessage": "I've sent you the website mockup. Let me know what you think!",
      "time": "10:30 AM",
      "unread": 2,
      "isOnline": true,
    },
    {
      "name": "Ama Serwaa",
      "avatar": "assets/images/provider_graphic_design.jpg",
      "lastMessage": "The logo design is almost complete. Just need to make a few color adjustments.",
      "time": "Yesterday",
      "unread": 0,
      "isOnline": false,
    },
    {
      "name": "Kofi Adu",
      "avatar": "assets/images/provider_content_writing.jpg",
      "lastMessage": "Thank you for your feedback! I'll revise the article accordingly.",
      "time": "Yesterday",
      "unread": 0,
      "isOnline": true,
    },
    {
      "name": "Akua Mensah",
      "avatar": "assets/images/provider_events.jpg",
      "lastMessage": "Great meeting you today. I'd be happy to help with your event planning.",
      "time": "Monday",
      "unread": 0,
      "isOnline": false,
    },
    {
      "name": "Joseph Ansah",
      "avatar": "assets/images/provider_legal.jpg",
      "lastMessage": "I've prepared the documents you requested. Let's schedule a call to discuss.",
      "time": "Monday",
      "unread": 1,
      "isOnline": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text(
          "Messages",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMedium,
          tabs: const [
            Tab(text: "Chats"),
            Tab(text: "Requests"),
          ],
        ),
      ),
      body: AfricanPatternContainer(
        opacity: 0.02,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildChatsTab(),
            _buildRequestsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsTab() {
    return _conversations.isEmpty
        ? _buildEmptyState(
            icon: Icons.chat_bubble_outline,
            message: "No conversations yet",
            description: "Your conversations with service providers will appear here",
          )
        : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              final conversation = _conversations[index];
              return _buildConversationTile(conversation);
            },
          );
  }

  Widget _buildRequestsTab() {
    // For demo purposes, showing an empty state for message requests
    return _buildEmptyState(
      icon: Icons.mail_outline,
      message: "No message requests",
      description: "New connection requests will appear here",
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    required String description,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConversationTile(Map<String, dynamic> conversation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                name: conversation["name"],
                avatar: conversation["avatar"],
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      conversation["avatar"],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: AppColors.primaryLight,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ),
                  if (conversation["isOnline"])
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            conversation["name"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Text(
                          conversation["time"],
                          style: TextStyle(
                            fontSize: 12,
                            color: conversation["unread"] > 0
                                ? AppColors.primary
                                : AppColors.textLight,
                            fontWeight: conversation["unread"] > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            conversation["lastMessage"],
                            style: TextStyle(
                              fontSize: 14,
                              color: conversation["unread"] > 0
                                  ? AppColors.textDark
                                  : AppColors.textMedium,
                              fontWeight: conversation["unread"] > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation["unread"] > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              conversation["unread"].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}