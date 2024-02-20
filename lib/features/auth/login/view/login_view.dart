import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_study_case/product/provider/providers.dart';
import 'package:voco_study_case/product/enum/project_enums.dart';
import 'package:voco_study_case/product/widget/button/project_button.dart';
import 'package:voco_study_case/product/widget/spacer/custom_sizedBox.dart';
import 'package:voco_study_case/product/widget/textfield/project_textfield.dart';

class LoginView extends ConsumerStatefulWidget {
  static const String routeName = "/login-view";
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with LoginViewMixin {
  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.sizeOf(context);
    final loginController = ref.watch(loginControllerProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: loginController == ProjectState.loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const FlutterLogo(
                            size: 150.0,
                          ),
                          addSpaceVertical(size.height * 0.04),
                          ProjectTextField(
                            controller: emailController,
                            hintText: "someone@gmail.com",
                            prefixIcon: Icons.person,
                          ),
                          addSpaceVertical(size.height * 0.01),
                          ProjectTextField(
                            controller: passwordController,
                            hintText: "*********",
                            isPassword: true,
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          addSpaceVertical(size.height * 0.05),
                          ProjectButton(
                            text: "Login",
                            onPressed: login,
                          ),
                          addSpaceVertical(size.height * .05),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

mixin LoginViewMixin on ConsumerState<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  login() {
    ref.read(loginControllerProvider.notifier).login(
        email: emailController.text.toLowerCase().trim(),
        password: passwordController.text,
        context: context);
  }
}
