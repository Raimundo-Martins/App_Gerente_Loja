import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductScreen({this.categoryId, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc;

  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(color: Colors.white, fontSize: 16);

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: Text('Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
            stream: _productBloc.outProduct,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    initialValue: snapshot.data['title'],
                    style: _style,
                    decoration: _buildDecoration('Título'),
                    onSaved: (valor) {},
                    validator: (valor) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data['description'],
                    maxLines: 5,
                    style: _style,
                    decoration: _buildDecoration('Descrição'),
                    onSaved: (valor) {},
                    validator: (valor) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data['price']?.toStringAsFixed(2),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: _style,
                    decoration: _buildDecoration('Preço'),
                    onSaved: (valor) {},
                    validator: (valor) {},
                  ),
                ],
              );
            }),
      ),
    );
  }
}
