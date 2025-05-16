import 'package:flutter/material.dart';

class CurrencyExchangePage extends StatefulWidget {
  const CurrencyExchangePage({super.key});

  @override
  State<CurrencyExchangePage> createState() => _CurrencyExchangePageState();
}

class _CurrencyExchangePageState extends State<CurrencyExchangePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _currencyCtrl   = TextEditingController();

  // Exchange rates: 1 unit foreign → LKR  (update via API later)
  final Map<String, double> _exchangeRates = {
    'USD': 300.0,
    'EUR': 325.0,
    'GBP': 380.0,
    'INR': 3.7,
    'CNY': 42.0,
    'AUD': 200.0,
  };

  // Currency metadata
  final Map<String, Map<String, String>> _meta = {
    'USD': {'flag': '🇺🇸', 'symbol': '\$'},
    'EUR': {'flag': '🇪🇺', 'symbol': '€'},
    'GBP': {'flag': '🇬🇧', 'symbol': '£'},
    'INR': {'flag': '🇮🇳', 'symbol': '₹'},
    'CNY': {'flag': '🇨🇳', 'symbol': '¥'},
    'AUD': {'flag': '🇦🇺', 'symbol': '\$'},
  };

  String? _selectedCode;        // e.g., "USD"
  double? _convertedAmount;     // result in LKR

  /* ---------- Helpers ---------- */
  Iterable<String> _filterOptions(String query) {
    if (query.isEmpty) return _meta.keys;
    final q = query.toLowerCase();
    return _meta.keys.where((code) =>
    code.toLowerCase().contains(q) ||
        _meta[code]!['symbol']!.contains(q));
  }

  void _convert() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || _selectedCode == null) {
      setState(() => _convertedAmount = null);
      return;
    }
    final rate = _exchangeRates[_selectedCode]!;
    setState(() => _convertedAmount = amount * rate);
  }

  /* ---------- UI ---------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD5EBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Currency Exchange',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Convert your currency to Sri Lankan Rupees (LKR)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            /* Amount input */
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount',
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /* Autocomplete currency selector */
            Autocomplete<String>(
              optionsBuilder: (t) => _filterOptions(t.text),
              displayStringForOption: (code) =>
              '${_meta[code]!['flag']}  $code',
              fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                _currencyCtrl.value = controller.value;
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Select currency',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              onSelected: (code) {
                setState(() => _selectedCode = code);
              },
              optionsViewBuilder: (context, onSelect, options) => Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (_, i) {
                    final code = options.elementAt(i);
                    return ListTile(
                      onTap: () => onSelect(code),
                      leading: Text(_meta[code]!['flag']!, style: const TextStyle(fontSize: 20)),
                      title: Text('$code  (${_meta[code]!['symbol']})'),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            /* Convert button */
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Convert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            /* Result card */
            if (_convertedAmount != null)
              Card(
                color: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '$_selectedCode → LKR\n'
                        '${_meta[_selectedCode]!['symbol']}${_amountController.text} = '
                        'Rs. ${_convertedAmount!.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _currencyCtrl.dispose();
    super.dispose();
  }
}
