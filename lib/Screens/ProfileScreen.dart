import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/ChangePasswordModelClass.dart';
import 'package:greendice/ModelClasses/SigninUser.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'HomeScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String firstname, lastname, phone, email;
  String? photo;

  var _formkey = GlobalKey<FormState>();
  var _formkey2 = GlobalKey<FormState>();

  //final ImagePicker _picker = ImagePicker();
  TextEditingController user_ctrl = TextEditingController();
  TextEditingController user_lname = TextEditingController();
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController phone_ctrl = TextEditingController();
  TextEditingController old_pass_ctrl = TextEditingController();
  TextEditingController pass_ctrl = TextEditingController();
  TextEditingController confirmpass_ctrl = TextEditingController();
  TextEditingController profilepic_ctrl = TextEditingController();

  final _picker = ImagePicker();
  PickedFile? _imageFile;
  @override
  void dispose() {
    user_ctrl.dispose();
    user_lname.dispose();
    email_ctrl.dispose();
    phone_ctrl.dispose();
    old_pass_ctrl.dispose();
    pass_ctrl.dispose();
    confirmpass_ctrl.dispose();
    profilepic_ctrl.dispose();
    super.dispose();
  }

  bool isLoading = true;
  bool isLoading2 = false;

  @override
  void initState() {
    super.initState();

    _loadCounter().then((value) => {
          setState(() {
            isLoading = false;
          }),
          user_ctrl.value = user_ctrl.value.copyWith(
            text: firstname,
            selection: TextSelection.collapsed(
              offset: user_ctrl.value.selection.baseOffset + firstname.length,
            ),
          ),
          user_lname.value = user_lname.value.copyWith(
            text: lastname,
            selection: TextSelection.collapsed(
              offset: user_lname.value.selection.baseOffset + lastname.length,
            ),
          ),
          email_ctrl.value = email_ctrl.value.copyWith(
            text: email,
            selection: TextSelection.collapsed(
              offset: email_ctrl.value.selection.baseOffset + email.length,
            ),
          ),
          phone_ctrl.value = phone_ctrl.value.copyWith(
            text: phone,
            selection: TextSelection.collapsed(
              offset: phone_ctrl.value.selection.baseOffset + phone.length,
            ),
          ),
          print('photo: $photo'),
        });
  }

  Future changePassword() async {
    if (pass_ctrl.text == confirmpass_ctrl.text) {
      final isValid = _formkey2.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        setState(() {
          isLoading2 = true;
        });
        final prefs = await SharedPreferences.getInstance();
        final access_token = prefs.getString('access_token') ?? '';

        var response = await http.post(
          Uri.parse("http://syedu12.sg-host.com/api/changepassword"),
          body: {
            "old_password": old_pass_ctrl.text,
            "password": pass_ctrl.text,
            //"image": user_lname.text,
            "password_confirmation": confirmpass_ctrl.text,
          },
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + access_token,
          },
        );

        var data = json.decode(response.body);
        ChangePasswordModelClass changePasswordModelClass =
            ChangePasswordModelClass.fromJson(jsonDecode(response.body));
        var val = '${changePasswordModelClass.success}';
        var message = '${changePasswordModelClass.message}';

        print(response);
        if (val == "0") {
          if (mounted) {
            setState(() {
              isLoading2 = false;
            });
          }
          Fluttertoast.showToast(
            msg:
                "Icorrect Old Password! Please enter a correct old password or use Forgot password from Signin Screen",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else {
          if (mounted) {
            setState(() {
              isLoading2 = false;
              pass_ctrl.clear();
              confirmpass_ctrl.clear();
              old_pass_ctrl.clear();
            });
          }
          Fluttertoast.showToast(
            msg: "Password Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: "Error! Password and Confirm Password Fields does not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future update() async {
    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      if (mounted) {
        setState(() {
          isLoading2 = true;
        });
      }
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString('access_token') ?? '';

      // var response = await http
      //     .post(Uri.parse("http://syedu12.sg-host.com/api/updateuser"),
      //   body: {
      //   "first_name": user_ctrl.text,
      //   "last_name": user_lname.text,
      //   //"image": user_lname.text,
      //   "phone": phone_ctrl.text,
      // },
      //   headers: {
      //     HttpHeaders.authorizationHeader: "Bearer " + access_token,
      //   },
      // );

      var headers = {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $access_token'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://syedu12.sg-host.com/api/updateuser'));
      request.fields.addAll({
        "first_name": user_ctrl.text,
        "last_name": user_lname.text,
        "phone": phone_ctrl.text,
      });

      if (_imageFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _imageFile!.path));
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var v = await response.stream.bytesToString();

      print("status code -> ${response.statusCode}");
      print("response -> $v");

      //SigninUser signinUser = SigninUser.fromJson(jsonDecode(response.body));
      SigninUser signinUser = SigninUser.fromJson(jsonDecode(v));
      var val = '${signinUser.success}';
      var message = '${signinUser.message}';
      prefs.setString('fname', signinUser.data!.user!.firstName!);
      prefs.setString('lname', signinUser.data!.user!.lastName!);
      prefs.setString('phone', signinUser.data!.user!.phone!);
      prefs.setString('email', signinUser.data!.user!.email!);
      prefs.setString('image', signinUser.data!.user!.photo!);

      print(response);
      if (mounted) {
        setState(() {
          isLoading2 = false;
        });
      }
      if (val == "0") {
        Fluttertoast.showToast(
          msg: "Unable to update profile. Please try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      phone = (prefs.getString('phone') ?? '');
      email = (prefs.getString('email') ?? '');
      photo = (prefs.getString('image') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading2
          ? Center(
              child: CircularProgressIndicator(
              color: Color(0xff009E61),
              backgroundColor: Color(0xff0ECB82),
            ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.21,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/profilebackground.png"),
                                      fit: BoxFit.cover)),
                            ),

                            /*Padding(
                        padding: EdgeInsets.fromLTRB(15, 25, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.035,
                            height: MediaQuery.of(context).size.height * 0.035,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage('assets/images/back.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),*/

                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Image.asset('assets/images/back.png'),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -70,
                              child: InkWell(
                                onTap: () async {
                                  print('cliked');
                                  //await _picker.pickImage(source: ImageSource.gallery);
                                  _showPicker(context);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: (photo != '' && _imageFile == null)
                                      ? Container(
                                          width: 72.0,
                                          height: 72.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                photo!,
                                              ),
                                            ),
                                          ),
                                        )
                                      : _imageFile != null
                                          ? Container(
                                              width: 72.0,
                                              height: 72.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(
                                                      File(_imageFile!.path),
                                                    )),
                                              ),
                                            )
                                          : Image.asset(
                                              "assets/images/profileimage.png",
                                              width: 72,
                                              height: 72,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.45,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                ),
                                TextFormField(
                                  controller: user_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter First Name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  controller: user_lname,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter Last Name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  enabled: false,
                                  controller: email_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter a valid Email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  controller: phone_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter Phone Number";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                            key: _formkey2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  controller: old_pass_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Old Password',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter Old Password";
                                    } else if (text.length < 5) {
                                      return "Password should not be less then 5 characters";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  controller: pass_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter New Password";
                                    } else if (text.length < 5) {
                                      return "Password should not be less then 5 characters";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                  controller: confirmpass_ctrl,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(
                                        color: Color(0xff9B9B9B),
                                      )),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter Confirm Password";
                                    } else if (text.length < 5) {
                                      return "Password should not be less then 5 characters";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: ElevatedButton(
                                      child: Text(
                                          "Update Profile".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff009E61)),
                                          alignment: Alignment.center,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  side: BorderSide(
                                                    color: Color(0xff009E61),
                                                  )))),
                                      onPressed:
                                          isLoading2 ? null : () => update()),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: ElevatedButton(
                                      child: Text(
                                          "Update Password".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff009E61)),
                                          alignment: Alignment.center,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  side: BorderSide(
                                                    color: Color(0xff009E61),
                                                  )))),
                                      onPressed: isLoading2
                                          ? null
                                          : () => changePassword()),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isLoading2,
                      child: CircularProgressIndicator(
                        color: Color(0xff009E61),
                        backgroundColor: Color(0xff0ECB82),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Gallery'),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (mounted) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print('image picker error: $e');
    }
  }

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (mounted) {
        setState(() {
          _imageFile = pickedFile;
        });
      }

      //print(‘img file 1 = ${_imgFile!.path}’);
    } catch (e) {
      print('image picker error: $e');
    }
  }
}
