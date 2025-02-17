// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_null_comparison, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, avoid_web_libraries_in_flutter, unused_element, file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/modles/users_model.dart';
import 'package:madproject/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:madproject/widgets/toast.dart';
import '../const/colors.dart';
import '../screens/loginScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    name.dispose();
    mobileNo.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    UserData userData = UserData(
      uid: '', 
      email: email.text,
      mobileNo: mobileNo.text,
      name: name.text,
    );
    // signup user using our authmethod
    User? users = await AuthMethod().signupUser(
      user: userData,
      password: password.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    setState(() {
      isLoading = false;
    });
    if (users != null) {
      showToast(message: "User is successfully created");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
     else {
      showToast(message: "Some error happend");
    }
    //show error
  }

  void validation() {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    RegExp phoneRegex = RegExp(r'^[0-9]{11}$');
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    if (name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Name is empty",
          ),
        ),
      );
      return;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Name should contain only alphabetic characters.",
          ),
        ),
      );
      return;
    } // Validate if name contains only alphabetic characters
    if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Email is empty",
          ),
        ),
      );
      return;
    } else if (!emailRegex.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid Email Format",
          ),
        ),
      );
      return;
    } // Validate email format
    if (mobileNo.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Mobile Number is empty",
          ),
        ),
      );
      return;
    } else if (!phoneRegex.hasMatch(mobileNo.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid Phone Number Format. Please enter a 11-digit phone number.",
          ),
        ),
      );
      return;
    } // Assumes a 11-digit phone number format
    if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password is empty",
          ),
        ),
      );
      return;
    } else if (!passwordRegex.hasMatch(password.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid Password Format. It should contain at least 8 characters, one uppercase, one lowercase, and one digit.",
          ),
        ),
      );
      return;
    } // Validate password format (e.g., at least 8 characters, at least one uppercase, one lowercase, and one digit)
    if (confirmPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Confirm Password is empty",
          ),
        ),
      );
      return;
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password and Confirm Password do not match.",
          ),
        ),
      );
      return;
    } // Check if password and confirm password match
    signupUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: SingleChildScrollView(
          child: Container(
            width: Helper.getScreenWidth(context),
            height: Helper.getScreenHeight(context),
            child: SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: Helper.getTheme(context).titleLarge,
                    ),
                    Spacer(),
                    Text(
                      "Add your details to sign up",
                    ),
                    Spacer(),
                    CustomTextInput(
                      hintText: "Name",
                      obscureText: false,
                      controller: name,
                    ),
                    Spacer(),
                    CustomTextInput(
                      hintText: "Email",
                      obscureText: false,
                      controller: email,
                    ),
                    Spacer(),
                    CustomTextInput(
                      hintText: "Mobile No",
                      obscureText: false,
                      controller: mobileNo,
                    ),
                    Spacer(),
                    CustomTextInput(
                      hintText: "Password",
                      obscureText: true,
                      controller: password,
                    ),
                    Spacer(),
                    CustomTextInput(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: confirmPassword,
                    ),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          validation();
                        },
                        child: Text("Sign Up"),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an Account?"),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: AppColor.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
