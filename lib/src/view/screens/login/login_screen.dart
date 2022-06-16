import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:trendyol_market/src/view/screens/home/home_screen.dart';
import 'package:trendyol_market/src/view/screens/login/sign_up_screen.dart';

import '../../../logic/blocs/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInitial ||
                  state is AuthError ||
                  state is AuthRegisterSuccess) {
                return LoginInitialWidget(
                  usernameController: usernameController,
                  passwordController: passwordController,
                );
              } else if (state is AuthSuccess || state.email != "") {
                String token = BlocProvider.of<AuthBloc>(context).state.token;
                return const HomeScreen();
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
            listener: (context, state) {
              state is AuthFailed
                  ? ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                        content: Text("Invalid email or password}"),
                      ),
                    )
                  : null;

              state is AuthError 
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Something went wrong(Server down)"),
                      ),
                    )
                  : null;
            },
          ),
        ));
  }
}

class LoginInitialWidget extends StatefulWidget {
  const LoginInitialWidget({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<LoginInitialWidget> createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {
  bool check(String name, String password) =>
      !(name.isEmpty || password.length < 6);

  late bool isShowed = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.9.h),
      child: Column(
        children: [
          SizedBox(
            height: 27.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: 'Login\n',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: 'Please sign in to continue.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: TextFormField(
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorHeight: 18,
                  style: TextStyle(fontSize: 14.sp),
                  controller: widget.usernameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.email,
                        size: 3.h,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: TextFormField(
                  controller: widget.passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: isShowed,
                  cursorHeight: 18,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(fontSize: 18),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.lock,
                        size: 3.h,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: isShowed
                          ? const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.visibility_off),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.visibility),
                            ),
                      onPressed: () {
                        setState(() {
                          isShowed = !isShowed;
                        });
                      },
                    ),
                    hintText: "Password",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        check(widget.usernameController.text,
                                widget.passwordController.text)
                            ? BlocProvider.of<AuthBloc>(context).add(
                                AuthLogin(widget.usernameController.text,
                                    widget.passwordController.text),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Entered invalid data!"),
                                ),
                              );
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Login ",
                          ),
                           Icon(
                            Icons.arrow_forward,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.27,
          // ),
         const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Don\'t have account ? ',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                TextSpan(
                    text: 'Sign up',
                    style: const TextStyle(color: Colors.orange),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterInitialWidget(
                                    usernameController: TextEditingController(),
                                    passwordController: TextEditingController(),
                                    passwordRepeatController:
                                        TextEditingController(),
                                  )),
                        );
                      })
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }
}
