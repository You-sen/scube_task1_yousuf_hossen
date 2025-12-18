import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'detail_page.dart';
import 'more_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4F1),
      appBar: AppBar(
        title: const Text('SCM'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(16.0), 
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildTopButtons(),
              const Divider(height: 20, thickness: 1, color: Colors.grey),

              _buildElectricityCard(),
              const SizedBox(height: 16),

              _buildSourceLoadButtons(),
              const Divider(height: 20, thickness: 1, color: Colors.grey),

              _buildScrollableDataContainer(context),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: _buildBottomButtons(context),
        ),
      ],
    ),
  ),
),

    );
  }

  Widget _buildTopButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Summery',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'SLD',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Data',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElectricityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Electricity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 15.0,
            percent: 1,
            center: const Text(
              'Total Power\n5.53 kw',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            progressColor: Colors.blue,
            backgroundColor: Colors.blue.shade100,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceLoadButtons() {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: const Color(0xFFD9E4F1), 
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Source',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Expanded(
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(24),
            child: const Center(
              child: Text(
                'Load',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildScrollableDataContainer(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDataRow(context, 'Data Type 1', 'Active', '55505.63', '58805.63', Icons.solar_power, Colors.blue),
              _buildDataRow(context, 'Data Type 2', 'Active', '55505.63', '58805.63', Icons.battery_charging_full, Colors.blue),
              _buildDataRow(context, 'Data Type 3', 'Inactive', '55505.63', '58805.63', Icons.power, Colors.red),
              _buildDataRow(context, 'Data Type 4', 'Active', '12345.67', '23456.78', Icons.lightbulb, Colors.blue),
              _buildDataRow(context, 'Data Type 5', 'Inactive', '98765.43', '87654.32', Icons.warning, Colors.red),
              _buildDataRow(context, 'Data Type 6', 'Active', '54321.09', '65432.10', Icons.ac_unit, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(
  BuildContext context,
  String title,
  String status,
  String data1,
  String data2,
  IconData icon,
  Color statusColor,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFD9E4F1), 
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.grey.shade400, 
      ),
    ),
    child: Row(
      children: [
        Icon(icon, size: 36),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '($status)',
                    style: TextStyle(color: statusColor),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('Data 1 : $data1'),
              Text('Data 2 : $data2'),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailPage()),
            );
          },
        ),
      ],
    ),
  );
}


  Widget _buildBottomButtons(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildBottomButton(context, 'Analysis Pro', Icons.analytics),
        _buildBottomButton(context, 'G. Generator', Icons.power_input),
        _buildBottomButton(context, 'Plant Summery', Icons.factory),
        _buildBottomButton(context, 'Natural Gas', Icons.local_fire_department),
        _buildBottomButton(context, 'D. Generator', Icons.power_input),
        _buildBottomButton(context, 'Water Process', Icons.water),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MorePage()),
        );
      },
      icon: Icon(icon, size: 18,),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
