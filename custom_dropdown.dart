import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final String placeholder;
  final String? headingText;
  final TextStyle? headingTextStyle;
  final double? headingTextHeight;
  final ValueChanged<String> onDone;
  final bool isDisabled;
  final Color? boxColor;
  final double? boxHeight;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.placeholder,
    this.headingText,
    this.headingTextStyle,
    this.headingTextHeight,
    required this.onDone,
    this.value,
    this.isDisabled = false,
    this.boxColor,
    this.boxHeight,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  dynamic selectedItem;

  void _showPicker(BuildContext context) {
    final int initialIndex =
        widget.value != null ? widget.items.indexOf(widget.value!) : 0;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 260.h,
        color: white,
        child: Column(
          children: [
            // Top bar
            Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                border: Border(
                  bottom: BorderSide(color: Color(0xffE5E5EA)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child:  Text('cancel'.tr,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: red,
                      )),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child:  Text('done'.tr,
                      style: TextStyle(
                      fontSize: 18.sp,
                      color: txtBlue,
                    ),),
                    onPressed: () {
                      Navigator.pop(context);
                      if(selectedItem == null){
                        widget.onDone(widget.items[0]);
                      } else {
                        widget.onDone(selectedItem);
                      }
                    },
                  ),
                ],
              ),
            ),

            // Picker
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: initialIndex < 0 ? 0 : initialIndex,
                ),
                itemExtent: 36.h,
                onSelectedItemChanged: (index) {
                  setState((){
                    selectedItem = widget.items[index];
                  });
                  // widget.onChanged(widget.items[index]);
                },
                children: widget.items
                    .map(
                      (e) => Center(
                        child: Text(
                          e,
                          style: interRegular(
                            size: 18.sp,
                            color: txtBlack,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.headingText != null,
          child: SizedBox(
            // width: width != null ? width!/2 : null,
            child: Text(widget.headingText ?? "", style: widget.headingTextStyle??interRegular(size: 13.sp, color: Color(0xff808084)))
          ),
        ),
        
        SizedBox(height: widget.headingText == null ? 0 : widget.headingTextHeight ?? 8.0.h,),

        GestureDetector(
          onTap: widget.isDisabled ? null : () => _showPicker(context),
          child: Container(
            height: widget.boxHeight ?? 44.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: widget.isDisabled ? grey2 : white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: widget.boxColor ?? Color(0xffC9C9C9),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.value ?? widget.placeholder,
                    style: interRegular(
                      size: 14.sp,
                      color: widget.value == null ? txtGrey7 : txtBlack,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20.sp,
                  color: txtGrey7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

