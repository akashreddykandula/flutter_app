import 'package:flutter/material.dart';

// --- MAIN APPLICATION SETUP ---

void main() {
  runApp(const BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the primary color theme for the app
    final MaterialColor primaryRed = MaterialColor(
      _RedTheme.primaryColor.value,
      <int, Color>{
        50: const Color(0xFFFFEBEE),
        100: const Color(0xFFFFCDD2),
        200: const Color(0xFFEF9A9A),
        300: const Color(0xFFE57373),
        400: const Color(0xFFEF5350),
        500: _RedTheme.primaryColor, // Main color
        600: const Color(0xFFE53935),
        700: const Color(0xFFD32F2F),
        800: const Color(0xFFC62828),
        900: const Color(0xFFB71C1C),
      },
    );

    return MaterialApp(
      title: 'LifeFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: primaryRed,
        primaryColor: _RedTheme.primaryColor,
        // Global text theme and primary background
        scaffoldBackgroundColor: _RedTheme.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: _RedTheme.primaryColor),
          titleTextStyle: TextStyle(
            color: _RedTheme.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
          elevation: 0.5,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _RedTheme.accentColor,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MainAppWrapper(),
    );
  }
}

// --- COLOR AND STYLE CONSTANTS ---

abstract class _RedTheme {
  static const Color primaryColor = Color(0xFFD81B60); // Deep Pinkish Red
  static const Color accentColor = Color(
    0xFFE94A6E,
  ); // Lighter Red/Pink for accents
  static const Color warningColor = Color(0xFFFFB300); // Amber for urgency
  static const Color successColor = Color(0xFF43A047); // Green for success
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color shadowColor = Color(0x11000000); // Light shadow
}

// --- UTILITY/MOCK DATA ---

class Campaign {
  final String id;
  final String title;
  final String location;
  final String date;
  final String bloodTypeNeeded;
  final String imageUrl;
  final String description;

  Campaign({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.bloodTypeNeeded,
    required this.imageUrl,
    required this.description,
  });
}

final List<Campaign> mockCampaigns = [
  Campaign(
    id: 'c1',
    title: 'City General Hospital Drive',
    location: 'Central Hall, City General',
    date: 'Oct 28, 2025 | 10:00 AM - 4:00 PM',
    bloodTypeNeeded: 'O+',
    imageUrl: 'assets/campaign1.jpg', // Placeholder for image asset
    description:
        'Help stock our emergency supply. We are critically low on O+ and A- blood types. All donors receive a complimentary snack box and a thank you gift.',
  ),
  Campaign(
    id: 'c2',
    title: 'University Campus Campaign',
    location: 'Student Union Building, Room 101',
    date: 'Nov 5, 2025 | 9:00 AM - 3:00 PM',
    bloodTypeNeeded: 'A-',
    imageUrl: 'assets/campaign2.jpg',
    description:
        'A special drive for students and staff. Every donation supports local pediatric care units. Walk-ins are welcome, but appointments are encouraged.',
  ),
  Campaign(
    id: 'c3',
    title: 'Community Center Weekend Drive',
    location: 'Northwood Community Center',
    date: 'Nov 12, 2025 | 11:00 AM - 5:00 PM',
    bloodTypeNeeded: 'B+',
    imageUrl: 'assets/campaign3.jpg',
    description:
        'Join your neighbors to save lives. B+ is in steady demand this month. Free health check-ups for all participants.',
  ),
];

// --- MAIN WRAPPER (Handles Splash and Auth Flow) ---

enum AppState { splash, auth, home }

class MainAppWrapper extends StatefulWidget {
  const MainAppWrapper({super.key});

  @override
  State<MainAppWrapper> createState() => _MainAppWrapperState();
}

class _MainAppWrapperState extends State<MainAppWrapper> {
  AppState _currentState = AppState.splash;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate initial loading and auth check
    await Future.delayed(const Duration(seconds: 3));

    // For this example, we immediately transition to the Auth Screen
    setState(() {
      _currentState = AppState.auth;
    });

