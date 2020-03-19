import 'package:epasal_app/provider/product.dart';
import 'package:epasal_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeId = '/edit_product_screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  var _editedProduct = Product(
      title: "",
      price: 0,
      description: "",
      imageURL: "",
      id: null,
      isFavourite: false);

  bool isInit = true;

  var initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  // --------- first function called when our screen is created ----------
  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  //--------- the first time to initializing values------------

  @override
  void didChangeDependencies() {
    if (isInit) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  // --------- to clean off the unwanted widgets ----------
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  //------- to update image on container after user enter new image url------------
  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.JPG') &&
              !_imageUrlController.text.endsWith('.JPEG'))) {
        return;
      }
      setState(() {});
    }
  }

  // ------- to save products ----------

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error occured!"),
                  content:
                      Text("Something has occured! Product couldn't bt added."),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'The title must not be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value.trim(),
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageURL: _editedProduct.imageURL,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                    TextFormField(
                        initialValue: initValues['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descFocusNode);
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'The price must not be empty!';
                          }
                          if (double.tryParse(value) == null) {
                            return 'The price must be in number format!';
                          }
                          if (double.parse(value) <= 0) {
                            return 'The price must not be less then zero!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageURL: _editedProduct.imageURL,
                            id: _editedProduct.id,
                          );
                        }),
                    TextFormField(
                        initialValue: initValues['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        focusNode: _descFocusNode,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'The description must not be empty!';
                          }
                          if (value.length < 10) {
                            return 'The description must not be less than 10 characters!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            title: _editedProduct.title,
                            description: value.trim(),
                            price: _editedProduct.price,
                            imageURL: _editedProduct.imageURL,
                            id: _editedProduct.id,
                          );
                        }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("Enter URL")
                              : FittedBox(
                                  child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        Expanded(
                          child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              focusNode: _imgUrlFocusNode,
                              controller: _imageUrlController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'The image url must not be empty!';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'The image url is not valid!';
                                }
                                if (!value.endsWith('.jpg') &&
                                    !value.endsWith('.jpeg') &&
                                    !value.endsWith('.png') &&
                                    !value.endsWith('.JPG') &&
                                    !value.endsWith('.JPEG')) {
                                  return 'The image url is not correct!';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageURL: value.trim(),
                                  id: _editedProduct.id,
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
