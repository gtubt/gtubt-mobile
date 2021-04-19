import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextStyle _headerTextStyle = TextStyles.subtitle1
      .copyWith(height: -2, color: ColorSets.profilePageThemeColor);
  final TextStyle _nameTextStyle = TextStyles.subtitle2
      .copyWith(height: 1.4, color: ColorSets.defaultTextColor);

  User user;
  final picker = ImagePicker();

  Widget _imageBackground() {
    return Container(
      height: 150.0,
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
        style: _nameTextStyle,
      );
    }

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 32.0, right: 32.0),
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
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  E-posta  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(EmailChanged(), email),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _departmentInfo(String department) {
    //TODO: must be dropdown
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Bölüm  ",
                style: _headerTextStyle,
              ),
            ),
            formWidget(DepartmentChanged(), department),
          ]),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _yearInfo(String year) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Sınıf  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(YearChanged(), year),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _studentNumber(String studentId) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Öğrenci No  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(StudentNumberChanged(), studentId),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _phoneNumber(String phone) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Telefon No  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(PhoneChanged(), phone),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget formWidget(UserEvent field, formData) {
    Widget form;
    if (context.read<AppbarBloc>().state.editMode) {
      TextEditingController controller = context.read<UserBloc>().textEditingController(field);
      controller.text = formData;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        context.read<UserBloc>().add(field);
      });
      form = TextFormField(
        controller: controller,
      );
    } else {
      form = Text(formData, style: _nameTextStyle);
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25),
        child: form,
      ),
    );
  }

  Widget buildAll(BuildContext context, UserState state) {
    User user = context.read<UserBloc>().userService.currentUser;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imageBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _profileImage(),
                  _fullName(user.fullName),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _eMail(user.email),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _departmentInfo(user.department.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _yearInfo(user.year.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _studentNumber(user.studentId),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _phoneNumber(user.phone),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
