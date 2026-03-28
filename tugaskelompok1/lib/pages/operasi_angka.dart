import 'package:flutter/material.dart';

class OperasiAngka extends StatefulWidget {
  const OperasiAngka({super.key});

  @override
  State<OperasiAngka> createState() => _OperasiAngkaState();
}

class _OperasiAngkaState extends State<OperasiAngka> {
  String _display = '0';
  double _firstOperand = 0;
  String? _operator;
  bool _waitingForSecondOperand = false;

  static const double _maxFontSize = 64;
  static const double _minFontSize = 27;

  final ScrollController _displayScrollController = ScrollController();

  String get _formattedDisplay => _display;

  /// Format angka agar tidak muncul scientific notation (e / E)
  /// Jika hasil tidak valid, tampilkan Undefined
  String _formatNumber(double value) {
    if (value.isNaN || value.isInfinite) return 'Undefined';

    String text = value.toStringAsFixed(12);

    // Hapus nol berlebih di belakang desimal
    text = text.replaceFirst(RegExp(r'\.?0+$'), '');

    return text;
  }

  /// Font mengecil jika teks menyentuh batas lebar display
  double _calculateFittedFontSize(String text, double maxWidth) {
    double fontSize = _maxFontSize;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    while (fontSize > _minFontSize) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      );

      textPainter.layout();

      if (textPainter.width <= maxWidth) {
        return fontSize;
      }

