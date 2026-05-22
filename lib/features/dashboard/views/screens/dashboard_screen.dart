import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/features/auth/views/screens/login_screen.dart';
import 'package:pulse/core/theme/app_spacing.dart';
import 'package:pulse/core/widgets/skeleton_grid.dart';
import 'package:pulse/core/widgets/error_view.dart';
import 'package:pulse/core/widgets/logout_confirmation_dialog.dart';
import 'package:pulse/features/dashboard/controllers/dashboard_controller.dart';
import 'package:pulse/features/dashboard/views/widgets/dashboard_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardController>().fetchDashboard();
    });
  }

  List<Map<String, dynamic>> get sampleActivities => [
        {
          'title': 'Meeting Scheduled',
          'description': 'Zoom meeting with Acme Corporation',
          'time': '2 hours ago',
          'icon': Icons.video_call_rounded,
          'iconBgColor': const Color(0xFFE3F2FD),
          'iconColor': const Color(0xFF1976D2),
        },
        {
          'title': 'Email Sent',
          'description': 'Proposal sent to Tech Solutions Inc',
          'time': '4 hours ago',
          'icon': Icons.mail_rounded,
          'iconBgColor': const Color(0xFFF3E5F5),
          'iconColor': const Color(0xFF7B1FA2),
        },
        {
          'title': 'Call Completed',
          'description': 'Client call with Global Industries',
          'time': '1 day ago',
          'icon': Icons.phone_rounded,
          'iconBgColor': const Color(0xFFE8F5E9),
          'iconColor': const Color(0xFF388E3C),
        },
        {
          'title': 'Meeting Rescheduled',
          'description': 'Updated meeting time with Digital Ventures',
          'time': '2 days ago',
          'icon': Icons.calendar_today_rounded,
          'iconBgColor': const Color(0xFFFFF3E0),
          'iconColor': const Color(0xFFF57C00),
        },
      ];

  List<Map<String, dynamic>> get sampleMeetings => [
        {
          'company': 'Acme Corporation',
          'time': '10:00 AM',
          'duration': '30 min',
          'type': 'Video Call',
          'attendee': 'John Smith',
          'tagColor': const Color(0xFFE3F2FD),
          'tagTextColor': const Color(0xFF1976D2),
        },
        {
          'company': 'Tech Solutions Inc',
          'time': '2:30 PM',
          'duration': '45 min',
          'type': 'In-Person',
          'attendee': 'Sarah Johnson',
          'tagColor': const Color(0xFFE8F5E9),
          'tagTextColor': const Color(0xFF388E3C),
        },
        {
          'company': 'Global Industries',
          'time': '4:00 PM',
          'duration': '60 min',
          'type': 'Call',
          'attendee': 'Mike Davis',
          'tagColor': const Color(0xFFFFF3E0),
          'tagTextColor': const Color(0xFFF57C00),
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              final shouldLogout = await showLogoutConfirmationDialog(context);
              if (!shouldLogout || !context.mounted) {
                return;
              }
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Consumer<DashboardController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return SkeletonGrid(crossAxisCount: 2);
            }
            if (controller.errorMessage != null) {
              return ErrorView(
                message: controller.errorMessage!,
                onRetry: () => controller.fetchDashboard(),
              );
            }
            if (controller.data != null) {
              final data = controller.data!;
              return DashboardContent(
                data: data,
                sampleActivities: sampleActivities,
                sampleMeetings: sampleMeetings,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
