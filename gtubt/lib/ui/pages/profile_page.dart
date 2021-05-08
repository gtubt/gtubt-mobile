import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/button_styles.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/style/decorations.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _passwordFieldKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  final TextStyle _nameTextStyle = TextStyles.subtitle1.copyWith(
      height: 1.4,
      color: ColorSets.defaultTextColor,
      letterSpacing: 0,
      fontWeight: FontWeight.w500);

  Widget _imageBackground() {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
        color: ColorSets.profilePageThemeColor,
      ),
    );
  }

  Widget _profileImage() {
    double _iconSize = 140;
    return Positioned(
      top: 50,
      child: Card(
        elevation: 8.0,
        child: Icon(
          Icons.account_circle,
          color: ColorSets.profilePageThemeColor,
          size: _iconSize,
        ),
      ),
    );
  }

  Widget _fullName(String name) {
    Widget form;
    if (context.read<AppbarBloc>().state.editMode) {
      var controller = TextEditingController();
      controller.text = name;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
      });
      form = TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
      );
    } else {
      form = Text(
        name,
        textAlign: TextAlign.center,
        style: _nameTextStyle,
      );
    }

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50.0, right: 50.0),
      child: Container(
        height: 30.0,
        child: form,
      ),
    );
  }

  Widget _eMail(String email) {
    return Container(
      width: 350.0,
      height: 60.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(EmailChanged(), email, 'E-mail'),
        ],
      ),
    );
  }

  Widget _deparmentInfo(String department) {
    //TODO: must be dropdown
    return Container(
      width: 350.0,
      height: 60.0,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            formWidget(DepartmentChanged(), department, 'Department'),
          ]),
    );
  }

  Widget _yearInfo(String year) {
    return Container(
      width: 350.0,
      height: 60.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(YearChanged(), year, 'Year'),
        ],
      ),
    );
  }

  Widget _studentNumber(String studentId) {
    return Container(
      width: 350.0,
      height: 60.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(StudentNumberChanged(), studentId, 'Student ID'),
        ],
      ),
    );
  }

  Widget _phoneNumber(String phone) {
    phone ??= '';
    return Container(
      width: 350.0,
      height: 60.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(PhoneChanged(), phone, 'Phone'),
        ],
      ),
    );
  }

  Widget formWidget(UserEvent field, formData, fieldName) {
    Widget form;
    if (context.read<AppbarBloc>().state.editMode) {
      TextEditingController controller =
          context.read<UserBloc>().textEditingController(field);
      controller.text = formData;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        context.read<UserBloc>().add(field);
      });
      form = TextFormField(
        controller: controller,
        readOnly: !context.read<AppbarBloc>().state.editMode,
        decoration: FormBoxContainer.textFieldStyle(
            labelTextStr: "  " + fieldName + "  "),
      );
    } else {
      form = TextFormField(
        controller: null,
        readOnly: !context.read<AppbarBloc>().state.editMode,
        enabled: false,
        initialValue: formData,
        decoration: FormBoxContainer.textFieldStyle(
            labelTextStr: "  " + fieldName + "  "),
      );
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: form,
      ),
    );
  }

  Widget accountDeletionDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorSets.popUpBackgroundColor,
      elevation: 40,
      child: Container(
          height: 236,
          width: 600,
          padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
          child: Column(
            children: [
              Text(
                "To delete your account please enter your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              SizedBox(height: 15),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                      key: _passwordFieldKey,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          final authState =
                              context.read<AuthenticationBloc>().state;
                          if (authState is AuthenticationError) {
                            return authState.message;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyles.outlinedButton,
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_passwordFieldKey.currentState.validate()) {
                        context.read<AuthenticationBloc>().add(
                              DeleteAcc(
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    style: ButtonStyles.containedButton,
                    child: Text("Delete Account"),
                  )
                ]),
              )
            ],
          )),
    );
  }

  Widget buildAll(BuildContext context, UserState state) {
    User user = context.read<UserBloc>().userService.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            _imageBackground(),
            _profileImage(),
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                  ),
                  _fullName(user.fullName),
                  Container(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 5.0),
                    child: _eMail(user.email),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _deparmentInfo(user.department.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _yearInfo(user.year.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _studentNumber(user.studentId),
                  ),
                  Container(
                    child: _phoneNumber(user.phone),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(bottom: 5.0, right: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 32,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              _passwordController.clear();
                              return accountDeletionDialog(context);
                            });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          _passwordFieldKey.currentState.validate();
        }
        if (state is AuthenticationUnauthenticated) {
          context.read<PageBloc>().add(
                PageChanged(
                  context: context,
                  routeName: ROOT_URL,
                  clearStack: true,
                ),
              );
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppbarBloc, AppbarState>(
          builder: (context, state) {
            return BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state.isFailure) {
                  NotificationFactory.errorFactory(message: state.errorMessage)
                      .show(context);
                }
              },
              builder: (context, state) {
                if (!state.isFailure) {
                  return buildAll(context, state);
                } else {
                  return Scaffold();
                }
              },
            );
          },
        );
      },
    );
  }
}
