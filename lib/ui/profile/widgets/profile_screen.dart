import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
              Stack(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "lib/assets/images/img_cloth.jpeg",
                      width: 100,
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
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Save"),
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
