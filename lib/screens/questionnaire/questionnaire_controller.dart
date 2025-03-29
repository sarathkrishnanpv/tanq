import 'package:get/get.dart';

class QuestionnaireController extends GetxController {
  static const int TOTAL_STEPS = 5;
  
  final RxInt currentStep = 1.obs;
  final RxMap<String, dynamic> answers = <String, dynamic>{}.obs;
  
  // Personal Information
  final RxString name = ''.obs;
  final RxBool nameHasError = false.obs;
  final RxString nameError = ''.obs;

  final Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);
  final RxBool dateOfBirthHasError = false.obs;
  final RxString dateOfBirthError = ''.obs;

  final RxString homeAddress = ''.obs;
  final RxBool homeAddressHasError = false.obs;
  final RxString homeAddressError = ''.obs;

  final RxList<String> languages = <String>[].obs;
  final RxBool languagesHasError = false.obs;
  final RxString languagesError = ''.obs;
  
  // Vehicle Information
  final RxString vehicleType = ''.obs;
  final RxString vehicleModel = ''.obs;
  final RxString vehicleYear = ''.obs;
  final RxString licensePlate = ''.obs;
  final RxList<String> vehicleImages = <String>[].obs;
  
  // Vehicle Type validation
  final RxBool vehicleTypeError = false.obs;
  final RxString vehicleTypeErrorText = ''.obs;

  // Vehicle Model validation
  final RxBool vehicleModelError = false.obs;
  final RxString vehicleModelErrorText = ''.obs;

  // Vehicle Year validation
  final RxBool vehicleYearError = false.obs;
  final RxString vehicleYearErrorText = ''.obs;

  // Vehicle Images validation
  final RxBool vehicleImagesError = false.obs;
  final RxString vehicleImagesErrorText = ''.obs;
  
  // Documents
  final RxString driverLicense = ''.obs;
  final RxString vehicleRegistration = ''.obs;
  final RxString insurance = ''.obs;
  
  // Bank Details
  final RxString bankName = ''.obs;
  final RxString accountNumber = ''.obs;
  final RxString ifscCode = ''.obs;

  final RxBool bankNameError = false.obs;
  final RxBool accountNumberError = false.obs;
  final RxBool ifscCodeError = false.obs;

  final RxString bankNameErrorText = ''.obs;
  final RxString accountNumberErrorText = ''.obs;
  final RxString ifscCodeErrorText = ''.obs;

  // Document Upload Status
  final RxBool driversLicenseUploaded = false.obs;
  final RxBool rcBookUploaded = false.obs;
  final RxBool pccUploaded = false.obs;
  final RxBool pollutionUploaded = false.obs;
  final RxBool insuranceUploaded = false.obs;
  final RxBool permitUploaded = false.obs;
  final RxBool aadharUploaded = false.obs;
  final RxBool panUploaded = false.obs;

  // Document Upload Progress
  final RxInt driversLicenseProgress = 0.obs;
  final RxInt rcBookProgress = 0.obs;
  final RxInt pccProgress = 0.obs;
  final RxInt pollutionProgress = 0.obs;
  final RxInt insuranceProgress = 0.obs;
  final RxInt permitProgress = 0.obs;
  final RxInt aadharProgress = 0.obs;
  final RxInt panProgress = 0.obs;

  // Document Paths
  final RxList<String> driversLicensePaths = <String>[].obs;
  final RxList<String> rcBookPaths = <String>[].obs;
  final RxList<String> pccPaths = <String>[].obs;
  final RxList<String> pollutionPaths = <String>[].obs;
  final RxList<String> insurancePaths = <String>[].obs;
  final RxList<String> permitPaths = <String>[].obs;
  final RxList<String> aadharPaths = <String>[].obs;
  final RxList<String> panPaths = <String>[].obs;

  // Selfie
  final Rx<String?> selfieImage = Rx<String?>(null);
  final RxBool selfieError = false.obs;
  final RxString selfieErrorText = ''.obs;

  // Language selection
  final RxList<String> selectedLanguages = <String>[].obs;
  final RxBool hasLanguageError = false.obs;
  final RxString languageErrorText = ''.obs;

  // Driver's License
  final RxString driversLicenseFront = ''.obs;
  final RxString driversLicenseBack = ''.obs;
  final Rx<DateTime?> driversLicenseExpiry = Rx<DateTime?>(null);
  final RxString driversLicenseNumber = ''.obs;

  // RC Book
  final RxString rcBookFront = ''.obs;
  final RxString rcBookBack = ''.obs;
  final Rx<DateTime?> rcBookExpiry = Rx<DateTime?>(null);
  final RxString rcBookNumber = ''.obs;

  // Computed property for all documents uploaded
  bool get allDocumentsUploaded => 
    driversLicenseUploaded.value &&
    rcBookUploaded.value &&
    pccUploaded.value &&
    pollutionUploaded.value &&
    insuranceUploaded.value &&
    permitUploaded.value &&
    aadharUploaded.value &&
    panUploaded.value;

  void validateName(String value) {
    name.value = value;
    if (value.isEmpty) {
      nameHasError.value = true;
      nameError.value = 'Name is required';
    } else if (value.length < 3) {
      nameHasError.value = true;
      nameError.value = 'Name must be at least 3 characters';
    } else {
      nameHasError.value = false;
      nameError.value = '';
    }
  }

  void validateDateOfBirth(DateTime? date) {
    dateOfBirth.value = date;
    if (date == null) {
      dateOfBirthHasError.value = true;
      dateOfBirthError.value = 'Date of birth is required';
    } else if (date.isAfter(DateTime.now().subtract(const Duration(days: 365 * 18)))) {
      dateOfBirthHasError.value = true;
      dateOfBirthError.value = 'You must be at least 18 years old';
    } else {
      dateOfBirthHasError.value = false;
      dateOfBirthError.value = '';
    }
  }

  void validateHomeAddress(String value) {
    homeAddress.value = value;
    if (value.isEmpty) {
      homeAddressHasError.value = true;
      homeAddressError.value = 'Home address is required';
    } else if (value.length < 10) {
      homeAddressHasError.value = true;
      homeAddressError.value = 'Please enter complete address';
    } else {
      homeAddressHasError.value = false;
      homeAddressError.value = '';
    }
  }

  void validateLanguages() {
    if (selectedLanguages.isEmpty) {
      hasLanguageError.value = true;
      languageErrorText.value = 'Please select at least one language';
    } else {
      hasLanguageError.value = false;
      languageErrorText.value = '';
    }
  }

  void addLanguage(String language) {
    if (!selectedLanguages.contains(language)) {
      selectedLanguages.add(language);
      validateLanguages();
    }
  }

  void removeLanguage(String language) {
    selectedLanguages.remove(language);
    validateLanguages();
  }

  bool validatePersonalInfo() {
    validateName(name.value);
    validateDateOfBirth(dateOfBirth.value);
    validateHomeAddress(homeAddress.value);
    validateLanguages();

    return !nameHasError.value && 
           !dateOfBirthHasError.value && 
           !homeAddressHasError.value && 
           !hasLanguageError.value;
  }

  bool validateVehicleInfo() {
    bool isValid = true;

    // Validate Vehicle Type
    if (vehicleType.value.isEmpty) {
      vehicleTypeError.value = true;
      vehicleTypeErrorText.value = 'Please select a vehicle type';
      isValid = false;
    } else {
      vehicleTypeError.value = false;
      vehicleTypeErrorText.value = '';
    }

    // Validate Vehicle Model
    if (vehicleModel.value.isEmpty) {
      vehicleModelError.value = true;
      vehicleModelErrorText.value = 'Please enter vehicle model';
      isValid = false;
    } else {
      vehicleModelError.value = false;
      vehicleModelErrorText.value = '';
    }

    // Validate Vehicle Year
    if (vehicleYear.value.isEmpty) {
      vehicleYearError.value = true;
      vehicleYearErrorText.value = 'Please select manufacture year';
      isValid = false;
    } else {
      vehicleYearError.value = false;
      vehicleYearErrorText.value = '';
    }

    // Validate Vehicle Images
    if (vehicleImages.isEmpty) {
      vehicleImagesError.value = true;
      vehicleImagesErrorText.value = 'Please upload at least one vehicle image';
      isValid = false;
    } else {
      vehicleImagesError.value = false;
      vehicleImagesErrorText.value = '';
    }

    return isValid;
  }

  void addVehicleImage(String imagePath) {
    vehicleImages.add(imagePath);
  }

  void removeVehicleImage(int index) {
    if (index >= 0 && index < vehicleImages.length) {
      vehicleImages.removeAt(index);
    }
  }

  bool validateBankDetails() {
    bool isValid = true;

    // Bank Name validation
    if (bankName.value.isEmpty) {
      bankNameError.value = true;
      bankNameErrorText.value = 'Please enter bank name';
      isValid = false;
    } else {
      bankNameError.value = false;
    }

    // Account Number validation
    if (accountNumber.value.isEmpty) {
      accountNumberError.value = true;
      accountNumberErrorText.value = 'Please enter account number';
      isValid = false;
    } else if (accountNumber.value.length < 8 || accountNumber.value.length > 18) {
      accountNumberError.value = true;
      accountNumberErrorText.value = 'Please enter a valid account number';
      isValid = false;
    } else {
      accountNumberError.value = false;
    }

    // IFSC Code validation
    if (ifscCode.value.isEmpty) {
      ifscCodeError.value = true;
      ifscCodeErrorText.value = 'Please enter IFSC code';
      isValid = false;
    } else if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifscCode.value)) {
      ifscCodeError.value = true;
      ifscCodeErrorText.value = 'Please enter a valid IFSC code';
      isValid = false;
    } else {
      ifscCodeError.value = false;
    }

    return isValid;
  }

  bool validateSelfie() {
    if (selfieImage.value == null) {
      selfieError.value = true;
      selfieErrorText.value = 'Please take a selfie';
      return false;
    }
    selfieError.value = false;
    selfieErrorText.value = '';
    return true;
  }

  bool validatePaymentDetails() {
    bool isValid = true;
    
    // Validate bank name
    if (bankName.value.isEmpty) {
      bankNameError.value = true;
      bankNameErrorText.value = 'Please enter bank name';
      isValid = false;
    }

    // Validate account number
    if (accountNumber.value.isEmpty) {
      accountNumberError.value = true;
      accountNumberErrorText.value = 'Please enter account number';
      isValid = false;
    } else if (accountNumber.value.length < 9) {
      accountNumberError.value = true;
      accountNumberErrorText.value = 'Please enter a valid account number';
      isValid = false;
    }

    // Validate IFSC code
    if (ifscCode.value.isEmpty) {
      ifscCodeError.value = true;
      ifscCodeErrorText.value = 'Please enter IFSC code';
      isValid = false;
    } else if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifscCode.value)) {
      ifscCodeError.value = true;
      ifscCodeErrorText.value = 'Please enter a valid IFSC code';
      isValid = false;
    }

    return isValid;
  }

  void nextStep() {
    if (currentStep.value < TOTAL_STEPS) {
      currentStep.value++;
    } else {
      submitQuestionnaire();
    }
  }
  
  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }
  
  void submitQuestionnaire() {
    answers.value = {
      'personal_info': {
        'name': name.value,
        'date_of_birth': dateOfBirth.value?.toIso8601String(),
        'home_address': homeAddress.value,
        'languages': selectedLanguages.toList(),
      },
      'vehicle_info': {
        'type': vehicleType.value,
        'model': vehicleModel.value,
        'year': vehicleYear.value,
        'license_plate': licensePlate.value,
      },
      'documents': {
        'driver_license': driverLicense.value,
        'vehicle_registration': vehicleRegistration.value,
        'insurance': insurance.value,
      },
    };
    
    // TODO: Send answers to backend
    print('Submitting questionnaire answers: ${answers.value}');
    
    // Navigate to next screen (e.g., home screen or verification screen)
    Get.offAllNamed('/home');
  }

  // Document Upload Methods
  Future<void> uploadDriversLicense() async {
    // TODO: Implement document upload
    driversLicenseUploaded.value = true;
  }

  Future<void> uploadRCBook() async {
    // TODO: Implement document upload
    rcBookUploaded.value = true;
  }

  Future<void> uploadPCC() async {
    // TODO: Implement document upload
    pccUploaded.value = true;
  }

  Future<void> uploadPollution() async {
    // TODO: Implement document upload
    pollutionUploaded.value = true;
  }

  Future<void> uploadInsurance() async {
    // TODO: Implement document upload
    insuranceUploaded.value = true;
  }

  Future<void> uploadPermit() async {
    // TODO: Implement document upload
    permitUploaded.value = true;
  }

  Future<void> uploadAadhar() async {
    // TODO: Implement document upload
    aadharUploaded.value = true;
  }

  Future<void> uploadPAN() async {
    // TODO: Implement document upload
    panUploaded.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }

  Map<String, dynamic> getFormData() {
    return {
      'personal_info': {
        'name': name.value,
        'date_of_birth': dateOfBirth.value?.toIso8601String(),
        'home_address': homeAddress.value,
        'languages': selectedLanguages.toList(),
      },
      // ... rest of the form data ...
    };
  }
} 