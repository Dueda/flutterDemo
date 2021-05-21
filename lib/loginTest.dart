import 'package:flutter/material.dart';

// 用户名不能为空，如果为空则提示“用户名不能为空”。
// 密码不能小于6位，如果小于6为则提示“密码不能少于6位”。
class LoginVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginVCState();
}

class _LoginVCState extends State<LoginVC> {
  //登录需要 用户名 密码 以及登录按钮
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //textfield 需要和from一起使用比较好 如果适配键盘 在滚动试图中添加
  GlobalKey _formKey = GlobalKey<FormState>();

  void _loginHandle() {
    if ((_formKey.currentState as FormState).validate()) {
      String name = _userNameController.value.text;
      String password = _passwordController.value.text;
      print("姓名" + name + "\n" + "密码" + password);
    }
    if (Form.of(context).validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名或邮箱",
                    icon: Icon(
                      Icons.person,
                      color: Colors.green,
                    )),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.green,
                    )),
                validator: (value) {
                  return value.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: _loginHandle,
                      child: Text("登录"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
