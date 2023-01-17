import 'package:app/api/api.dart';
import 'package:app/api/models.dart';
import 'package:app/models.dart';
import 'package:app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showActions: false,
      body: ListView(
        children: [
          const ProfileInformation(),
          ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.logout),
                SizedBox(width: 5),
                Text("Logout"),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
              Provider.of<Token>(context, listen: false).setToken(null);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => ProfileInformationState();
}

class ProfileInformationState extends State<ProfileInformation> {
  late Future<User?> userFuture;

  @override
  void initState() {
    userFuture = API.getTokenInfo().then((tokenInfo) async {
      if (tokenInfo != null) {
        return API.getUser(tokenInfo.user);
      }
      return null;
    });

    super.initState();
  }

  Widget detailBuilder(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(value, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "User Information",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  detailBuilder("Username", user.username),
                  detailBuilder("Email", user.email),
                  detailBuilder("Type", user.type.toHumanReadable()),
                  const SizedBox(height: 20),
                  user.type == UserType.customer && user.profile != null
                      ? CustomerInformation(profile: user.profile!)
                      : const SizedBox(),
                ],
              ),
            );
          } else {
            return const FractionallySizedBox(
              widthFactor: 0.25,
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class CustomerInformation extends StatefulWidget {
  final Uri profile;
  const CustomerInformation({super.key, required this.profile});

  @override
  State<CustomerInformation> createState() => _CustomerInformationState();
}

class _CustomerInformationState extends State<CustomerInformation> {
  late Future<CustomerProfile?> customerProfileFuture;

  @override
  void initState() {
    customerProfileFuture = API.getCustomerProfile(widget.profile);
    super.initState();
  }

  Widget detailBuilder(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(value, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: customerProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final customerProfile = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile Information",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              detailBuilder("Gender", "${customerProfile.gender}"),
              detailBuilder("City", customerProfile.city),
              detailBuilder("State", customerProfile.state),
              detailBuilder("Contact", customerProfile.contact),
              detailBuilder("Citizenship", customerProfile.citizenship),
            ],
          );
        } else {
          return const FractionallySizedBox(
            widthFactor: 0.25,
            child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
