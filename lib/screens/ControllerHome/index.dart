import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_park/core/services/auth_provider.dart';
import 'package:self_park/screens/ControllerHome/components/ParkAdd/index.dart';
import 'package:self_park/screens/ControllerHome/components/Reports/index.dart';

import 'components/OperatorAdd/index.dart';

class ControllerHome extends StatefulWidget {
  const ControllerHome({super.key});

  @override
  State<ControllerHome> createState() => _ControllerHomeState();
}

class _ControllerHomeState extends State<ControllerHome> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: WillPopScope(
        onWillPop: () async {
          // Show a dialog to confirm logout
          bool confirmLogout = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context, false); // User doesn't want to log out
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // User confirmed to log out
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          );

          if (confirmLogout == true) {
            // Call the logout function when the user confirms to log out
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);

            try {
              await authProvider.logout();
              // Logout successful
              print('User logged out successfully!');
            } catch (error) {
              // Logout failed, handle the error
              print('Logout error: $error');
            }
          }

          return confirmLogout; // Allow back navigation if the user confirmed logout
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: deviceOrientation == Orientation.portrait
                ? const _ControlWidget()
                : const _ControlWidgetRow(),
          ),
        ),
      ),
    );
  }
}

class _ControlWidget extends StatelessWidget {
  const _ControlWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade100,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OperatorAdd(),
                      ));
                },
                child: const SizedBox(
                  width: 600,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Add Operator / Edit',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ParkAdd(),
                      ));
                },
                child: const SizedBox(
                  width: 600,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Add Park / Edit',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade100,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Reports(),
                      ));
                },
                child: const SizedBox(
                  width: 600,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Reports',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                ),
                onPressed: () {},
                child: const SizedBox(
                  width: 600,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'View Parking Status',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _ControlWidgetRow extends StatelessWidget {
  const _ControlWidgetRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.yellow.shade100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OperatorAdd(),
                    ));
              },
              child: const SizedBox(
                width: 800,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Add Operator / Edit',
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
              )),
          const SizedBox(height: 10),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.orange.shade100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ParkAdd(),
                    ));
              },
              child: const SizedBox(
                width: 800,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Add Park / Edit',
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
              )),
          const SizedBox(height: 10),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.yellow.shade100,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Reports(),
                    ));
              },
              child: const SizedBox(
                width: 800,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Reports',
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
              )),
          const SizedBox(height: 10),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.orange.shade100,
              ),
              onPressed: () {},
              child: const SizedBox(
                width: 800,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'View Parking Status',
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
