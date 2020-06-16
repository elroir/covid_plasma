import 'file:///C:/Users/enriq/AndroidStudioProjects/soy_donante/lib/src/widgets/background_widget.dart';
import 'package:covidplasma/src/widgets/card_swiper_widget.dart';
import 'package:covidplasma/src/widgets/country_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:covidplasma/src/models/estadisticas_model.dart';
import 'package:covidplasma/src/providers/estadisticas_provider.dart';
import 'package:covidplasma/src/widgets/background_square.dart';
import 'package:covidplasma/src/widgets/cutom_buttom_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final paises = new EstadisticasModel().countries;

  String _pais = 'Bol';

  final Color _color= Color.fromRGBO(62, 66, 107, 0.7);

  int _paisIndice;

  final estadisticasProvider = new EstadisticasProvider();

  final estiloTitulo = TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white);

  final TextStyle style = TextStyle(
                                    fontWeight:FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24.0 );

  @override
  void initState() {
    _paisIndice = 20;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          BackgroundWidget(),
          BackgroundSquare(),
          // TODO Para dispositivos sin pestañas arriba, cambiar por container con un padding superior de  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06)
          SafeArea(
              child: CardSwiper(
                children: <Widget>[
                  _construirEstadisticas(context),
                  Container(child:Text('Hola mundo') ,)
                ],
                height: MediaQuery.of(context).size.height*0.34,
                width: MediaQuery.of(context).size.width ,
              )
          ),
          _construirBotones(context),
        ],
      ),
    );
  }

  Widget _construirEstadisticas(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Casos de Covid-19', style: style,),
            ),
            CountryDropdown(
              countries: ['Bol','Arg'],
              country: _pais,
              onChanged: (val) => setState((){
                _pais = val;
                if(_pais=='Bol'){
                  _paisIndice = 20;
                }else{
                  _paisIndice = 6;
                }
              }) ,
            )
          ],
        ),
        _crearDatos(context),
      ],
    );
  }
  Widget _construirBotones(BuildContext context){

    final alturaBoton = MediaQuery.of(context).size.height*0.15;
    final anchuraBoton =  MediaQuery.of(context).size.width*0.9;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
     // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        CustomButtom(
          gradiente: false,
          alto: alturaBoton,
          ancho: anchuraBoton,
          texto: Text('Donante',style: estiloTitulo,),
        //  colorFondo: _color,
          imagen: Image(image: AssetImage('assets/medicamento.png')),
          descripcion: Text('Si buscas ayudar donando plasma, presiona esta opcion',
              style: TextStyle(color: Colors.white70)),
          onPressed: (){},
        ),
        SizedBox(height: 10.0,),
        CustomButtom(
          gradiente: true,
         // colorFondo: _color,
          alto: alturaBoton,
          ancho:anchuraBoton,
          texto: Text('Receptor',style: estiloTitulo,),
          descripcion: Text('Si necesitas plasma, presiona aqui',
              style: TextStyle(color: Colors.white70)),
          imagen: Image(image: AssetImage('assets/persona.png')),
          onPressed: (){},
        ),
        SizedBox(height: 50.0,width: double.infinity,)

      ],
    );
  }


  Widget _crearDatos(BuildContext context){
    return FutureBuilder(
      future: estadisticasProvider.getDatosPais(),
      builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot){
        if(snapshot.hasData){
          print('hola');
          final datos = snapshot.data.asMap();
          final recuperados = datos[_paisIndice].totalRecovered;
          final muertes = datos[_paisIndice].totalDeaths;
          final confirmados = datos[_paisIndice].totalConfirmed;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _crearCuadrado(context, confirmados, 'Confirmados', Colors.blue),
              Table(
                children: [
                  TableRow(
                    children: <Widget>[
                      _crearCuadrado(context, muertes, 'Muertes', Colors.red),
                      _crearCuadrado(context, recuperados, 'Recuperados', Colors.green),
                    ]
                  )

                ],
              ),
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
    }
    );

  }

  Widget _crearCuadrado(BuildContext context,int datos, String texto,Color color){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.11,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 12.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0,3.0),
                spreadRadius: 1.0
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$texto',style: estiloTitulo,),
            Text('$datos',style: style,)
          ],
        ),
      ),

    );
  }
}
