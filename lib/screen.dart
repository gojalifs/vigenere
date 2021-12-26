import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'logic.dart';

class Screen extends StatefulWidget {
  final title;

  Screen({this.title});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Logic logic = Logic();
  String result = '';

  inputFormattin() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
    ];
  }

  keyFormattin() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
    ];
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController key = TextEditingController();
  TextEditingController additionalParam = TextEditingController();

  bool fullVigenere = false;
  List<int> randomAlphabeth = [];
  String fromRandom = '';
  String message =
      'Jika anda menginginkan untuk membuat vigenere cipher dengan tipe Full Vigenere Cipher, maka anda bisa bengisi kotak alfabet ini, anda juga bisa generate alfabet secara random';

  void generateAlphabeth() {
    randomAlphabeth.clear();
    fromRandom = '';
    for (var i = 0; randomAlphabeth.length < 26; i++) {
      int random = Random().nextInt(26);
      if (randomAlphabeth.contains(random)) {
        continue;
      }
      randomAlphabeth.add(random);
      fromRandom += String.fromCharCode(random + 97);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      maxLines: null,
                      controller: input,
                      inputFormatters: inputFormattin(),
                      validator: (value) {
                        if (value!.isEmpty) return 'Required';
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          hintText: 'Text'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: key,
                      inputFormatters: keyFormattin(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          hintText: 'Key'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: additionalParam,
                              inputFormatters: keyFormattin(),
                              validator: (value) {
                                if (value!.length != 26 && value.isNotEmpty) {
                                  return 'Alphabeth Must Be 26 Digit Of Char';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                hintText: 'Alphabeth (Optional)',
                                suffixIcon: Tooltip(
                                  message: message,
                                  padding: EdgeInsets.all(10),
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  margin: EdgeInsets.symmetric(horizontal: 100),
                                  child: Icon(Icons.help),
                                  triggerMode: TooltipTriggerMode.tap,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.shuffle),
                                onPressed: () {
                                  generateAlphabeth();
                                  setState(() {
                                    additionalParam.text = fromRandom;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (formKey.currentState!.validate()) {
                                  setState(
                                    () {
                                      if (additionalParam.text.isNotEmpty) {
                                        fullVigenere = true;
                                      } else {
                                        fullVigenere = false;
                                      }
                                      result = logic.vigenere(
                                          input.text,
                                          key.text,
                                          fullVigenere,
                                          1,
                                          additionalParam.text);
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.lock_outline),
                              label: const Text('ENCRYPT'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (formKey.currentState!.validate()) {
                                  setState(
                                    () {
                                      if (additionalParam.text.isNotEmpty) {
                                        fullVigenere = true;
                                      } else {
                                        fullVigenere = false;
                                      }
                                      result = logic.vigenere(
                                          input.text,
                                          key.text,
                                          fullVigenere,
                                          0,
                                          additionalParam.text);
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.lock_open_rounded),
                              label: const Text('DECRYPT'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: const ListTile(
                        title: Text(
                      'OUTPUT',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      constraints: const BoxConstraints.expand(
                        width: 500,
                        height: 100,
                      ),
                      child: result == ''
                          ? const Text('Output Will Shown Here')
                          : SelectableText(result),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
