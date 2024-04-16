import '/import.dart';

class PillDropdownButton extends StatefulWidget {
  const PillDropdownButton({
    super.key,
    required this.dropDownList,
    required this.width,
    required this.onSelectionChanged,
    required this.destination,
  });

  final List<String> dropDownList;
  final double width;
  final void Function(String) onSelectionChanged;
  final String destination;

  @override
  PillDropdownButtonState createState() => PillDropdownButtonState();
}

class PillDropdownButtonState extends State<PillDropdownButton> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    // selectedItem ??= widget.dropDownList.first;
    return Column(
      children: [
        Text(
          widget.destination,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: widget.width,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 10.0),
              DropdownButton<String>(
                underline: const SizedBox(),
                value: selectedItem,
                dropdownColor: AppColors.kPrimaryColor,
                hint: const Text(
                  "Select",
                  style: TextStyle(color: AppColors.white),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: 20,
                ),
                items: widget.dropDownList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedItem = val!;
                    widget.onSelectionChanged(val);
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
