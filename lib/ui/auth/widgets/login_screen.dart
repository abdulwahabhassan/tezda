import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda/domain/models/status.dart';
import 'package:tezda/ui/product_list/widgets/product_list_screen.dart';
import '../../core/ui/error_dialog.dart';

part 'login_screen.g.dart';

final counterProvider = StateProvider((ref) => 0);

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Status build() => Status.idle;

  Future<void> login(String email, String password) async {
    state = Status.loading;
    await Future.delayed(Duration(seconds: 2));
    if (email == "test@example.com" && password == "password123") {
      state = Status.success;
    } else {
      state = Status.error;
    }
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final loginStatus = ref.watch(loginNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginStatus == Status.error) {
        showErrorDialog(context, "Invalid email or password");
      } else if (loginStatus == Status.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (buildContext) => ProductListScreen(title: "Products"),
          ),
        );
      }
    });

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
              Text(
                "Tezda",
                style: TextTheme.of(
                  context,
                ).headlineMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Welcome to the world's number one leading\n e-commerce hub 🎉🥳",
                  style: TextTheme.of(context).labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextTheme.of(context).labelMedium,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    style: TextTheme.of(context).bodyMedium,
                    cursorColor: Colors.purple.withAlpha(100),

                    decoration: InputDecoration(
                      icon: Icon(Icons.email, color: Colors.black),
                      hintText: "Enter your email",
                      hintStyle: TextTheme.of(
                        context,
                      ).labelMedium?.copyWith(fontWeight: FontWeight.normal),
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
                        vertical: 12,
                      ),
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
                      "Password",
                      style: TextTheme.of(context).labelMedium,
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextTheme.of(context).bodyMedium,
                    cursorColor: Colors.purple.withAlpha(100),
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.black),
                      hintText: "Enter your password",
                      hintStyle: TextTheme.of(
                        context,
                      ).labelMedium?.copyWith(fontWeight: FontWeight.normal),
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
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              loginStatus == Status.loading
                  ? CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        loginNotifier.login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Login or Register 🚀",
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
