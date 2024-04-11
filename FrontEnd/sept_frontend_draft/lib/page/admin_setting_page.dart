import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/base_request.dart';
import 'package:sept_frontend_draft/page/admin_home_page.dart';

class AdminSettingPage extends StatefulWidget {
  final Map<String, dynamic> map;
  static const sName = 'AdminSettingPage';

  const AdminSettingPage({Key? key, required this.map}) : super(key: key);

  @override
  State<AdminSettingPage> createState() => _AdminSettingPageState();
}

class _AdminSettingPageState extends State<AdminSettingPage> {
  ValueNotifier<InfoType> type = ValueNotifier(InfoType.doctor);

  HomeTabListDtoEntity? currentEntity;

  HomeTabListDtoEntity addEntity = HomeTabListDtoEntity();

  @override
  void initState() {
    super.initState();
    if (widget.map['entity'] != null) {
      currentEntity = widget.map['entity'];
    }

    type.value = widget.map['type'];
  }

  /// edit info
  void editInfo () async {
    try {
      if (type.value == InfoType.doctor) {
        if (currentEntity?.subTitle == null || currentEntity?.title == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().put(
          'http://localhost:8080/Doctor',
          queryParameters: {
            'id': currentEntity?.title,
            'name': currentEntity?.subTitle,
            'password': currentEntity?.info
          },
        );
      } else if (type.value == InfoType.medicine) {
        if (currentEntity?.subTitle == null || currentEntity?.title == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().put(
          'http://localhost:8080/Medicine',
          queryParameters: {
            'description': currentEntity?.info,
            'id': currentEntity?.title,
            'name': currentEntity?.subTitle,
            'stock': currentEntity?.tagTitle,
          },
        );
      } else {
        if (currentEntity?.subTitle == null ||
            currentEntity?.title == null ||
            currentEntity?.info == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().put(
          'http://localhost:8080/Patient',
          queryParameters: {
            'id': currentEntity?.title,
            'name': currentEntity?.subTitle,
            'password': currentEntity?.info,
            'status':  currentEntity?.tagTitle,
          },
        );
      }

      showToast('Edit success', onDismiss: () {
        Navigator.pop(context, currentEntity);
      });
    } catch (e) {
      showToast(e.toString());
    }
  }

  /// add info
  void addInfo() async {
    try {
      if (type.value == InfoType.doctor) {
        if (addEntity.subTitle == null || addEntity.title == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().post(
          'http://localhost:8080/Doctor',
          queryParameters: {
            'name': addEntity.subTitle,
            'password': addEntity.title
          },
        );
      } else if (type.value == InfoType.medicine) {
        if (addEntity.subTitle == null || addEntity.title == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().post(
          'http://localhost:8080/Medicine',
          queryParameters: {
            'description': addEntity.subTitle,
            'name': addEntity.title
          },
        );
      } else {
        if (addEntity.subTitle == null ||
            addEntity.title == null ||
            addEntity.info == null) {
          showToast('Please input all info');
          return;
        }
        final response = await BaseRequest().post(
          'http://localhost:8080/Patient',
          queryParameters: {
            'id': addEntity.subTitle,
            'name': addEntity.title,
            'password': addEntity.info
          },
        );
      }

      showToast('Add success', onDismiss: () {
        Navigator.pop(context, addEntity);
      });
    } catch (e) {
      showToast(e.toString());
    }
  }

  void showTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.book),
                title: Text('doctor'),
                onTap: () {
                  Navigator.pop(context);
                  type.value = InfoType.doctor;
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('medicine'),
                onTap: () {
                  Navigator.pop(context);
                  type.value = InfoType.medicine;
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('patient'),
                onTap: () {
                  Navigator.pop(context);
                  type.value = InfoType.patient;
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin setting',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<InfoType>(valueListenable: type, builder: (context,value,child){
                Widget inputContent = const SizedBox();
                if (currentEntity != null) {
                  /// edit
                  inputContent = _buildContent(currentEntity,value);
                } else {
                  /// add
                  inputContent = _buildAddWidget(value);
                }
                return Column(
                  children: [
                    Visibility(

                      child: CommonSelectItem(
                          title: 'Add Type',
                          placeholder: value.name,
                          onTap: () {
                            showTypeBottomSheet(context);
                          },
                          showClear: false,
                          color: const Color(0xFF030319),
                          formType: FormType.actionSheet),
                      visible: currentEntity == null,
                    ),
                    inputContent,
                  ],
                );
              }),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (currentEntity != null) {
                    editInfo();
                  } else {
                    addInfo();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width - 32,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.lightBlue,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// build input widget
  Widget _buildContent(HomeTabListDtoEntity? entity, InfoType type) {
    if (type == InfoType.doctor){
      return Column(
        children: [
          CommonSelectItem(
            title: 'Id',
            placeholder: 'Input Id',
            initString: entity?.title,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) {

              currentEntity?.title = value;
            },

            formType: FormType.disable,
          ),
          CommonSelectItem(
            title: 'Name',
            placeholder:'Input Name',
            initString: entity?.subTitle,
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) {
              currentEntity?.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Password',
            placeholder: 'Input Password',
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) {
              currentEntity?.info = value;
            },
            formType: FormType.input,
          ),
          Visibility(
            visible: type == InfoType.patient,
            child: CommonSelectItem(
              title: 'Status',
              placeholder: 'Input Status',
              keyboardType: TextInputType.visiblePassword,
              onChange: (value) {
                currentEntity?.info = value;
              },
              formType: FormType.input,
            ),
          ),
        ],
      );
    } else if(type ==InfoType.medicine){
      return Column(
        children: [
          CommonSelectItem(
            title: 'Id',
            placeholder: 'Input Id',
            initString: entity?.title,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) {

              currentEntity?.title = value;
            },

            formType: FormType.disable,
          ),
          CommonSelectItem(
            title: 'Name',
            placeholder:'Input Name',
            initString: entity?.subTitle,
            keyboardType: TextInputType.name,
            onChange: (value) {
              currentEntity?.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'description',
            placeholder: 'Input description',
            keyboardType: TextInputType.name,
            onChange: (value) {
              currentEntity?.info = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Stock',
            placeholder: 'Input Stock',
            keyboardType: TextInputType.number,
            onChange: (value) {
              currentEntity?.tagTitle = value;
            },
            formType: FormType.input,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CommonSelectItem(
            title: 'Id',
            placeholder: 'Input Id',
            initString: entity?.title,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) {

              currentEntity?.title = value;
            },

            formType: FormType.disable,
          ),
          CommonSelectItem(
            title: 'Name',
            placeholder:'Input Name',
            initString: entity?.subTitle,
            keyboardType: TextInputType.name,
            onChange: (value) {
              currentEntity?.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'password',
            placeholder: 'Input password',
            keyboardType: TextInputType.name,
            onChange: (value) {
              currentEntity?.info = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Status',
            placeholder: 'Input Status',
            keyboardType: TextInputType.number,
            onChange: (value) {
              currentEntity?.tagTitle = value;
            },
            formType: FormType.input,
          ),
        ],
      );
    }
  }

  Widget _buildAddWidget(InfoType type) {
    Widget content;
    if (type == InfoType.doctor) {
      return Column(
        children: [
          CommonSelectItem(
            title: 'Name',
            placeholder: 'Input Name',
            keyboardType: TextInputType.name,
            onChange: (value) {
              addEntity.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Password',
            placeholder: 'Input Password',
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) {
              addEntity.title = value;
            },
            formType: FormType.input,
          ),
        ],
      );
    } else if (type == InfoType.patient) {
      return Column(
        children: [
          CommonSelectItem(
            title: 'Id',
            placeholder: 'Input Id',
            keyboardType: TextInputType.number,
            onChange: (value) {
              addEntity.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Name',
            placeholder: 'Input Name',
            keyboardType: TextInputType.name,
            onChange: (value) {
              addEntity.title = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Password',
            placeholder: 'Input Password',
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) {
              addEntity.info = value;
            },
            formType: FormType.input,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          CommonSelectItem(
            title: 'Description',
            placeholder: 'Input description',
            keyboardType: TextInputType.name,
            onChange: (value) {
              addEntity.subTitle = value;
            },
            formType: FormType.input,
          ),
          CommonSelectItem(
            title: 'Name',
            placeholder: 'Input Name',
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) {
              addEntity.title = value;
            },
            formType: FormType.input,
          ),
        ],
      );
    }
  }
}

enum InfoType { medicine, doctor, patient }

/// fetch info type
extension UserExtension on String? {
  InfoType get infoType {
    switch (this) {
      case 'medicine':
        return InfoType.medicine;
      case 'doctor':
        return InfoType.doctor;
      case 'patient':
        return InfoType.patient;
      default:
        return InfoType.doctor;
    }
  }
}

enum FormType { input, actionSheet, disable }

class CommonSelectItem extends StatefulWidget {
  final String title;
  final String placeholder;
  final FormType formType;
  final ValueChanged<String?>? onChange;
  final VoidCallback? onTap;
  final Color textColor;
  final TextInputType? keyboardType;
  final String? initString;
  final bool showClear;
  final bool overflow;
  final bool isPhone;
  final TextEditingController? textEditingController;
  final int hintMaxLines;
  final int? maxL;
  final List<TextInputFormatter>? formatter;

  const CommonSelectItem({
    Key? key,
    required this.title,
    required this.placeholder,
    required this.formType,
    Color? color,
    this.onChange,
    this.onTap,
    this.keyboardType,
    this.initString,
    this.showClear = true,
    this.overflow = false,
    this.isPhone = false,
    this.textEditingController,
    this.hintMaxLines = 1,
    this.formatter,
    this.maxL,
  })  : textColor = color ?? const Color(0xFFBDBDBD),
        super(key: key);

  @override
  _CommonSelectItemState createState() => _CommonSelectItemState();
}

class _CommonSelectItemState extends State<CommonSelectItem> {
  late TextEditingController _editingController;
  late FocusNode _focusNode;
  List<TextInputFormatter>? inputFormatter;
  final ValueNotifier<bool> _showClear = ValueNotifier(false);

  ValueNotifier<bool> isFocus = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    if (widget.textEditingController == null) {
      _editingController = TextEditingController();
    } else {
      _editingController = widget.textEditingController!;
    }
    if (widget.showClear) {
      _editingController.addListener(() {
        _showClear.value = _editingController.text.isNotEmpty;
      });
    }

    if ((widget.initString ?? '').isNotEmpty) {
      _editingController.text = widget.initString!;
    }

    _focusNode.addListener(() {
      isFocus.value = _focusNode.hasFocus;
    });

    _editingController.addListener(() {
      if (_editingController.text.isEmpty) {
        widget.onChange?.call('');
      }
    });

    if (widget.isPhone) {
      inputFormatter = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ];
    }
    if (widget.formatter != null) {
      inputFormatter = widget.formatter;
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isFocus,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: widget.formType == FormType.input ? null : widget.onTap,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 17),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: value
                        ? const Color(0xFF4CD080)
                        : const Color(0xFFF2F2F2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 106),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFF030319),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  widget.overflow
                      ? Expanded(
                          child: Text(
                          widget.placeholder,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: 16,
                          ),
                        ))
                      : Expanded(
                          child: TextField(
                          enabled: widget.formType == FormType.input,
                          focusNode: _focusNode,
                          onSubmitted: (value) {
                            _focusNode.unfocus();
                          },
                          controller: _editingController,
                          onChanged: widget.onChange,
                          keyboardType: widget.keyboardType,
                          cursorColor: const Color(0xFF030319),
                          keyboardAppearance: Brightness.light,
                          inputFormatters: inputFormatter,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLength: widget.maxL,
                          decoration: InputDecoration(
                            hintText: widget.placeholder,
                            hintStyle: TextStyle(
                              color: widget.textColor,
                              fontSize: 16,
                            ),
                            counterText: '',
                            hintMaxLines: widget.hintMaxLines,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 1),
                            border: InputBorder.none,
                            suffixIcon: _buildClearSuffix(),
                            suffixIconConstraints: const BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 24,
                            ),
                          ),
                        )),
                  Visibility(
                    visible: widget.formType == FormType.actionSheet,
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildClearSuffix() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: _showClear,
            builder: (BuildContext context, value, Widget? child) {
              return Visibility(
                visible: value && isFocus.value == true,
                child: GestureDetector(
                  onTap: () {
                    _editingController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              );
            }),
      ],
    );
  }
}
