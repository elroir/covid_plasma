import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final double alto;
  final double ancho;
  final Color colorFondo;
  final Color colorIcono;
  final Text texto;
  final Text descripcion;
  final Function onPressed;
  final Image imagen;
  final bool gradiente;

  CustomButtom({this.alto,this.ancho,this.colorFondo,this.imagen,this.gradiente,
    this.colorIcono,this.texto,@required this.onPressed,this.descripcion});

  @override
  Widget build(BuildContext context) {
    final double width = (ancho==null) ? MediaQuery.of(context).size.width : ancho;
    final Text text = (texto==null) ? Text('') : texto;

    return Container(
      height: (alto==null) ? MediaQuery.of(context).size.height * 0.4 : alto ,
      width: width,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0.0,3.0),
              spreadRadius: 1.0
          )
        ],
          gradient:(gradiente==null||!gradiente) ? null : LinearGradient(
              begin: FractionalOffset(0.0,0.0),
              end: FractionalOffset(0.4,0.0),
              colors: [
                Colors.blueGrey,
                (colorFondo==null) ? Theme.of(context).accentColor : colorFondo,
              ]
          ),
          color: (colorFondo==null&&(gradiente==null||!gradiente)) ? Theme.of(context).accentColor : colorFondo,
          borderRadius: BorderRadius.circular(15.0)
      ),


      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10.0,),
            Container(
              child: imagen
            ),
            SizedBox(width: 20.0,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text,
                  descripcion
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
