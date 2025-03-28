import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const platform = MethodChannel('device_info');

  String deviceModel = "";
  String systemVersion = "";
  String deviceName = "";
  String name = "";
  String email = "";

  Future<void> getDeviceInfo() async {
    try {
      final Map<dynamic, dynamic> deviceInfo = await platform.invokeMethod(
        'getDeviceInfo',
      );
      setState(() {
        deviceModel = deviceInfo['model'] ?? "Unknown";
        systemVersion = deviceInfo['systemVersion'] ?? "Unknown";
        deviceName = deviceInfo['name'] ?? "Unknown";
      });
    } on PlatformException catch (e) {
      print("Failed to get device info: '${e.message}'.");
    }
  }

  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final savedImage = await File(pickedFile.path).copy(imagePath);
      setState(() {
        image = savedImage;
      });
    }
  }

  Future<void> loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.png';

    if (File(imagePath).existsSync()) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  Future<void> saveProfile(String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name_key', name);
    await prefs.setString('email_key', email);
  }

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name_key') ?? "";
      email = prefs.getString('email_key') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    loadImage();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextTheme.of(context).titleMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Stack(
                  children: [
                    ClipOval(
                      child:
                          image != null
                              ? Image.file(
                                image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                "lib/assets/images/img_cloth.jpeg",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                    ),
                    Positioned(
                      bottom: 50,
                      child: CustomPaint(
                        size: Size(100, 50),
                        painter: _HalfCirclePainter(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 38,

                      child: Row(
                        children: [
                          Text(
                            "Edit",
                            style: TextTheme.of(
                              context,
                            ).labelSmall?.copyWith(color: Colors.white),
                          ),
                          Icon(Icons.edit, size: 12, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  Text("Device Model", style: TextTheme.of(context).labelSmall),
                  Text(deviceModel, style: TextTheme.of(context).bodySmall),
                  SizedBox(height: 4),
                  Text(
                    "System Version",
                    style: TextTheme.of(context).labelSmall,
                  ),
                  Text(systemVersion, style: TextTheme.of(context).bodySmall),
                  SizedBox(height: 4),
                  Text("Device Name", style: TextTheme.of(context).labelSmall),
                  Text(deviceName, style: TextTheme.of(context).bodySmall),
                ],
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextTheme.of(context).labelSmall,
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    onSubmitted: (text) {},
                    style: TextTheme.of(context).bodyMedium,
                    cursorColor: Colors.purple.withAlpha(100),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black),
                      hintText: "Tap to edit name",
                      hintStyle: TextTheme.of(
                        context,
                      ).labelSmall?.copyWith(fontWeight: FontWeight.normal),
                      fillColor: Colors.purple.withAlpha(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      filled: true,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextTheme.of(context).labelSmall,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    onSubmitted: (text) {},
                    style: TextTheme.of(context).bodyMedium,
                    cursorColor: Colors.purple.withAlpha(100),
                    decoration: InputDecoration(
                      icon: Icon(Icons.email, color: Colors.black),
                      hintText: "Tap to edit email",
                      hintStyle: TextTheme.of(
                        context,
                      ).labelSmall?.copyWith(fontWeight: FontWeight.normal),
                      fillColor: Colors.purple.withAlpha(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      filled: true,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    saveProfile(nameController.text, emailController.text);
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Save 🔐",
                    style: TextTheme.of(
                      context,
                    ).labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.black.withAlpha(50)
          ..style = PaintingStyle.fill;

    final Path path =
        Path()
          ..addArc(Rect.fromLTWH(0, 0, size.width, size.height * 2), 0.57, 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
