

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BloodFinderApp());
}

class BloodFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodFinder',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 235, 43, 43)),
        // textTheme: GoogleFonts.interTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (_) => SplashScreen(),
        Routes.login: (_) => LoginScreen(),
        Routes.signup: (_) => SignupScreen(),
        Routes.home: (_) => HomeShell(),
        Routes.campaignDetail: (_) => CampaignDetailScreen(),
        Routes.donate: (_) => DonateScreen(),
        Routes.history: (_) => DonationHistoryScreen(),
        Routes.search: (_) => SearchScreen(),
        Routes.profile: (_) => ProfileScreen(),
        Routes.notifications: (_) => NotificationsScreen(),
        Routes.settings: (_) => SettingsScreen(),
      },
    );
  }
}

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const campaignDetail = '/campaign';
  static const donate = '/donate';
  static const history = '/history';
  static const search = '/search';
  static const profile = '/profile';
  static const notifications = '/notifications';
  static const settings = '/settings';
}

// -----------------------
// Splash
// -----------------------
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1200), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bloodtype, size: 88, color: theme.colorScheme.primary),
            SizedBox(height: 16),
            Text('BloodFinder', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('Find donors • Join campaigns • Save lives', style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

// -----------------------
// Auth Screens (Login/Signup) - simple UI only
// -----------------------
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // in real app: call auth service
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text('Welcome back🩸', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Sign in to continue', style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null,
                    onChanged: (v) => email = v,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (v) => (v == null || v.length < 6) ? 'Password min 6 chars' : null,
                    onChanged: (v) => password = v,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _submit, child: Text('Login')),
                  ),
                ]),
              ),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account? "),
                TextButton(onPressed: () => Navigator.pushNamed(context, Routes.signup), child: Text('Sign up'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create account')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(decoration: InputDecoration(labelText: 'Full name'), onChanged: (v) => name = v, validator: (v) => (v == null || v.isEmpty) ? 'Enter name' : null),
            SizedBox(height: 12),
            TextFormField(decoration: InputDecoration(labelText: 'Email'), onChanged: (v) => email = v, validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null),
            SizedBox(height: 12),
            TextFormField(decoration: InputDecoration(labelText: 'Password'), obscureText: true, onChanged: (v) => password = v, validator: (v) => (v == null || v.length < 6) ? 'Password min 6 chars' : null),
            SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _submit, child: Text('Sign up'))),
          ]),
        ),
      ),
    );
  }
}

// -----------------------
// Home Shell with Bottom Navigation and Campaigns
// -----------------------
class HomeShell extends StatefulWidget {
  @override
  _HomeShellState createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = [HomeScreen(), SearchScreen(), DonationHistoryScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.history), selectedIcon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.notifications),
        icon: Icon(Icons.add),
        label: Text('Donate'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// -----------------------
// Home / Campaigns List
// -----------------------
class HomeScreen extends StatelessWidget {
  final campaigns = List.generate(6, (i) => Campaign.sample(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaigns'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, Routes.notifications), icon: Icon(Icons.notifications_none)),
          IconButton(onPressed: () => Navigator.pushNamed(context, Routes.settings), icon: Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: campaigns.length,
          itemBuilder: (context, idx) {
            final c = campaigns[idx];
            return CampaignCard(campaign: c);
          },
        ),
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  const CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.campaignDetail, arguments: campaign),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.red.shade50),
              child: Icon(Icons.event, size: 36, color: Colors.redAccent),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(campaign.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                SizedBox(height: 6),
                Text(campaign.location + ' • ' + campaign.date, style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 8),
                LinearProgressIndicator(value: campaign.progress),
                SizedBox(height: 6),
                Row(children: [
                  Text('${(campaign.progress * 100).toInt()}% filled', style: Theme.of(context).textTheme.bodySmall),
                  Spacer(),
                  Text('${campaign.donorsNeeded} needed', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                ])
              ]),
            )
          ]),
        ),
      ),
    );
  }
}

class Campaign {
  final String id;
  final String title;
  final String location;
  final String date;
  final int donorsNeeded;
  final double progress;

  Campaign({required this.id, required this.title, required this.location, required this.date, required this.donorsNeeded, required this.progress});

  static Campaign sample(int i) => Campaign(
        id: 'c$i',
        title: 'Community Blood Drive #${i + 1}',
        location: 'Community Center, Sector ${i + 3}',
        date: 'Oct ${20 + i}, 2025',
        donorsNeeded: 10 + i * 2,
        progress: (0.2 * (i + 1)).clamp(0.0, 0.95),
      );
}

