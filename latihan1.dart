import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/m02/provider.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';

class Mybio extends StatelessWidget {
  const Mybio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mybio")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<MyBioModel>(
            builder: (context, bioModel, child) {
              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child: bioModel.imagePath != null
                        ? Image.file(
                            File(bioModel.imagePath!),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 198, 198, 198)),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: bioModel.pickImage,
                      child: Text("Take Image"),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpinBox(
                        max: 10.0,
                        min: 0.0,
                        value: bioModel.score,
                        decimals: 1,
                        step: 0.1,
                        decoration: InputDecoration(labelText: 'Decimal'),
                        onChanged: bioModel.setScore,
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
