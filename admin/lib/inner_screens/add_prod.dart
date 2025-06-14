import 'dart:io';
import 'dart:ui' as BorderType;
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin_app/controllers/MyMenuController.dart';
import 'package:admin_app/services/utils.dart';
import 'package:admin_app/widgets/buttons.dart';
import 'package:admin_app/widgets/header.dart';
import 'package:admin_app/widgets/side_menu.dart';
import 'package:admin_app/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../responsive.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _categoryValue = 'Vegetables';

  late final TextEditingController _titleController, _priceController;
  int _groupValue = 1;
  bool ispieced = false;
  File? _pickedImage;
  Uint8List? webImage=Uint8List(8);

  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
  }
  void _clearForm() {
    _groupValue=1;
    ispieced =false;
    _titleController.clear();
    _priceController.clear();
    setState(() {
      _pickedImage = null;
      webImage=Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      key: context.read<MyMenuController>().getAddProductscaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Header(fct: () {
                    context.read<MyMenuController>().controlAddProductsMenu();
                  },
                    title: 'Add Product',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width > 650 ? 650 : size.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextWidget(
                            text: 'Product title*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _titleController,
                            key: const ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Title';
                              }
                              return null;
                            },
                            decoration: inputDecoration,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'Price in \$*',
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: TextFormField(
                                          controller: _priceController,
                                          key: const ValueKey('Price \$'),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Price is missed';
                                            }
                                            return null;
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]')),
                                          ],
                                          decoration: inputDecoration,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextWidget(
                                        text: 'Porduct category*',
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(height: 10),
                                       _categoryDropDown(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextWidget(
                                        text: 'Measure unit*',
                                        color: color,
                                        isTitle: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          TextWidget(
                                            text: 'Kg',
                                            color: color,
                                          ),
                                          Radio(value: 1, groupValue: _groupValue, onChanged: (valuee){
                                            setState(() {
                                              _groupValue=1;
                                              ispieced=false;
                                            });
                                          },
                                            activeColor: Colors.green,
                                          ),
                                          TextWidget(
                                            text: 'Piece',
                                            color: color,
                                          ),
                                          Radio(value: 2, groupValue: _groupValue, onChanged: (valuee){
                                            setState(() {
                                              _groupValue=2;
                                              ispieced=true;
                                            });
                                          },
                                          activeColor: Colors.green,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )


                                    ],
                                  ),
                                ),
                              ),
                              // Image to be picked code is here
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: size.width>650?350:size.width*0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                      child: _pickedImage == null
                                          ? dottedBorder(color: color)
                                         :ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: kIsWeb? Image.memory(
                                          webImage!,
                                          fit: BoxFit.fill,
                                        ):Image.file(
                                          _pickedImage!,
                                          fit: BoxFit.fill,
                                    ),
                                  )),
                                  ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _pickedImage = null;
                                              webImage = Uint8List(8);
                                            });
                                          },
                                          child: TextWidget(
                                            text: 'Clear',
                                            color: Colors.red,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {

                                          },
                                          child: TextWidget(
                                            text: 'Update image',
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                  onPressed: () {
                                    _clearForm();
                                  },
                                  text: 'Clear form',
                                  icon: IconlyBold.danger,
                                  backgroundColor: Colors.white,
                                ),
                                ButtonsWidget(
                                  onPressed: () {
                                    _uploadForm();
                                  },
                                  text: 'Upload',
                                  icon: IconlyBold.upload,
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget dottedBorder(
  {
    required Color color,
}
      ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        color: color,
        strokeWidth: 2,
        dashPattern: const [6, 7],
        customPath: (size) {
          return Path()
            ..addRRect(RRect.fromRectAndRadius(
              Rect.fromLTWH(0, 0, size.width, size.height),
              const Radius.circular(12),
            ));
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Icon(
              Icons.image_outlined,
              size: 50,
              color: color,
            ),
              TextButton(
                  onPressed: ((){
                    _pickImage();
                  }),
                  child:TextWidget(
                      text: 'Choose an image',
                      color: Colors.blue) )
            ]
          ),
        )
      )
    );
  }
  Widget _categoryDropDown(){
    final color = Utils(context).color;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(

            child: DropdownButton<String>(
                style:TextStyle( fontWeight: FontWeight.w600,fontSize: 20),
              value: _categoryValue,
              onChanged: (value){
                setState(() {
                  _categoryValue=value!;
                });
                print(_categoryValue);
              },
              hint:  Text(
                'Select a Category',
                style: TextStyle(
                  color: color,
                ),
              ),
              items:const
              [
                DropdownMenuItem(
                  child: Text(
                    'Vegetables',
                  ),
                  value: 'Vegetables',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Fruits',
                  ),
                  value: 'Fruits',
                ),
                DropdownMenuItem(
                    child: Text('Grains'),
                    value: 'Grains'),
                DropdownMenuItem(
                    child: Text('Nuts'),
                    value: 'Nuts'),
                DropdownMenuItem(
                    child: Text('Herbs'),
                    value: 'Herbs'),
                DropdownMenuItem(
                    child: Text('Spices'),
                    value: 'Spices')
                ],
            ),
            ),
      ),
    );

  }
}
