import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

// Sample profile model - you'll replace this with your actual data model
class ProfileCard {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> tags;
  final String location;
  final String type; // 'model' or 'brand'

  ProfileCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.location,
    required this.type,
  });
}

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  late MatchEngine _matchEngine;
  final List<SwipeItem> _swipeItems = [];
  
  // Sample data - replace with actual data from Supabase
  final List<ProfileCard> _profiles = [
    ProfileCard(
      id: '1',
      name: 'Alex Turner',
      imageUrl: 'https://via.placeholder.com/400x600/FF6B6B/FFFFFF?text=Model+1',
      tags: ['streetwear', 'editorial', 'fitness'],
      location: 'New York, NY',
      type: 'model',
    ),
    ProfileCard(
      id: '2',
      name: 'Nike Athletics',
      imageUrl: 'https://via.placeholder.com/400x600/4ECDC4/FFFFFF?text=Brand+1',
      tags: ['sportswear', 'fitness', 'commercial'],
      location: 'Portland, OR',
      type: 'brand',
    ),
    ProfileCard(
      id: '3',
      name: 'Jordan Smith',
      imageUrl: 'https://via.placeholder.com/400x600/95E1D3/FFFFFF?text=Model+2',
      tags: ['editorial', 'commercial', 'beauty'],
      location: 'Los Angeles, CA',
      type: 'model',
    ),
    ProfileCard(
      id: '4',
      name: 'Gucci Fashion',
      imageUrl: 'https://via.placeholder.com/400x600/F38181/FFFFFF?text=Brand+2',
      tags: ['luxury', 'editorial', 'runway'],
      location: 'Milan, Italy',
      type: 'brand',
    ),
    ProfileCard(
      id: '5',
      name: 'Emma Chen',
      imageUrl: 'https://via.placeholder.com/400x600/AA96DA/FFFFFF?text=Model+3',
      tags: ['streetwear', 'commercial', 'fitness'],
      location: 'San Francisco, CA',
      type: 'model',
    ),
  ];

  String _selectedFilter = 'Nearby';

  @override
  void initState() {
    super.initState();
    _initializeSwipeItems();
  }

  void _initializeSwipeItems() {
    for (var profile in _profiles) {
      _swipeItems.add(SwipeItem(
        content: profile,
        likeAction: () {
          _handleLike(profile);
        },
        nopeAction: () {
          _handleReject(profile);
        },
        superlikeAction: () {
          _handleSuperLike(profile);
        },
      ));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void _handleLike(ProfileCard profile) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('❤️ You liked ${profile.name}'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
    // TODO: Save like to Supabase
    // TODO: Check for mutual match
  }

  void _handleReject(ProfileCard profile) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✕ You passed on ${profile.name}'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
    // TODO: Save rejection to Supabase
  }

  void _handleSuperLike(ProfileCard profile) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⭐ You super liked ${profile.name}!'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
      ),
    );
    // TODO: Save super like to Supabase
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            onPressed: _showFiltersDialog,
            icon: const Icon(Icons.tune),
          )
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              // children: [
              //   _buildFilterChip('Nearby'),
              //   _buildFilterChip('Streetwear'),
              //   _buildFilterChip('Editorial'),
              //   _buildFilterChip('Commercial'),
              // ],
            ),
          ),
          
          // Swipe cards
          Expanded(
            child: _swipeItems.isEmpty
                ? _buildEmptyState(cs)
                : SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      final profile = _swipeItems[index].content as ProfileCard;
                      return _buildProfileCard(profile, cs);
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No more profiles to show'),
                        ),
                      );
                    },
                    itemChanged: (SwipeItem item, int index) {
                      // Optional: track which card is currently showing
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 24, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.close_rounded,
                  color: cs.error,
                  onPressed: () {
                    if (_swipeItems.isNotEmpty) {
                      _matchEngine.currentItem?.nope();
                    }
                  },
                ),
                _buildActionButton(
                  context,
                  icon: Icons.star,
                  color: Colors.blue,
                  onPressed: () {
                    if (_swipeItems.isNotEmpty) {
                      _matchEngine.currentItem?.superLike();
                    }
                  },
                  size: 56,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.favorite,
                  color: cs.primary,
                  onPressed: () {
                    if (_swipeItems.isNotEmpty) {
                      _matchEngine.currentItem?.like();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'Nearby';
          });
          // TODO: Filter profiles based on selection
        },
      ),
    );
  }

  Widget _buildProfileCard(ProfileCard profile, ColorScheme cs) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.network(
                profile.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: cs.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 64),
                    ),
                  );
                },
              ),
            ),
            
            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ),
            
            // Profile info
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: profile.type == 'model' 
                              ? Colors.purple.withOpacity(0.8)
                              : Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          profile.type.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        color: Colors.white70,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Swipe indicators
            Positioned(
              top: 40,
              left: 40,
              child: Transform.rotate(
                angle: -0.3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'NOPE',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: Transform.rotate(
                angle: 0.3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'LIKE',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    double size = 64,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: size * 0.5),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: cs.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No more profiles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new matches',
            style: TextStyle(
              fontSize: 16,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              leading: Icon(Icons.place_outlined),
              title: Text('Distance'),
              subtitle: Text('Within 50 km'),
            ),
            ListTile(
              leading: Icon(Icons.category_outlined),
              title: Text('Categories'),
              subtitle: Text('All selected'),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Collaboration Type'),
              subtitle: Text('All types'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Apply filters
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}