    // Simulate successful login after another delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _currentState = AppState.home;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentState) {
      case AppState.splash:
        return const _SplashScreen();
      case AppState.auth:
        return const _AuthScreen(
          onLoginSuccess: null, // Login is auto-simulated in this structure
        );
      case AppState.home:
        return const _HomeScreen();
    }
  }
}

// --- 1. SPLASH SCREEN ---

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _RedTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Icon/Logo
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 1 + (1 - value) * 0.2, // Small scale-up effect
                    child: child,
                  ),
                );
              },
              // LOGO: Replaced Icon with Image.asset
              child: Image.asset(
                'assets/logo.png', // Assuming you have added assets/logo.png to your project
                height: 120.0,
                width: 120.0,
              ),
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'LifeFlow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find a drop, save a life.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. AUTH SCREEN (Login/Signup) ---

class _AuthScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  const _AuthScreen({this.onLoginSuccess});

  @override
  State<_AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<_AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
    if (_isLogin) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _RedTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LOGO: Replaced Icon with Image.asset
              Image.asset(
                'assets/logo.png', // Assuming you have added assets/logo.png to your project
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10),
              Text(
                _isLogin ? 'Welcome Back!' : 'Join LifeFlow',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              // Email Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email', Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              // Password Field
              TextFormField(
                obscureText: true,
                decoration: _inputDecoration('Password', Icons.lock_outline),
              ),
              // Signup specific field
              SizeTransition(
                sizeFactor: _animation,
                axis: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: _inputDecoration(
                        'Full Name',
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration('Blood Type', Icons.opacity),
                      value: 'O+',
                      items: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Action Button
              ElevatedButton(
                onPressed: () {
                  // Simulate action - MainAppWrapper handles the actual transition
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _RedTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isLogin ? 'LOGIN' : 'SIGN UP',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Toggle Button
              TextButton(
                onPressed: _toggleForm,
                child: Text(
                  _isLogin
                      ? "Don't have an account? Sign Up"
                      : "Already have an account? Login",
                  style: TextStyle(color: _RedTheme.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _RedTheme.primaryColor.withOpacity(0.7)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _RedTheme.primaryColor, width: 2),
      ),
    );
  }
}

// --- 3. HOME SCREEN (Bottom Navigation Container) ---

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _views = <Widget>[
    const _CampaignsView(),
    const _DonationHistoryView(),
    const _SearchView(),
    const _ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _views.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _RedTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        elevation: 10,
      ),
      // Floating Action Button for quick "Donate"
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToDonateScreen(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 30),
      ),
    );
  }

  void _navigateToDonateScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _DonateScreen(),
        fullscreenDialog: true,
      ),
    );
  }
}

// --- 3a. HOME/CAMPAIGNS VIEW ---

class _CampaignsView extends StatelessWidget {
  const _CampaignsView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar with Welcome Message
        SliverAppBar(
          backgroundColor: _RedTheme.backgroundColor,
          pinned: true,
          elevation: 0,
          title: const Text(
            'Welcome, Donor!',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              color: Colors.black54,
              onPressed: () => _navigateToNotifications(context),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black54,
              onPressed: () => _navigateToSettings(context),
            ),
            const SizedBox(width: 8),
          ],
        ),

        // Urgent Needs Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Card(
              color: _RedTheme.warningColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'URGENT NEED',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Immediate need for O- blood in the West Region. Your donation is critical right now.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Find Nearby Center'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _RedTheme.warningColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Campaigns Header
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Upcoming Campaigns Near You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        // Campaigns List
        SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            return _CampaignCard(campaign: mockCampaigns[index]);
          }, childCount: mockCampaigns.length),
        ),

        // Spacer for Bottom Nav Bar
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const _NotificationsScreen()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const _SettingsScreen()));
  }
}

