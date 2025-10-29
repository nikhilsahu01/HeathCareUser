import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/after_care/progress.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../appointment_model/appointment_model.dart';
import '../daily_remainder_model/daily_remainder_model.dart';
import '../medicine_model/medicine_model.dart';

class AfterCareScreen extends StatefulWidget {
  const AfterCareScreen({super.key});

  get isBack => null;

  @override
  State<AfterCareScreen> createState() => _AfterCareScreenState();
}

class _AfterCareScreenState extends State<AfterCareScreen> {
  double _progress = 0.5;
  List<DailyRemainderModel> dailyreminder=[
    DailyRemainderModel(
      dailyrem: ' 9:00 AM – Take Pain Reliever (Paracetamol 500mg)',
    ),
    DailyRemainderModel(
      dailyrem: '10:00 AM – Change dressing (use antiseptic kit)',
    ),
    DailyRemainderModel(
      dailyrem: ' 5:00 PM – Knee Stretch Exercise – 15 mins',
    ),
    DailyRemainderModel(
      dailyrem: ' 8:00 PM – Take Multivitamin Tablet',
    )
  ];
  List<MedicineModel> medicine=[
    MedicineModel(
      image1:'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png',
      medicinename: 'Multivitamin',
      medicinetime: 'After Lunch',
      tablenumber: '1',
    ),
    MedicineModel(
      image1:'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png',
      medicinename: 'Multivitamin',
      medicinetime: 'After Lunch',
      tablenumber: '1',
    )
  ];
  List<AppointmentModel> appoint=[
    AppointmentModel(
      doctorname: ' Dr. Leena Bhusan',
      dateandtime: 'May 16 May | 10:00 AM',
      booking: 'Video Call',
      mode: 'Self',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Aftercare',isBack:widget.isBack ?? true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorResource.lightBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Center(
                        child: Text('Daily Dose Reminder',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 8,),
                      Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5,),
                      CustomAppButton(label: '+Add Medicine',onPressed: () {  },),
                      SizedBox(height: 15,),
                      GestureDetector(
                        onTap: (){
                          // navPush(context: context, page: AfterCareScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFC9DFFE),
                                    ),
                                    child: CustomImageView(
                                      imagePath: 'https://cdn-icons-png.flaticon.com/512/2551/2551677.png',
                                      width: 48,
                                      height: 48,
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text: "Multivitamin", fontSize: 16),
                                        CustomText(text: "After Lunch", fontSize: 14),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: ColorResource.pillBlue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "1\nTablet",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 16,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomAppButton(
                                      label: 'Remind',
                                      color: ColorResource.red,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Add space between buttons
                                  Expanded(
                                    child: CustomAppButton(
                                      label: 'Taken',
                                      color: ColorResource.green,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffD8ECFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                    padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Next Flow Up appointment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5,),
                      ListView.builder(
                          itemCount: appoint.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            final appointdata = appoint[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Doctor :',style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    Text(appointdata.doctorname!,style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('Date & Time :',style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    Text(appointdata.dateandtime!,style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('Mode :',style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    Text(appointdata.mode!,style: TextStyle(fontSize: 14,color:ColorResource.darkText,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('Booking For :',style: TextStyle(fontSize: 12,color:ColorResource.darkText,),),
                                    Spacer(),
                                    Text(appointdata.booking!,style: TextStyle(fontSize: 12,color:ColorResource.darkText,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Expanded(child: CustomAppButton(label: 'Cancel',color:ColorResource.white,textColor: ColorResource.darkText, onPressed: (){},),),
                                    SizedBox(width: 15),
                                    Expanded(child:
                                    CustomAppButton(label: 'Reschedule', onPressed: (){},)
                                    )
                                  ],
                                ),

                              ],
                            );
                          }
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color:ColorResource.lightPink ,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomText(text: 'Recovery Progress Tracker',),
                      ),
                      SizedBox(height: 5,),
                      Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          CustomText(text: 'Recovery Post Plan',fontWeight: FontWeight.normal,),
                          Spacer(),
                          CustomText(text:'Post-Operative Knee\n Surgery Care',fontSize: 13,)
                        ],
                      ),
                      SizedBox(height: 5,),
                      AutoProgressBar(progress: 0.75),
                      SizedBox(height: 10,),
                      CustomText(text: 'Task To do:',fontSize: 13,fontWeight: FontWeight.w600),
                      Padding(
                          padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            // Dot circle icon (you can use CircleAvatar or Icon)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black, // Change color as needed
                                shape: BoxShape.circle,
                              ),
                            ),

                            // 5px horizontal space
                            SizedBox(width: 5),

                            // Text next to the dot
                            Text(
                              ' Medication taken',
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                        ,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            // Dot circle icon (you can use CircleAvatar or Icon)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black, // Change color as needed
                                shape: BoxShape.circle,
                              ),
                            ),

                            // 5px horizontal space
                            SizedBox(width: 5),

                            // Text next to the dot
                            Text(
                              ' Dressing changed',
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                        ,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            // Dot circle icon (you can use CircleAvatar or Icon)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black, // Change color as needed
                                shape: BoxShape.circle,
                              ),
                            ),

                            // 5px horizontal space
                            SizedBox(width: 5),

                            // Text next to the dot
                            Text(
                              ' Completed basic physiotherapy',
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                        ,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            // Dot circle icon (you can use CircleAvatar or Icon)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black, // Change color as needed
                                shape: BoxShape.circle,
                              ),
                            ),

                            // 5px horizontal space
                            SizedBox(width: 5),

                            // Text next to the dot
                            Text(
                              ' Virtual follow-up',
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                        ,
                      ),
                      SizedBox(height: 10,),

                       Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Follow-Up Questions',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    ...List.generate(questions.length, (index) {
                      final q = questions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}. ${q.question}",
                            style: const TextStyle(fontSize: 13),
                          ),
                         Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: q.answer,
                                fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.blue;
                                  }
                                  return Colors.white;
                                }),
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  setState(() {
                                    q.answer = value;
                                  });
                                },
                              ),
                              const Text("Yes"),
                              Radio<bool>(
                                value: false,
                                groupValue: q.answer,
                                fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.blue;
                                  }
                                  return Colors.white;
                                }),
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  setState(() {
                                    q.answer = value;
                                  });
                                },
                              ),
                              const Text("No"),
                            ],
                          ),



                        ],
                      );
                    }),
                  ],
                ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffFEEECC),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomText(
                          text: 'Daily Reminders',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Divider(height: 1, color: Colors.white),
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dailyreminder.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final dailyremdata = dailyreminder[index];
                          return CustomText(
                            text: "• ${dailyremdata.dailyrem ?? ''}",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  List<FollowUpQuestion> questions = [
    FollowUpQuestion('Are your symptoms getting better?'),
    FollowUpQuestion('Are you experiencing any new symptoms?'),
    FollowUpQuestion('Do you still feel pain or discomfort?'),
  ];
}



class FollowUpQuestion {
  String question;
  bool? answer;

  FollowUpQuestion(this.question, {this.answer});
}


