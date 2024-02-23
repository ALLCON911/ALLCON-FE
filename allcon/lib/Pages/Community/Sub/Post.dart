import 'package:allcon/Util/validator_util.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/Widget/custom_text_area.dart';
import 'package:allcon/Widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class MyContentWrite extends StatefulWidget {
  @override
  _ContentWriteState createState() => _ContentWriteState();
}

class _ContentWriteState extends State<MyContentWrite> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '커뮤니티'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hint: "제목",
                funValidator: validateTitle(),
              ),
              const SizedBox(height: 16),
              CustomTextArea(
                hint: "내용",
                funValidator: validateContent(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  print('사진 첨부 클릭 성공');
                },
                child: const Text('사진 첨부하기'),
              ),
              const SizedBox(height: 12),
              CustomElevatedBtn(
                text: "업로드",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    print('버튼 클릭 업로드');
                    //Get.off(MyCommunity());
                  }
                },
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}