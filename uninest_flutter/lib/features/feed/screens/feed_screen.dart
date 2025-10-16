import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  
  final List<Post> _posts = [
    Post(
      id: '1',
      authorName: 'John Doe',
      authorAvatar: '',
      content: 'Just finished my final exams! 🎉 Time to relax and enjoy the break. Anyone up for a movie night?',
      imageUrl: '',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      likes: 15,
      comments: 3,
      isLiked: false,
      type: PostType.text,
    ),
    Post(
      id: '2',
      authorName: 'Sarah Smith',
      authorAvatar: '',
      content: 'Selling my engineering textbooks at great prices! All in excellent condition. DM me if interested 📚',
      imageUrl: '',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 8,
      comments: 5,
      isLiked: true,
      type: PostType.marketplace,
    ),
    Post(
      id: '3',
      authorName: 'Mike Johnson',
      authorAvatar: '',
      content: 'Beautiful sunset from the hostel rooftop today! 🌅',
      imageUrl: '',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 32,
      comments: 7,
      isLiked: false,
      type: PostType.photo,
    ),
    Post(
      id: '4',
      authorName: 'Emily Davis',
      authorAvatar: '',
      content: 'Study group forming for Advanced Mathematics. We meet every Tuesday and Thursday at 6 PM in the library. Join us! 📖',
      imageUrl: '',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      likes: 12,
      comments: 8,
      isLiked: true,
      type: PostType.study,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ).createShader(bounds),
              child: const Text(
                'Feed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            centerTitle: true,
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Navigate to search
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // Show notifications
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Study'),
                Tab(text: 'Market'),
                Tab(text: 'Events'),
              ],
            ),
          ),
        ],
        body: Column(
          children: [
            // Create Post Section
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.surface,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _showCreatePostDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          'What\'s on your mind?',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: _showCreatePostDialog,
                    icon: Icon(
                      Icons.photo_camera,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Posts Feed
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostsList(_posts),
                  _buildPostsList(_posts.where((p) => p.type == PostType.study).toList()),
                  _buildPostsList(_posts.where((p) => p.type == PostType.marketplace).toList()),
                  _buildPostsList(_posts.where((p) => p.type == PostType.event).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsList(List<Post> posts) {
    if (posts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No posts yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Be the first to share something!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh posts
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _PostCard(
            post: post,
            onLike: () => _toggleLike(post),
            onComment: () => _showComments(post),
            onShare: () => _sharePost(post),
          );
        },
      ),
    );
  }

  void _showCreatePostDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CreatePostSheet(),
    );
  }

  void _toggleLike(Post post) {
    setState(() {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CommentsSheet(post: post),
    );
  }

  void _sharePost(Post post) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post shared!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const _PostCard({
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.authorName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTypeColor(post.type).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _getTypeText(post.type),
                              style: TextStyle(
                                color: _getTypeColor(post.type),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _formatTimestamp(post.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show post options
                  },
                ),
              ],
            ),
          ),
          
          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.content,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          
          // Post Image (if any)
          if (post.type == PostType.photo)
            Container(
              margin: const EdgeInsets.all(16),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${post.likes} likes',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${post.comments} comments',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: onLike,
                        icon: Icon(
                          post.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: post.isLiked ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                        label: Text(
                          'Like',
                          style: TextStyle(
                            color: post.isLiked ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: onComment,
                        icon: const Icon(Icons.comment_outlined, color: Colors.grey, size: 20),
                        label: const Text(
                          'Comment',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: onShare,
                        icon: const Icon(Icons.share_outlined, color: Colors.grey, size: 20),
                        label: const Text(
                          'Share',
                          style: TextStyle(color: Colors.grey),
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

  Color _getTypeColor(PostType type) {
    switch (type) {
      case PostType.text:
        return Colors.blue;
      case PostType.photo:
        return Colors.purple;
      case PostType.marketplace:
        return Colors.green;
      case PostType.study:
        return Colors.orange;
      case PostType.event:
        return Colors.red;
    }
  }

  String _getTypeText(PostType type) {
    switch (type) {
      case PostType.text:
        return 'Post';
      case PostType.photo:
        return 'Photo';
      case PostType.marketplace:
        return 'Selling';
      case PostType.study:
        return 'Study';
      case PostType.event:
        return 'Event';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }
}

class _CreatePostSheet extends StatefulWidget {
  const _CreatePostSheet();

  @override
  State<_CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<_CreatePostSheet> {
  final TextEditingController _contentController = TextEditingController();
  PostType _selectedType = PostType.text;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const Spacer(),
                Text(
                  'Create Post',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _contentController.text.isNotEmpty ? () {
                    Navigator.pop(context);
                    // Create post logic
                  } : null,
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Type Selector
                  Text(
                    'Post Type',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: PostType.values.map((type) => 
                      FilterChip(
                        label: Text(_getTypeText(type)),
                        selected: _selectedType == type,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedType = type;
                            });
                          }
                        },
                      ),
                    ).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Content Input
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Add photo
                  },
                  icon: const Icon(Icons.photo_camera),
                ),
                IconButton(
                  onPressed: () {
                    // Add location
                  },
                  icon: const Icon(Icons.location_on),
                ),
                IconButton(
                  onPressed: () {
                    // Add emoji
                  },
                  icon: const Icon(Icons.emoji_emotions),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeText(PostType type) {
    switch (type) {
      case PostType.text:
        return 'General';
      case PostType.photo:
        return 'Photo';
      case PostType.marketplace:
        return 'Selling';
      case PostType.study:
        return 'Study Group';
      case PostType.event:
        return 'Event';
    }
  }
}

class _CommentsSheet extends StatelessWidget {
  final Post post;

  const _CommentsSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Comments',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const Divider(height: 1),
          
          // Comments List
          const Expanded(
            child: Center(
              child: Text(
                'No comments yet.\nBe the first to comment!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          
          // Comment Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // Send comment
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final String imageUrl;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final bool isLiked;
  final PostType type;

  Post({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.type,
  });

  Post copyWith({
    String? id,
    String? authorName,
    String? authorAvatar,
    String? content,
    String? imageUrl,
    DateTime? timestamp,
    int? likes,
    int? comments,
    bool? isLiked,
    PostType? type,
  }) {
    return Post(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      type: type ?? this.type,
    );
  }
}

enum PostType {
  text,
  photo,
  marketplace,
  study,
  event,
}
