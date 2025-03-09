import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takehomeproject/models/user_model.dart';
import 'package:takehomeproject/controllers/services/user_service.dart';
import 'package:takehomeproject/views/widgets/toast_widget.dart';
import '../../controllers/blocs/user_bloc.dart';
import '../pages/user_details_page.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];
  List<UserModel> _allUsers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserService())..add(LoadUsers()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          } else if (state is UserLoaded) {
            _allUsers =
                state.users.map((json) => UserModel.fromJson(json)).toList();
            _filteredUsers =
                _searchController.text.isEmpty ? _allUsers : _filteredUsers;

            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by Name, Username, or Email",
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterUsers,
                  ),
                ),

                // User List
                Expanded(
                  child: _filteredUsers.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            UserModel user = _filteredUsers[index];

                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          UserDetailsPage(user: user),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    user.name.substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                title: Text(
                                  user.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(user.email),
                                trailing: const Icon(Icons.chevron_right,
                                    color: Colors.blueAccent),
                              ),
                            );
                          },
                        )
                      : _buildFetchUsersButton(context),
                ),
              ],
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return _buildFetchUsersButton(context);
          }
        },
      ),
    );
  }

  /// Search Functionality
  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.username.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  /// Fetch Users Button UI
  Widget _buildFetchUsersButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(FetchUsers());
              showToast(message: "✅ Fetching users from API...");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              "Fetch & Save Users",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