      fontSize -= 1;
    }

    return _minFontSize;
  }

  void _scrollDisplayToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_displayScrollController.hasClients) {
        _displayScrollController.animateTo(
          _displayScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool get _isUndefined => _display == 'Undefined';

  void _inputDigit(String digit) {
    setState(() {
      if (_isUndefined) {
        _display = digit;
        _waitingForSecondOperand = false;
        _operator = null;
        return;
      }

      if (_waitingForSecondOperand) {
        _display = digit;
        _waitingForSecondOperand = false;
      } else {
        if (_display == '0') {
          _display = digit;
        } else {
          _display += digit;
        }
      }
    });

    _scrollDisplayToEnd();
  }

  void _inputDot() {
    if (_isUndefined) {
      setState(() {
        _display = '0.';
        _waitingForSecondOperand = false;
        _operator = null;
      });
      _scrollDisplayToEnd();
      return;
    }

    if (_waitingForSecondOperand) {
      setState(() {
        _display = '0.';
        _waitingForSecondOperand = false;
      });
      _scrollDisplayToEnd();
      return;
    }

    if (!_display.contains('.')) {
      setState(() {
        _display += '.';
      });
      _scrollDisplayToEnd();
    }
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = 0;
      _operator = null;
      _waitingForSecondOperand = false;
    });

    _scrollDisplayToEnd();
  }

  void _toggleSign() {
    if (_isUndefined) return;

    setState(() {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        if (_display != '0') {
          _display = '-$_display';
        }
      }
    });

    _scrollDisplayToEnd();
  }

  void _percent() {
    if (_isUndefined) return;

    setState(() {
      final value = double.tryParse(_display) ?? 0;
      final result = value / 100;
      _display = _formatNumber(result);
    });

    _scrollDisplayToEnd();
  }

  void _operatorPressed(String selectedOperator) {
    if (_isUndefined) return;

    setState(() {
      final inputValue = double.tryParse(_display) ?? 0;

      if (_operator != null && !_waitingForSecondOperand) {
        _calculate();
      } else {
        _firstOperand = inputValue;
      }

      _operator = selectedOperator;
      _waitingForSecondOperand = true;
    });
  }

  void _calculate() {
    if (_isUndefined) return;

    final secondOperand = double.tryParse(_display) ?? 0;
    double result = _firstOperand;

    if (_operator == '+') {
      result += secondOperand;
    } else if (_operator == '-') {
      result -= secondOperand;
    } else if (_operator == '×') {
      result *= secondOperand;
    } else if (_operator == '÷') {
      if (secondOperand == 0) {
        setState(() {
          _display = 'Undefined';
          _operator = null;
          _waitingForSecondOperand = false;
        });
        _scrollDisplayToEnd();
        return;
      }
      result /= secondOperand;
    }

    setState(() {
      _display = _formatNumber(result);
      _firstOperand = result;
      _operator = null;
      _waitingForSecondOperand = false;
    });

    _scrollDisplayToEnd();
  }

  @override
  void dispose() {
    _displayScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Kalkulator"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              /// DISPLAY
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availableWidth = constraints.maxWidth - 16;
                    final fittedFontSize = _calculateFittedFontSize(
                      _formattedDisplay,
                      availableWidth,
                    );

                    return Container(
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(
                        right: 8,
                        bottom: 16,
                        left: 8,
                      ),
                      child: SingleChildScrollView(
                        controller: _displayScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: availableWidth,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              _formattedDisplay,
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fittedFontSize,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// BUTTON AREA
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            'AC',
                            bgColor: const Color(0xFFE0E0E0),
                            textColor: Colors.black,
                            onTap: _clear,
                            isTopFunction: true,
                          ),
                          _buildButton(
                            '+/-',
                            bgColor: const Color(0xFFE0E0E0),
                            textColor: Colors.black,
                            onTap: _toggleSign,
                            isTopFunction: true,
                          ),
                          _buildButton(
                            '%',
                            bgColor: const Color(0xFFE0E0E0),
                            textColor: Colors.black,
                            onTap: _percent,
                            isTopFunction: true,
                          ),
                          _buildButton(
                            '÷',
                            bgColor: const Color(0xFFFF9500),
                            textColor: Colors.white,
                            onTap: () => _operatorPressed('÷'),
                            isOperator: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('7', onTap: () => _inputDigit('7')),
                          _buildButton('8', onTap: () => _inputDigit('8')),
                          _buildButton('9', onTap: () => _inputDigit('9')),
                          _buildButton(
                            '×',
                            bgColor: const Color(0xFFFF9500),
                            textColor: Colors.white,
                            onTap: () => _operatorPressed('×'),
                            isOperator: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('4', onTap: () => _inputDigit('4')),
                          _buildButton('5', onTap: () => _inputDigit('5')),
                          _buildButton('6', onTap: () => _inputDigit('6')),
                          _buildButton(
                            '-',
                            bgColor: const Color(0xFFFF9500),
                            textColor: Colors.white,
                            onTap: () => _operatorPressed('-'),
                            isOperator: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('1', onTap: () => _inputDigit('1')),
                          _buildButton('2', onTap: () => _inputDigit('2')),
                          _buildButton('3', onTap: () => _inputDigit('3')),
                          _buildButton(
                            '+',
                            bgColor: const Color(0xFFFF9500),
                            textColor: Colors.white,
                            onTap: () => _operatorPressed('+'),
                            isOperator: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            '0',
                            flex: 2,
                            onTap: () => _inputDigit('0'),
                            isZero: true,
                          ),
                          _buildButton('.', onTap: _inputDot),
                          _buildButton(
                            '=',
                            bgColor: const Color(0xFFFF9500),
                            textColor: Colors.white,
                            onTap: _calculate,
                            isOperator: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String label, {
    Color bgColor = const Color(0xFFF2F2F2),
    Color textColor = Colors.black,
    void Function()? onTap,
    int flex = 1,
    bool isOperator = false,
    bool isTopFunction = false,
    bool isZero = false,
  }) {
    double fontSize = 30;

    if (isOperator) fontSize = 28;
    if (isTopFunction) fontSize = 24;
    if (label == '+/-') fontSize = 20;
    if (label == 'AC') fontSize = 22;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: bgColor,
              foregroundColor: textColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isZero ? 40 : 100),
              ),
            ),
            child: Align(
              alignment: isZero ? Alignment.centerLeft : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: isZero ? 28 : 0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}