// Campaign Card Widget
class _CampaignCard extends StatelessWidget {
  final Campaign campaign;
  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => _CampaignDetailScreen(campaign: campaign),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      campaign.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _RedTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _RedTheme.primaryColor),
                      ),
                      child: Text(
                        campaign.bloodTypeNeeded,
                        style: TextStyle(
                          color: _RedTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        campaign.date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        campaign.location,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
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

// --- 4. CAMPAIGN DETAIL SCREEN ---

class _CampaignDetailScreen extends StatelessWidget {
  final Campaign campaign;
  const _CampaignDetailScreen({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campaign.title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image (using a container for visual appeal)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: _RedTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _RedTheme.primaryColor, width: 2),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://placehold.co/600x200/FFCDD2/D81B60?text=Campaign+Image',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
              child: Center(
                child: Text(
                  'Need: ${campaign.bloodTypeNeeded}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _RedTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Key Details
            _buildDetailRow(
              Icons.schedule_rounded,
              'Date & Time',
              campaign.date,
            ),
            const Divider(height: 20),
            _buildDetailRow(Icons.location_pin, 'Location', campaign.location),
            const Divider(height: 20),
            _buildDetailRow(Icons.opacity_rounded, 'Urgency', 'Medium'),
            const Divider(height: 20),

            const Text(
              'About the Campaign',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              campaign.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 40),
            // Call to Action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToDonateScreen(context, campaign),
                icon: const Icon(Icons.calendar_month_outlined),
                label: const Text('Book Your Donation Slot'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _RedTheme.accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _RedTheme.primaryColor, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToDonateScreen(BuildContext context, Campaign campaign) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _DonateScreen(campaign: campaign),
        fullscreenDialog: true,
      ),
    );
  }
}

// --- 5. DONATE SCREEN (Booking Modal) ---

class _DonateScreen extends StatelessWidget {
  final Campaign? campaign;
  const _DonateScreen({this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _RedTheme.backgroundColor,
      appBar: AppBar(
        title: Text(campaign != null ? 'Book Donation' : 'Quick Donate'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (campaign != null) _buildCampaignSummary(campaign!),
            const SizedBox(height: 20),
            const Text(
              'Select Date and Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInputCard(
              icon: Icons.date_range_rounded,
              label: 'Select Date',
              hint: 'Tuesday, Nov 5',
              onTap: () {}, // Simulate date picker
            ),
            const SizedBox(height: 16),
            _buildInputCard(
              icon: Icons.access_time_filled,
              label: 'Select Time Slot',
              hint: '11:30 AM',
              onTap: () {}, // Simulate time picker
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showBookingConfirmation(context),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirm Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _RedTheme.successColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignSummary(Campaign campaign) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Campaign: ${campaign.title}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: _RedTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    campaign.location,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: _RedTheme.shadowColor,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: _RedTheme.primaryColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hint,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed!'),
        content: const Text(
          'Your donation slot has been successfully reserved. Check your history for details.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close donate screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// --- 6. DONATION HISTORY VIEW ---

class _DonationHistoryView extends StatelessWidget {
  const _DonationHistoryView();

  final List<Map<String, String>> historyData = const [
    {
      'date': 'Aug 15, 2025',
      'location': 'Community Center North',
      'type': 'Whole Blood',
      'status': 'Completed',
    },
    {
      'date': 'Apr 20, 2025',
      'location': 'City General Hospital',
      'type': 'Platelets',
      'status': 'Completed',
    },
    {
      'date': 'Jan 5, 2025',
      'location': 'Red Cross Mobile Unit',
      'type': 'Whole Blood',
      'status': 'Completed',
    },
    {
      'date': 'Nov 1, 2025',
      'location': 'University Campus',
      'type': 'Whole Blood',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation History'),
        automaticallyImplyLeading: false, // Managed by BottomNav
      ),
      body: historyData.isEmpty
          ? const Center(
              child: Text(
                'No donation history yet.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                return _HistoryCard(item: item);
              },
            ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final Map<String, String> item;
  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    Color statusColor = item['status'] == 'Completed'
        ? _RedTheme.successColor
        : _RedTheme.warningColor;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['date']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    item['status']!,
                    style: TextStyle(color: statusColor, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item['location']!,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Type: ${item['type']!}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 7. SEARCH VIEW ---

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Campaigns & Centers'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search by location, center name, or blood type...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: _RedTheme.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),

            // Filters/Quick Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickFilter(Icons.location_on, 'Nearby'),
                _buildQuickFilter(Icons.opacity, 'O+ Type'),
                _buildQuickFilter(Icons.calendar_month, 'This Week'),
              ],
            ),
            const SizedBox(height: 20),
            // Results Placeholder
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'Enter a query to find centers or campaigns.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilter(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: _RedTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: _RedTheme.primaryColor, size: 30),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// --- 8. PROFILE VIEW ---

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _navigateToSettings(context),
            color: Colors.black54,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header
            const CircleAvatar(
              radius: 50,
              backgroundColor: _RedTheme.accentColor,
              child: Text(
                'JD',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jane Donor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'jane.donor@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Blood Type & Stats Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Blood Type', 'O+', _RedTheme.primaryColor),
                    _buildStatItem('Donations', '8', _RedTheme.successColor),
                    _buildStatItem(
                      'Next Date',
                      'Dec 1st',
                      _RedTheme.warningColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Profile Options
            _buildProfileOption(
              context,
              Icons.medical_services_outlined,
              'Health Records',
            ),
            _buildProfileOption(
              context,
              Icons.edit_note_outlined,
              'Update Information',
            ),
            _buildProfileOption(
              context,
              Icons.people_outline,
              'Refer a Friend',
            ),
            _buildProfileOption(context, Icons.help_outline, 'Help & Support'),

            const SizedBox(height: 30),
            // Logout Button
            TextButton.icon(
              onPressed: () {
                // Simulate Logout
              },
              icon: const Icon(Icons.logout, color: Colors.grey),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return ListTile(
      leading: Icon(icon, color: _RedTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate to relevant screen or action
        _showPlaceholder(context, title);
      },
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const _SettingsScreen()));
  }
}

// --- 9. NOTIFICATIONS SCREEN ---

class _NotificationsScreen extends StatelessWidget {
  const _NotificationsScreen();

  final List<String> notifications = const [
    'Your O+ blood donation is needed at City General Hospital today!',
    'Campaign update: University drive time has been extended to 5 PM.',
    'Thank you for your donation on Aug 15! Your blood was used to save a life.',
    'New article: The importance of platelet donation. Read now.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notifications[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.favorite_rounded,
                color: _RedTheme.primaryColor,
              ),
              title: Text(notifications[index]),
              subtitle: Text(
                '${index + 1} hours ago',
              ), // Simple dynamic time placeholder
              onTap: () => _showPlaceholder(context, notifications[index]),
            ),
          );
        },
      ),
    );
  }
}

// --- 10. SETTINGS SCREEN ---

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Account Settings
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          _buildSettingsTile(
            Icons.person_outline,
            'Manage Profile',
            () => _showPlaceholder(context, 'Manage Profile'),
          ),
          _buildSettingsTile(
            Icons.lock_outline,
            'Change Password',
            () => _showPlaceholder(context, 'Change Password'),
          ),
          const Divider(),

          // Notification Settings
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          _buildToggleTile(
            Icons.notifications_active_outlined,
            'Campaign Alerts',
            true,
            (val) {},
          ),
          _buildToggleTile(
            Icons.schedule_outlined,
            'Next Date Reminders',
            false,
            (val) {},
          ),
          const Divider(),

          // General Settings
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'General',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          _buildSettingsTile(
            Icons.policy_outlined,
            'Privacy Policy',
            () => _showPlaceholder(context, 'Privacy Policy'),
          ),
          _buildSettingsTile(
            Icons.info_outline,
            'About LifeFlow',
            () => _showPlaceholder(context, 'About LifeFlow'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: _RedTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildToggleTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      secondary: Icon(icon, color: _RedTheme.primaryColor),
      value: value,
      onChanged: onChanged,
      activeColor: _RedTheme.primaryColor,
    );
  }
}

// --- PLACEHOLDER FUNCTION ---

void _showPlaceholder(BuildContext context, String action) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Feature Placeholder'),
      content: Text(
        'You attempted to perform: $action. This feature needs further development.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
