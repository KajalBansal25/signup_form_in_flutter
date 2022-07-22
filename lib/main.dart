import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Please fill in this form to create an account!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Name",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            errorBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (EmailValidator.validate(value) == false) {
                            return ' Please enter valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Email",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            errorBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.allow(
                        //       RegExp("(0|91)?[7-9][0-9]{9}")),
                        // ],
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone no';
                          } else if (
                              !RegExp("(0|91)?[7-9][0-9]{9}").hasMatch(value)) {
                            return ' Please enter valid mobile number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Phone no.",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            errorBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 6) {
                            return "Atleast 6 character";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Password",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            errorBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Address",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            errorBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2022, 7),
                              lastDate: DateTime(2100));
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              var date =
                                  "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                              dateController.text = date;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter DOB';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "DOB",
                                contentPadding: EdgeInsets.only(left: 20),
                                border: UnderlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                                errorBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: AlertDialog(
                                      content: Column(
                                        children: [
                                          Text(nameController.text),
                                          Text(emailController.text),
                                          Text(phoneController.text),
                                          Text(passwordController.text),
                                          Text(addressController.text),
                                          Text(dateController.text),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    )
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
