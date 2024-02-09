import 'package:flutter/material.dart';
import 'package:football/framework/components/outlined_text_filed.dart';

class ItemTeam extends StatefulWidget {
  final String label;
  const ItemTeam({super.key, required this.label});

  @override
  State<ItemTeam> createState() => _ItemTeamState();
}

class _ItemTeamState extends State<ItemTeam> {

  ValueNotifier<bool> isEdit = new ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ValueListenableBuilder(
        valueListenable: isEdit,
        builder: (_, edit, __) {
          return edit ?
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedTextFiled(
                  labelText: "Editar Time",
                  hintText: widget.label,
                  onChanged: (value) {

                  },
                ),
              ),
              IconButton(onPressed: () {
                isEdit.value = false;
              }, icon: Icon(Icons.save))
            ],
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              IconButton(onPressed: () => isEdit.value = true, icon: Icon(Icons.edit_outlined))
            ],
          );
        }
      ),
    );
  }
}
