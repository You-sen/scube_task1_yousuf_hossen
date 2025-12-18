import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isDataView = true;
  bool _isTodayData = true;
  bool _isDataCostInfoExpanded = true;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      appBar: AppBar(
        title: const Text('SCM'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTopButtons(),
              const SizedBox(height: 32),
              if (_isDataView) _buildDataViewContent() else _buildRevenueViewContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButtons() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => setState(() => _isDataView = true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _isDataView,
                  onChanged: (v) => setState(() => _isDataView = true),
                  activeColor: Colors.blue,
                ),
                Text(
                  'Data View',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isDataView ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: InkWell(
            onTap: () => setState(() => _isDataView = false),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  value: false,
                  groupValue: _isDataView,
                  onChanged: (v) => setState(() => _isDataView = false),
                  activeColor: Colors.blue,
                ),
                Text(
                  'Revenue View',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: !_isDataView ? Colors.blue : Colors.grey,
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


  Widget _buildDataViewContent() {
    return Column(
      children: [
        _buildCircularProgress(),
        const SizedBox(height: 32),
        _buildDataSelection(),
        const SizedBox(height: 16),
        if (_isTodayData) _buildTodayData(),
        if (!_isTodayData) _buildCustomDateData(),
      ],
    );
  }

  Widget _buildRevenueViewContent() {
    return Column(
      children: [
        _buildRevenueCircularProgress(),
        const SizedBox(height: 32),
        _buildDataCostInfoCard(),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 15.0,
      percent: 0.57,
      center: const Text(
        '57.00\nkWh/Sqft',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      progressColor: Colors.blue,
      backgroundColor: Colors.blue.shade100,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildDataSelection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => setState(() => _isTodayData = true),
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _isTodayData,
                    onChanged: (val) => setState(() => _isTodayData = true),
                    activeColor: Colors.blue,
                  ),
                  //const Text('Today Data'),
                  Text(
                  'Today Data',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isTodayData ? Colors.blue : Colors.grey,
                  ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () => setState(() => _isTodayData = false),
              child: Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _isTodayData,
                    onChanged: (val) => setState(() => _isTodayData = false),
                    activeColor: Colors.blue,
                  ),
                  Text(
                  'Custom Date Data',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: !_isTodayData ? Colors.blue : Colors.grey,
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!_isTodayData)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Expanded(child: _buildDateField('From Date', _fromDateController)),
                const SizedBox(width: 16),
                Expanded(child: _buildDateField('To Date', _toDateController)),
                const SizedBox(width: 16),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDateField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = "${picked.toLocal()}".split(' ')[0];
        }
      },
    );
  }

  Widget _buildTodayData() {
    return _buildEnergyChartCard('5.53 kW', 'Energy Chart');
  }

  Widget _buildCustomDateData() {
    return Column(
      children: [
        _buildEnergyChartCard('20.05 kW', 'Energy Chart'),
        const SizedBox(height: 16),
        _buildEnergyChartCard('5.53 kW', 'Energy Chart'),
      ],
    );
  }

  Widget _buildEnergyChartCard(String value, String title) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300), // card border
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDataRow('Data A', '2798.50 (29.53%)', '35689 ৳', Colors.blue),
        _buildDataRow('Data B', '72598.50 (35.39%)', '5259689 ৳',Colors.red),
        _buildDataRow('Data C', '6598.36 (83.90%)', '5698756 ৳',Colors.orange),
        _buildDataRow('Data D', '6598.26 (36.59%)', '356987 ৳',Colors.purple),
      ],
    ),
  );
}


  Widget _buildDataRow(String title, String data, String cost, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with color circle on top
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle above title
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        const SizedBox(width: 12),

        Container(
          width: 1,
          height: 40,
          color: Colors.grey.shade400,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Data    : ',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: data,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Cost    : ',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: cost,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildRevenueCircularProgress() {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 15.0,
      percent: 0.8,
      center: const Text(
        '8897455\ntk',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      progressColor: Colors.blue,
      backgroundColor: Colors.blue.shade100,
      circularStrokeCap: CircularStrokeCap.round,
      
    );
  }

Widget _buildDataCostInfoCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300, width: 1), // dark border for whole card
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5), // border below title
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Data & Cost Info',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isDataCostInfoExpanded
                      ? Icons.keyboard_double_arrow_up
                      : Icons.keyboard_double_arrow_down,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _isDataCostInfoExpanded = !_isDataCostInfoExpanded;
                  });
                },
              ),
            ],
          ),
        ),

        if (_isDataCostInfoExpanded)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDataCostRow('Data 1', '2798.50 (29.53%)','Cost 1', '35689 ৳'),
                _buildDataCostRow('Data 2', '2798.50 (29.53%)','Cost 2', '35689 ৳'),
                _buildDataCostRow('Data 3', '2798.50 (29.53%)','Cost 3', '35689 ৳'),
                _buildDataCostRow('Data 4', '2798.50 (29.53%)','Cost 4', '35689 ৳'),
              ],
            ),
          )
      ],
    ),
  );
}

Widget _buildDataCostRow(String title, String data, String costTitle, String costValue) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$title : ',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              data,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              '$costTitle : ',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              costValue,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}
