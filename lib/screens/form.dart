import 'package:flutter/material.dart';
import 'package:web_view_authentication/constants/constants.dart';
import 'package:web_view_authentication/helpers/helper_functions.dart';
import 'package:web_view_authentication/helpers/network_hepler.dart';
import 'package:web_view_authentication/screens/main_web_view.dart';
import 'package:web_view_authentication/widgets/custom_text_field.dart';
import 'package:web_view_authentication/widgets/main_button.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  NetworkHelper networkHelper = NetworkHelper();
  HelperFunctions helperFunctions = HelperFunctions();

  bool isButtonLoading = false;
  bool isButtonEnabled = false;

  Future<void> postRequest() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await networkHelper
          .getToken(
              username: _usernameController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) async {
        if (value == null) {
          await helperFunctions.showAlert(
            context,
            'Error',
            'Invalid Value',
            Icons.highlight_off,
          );
        } else {
          await networkHelper
              .authenticate(token: value.toString())
              .then((value) {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop(value);
            clearFields();
          });
        }
      });
    } catch (error) {
      await helperFunctions.showAlert(
        context,
        'Error',
        'Invalid Value',
        Icons.highlight_off,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void clearFields() {
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => WebViewPage(
                    url: Constants().mainUrl,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login to authenticate',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xff004252),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormFieldWidget(
                        controller: _usernameController,
                        hintText: 'username',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWidget(
                        controller: _passwordController,
                        hintText: 'password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MainButton(
                        onTap: isButtonLoading
                            ? null
                            : () {
                                postRequest();
                              },
                        buttonTitle: "Authenticate",
                      ),
                    ]),
              ),
      ),
    );
  }
}
