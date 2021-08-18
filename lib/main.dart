import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> fields = ['', '', '', '', '', '', '', '', ''];

  bool ohStart = true; // the first player is O!
  int ohPoints = 0;
  int exPoints = 0;
  int drawPoints = 0;
  int usedFields = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _restartGame, icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Vitórias do O',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          ohPoints.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Vitórias do X',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          exPoints.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Empates',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          drawPoints.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          fields[index],
                          style: GoogleFonts.fredokaOne(
                              color: fields[index] == 'X'
                                  ? Colors.red[900]
                                  : Colors.blue[900],
                              fontSize: 100,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //SizedBox(width: 20),
                    Text('JOGO DA VELHA',
                        style: GoogleFonts.pressStart2p(fontSize: 25)),
                    //SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohStart && fields[index] == '') {
        fields[index] = 'O';
        usedFields += 1;
      } else if (!ohStart && fields[index] == '') {
        fields[index] = 'X';
        usedFields += 1;
      }

      ohStart = !ohStart;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // check row 1
    if (fields[0] == fields[1] && fields[0] == fields[2] && fields[0] != '') {
      _winnerDialog(fields[0]);
    }

    // check row 2
    else if (fields[3] == fields[4] &&
        fields[3] == fields[5] &&
        fields[3] != '') {
      _winnerDialog(fields[3]);
    }

    // check row 3
    else if (fields[6] == fields[7] &&
        fields[6] == fields[8] &&
        fields[6] != '') {
      _winnerDialog(fields[6]);
    }

    // check column 1
    else if (fields[0] == fields[3] &&
        fields[0] == fields[6] &&
        fields[0] != '') {
      _winnerDialog(fields[0]);
    }

    // check column 2
    else if (fields[1] == fields[4] &&
        fields[1] == fields[7] &&
        fields[1] != '') {
      _winnerDialog(fields[1]);
    }

    // check column 3
    else if (fields[2] == fields[5] &&
        fields[2] == fields[8] &&
        fields[2] != '') {
      _winnerDialog(fields[2]);
    }

    // check diagonal
    else if (fields[6] == fields[4] &&
        fields[6] == fields[2] &&
        fields[6] != '') {
      _winnerDialog(fields[6]);
    }

    // check diagonal
    else if (fields[0] == fields[4] &&
        fields[0] == fields[8] &&
        fields[0] != '') {
      _winnerDialog(fields[0]);
    }

    // draw
    else if (usedFields == 9) {
      _drawDialog();
    }
  }

  void _drawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'EMPATE  !!',
              style: GoogleFonts.fredokaOne(),
            )),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  child: Text('JOGAR NOVAMENTE'),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                    _initGame();
                  },
                ),
              )
            ],
          );
        });
    drawPoints += 1;
  }

  void _winnerDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Column(
              children: [
                Text('O VENCEDOR FOI:'),
                SizedBox(height: 20),
                Text(
                  winner,
                  style: GoogleFonts.fredokaOne(
                      fontSize: 50,
                      color:
                          winner == 'X' ? Colors.red[900] : Colors.blue[900]),
                )
              ],
            )),
            actions: <Widget>[
              ElevatedButton(
                child: Center(child: Text('Jogar novamente')),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                  _initGame();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      ohPoints += 1;
    } else if (winner == 'X') {
      exPoints += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        fields[i] = '';
      }
    });

    usedFields = 0;
  }

  void _initGame() {
    showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Column(
              children: [
                Text(
                  ohStart == true ? 'O' : 'X',
                  style: GoogleFonts.fredokaOne(
                      fontSize: 50,
                      color:
                          ohStart == true ? Colors.blue[900] : Colors.red[900]),
                ),
                SizedBox(height: 20),
                Text('começa'),
              ],
            )),
            actions: <Widget>[
              ElevatedButton(
                child: Center(child: Text('Iniciar jogo')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _restartGame() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        fields[i] = '';
      }
      ohPoints = 0;
      exPoints = 0;
      drawPoints = 0;
    });

    usedFields = 0;
  }
}
