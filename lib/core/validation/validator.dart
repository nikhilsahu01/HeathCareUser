class Validators {

  static String? phone(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter mobile number";
    }

    if (value.length > 10) {
      return "Mobile number cannot exceed 10 digits";
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter valid mobile number";
    }

    return null;
  }

  static String? email(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter email";
    }

    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(value)) {
      return "Enter valid email";
    }

    return null;
  }

  static String? name(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter name";
    }

    if (value.length < 3) {
      return "Name too short";
    }

    return null;
  }


  /// DOB
  /// FORMAT => DD/MM/YYYY
  static String? dob(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter date of birth";
    }

    if (!RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d\d$',
    ).hasMatch(value)) {
      return "Enter DOB in DD/MM/YYYY format";
    }

    return null;
  }

  /// BLOOD GROUP
  static String? bloodGroup(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter blood group";
    }

    if (!RegExp(
      r'^(A|B|AB|O)[+-]$',
    ).hasMatch(value.toUpperCase())) {
      return "Enter valid blood group";
    }

    return null;
  }

  /// MARITAL STATUS
  static String? maritalStatus(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter marital status";
    }

    return null;
  }

  /// HEIGHT
  static String? height(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter height";
    }

    final height = double.tryParse(value);

    if (height == null) {
      return "Enter valid height";
    }

    if (height < 50 || height > 300) {
      return "Height should be between 50 - 300 cm";
    }

    return null;
  }

  /// WEIGHT
  static String? weight(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter weight";
    }

    final weight = double.tryParse(value);

    if (weight == null) {
      return "Enter valid weight";
    }

    if (weight < 10 || weight > 500) {
      return "Weight should be between 10 - 500 kg";
    }

    return null;
  }



  static String? pastMeditation(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    return null;
  }
}