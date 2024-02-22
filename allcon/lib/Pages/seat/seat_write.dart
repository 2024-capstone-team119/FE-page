import 'package:flutter/material.dart';

class SeatWrite extends StatefulWidget {
  const SeatWrite({super.key});

  @override
  State<SeatWrite> createState() => _SeatWriteState();
}

class _SeatWriteState extends State<SeatWrite> {
  int selectedStar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 238, 225, 255),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'A구역',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Row(
                          children: [
                            for (int i = 1; i < 6; i++)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedStar = i;
                                  });
                                },
                                icon: Icon(
                                  Icons.star_outlined,
                                  color: i <= selectedStar
                                      ? Colors.yellow
                                      : Colors.white,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '리뷰를 작성해주세요.',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  buildOutlinedButton(
                    onPressed: () {},
                    icon: Icons.camera_alt_rounded,
                    label: '사진 첨부하기',
                  ),
                  buildOutlinedButton(
                    onPressed: () {},
                    icon: Icons.edit,
                    label: '리뷰 등록하기',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOutlinedButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
