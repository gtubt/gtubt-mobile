import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:GTUBT/ui/style/form_box_container.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _passwordFieldKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  User user;
  final picker = ImagePicker();
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

  Future<void> _getImage(ImageSource imageSource) async {
    var imageFile = await picker.getImage(source: imageSource);
    if (imageFile == null) return;
    print('get image: ' + imageFile.path);
    /* TODO: save image to user.profilePhoto */
  }

  void _imagePickerMenu() {
    var _menuItems = [
      ListTile(
        leading: Icon(Icons.image),
        title: Text('Select from gallery'),
        onTap: () {
          Navigator.of(context).pop();
          _getImage(ImageSource.gallery);
        },
      ),
      ListTile(
        leading: Icon(Icons.camera_alt),
        title: Text('Take a photo'),
        onTap: () {
          Navigator.of(context).pop();
          _getImage(ImageSource.camera);
        },
      ),
    ];

    if (user.profilePhoto != null) {
      _menuItems.add(
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Remove'),
          onTap: () {
            Navigator.of(context).pop();
            /* TODO: remove users profile photo */
          },
        ),
      );
    }

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _menuItems,
            ),
          );
        });
  }

  Widget _profileImage() {
    Widget profilePhoto;

    if (user.profilePhoto == null) {
      profilePhoto = Icon(
        Icons.account_circle,
        color: ColorSets.profilePageThemeColor,
      );
    } else {
      profilePhoto = Image.network(
        user.profilePhoto,
      );
    }

    profilePhoto = Image.network(
      "https://i.picsum.photos/id/218/200/300.jpg?hmac=S2tW-K1x-k9tZ7xyNVAdnie_NW9LJEby6GBgYpL7kfo"
    );

    return Center(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            child: FittedBox(
              fit: BoxFit.cover,
              child: profilePhoto,
            ),
            width: 155.0,
            height: 140.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorSets.profilePageThemeColor,
                width: 5,
              ),

            ),
          ),
          FloatingActionButton(
            backgroundColor: ColorSets.barBackgroundColor,
            mini: true,
            onPressed: _imagePickerMenu,
            child: Icon(
              Icons.edit,
              color: ColorSets.pageBackgroundColor,
            ),
          ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(EmailChanged(), email, "E-mail"),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _departmentInfo(String department) {
    //TODO: must be dropdown
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            formWidget(DepartmentChanged(), department, "Department"),
          ]),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _yearInfo(String year) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(YearChanged(), year, "Year"),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _studentNumber(String studentId) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(StudentNumberChanged(), studentId, "Student ID"),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _phoneNumber(String phone) {
    phone ??= '';
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formWidget(PhoneChanged(), phone, "Phone"),
        ],
      ),
      width: 350.0,
      height: 60.0,
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
      backgroundColor: ColorSets.popUpColor,
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
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: ColorSets.barBackgroundColor,
                    textColor: ColorSets.lightTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    onPressed: () {
                      if (_passwordFieldKey.currentState.validate()) {
                        context.read<AuthenticationBloc>().add(
                              DeleteAcc(
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    color: ColorSets.profilePageThemeColor,
                    textColor: ColorSets.lightTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorSets.lightTextColor),
                    ),
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
                    child: _departmentInfo(user.department.toString()),
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
