import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveDashboardApp());
}

class ResponsiveDashboardApp extends StatelessWidget {
  const ResponsiveDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          brightness: Brightness.light,
        ),
        fontFamily: 'Arial',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final Color orange = const Color(0xFFFF6B00);
  final Color black = const Color(0xFF171717);
  final Color lightOrange = const Color(0xFFFFF1E8);

  final List<Map<String, dynamic>> statistics = [
    {
      'title': 'Total Users',
      'value': '12,450',
      'change': '+12.5%',
      'icon': Icons.people_alt_outlined,
    },
    {
      'title': 'Total Orders',
      'value': '3,280',
      'change': '+8.2%',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Revenue',
      'value': '₹8.4L',
      'change': '+15.8%',
      'icon': Icons.currency_rupee,
    },
    {
      'title': 'Products',
      'value': '1,240',
      'change': '+5.4%',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  final List<Map<String, dynamic>> activities = [
    {
      'name': 'Rahul Sharma',
      'action': 'placed a new order',
      'time': '5 minutes ago',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'name': 'Priya Patel',
      'action': 'created a new account',
      'time': '15 minutes ago',
      'icon': Icons.person_add_outlined,
    },
    {
      'name': 'Amit Singh',
      'action': 'completed payment',
      'time': '30 minutes ago',
      'icon': Icons.payment_outlined,
    },
    {
      'name': 'Sneha Joshi',
      'action': 'updated her profile',
      'time': '1 hour ago',
      'icon': Icons.edit_outlined,
    },
    {
      'name': 'Karan Mehta',
      'action': 'cancelled an order',
      'time': '2 hours ago',
      'icon': Icons.cancel_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1100;
    final bool isDesktop = screenWidth >= 1100;

    int gridColumns;

    if (isMobile) {
      gridColumns = 2;
    } else if (isTablet) {
      gridColumns = 2;
    } else {
      gridColumns = 4;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        titleSpacing: isMobile ? 16 : 24,
        title: Row(
          children: [
            if (!isDesktop) ...[
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.dashboard_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
            ],
            Text(
              'Dashboard',
              style: TextStyle(
                color: black,
                fontSize: isMobile ? 20 : 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMessage('No new notifications');
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 19,
              backgroundColor: lightOrange,
              child: Icon(Icons.person_outline, color: orange),
            ),
          ),
        ],
      ),

      // DRAWER FOR MOBILE + TABLET
      drawer: isDesktop
          ? null
          : Drawer(backgroundColor: Colors.white, child: buildSidebar()),

      body: Row(
        children: [
          // PERMANENT SIDEBAR ON DESKTOP
          if (isDesktop) SizedBox(width: 250, child: buildSidebar()),

          // MAIN CONTENT
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 14 : 24,
                vertical: isMobile ? 16 : 24,
              ),
              children: [
                buildWelcomeCard(isMobile, isTablet),

                const SizedBox(height: 24),

                buildSectionTitle('Overview', 'Your business summary'),

                const SizedBox(height: 14),

                // RESPONSIVE GRIDVIEW
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: statistics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridColumns,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,

                    // FIXED HEIGHT PREVENTS OVERFLOW
                    mainAxisExtent: isMobile
                        ? 142
                        : isTablet
                        ? 145
                        : 135,
                  ),
                  itemBuilder: (context, index) {
                    return buildStatCard(statistics[index]);
                  },
                ),

                const SizedBox(height: 26),

                // RESPONSIVE SALES + QUICK ACTIONS
                if (isMobile)
                  Column(
                    children: [
                      buildSalesCard(),
                      const SizedBox(height: 16),
                      buildQuickActions(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EXPANDED
                      Expanded(flex: 2, child: buildSalesCard()),

                      const SizedBox(width: 16),

                      // FLEXIBLE
                      Flexible(flex: 1, child: buildQuickActions()),
                    ],
                  ),

                const SizedBox(height: 26),

                buildRecentActivity(isMobile),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),

      // MOBILE BOTTOM NAVIGATION
      bottomNavigationBar: isMobile
          ? NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: lightOrange,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });

                showMessage(getNavigationName(index));
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_bag_outlined),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: 'Orders',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: 'Users',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
          : null,
    );
  }

  // =========================================================
  // SIDEBAR
  // =========================================================

  Widget buildSidebar() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 24),

            // LOGO
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.dashboard_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'My Dashboard',
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 30),

            buildMenuItem(
              Icons.dashboard_outlined,
              Icons.dashboard,
              'Dashboard',
              0,
            ),

            buildMenuItem(
              Icons.shopping_bag_outlined,
              Icons.shopping_bag,
              'Orders',
              1,
            ),

            buildMenuItem(Icons.people_outline, Icons.people, 'Customers', 2),

            buildMenuItem(
              Icons.bar_chart_outlined,
              Icons.bar_chart,
              'Analytics',
              3,
            ),

            buildMenuItem(
              Icons.inventory_2_outlined,
              Icons.inventory_2,
              'Products',
              4,
            ),

            buildMenuItem(
              Icons.settings_outlined,
              Icons.settings,
              'Settings',
              5,
            ),

            const Spacer(),

            // HELP CARD
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.help_outline, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Need Help?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Contact support anytime',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showMessage('Support selected');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Contact'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    IconData normalIcon,
    IconData selectedIcon,
    String title,
    int index,
  ) {
    final bool selected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: selected ? lightOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          selected ? selectedIcon : normalIcon,
          color: selected ? orange : Colors.black54,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? orange : Colors.black87,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          Navigator.pop(context);

          showMessage('$title selected');
        },
      ),
    );
  }

  // =========================================================
  // WELCOME CARD
  // =========================================================

  Widget buildWelcomeCard(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildWelcomeText(),
                const SizedBox(height: 18),
                buildProfileButton(),
              ],
            )
          : Row(
              children: [
                // FLEXIBLE
                Flexible(child: buildWelcomeText()),

                const SizedBox(width: 20),

                // EXPANDED
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: buildProfileButton(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Afternoon 👋',
          style: TextStyle(
            color: orange,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Welcome back!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 29,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Here is what is happening with your business today.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildProfileButton() {
    return ElevatedButton.icon(
      onPressed: () {
        showMessage('Profile opened');
      },
      icon: const Icon(Icons.person_outline, size: 19),
      label: const Text('View Profile'),
      style: ElevatedButton.styleFrom(
        backgroundColor: orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget buildSectionTitle(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Flexible(
          child: Text(
            subtitle,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // STATISTICS CARD
  // =========================================================

  Widget buildStatCard(Map<String, dynamic> data) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: lightOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(data['icon'], color: orange, size: 21),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {
                    showMessage('${data['title']} options');
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 20,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),

            const Spacer(),

            Text(
              data['value'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: black,
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 3),

            Row(
              children: [
                Flexible(
                  child: Text(
                    data['title'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  data['change'],
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SALES OVERVIEW
  // =========================================================

  Widget buildSalesCard() {
    final List<double> values = [0.45, 0.65, 0.52, 0.82, 0.60, 0.92, 0.72];

    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sales Overview',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showMessage('Sales report opened');
                  },
                  child: Text(
                    'View Report',
                    style: TextStyle(
                      color: orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            const Text(
              'Weekly performance',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 190,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(values.length, (index) {
                  return Flexible(child: buildBar(values[index], days[index]));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBar(double value, String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: value,
              child: Container(
                width: 25,
                constraints: const BoxConstraints(minHeight: 35),
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            day,
            style: const TextStyle(color: Colors.black45, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // QUICK ACTIONS
  // =========================================================

  Widget buildQuickActions() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 5),

            const Text(
              'Manage your business',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),

            const SizedBox(height: 10),

            buildAction(Icons.add_box_outlined, 'Add Product'),

            buildAction(Icons.person_add_outlined, 'Add Customer'),

            buildAction(Icons.receipt_long_outlined, 'Create Invoice'),

            buildAction(Icons.download_outlined, 'Download Report'),
          ],
        ),
      ),
    );
  }

  Widget buildAction(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Container(
        height: 39,
        width: 39,
        decoration: BoxDecoration(
          color: lightOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: orange, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: Colors.black45,
      ),
      onTap: () {
        showMessage('$title selected');
      },
    );
  }

  // =========================================================
  // RECENT ACTIVITY
  // =========================================================

  Widget buildRecentActivity(bool isMobile) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showMessage('Showing all activities');
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // LISTVIEW
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (context, index) {
                return const Divider(height: 1, color: Color(0xFFEDEDED));
              },
              itemBuilder: (context, index) {
                final activity = activities[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  leading: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: lightOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(activity['icon'], color: orange, size: 20),
                  ),
                  title: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: activity['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${activity['action']}'),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      activity['time'],
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  trailing: isMobile
                      ? null
                      : const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 13,
                          color: Colors.black38,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HELPER FUNCTIONS
  // =========================================================

  String getNavigationName(int index) {
    switch (index) {
      case 0:
        return 'Home selected';
      case 1:
        return 'Orders selected';
      case 2:
        return 'Users selected';
      case 3:
        return 'Settings selected';
      default:
        return 'Menu selected';
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: black,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
