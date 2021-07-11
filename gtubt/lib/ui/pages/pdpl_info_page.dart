import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';

class PdplInfoPage extends StatefulWidget {
  @override
  _PdplInfoPageState createState() => _PdplInfoPageState();
}

class _PdplInfoPageState extends State<PdplInfoPage> {

  Widget _buildPdplInfoPage() {

    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Html(data: Constants.pdpl,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: ColorSets.appMainColor,
          centerTitle: true,
          title: Text(
            'PDPL (KVKK) Information',
            style: TextStyle(color: ColorSets.lightTextColor),
          ),
          iconTheme: IconThemeData(color: ColorSets.lightTextColor)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: _buildPdplInfoPage(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
