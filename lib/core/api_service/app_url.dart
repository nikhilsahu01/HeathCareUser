class AppUrl {
  //local
  // static const String baseUrl = 'http://192.168.1.11:5002';
  // //live
  //static const String baseUrl = 'https://94np5jjf-5003.inc1.devtunnels.ms';
  static const String baseUrl = 'https://admin.olcure.com';
  static const String apiKey = 'AIzaSyCSk_LBk7QP0k4YUfX61t_QF8ItPuZzsoc';
  static const String getOtp = '$baseUrl/api/user/auth/send-otp';
  static const String verifyOtp = '$baseUrl/api/user/auth/verify-otp';
  static const String homeData = '$baseUrl/api/user/home/homeData';
  static const String symptomsList= '$baseUrl/api/user/home/symtomsList';
  static const String categoriesList= '$baseUrl/api/user/home/getAllCategory';
  static const String getCategoryList= '$baseUrl/api/user/appointment/getCategortList';
  static const String getDoctorsList= '$baseUrl/api/user/appointment/getDoctorList';
  static const String getDoctorDetails= '$baseUrl/api/user/appointment/doctorDetail';
  static const String reminderSlots = '$baseUrl/api/user/appointment/reminderSlots';
  static const String availableSlots = '$baseUrl/api/user/appointment/slots';
  static const String patientsList = '$baseUrl/api/user/userPateint/list';
  static const String createPatients = '$baseUrl/api/user/userPateint/create';
  static const String deletePatients = '$baseUrl/api/user/userPateint/delete';
  static const String createBooking = '$baseUrl/api/user/bookAppointment/create';
  static const String appointmentsList = '$baseUrl/api/user/bookedAppointment/list';
  static const String appointmentDetails = '$baseUrl/api/user/bookedAppointment/detail';
  static const String rescheduleAppointment = '$baseUrl/api/user/bookAppointment/reschedule';
  static const String cancelAppointment = '$baseUrl/api/user/bookAppointment/cancel';
  static const String createReviews = '$baseUrl/api/user/ratingReview/create';
  static const String updateReminder = '$baseUrl/api/user/bookedAppointment/updateReminder';
  static const String getAllSymptoms = '$baseUrl/api/user/home/getAllSymptoms';
  static const String videoCall = '$baseUrl/api/join-call';
  static const String ambulanceBooking = '$baseUrl/api/user/ambulanceBooking/create';
  static const String traumaCreate = '$baseUrl/api/user/traumaBooking/create';
  static const String cmsData = '$baseUrl/api/user/cmsData/list';
  static const String search = '$baseUrl/api/user/search';


  //pradeep
  static const String userAddress = '$baseUrl/api/user/userAddress';
  static const String registerApi = '$baseUrl/api/user/auth/register';
  static const String welcome = '$baseUrl/api/user/common/userWelcomeNotification';
  static const String profile = '$baseUrl/api/user/auth/profile';
}


