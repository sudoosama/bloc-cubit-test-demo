import 'package:demo_new/constant/my_images.dart';
import 'package:demo_new/constant/screen_sizing/my_media_query.dart';
import 'package:demo_new/constant/screen_sizing/screen_sizing.dart';
import 'package:demo_new/logic/cubit_sign_up/sign_up_cubit.dart';
import 'package:demo_new/logic/cubit_sign_up/sign_up_state.dart';
import 'package:demo_new/presentation/sign_in_screen.dart';
import 'package:demo_new/utils/validators/email_validator.dart';
import 'package:demo_new/widget/my_animated_loader_btn.dart';
import 'package:demo_new/widget/my_outlined_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/my_colors.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_header_widget.dart';
import '../widget/my_text_form_field.dart';
import 'home_nav.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode(),
      _passwordFocus = FocusNode(),
      _reEnterPasswordFocus = FocusNode();

  //Bool variables
  bool isHidePassword = true, isHideRePassword = true;

  String samePasswordChecker = '';

  //Form Key
  final _registrationFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _reEnterPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(SignUpInitState()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBars.appBarNormal(context, title: 'Sign Up'),
        body: Form(
          key: _registrationFormKey,
          child: Stack(
            children: [
              Image.asset(
                MyImages.bgImage,
                height: MyMediaQuery.height(context),
                width: MyMediaQuery.width(context),
                fit: BoxFit.fill,
              ),
              ListView(
                padding: MyScreenSizing.screenPadding(T: 30),
                children: [
                  const HeaderWidget(title: 'Register your account'),
                  _emailTextField(),
                  _passwordTextField(),
                  _reEnterPasswordTextField(),
                  _registrationBtn(),
                  _signInNavigatorBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registrationBtn() {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      bool isLoading = false; // Initialize isLoading with a default value

      if (state is SignUpLoaderState) {
        isLoading = state.isLoading; // Set isLoading based on the state
      }
      return MyAnimatedLoaderButton(
        margin: EdgeInsets.zero,
        loader: isLoading,
        onPressed: () async {
          if (_registrationFormKey.currentState!.validate()) {
            final isSuccess = await context.read<SignUpCubit>().register(
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
        text: 'Register',
      );
    });
  }

  Widget _signInNavigatorBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: MyOutlinedButton(
        title: 'Sign In now',
        onPressed: () async {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => const SignInScreen()),(route) => false,);
        },
        borderColor: MyColors.black,
      ),
    );
  }

  Widget _emailTextField() {
  return  MyTextFormField(
      hintText: 'Email Address',
      hintColor: MyColors.white500,
      controller: _emailController,
      title: 'Email',
      focusNode: _emailFocus,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
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

      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_reEnterPasswordFocus);
      },
      validator: (passwordText) {
        if (passwordText == null || passwordText.isEmpty) {
          return 'Please enter password';
        }
        else if (passwordText.length <= 5) {
          return 'Password length more than 6 character';
        }
        return null;
      },
      onChanged: (passwordText) {
        samePasswordChecker = passwordText.toString();
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

  Widget _reEnterPasswordTextField() {
    return MyTextFormField(
      controller: _rePasswordController,
      title: 'Re-Enter Password',
      focusNode: _reEnterPasswordFocus,
      focusColorEnable: true,
      hintColor: MyColors.white500,
      hintText: 'Retype Password',
      obscure: isHideRePassword,
      onFieldSubmitted: (_) {
        _registrationFormKey.currentState?.validate();
      },
      validator: (rePasswordText) {
        if (rePasswordText == null || rePasswordText.isEmpty) {
          return 'Please enter re-password';
        }
        else if (rePasswordText.length <= 5) {
          return 'Password length more than 6 character';
        }
        else if (samePasswordChecker != rePasswordText) {
          return 'Passwords must be same';
        }
        return null;
      },
      suffixIcon: IconButton(
        icon: Icon(
          isHideRePassword
              ? Icons.remove_red_eye
              : Icons.remove_red_eye_outlined,
          color: MyColors.primaryColor,
        ),
        onPressed: () {
          setState(() {
            isHideRePassword = !isHideRePassword;
          });
        },
      ),
    );
  }
}
