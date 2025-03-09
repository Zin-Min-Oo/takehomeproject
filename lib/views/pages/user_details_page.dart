import 'package:flutter/material.dart';
import 'package:takehomeproject/views/pages/post_form_page.dart';
import '../../models/user_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoCard(user),
              const SizedBox(height: 16),
              _buildAddressCard(user),
              const SizedBox(height: 16),
              _buildCompanyCard(user),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PostFormPage(userModel: user),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Upload Post",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// User Information Card
  Widget _buildUserInfoCard(UserModel user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoTile(Icons.person, "Username", user.username),
            _buildInfoTile(Icons.email, "Email", user.email),
            _buildInfoTile(Icons.phone, "Phone", user.phone),
            _buildInfoTile(Icons.web, "Website", user.website),
          ],
        ),
      ),
    );
  }

  /// Address Information Card
  Widget _buildAddressCard(UserModel user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoTile(Icons.location_on, "Street", user.address.street),
            _buildInfoTile(Icons.location_city, "City", user.address.city),
            _buildInfoTile(Icons.home, "Suite", user.address.suite),
            _buildInfoTile(Icons.pin_drop, "Zip Code", user.address.zipcode),
          ],
        ),
      ),
    );
  }

  /// Company Information Card
  Widget _buildCompanyCard(UserModel user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Company",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoTile(Icons.business, "Company Name", user.company.name),
            _buildInfoTile(
                Icons.description, "Catch Phrase", user.company.catchPhrase),
            _buildInfoTile(
                Icons.lightbulb, "Business Strategy", user.company.bs),
          ],
        ),
      ),
    );
  }

  /// Helper function for displaying ListTile items
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }
}
