import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/pages/home/Home.dart';
import 'package:allcon/pages/login/MySignUp.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLogIn extends StatefulWidget {
  const MyLogIn({super.key});

  @override
  State<MyLogIn> createState() => _MyMyLogInState();
}

class _MyMyLogInState extends State<MyLogIn> {
  final _formKey = GlobalKey<FormState>();
  final AccountController _accountController = Get.put(AccountController());

  final _userEmail = TextEditingController();
  final _userPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WellcomText(),
                const SizedBox(height: 20),
                SingInForm(),
                const SizedBox(height: 5),
                IsntUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget WellcomText() {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              '올콘해요!',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 26.0,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'O',
              style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'Cafe24Moyamoya',
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget SingInForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              hint: "이메일을 입력해주세요",
              funValidator: validateEmail(),
              controller: _userEmail,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hint: "비밀번호를 입력해주세요",
              funValidator: validatePwd(),
              controller: _userPwd,
            ),
            const SizedBox(height: 24),
            CustomElevatedBtn(
                text: "로그인",
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    bool isToken = await _accountController.login(
                        _userEmail.text.trim(), _userPwd.text.trim());
                    print(
                      'isToken : $isToken',
                    );
                    if (isToken) {
                      print("토큰 받기 성공");
                      Get.snackbar('로그인 성공 😚', "반가워요!");
                      Get.offAll(const MyHome());
                    } else {
                      Get.snackbar('로그인 실패 😭', "다시 시도해주세요!");
                    }
                  }
                }),
          ],
        ));
  }

  Widget IsntUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '아직 올콘러가 아니세요?',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(const MySignUp());
          },
          child: const Text(
            '회원가입',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
