import 'package:flutter/material.dart';

class GenericDataTable<T> extends StatefulWidget {
  final List<T> data;
  final List<String> columnTitles;
  final List<String> Function(T) extractRowValues;
  final int rowsPerPage;

  final bool showDetailButton;
  final void Function(T)? onDetailPressed;

  final bool showDeleteButton;
  final void Function(T)? onDeletePressed;

  const GenericDataTable({
    super.key,
    required this.data,
    required this.columnTitles,
    required this.extractRowValues,
    this.rowsPerPage = 10,
    this.showDetailButton = true,
    this.showDeleteButton = true,
    this.onDetailPressed,
    this.onDeletePressed,
  });

  @override
  State<GenericDataTable<T>> createState() => _GenericDataTableState<T>();
}

class _GenericDataTableState<T> extends State<GenericDataTable<T>> {
  int _currentPage = 0;

  @override
  void didUpdateWidget(covariant GenericDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 🔥 RESET PAGE kalau data berubah drastis (delete/add)
    if (oldWidget.data.length != widget.data.length) {
      final maxPage =
          (widget.data.isEmpty)
              ? 0
              : ((widget.data.length - 1) ~/ widget.rowsPerPage);

      if (_currentPage > maxPage) {
        setState(() {
          _currentPage = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalRows = widget.data.length;

    if (totalRows == 0) {
      return const Center(
        child: Text("Data kosong"),
      );
    }

    final totalPages =
        (totalRows / widget.rowsPerPage).ceil();

    final startIndex = _currentPage * widget.rowsPerPage;
    var endIndex = startIndex + widget.rowsPerPage;

    // 🔥 SAFE BOUNDARY
    if (endIndex > totalRows) {
      endIndex = totalRows;
    }

    final safeStart = startIndex.clamp(0, totalRows);
    final safeEnd = endIndex.clamp(0, totalRows);

    final currentPageData =
        (safeStart < safeEnd)
            ? widget.data.sublist(safeStart, safeEnd)
            : <T>[];

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    ...widget.columnTitles.map(
                      (title) => DataColumn(
                        label: Text(title),
                      ),
                    ),
                    if (widget.showDetailButton ||
                        widget.showDeleteButton)
                      const DataColumn(
                        label: Text("Action"),
                      ),
                  ],
                  rows: currentPageData.map((item) {
                    try {
                      final values = widget.extractRowValues(item);
                      print(values);
                      return DataRow(
                        cells: [
                          ...values.map(
                            (value) => DataCell(
                              Text(value ?? ''),
                            ),
                          ),

                          DataCell(
                            Row(
                              children: [
                                if (widget.showDetailButton)
                                  ElevatedButton(
                                    onPressed: () {
                                      if (widget.onDetailPressed != null) {
                                        widget.onDetailPressed!(item);
                                      }
                                    },
                                    child: const Text("Detail"),
                                  ),

                                const SizedBox(width: 8),

                                if (widget.showDeleteButton)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      if (widget.onDeletePressed != null) {
                                        widget.onDeletePressed!(item);
                                      }
                                    },
                                    child: const Text("Delete"),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } catch (e, st) {
                      print("ROW ERROR: $e");
                      print(st);
                      return const DataRow(
                        cells: [],
                      );
                    }
                  }).toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 📌 PAGINATION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${safeStart + 1} - $safeEnd dari $totalRows data',
              ),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _currentPage > 0
                        ? () {
                            setState(() {
                              _currentPage--;
                            });
                          }
                        : null,
                  ),

                  Text(
                    '${_currentPage + 1} dari $totalPages',
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _currentPage < totalPages - 1
                        ? () {
                            setState(() {
                              _currentPage++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}