// -----------------------
// Campaign Detail
// -----------------------
class CampaignDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final campaign = ModalRoute.of(context)?.settings.arguments as Campaign? ?? Campaign.sample(0);
    return Scaffold(
      appBar: AppBar(title: Text('Campaign')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(campaign.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('${campaign.location} • ${campaign.date}', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 12),
          LinearProgressIndicator(value: campaign.progress),
          SizedBox(height: 12),
          Text('About the event', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 8),
          Expanded(child: Text('This is a community drive to collect blood donations for local hospitals. Walk-ins welcome. Please check eligibility before donating and carry a valid ID.')),
          SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, Routes.donate, arguments: campaign), child: Text('Donate'))),
        ]),
      ),
    );
  }
}

// -----------------------
// Donate Screen
// -----------------------
class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  String bloodType = 'A+';
  bool consent = false;

  @override
  Widget build(BuildContext context) {
    final campaign = ModalRoute.of(context)?.settings.arguments as Campaign?;
    return Scaffold(
      appBar: AppBar(title: Text('Donate')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          if (campaign != null) Text('Donating to ${campaign.title}', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: bloodType,
            items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
            onChanged: (v) => setState(() => bloodType = v ?? bloodType),
            decoration: InputDecoration(labelText: 'Blood type'),
          ),
          SizedBox(height: 12),
          CheckboxListTile(title: Text('I confirm I am eligible to donate'), value: consent, onChanged: (v) => setState(() => consent = v ?? false)),
          Spacer(),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: consent ? () { Navigator.pushNamed(context, Routes.history); } : null, child: Text('Confirm Donation'))),
        ]),
      ),
    );
  }
}

// -----------------------
// Donation History
// -----------------------
class DonationHistoryScreen extends StatelessWidget {
  final history = List.generate(4, (i) => DonationRecord.sample(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donation History')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, idx) {
          final h = history[idx];
          return Card(
            child: ListTile(
              leading: Icon(Icons.bloodtype),
              title: Text(h.campaignTitle),
              subtitle: Text('${h.date} • ${h.bloodType}'),
              trailing: Text(h.status),
            ),
          );
        },
      ),
    );
  }
}

class DonationRecord {
  final String id;
  final String campaignTitle;
  final String date;
  final String bloodType;
  final String status;

  DonationRecord({required this.id, required this.campaignTitle, required this.date, required this.bloodType, required this.status});

  static DonationRecord sample(int i) => DonationRecord(id: 'd$i', campaignTitle: 'Community Drive #${i + 1}', date: '2025-09-${10 + i}', bloodType: ['A+','B+','O+','AB+'][i % 4], status: i % 2 == 0 ? 'Completed' : 'Pending');
}

// -----------------------
// Search Screen
// -----------------------
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = List.generate(3, (i) => 'Donor ${i + 1} • ${['A+','O+','B+'][i]} • 2 km');
    return Scaffold(
      appBar: AppBar(title: Text('Search donors/campaigns')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by blood type, location, campaign...'), onChanged: (v) => setState(() => query = v)),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(itemCount: results.length, itemBuilder: (context, idx) => ListTile(title: Text(results[idx]))),
          )
        ]),
      ),
    );
  }
}

// -----------------------
// Profile
// -----------------------
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Akash', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)), Text('A+ • Donor')])
          ]),
          SizedBox(height: 20),
          ListTile(leading: Icon(Icons.history), title: Text('My donations'), onTap: () => Navigator.pushNamed(context, Routes.history)),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings'), onTap: () => Navigator.pushNamed(context, Routes.settings)),
          ListTile(leading: Icon(Icons.logout), title: Text('Logout'), onTap: () {
            Navigator.pushReplacementNamed(context, Routes.login);
          })
        ]),
      ),
    );
  }
}

// -----------------------
// Notifications
// -----------------------
class NotificationsScreen extends StatelessWidget {
  final notifications = List.generate(5, (i) => 'Reminder: Campaign ${i + 1} on Oct ${20 + i}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView.builder(itemCount: notifications.length, itemBuilder: (context, idx) => ListTile(title: Text(notifications[idx]))),
    );
  }
}

// -----------------------
// Settings
// -----------------------
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(padding: EdgeInsets.all(12), children: [
        SwitchListTile(title: Text('Enable push notifications'), value: true, onChanged: (v) {}),
        ListTile(title: Text('App theme'), subtitle: Text('Material 3 (seed color)'), onTap: () {}),
        ListTile(title: Text('Privacy & Eligibility'), onTap: () {}),
      ]),
    );
  }
}

