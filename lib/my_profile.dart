import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final ImagePicker _picker = ImagePicker();
  String _profileImagePath = 'assets/profile.jpeg';
  File? _profileImageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        setState(() {
          _nameController.text = snapshot['name'] ?? '';
          _countryController.text = snapshot['country'] ?? '';
          _emailController.text = snapshot['email'] ?? '';
          _phoneController.text = snapshot['phone'] ?? '';
          _dobController.text = snapshot['dob'] ?? '';
          _profileImagePath = snapshot['profileImage'] ?? 'assets/profile.jpeg';
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
        _profileImageFile = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _profileImagePath = 'assets/profile.jpeg';
      _profileImageFile = null;
    });
  }

  Future<void> _saveProfile() async {
    if (userId == null) return;

    String imageUrl = _profileImagePath;

    if (_profileImageFile != null) {
      imageUrl = await _uploadProfileImage(_profileImageFile!);
    }

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': _nameController.text,
      'country': _countryController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'dob': _dobController.text,
      'profileImage': imageUrl,
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')));
  }

  Future<String> _uploadProfileImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child('$userId.jpg');
    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5EBFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120), // prevent overlap with buttons
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImageFile != null
                      ? FileImage(_profileImageFile!)
                      : (_profileImagePath.startsWith('http')
                          ? NetworkImage(_profileImagePath)
                          : AssetImage(_profileImagePath)) as ImageProvider,
                ),
                Positioned(
                  right: 36,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.camera_alt, size: 18),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _removeImage,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.delete,
                          size: 18, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF89BFFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ProfileTextField(
                      controller: _nameController, label: "User Name"),
                  const SizedBox(height: 12),
                  ProfileTextField(
                      controller: _countryController, label: "Country"),
                  const SizedBox(height: 12),
                  ProfileTextField(
                      controller: _emailController,
                      label: "Email Address",
                      enabled: false),
                  const SizedBox(height: 12),
                  ProfileTextField(
                      controller: _phoneController, label: "Mobile Number"),
                  const SizedBox(height: 12),
                  ProfileTextField(
                      controller: _dobController, label: "Date of Birth"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Save and Cancel buttons removed from here
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                minimumSize: const Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Save"),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                minimumSize: const Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool enabled;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}





