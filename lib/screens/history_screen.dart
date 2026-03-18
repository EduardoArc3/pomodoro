import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/models/history_record.dart';
import 'package:pomodoro/screens/settting_screen.dart';
import 'package:pomodoro/services/database_service.dart';
import 'package:pomodoro/utils/date_format.dart';
import 'package:pomodoro/widgets/notebook_background.dart';
import 'package:pomodoro/widgets/record.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryRecord> _records = [];
  bool _isLoading = true;

  int _totalCycles = 0;
  int _totalMins = 0;
  int _totalSessions = 0;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final data = await DatabaseService.instance.queryAllRecords();

    int tempCycles = 0;
    int tempMins = 0;

    for (var record in data) {
      if (record.cycles.contains('/')) {
        int completedCycles = int.tryParse(record.cycles.split('/')[0]) ?? 0;
        tempCycles += completedCycles;
      } else {
        tempCycles += int.tryParse(record.cycles) ?? 0;
      }

      tempMins += record.totalTime;
    }

    setState(() {
      _records = data;
      _totalSessions = data.length;
      _totalMins = tempMins;
      _totalCycles = tempCycles;
      _isLoading = false;
    });
  }

  Future<void> _togglePin(HistoryRecord record) async {
    bool newState = !record.isPinned;
    await DatabaseService.instance.updatePinStatus(record.id!, newState);
    await _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: NotebookBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFE65A4F), width: 5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(3, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: BackButton(
                      color: Color(0xFFE65A4F),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),

              Transform.rotate(
                angle: -0.05,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB84D),
                    border: Border.all(color: Colors.black, width: 5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        "Historial",
                        style: GoogleFonts.patrickHand(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _records.isEmpty
                    ? Center(
                        child: Text(
                          "No hay sesiones registradas",
                          style: GoogleFonts.patrickHand(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: _records.length,
                        itemBuilder: (context, index) {
                          final record = _records[index];
                          return Record(
                            title: record.title,
                            description: record.description,
                            date: formatDate(record.date),
                            completed: record.isCompleted,
                            cycles: record.cycles,
                            totalTime: record.totalTime,
                            onPin: () => _togglePin(record),
                            isPinned: record.isPinned,
                          );
                        },
                      ),
              ),

              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  border: Border.all(color: Color(0xFFFFB84D), width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Resumen Total",
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "$_totalCycles",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 30,
                                  color: Color(0xFFE65A4F),
                                ),
                              ),
                              Text(
                                "Ciclos",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          VerticalDivider(
                            color: Color(0xFFD1D5DC),
                            thickness: 1,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                "$_totalMins",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 30,
                                  color: Color(0xFFFFB84D),
                                ),
                              ),
                              Text(
                                "Minutos",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          VerticalDivider(
                            color: Color(0xFFD1D5DC),
                            thickness: 1,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                "$_totalSessions",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 30,
                                  color: Color(0xFF00C950),
                                ),
                              ),
                              Text(
                                "Sesiones",
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
}
