import 'package:demo_new/constant/my_images.dart';
import 'package:demo_new/constant/screen_sizing/my_media_query.dart';
import 'package:demo_new/constant/screen_sizing/screen_sizing.dart';
import 'package:demo_new/logic/cubit_sign_in/sign_in_state.dart';
import 'package:demo_new/presentation/home_nav.dart';
import 'package:demo_new/presentation/sign_up_screen.dart';
import 'package:demo_new/utils/validators/email_validator.dart';
import 'package:demo_new/widget/my_animated_loader_btn.dart';
import 'package:demo_new/widget/my_header_widget.dart';
import 'package:demo_new/widget/my_outlined_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/my_colors.dart';
import '../logic/cubit_sign_in/sign_in_cubit.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode(), _passwordFocus = FocusNode();

  //Bool variables
  bool isHidePassword = true;

  //Form Key
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(SignInInitState()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBars.appBarNormal(context, title: 'Sign In'),
        body: Form(
          key: _signInFormKey,
          child: Stack(
            children: [
              Image.asset(
                MyImages.bgImage,
                height: MyMediaQuery.height(context),
                width: MyMediaQuery.width(context),
                fit: BoxFit.contain,
              ),
              ListView(
                padding: MyScreenSizing.screenPadding(T: 30),
                children: [
                  const HeaderWidget(title: 'Login your account'),
                  _emailTextField(),
                  _passwordTextField(),
                  _signInBtn(),
                  _signUpNavigatorBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _signInBtn() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        bool isLoading = false; // Initialize isLoading with a default value

        if (state is SignInLoaderState) {
          isLoading = state.isLoading; // Set isLoading based on the state
        }
        return MyAnimatedLoaderButton(
          textColor: Colors.black,
          margin: EdgeInsets.zero,
          loader: isLoading,
          onPressed: () async {
            if (_signInFormKey.currentState!.validate()) {
              final isSuccess = await context.read<SignInCubit>().signIn(
                    context,
                    _emailController.text,
                    _passwordController.text,
                  );
              if (isSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeBottomNav()),
                  (route) => false,
                );
              }
            }
          },
          text: 'Sign In',
        );
      },
    );
  }

  Widget _signUpNavigatorBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: MyOutlinedButton(
        title: 'Sign up now',
        onPressed: () async {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) =>  const RegistrationScreen()),(route) => false,);
        },
        borderColor: MyColors.black,
      ),
    );
  }

 Widget _emailTextField() {
    return MyTextFormField(
      hintText: 'Email Address',
      hintColor: MyColors.white500,
      controller: _emailController,
      title: 'Email',
      focusNode: _emailFocus,
      focusColorEnable: true,
      validator: (emailText) {
        if (emailText == null) {
          return 'Please enter your email address';
        } else if (emailText.contains(' ')) {
          return 'Email address should not contain whitespace characters';
        } else if (!emailText.isValidEmail()) {
          return 'Please enter valid email';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return MyTextFormField(
      hintColor: MyColors.white500,
      hintText: 'Password',
      controller: _passwordController,
      title: 'Password',
      focusNode: _passwordFocus,
      focusColorEnable: true,
      obscure: isHidePassword,
      validator: (passwordText) {
        if (passwordText == null || passwordText.isEmpty) {
          return 'Please enter password';
        } else if (passwordText.length <= 5) {
          return 'Password length more than 6 character';
        }
        return null;
      },
      suffixIcon: IconButton(
        icon: Icon(
          isHidePassword ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
          color: MyColors.primaryColor,
        ),
        onPressed: () {
          setState(() {
            isHidePassword = !isHidePassword;
          });
        },
      ),
    );
  }
}
