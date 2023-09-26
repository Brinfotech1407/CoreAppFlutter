import 'dart:convert';



class TransactionModel {
  int beneficiary_id;
  int benefit_id;
  int benefitlist_id;
  int cycle_id;
  int site_id;
  int id;
  String transaction_site;
  int amount;
  String transaction_date;
  String transaction_scan_date;
  String transaction_type;
  String transaction_status;
  String transaction_new_status;
  String start_date;
  String end_date;
  int sequence;
  static final columns = [
    "id",
    "beneficiary_id",
    "benefit_id",
    "benefitlist_id",
    "cycle_id",
    "site_id",
    "transaction_site",
    "transaction_date",
    "transaction_scan_date",
    "start_date",
    "end_date",
    "transaction_type",
    "transaction_status",
    "transaction_new_status",
    "amount"
  ];

  TransactionModel(
      {this.id,
      this.sequence,
      this.beneficiary_id,
      this.benefit_id,
      this.benefitlist_id,
      this.cycle_id,
      this.site_id,
      this.transaction_site,
      this.amount,
      this.transaction_date,
      this.transaction_scan_date,
      this.start_date,
      this.end_date,
      this.transaction_status,
      this.transaction_new_status,
      this.transaction_type});

  // Used when returning a row from the DB and converting into an object
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      beneficiary_id: map["beneficiary_id"],
      benefit_id: map["benefit_id"],
      benefitlist_id: map["benefitlist_id"],
      cycle_id: map["cycle_id"],
      site_id: map["site_id"],
      id: map['id'],
      amount: map['amount'],
      transaction_site: map['transaction_site'],
      transaction_type: map['transaction_type'],
      transaction_date: map['transaction_date'],
      transaction_scan_date: map['transaction_scan_date'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      transaction_status: map['transaction_status'],
      transaction_new_status: map['transaction_new_status'],
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
        "id": this.id,
        "beneficiary_id": this.beneficiary_id,
        "benefit_id": this.benefit_id,
        "benefitlist_id": this.benefitlist_id,
        "cycle_id": this.cycle_id,
        "site_id": this.site_id,
        "transaction_date": this.transaction_date,
        "transaction_scan_date": this.transaction_scan_date,
        "start_date": this.start_date,
        "end_date": this.end_date,
        "transaction_site": this.transaction_site,
        "transaction_type": this.transaction_type,
        "transaction_status": this.transaction_status,
        "transaction_new_status": this.transaction_new_status,
        "amount": this.amount
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        beneficiary_id: json['beneficiary_id'],
        benefit_id: json['benefit_id'],
        benefitlist_id: json['benefitlist_id'],
        cycle_id: json['cycle_id'],
        site_id: json['site_id'],
        id: json['benefit_beneficiary_id'],
        transaction_date: json['benefit_date'],
        transaction_scan_date: "",
        start_date: json['start_date'],
        end_date: json['end_date'],
        transaction_site: json['label'],
        transaction_type: "TM",
        transaction_status: json['benefit_flag'].toString(),
        transaction_new_status: "",
        amount: json['benefit_amount']);
  }
}

class GrievanceModel {
  int id;
  int beneficiary_id;
  int site_id;
  int grievance_types_id;
  int grievance_categories_id;
  String grievance_flag;
  String grievance_date;
  String grievance_sync_date;
  String grievance_date_open;
  String grievance_date_start_approbal;
  String grievance_date_end_approbal;
  String grievance_date_rejected;
  String grievance_date_close;
  String grievance_date_executed;
  String description;
  String decision;
  String rejet;

  static final columns = [
    "id",
    "beneficiary_id",
    "site_id",
    "grievance_types_id",
    "grievance_categories_id",
    "grievance_flag",
    "grievance_date",
    "grievance_sync_date",
    "grievance_date_open",
    "grievance_date_start_approbal",
    "grievance_date_end_approbal",
    "grievance_date_rejected",
    "grievance_date_close",
    "grievance_date_executed",
    "description",
    "decision",
    "rejet"
  ];

  GrievanceModel(
      {this.id,
      this.description,
      this.beneficiary_id,
      this.site_id,
      this.grievance_types_id,
      this.grievance_categories_id,
      this.grievance_flag,
      this.grievance_date,
      this.grievance_sync_date,
      this.grievance_date_open,
      this.grievance_date_start_approbal,
      this.grievance_date_end_approbal,
      this.grievance_date_rejected,
      this.grievance_date_close,
      this.grievance_date_executed,
      this.decision,
      this.rejet});

  // Used when returning a row from the DB and converting into an object
  factory GrievanceModel.fromMap(Map<String, dynamic> map) {
    return GrievanceModel(
      beneficiary_id: map["beneficiary_id"],
      site_id: map["site_id"],
      grievance_types_id: map["grievance_types_id"],
      grievance_categories_id: map["grievance_categories_id"],
      id: map['id'],
      description: map['description'],
      rejet: map['rejet'],
      decision: map['decision'],
      grievance_flag: map["grievance_flag"],
      grievance_sync_date: map['grievance_sync_date'],
      grievance_date: map['grievance_date'],
      grievance_date_open: map['grievance_date_open'],
      grievance_date_start_approbal: map['grievance_date_start_approbal'],
      grievance_date_end_approbal: map['grievance_date_end_approbal'],
      grievance_date_rejected: map['grievance_date_end_approbal'],
      grievance_date_close: map['grievance_date_close'],
      grievance_date_executed: map['grievance_date_executed'],
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
        "id": this.id,
        "beneficiary_id": this.beneficiary_id,
        "site_id": this.site_id,
        "grievance_types_id": this.grievance_types_id,
        "grievance_categories_id": this.grievance_categories_id,
        "grievance_flag": this.grievance_flag,
        "grievance_date": this.grievance_date,
        "grievance_sync_date": this.grievance_sync_date,
        "grievance_date_open": this.grievance_date_open,
        "grievance_date_start_approbal": this.grievance_date_start_approbal,
        "grievance_date_end_approbal": this.grievance_date_end_approbal,
        "grievance_date_rejected": this.grievance_date_rejected,
        "grievance_date_close": this.grievance_date_close,
        "grievance_date_executed": this.grievance_date_executed,
        "description": this.description,
        "decision": this.decision,
        "rejet": this.rejet
      };

  factory GrievanceModel.fromJson(Map<String, dynamic> json) {
    return GrievanceModel(
        beneficiary_id: json["beneficiary_id"],
        site_id: json["ounit_id"],
        grievance_types_id: json["grievance_types_id"],
        grievance_categories_id: json["grievance_categories_id"],
        id: json['id'],
        description: json['description'],
        rejet: json['rejet'],
        decision: json['decision'],
        grievance_sync_date: "",
        grievance_flag: json["grievance_flag"],
        grievance_date: json['grievance_date'],
        grievance_date_open: json['grievance_date_open'],
        grievance_date_start_approbal: json['grievance_date_start_approbal'],
        grievance_date_end_approbal: json['grievance_date_end_approbal'],
        grievance_date_rejected: json['grievance_date_end_approbal'],
        grievance_date_close: json['grievance_date_close'],
        grievance_date_executed: json['grievance_date_executed']);
  }
}

class BeneficiaryModel {
  int id;
  int program_id;
  int project_id;
  int phase_id;
  String name;
  String householdid;
  String individualid;
  int site_id;
  int individual_id;
  String barcode;
  String ward;
  String constituency;
  String county;
  String district;
  String photo;
  List<TransactionModel> transactions;
  List<GrievanceModel> grievances;


  static final columns = [
    "individual_id",
    "id",
    "program_id",
    "project_id",
    "phase_id",
    "site_id",
    "name",
    "householdid",
    "individualid",
    "ward",
    "constituency",
    "county",
    "district",
    "barcode",
    "photo"
  ];

  BeneficiaryModel(
      {this.id,
      this.name,
      this.householdid,
      this.individualid,
      this.program_id,
      this.project_id,
      this.phase_id,
      this.site_id,
      this.individual_id,
      this.ward,
      this.constituency,
      this.county,
      this.district,
      this.barcode,
      this.photo,
      this.transactions,
      this.grievances});

  factory BeneficiaryModel.fromMap(Map<String, dynamic> map) {
    return BeneficiaryModel(
        name: map["name"],
        householdid: map['householdid'],
        individualid: map['individualid'],
        id: map['id'],
        program_id: map['program_id'],
        project_id: map['project_id'],
        phase_id: map['phase_id'],
        site_id: map['site_id'],
        individual_id: map['individual_id'],
        ward: map['ward'],
        constituency: map['constituency'],
        county: map['county'],
        district: map['district'],
        barcode: map['barcode'],
        photo: map['photo']

        );
  }

  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["name"] = this.name;
    map['householdid'] = this.householdid;
    map['individualid'] = this.individualid;
    map['id'] = this.id;
    map['program_id'] = this.program_id;
    map['project_id'] = this.project_id;
    map['phase_id'] = this.phase_id;
    map['site_id'] = this.site_id;
    map['individual_id'] = this.individual_id;
    map['ward'] = this.ward;
    map['constituency'] = this.constituency;
    map['county'] = this.county;
    map['district'] = this.district;
    map['barcode'] = this.barcode;
    map['photo'] = this.photo;

    return map;
  }

  fromJson(Map<String, dynamic> json) {
    List<dynamic> listT = json["transactions"];
    List<dynamic> listG = json["grievances"];

    if (listT != null) {
      //print(list.runtimeType);
      List<TransactionModel> transactionList =
          listT.map((i) => TransactionModel.fromJson(i)).toList();

      return BeneficiaryModel(
          name: json['name'],
          householdid: json['householdid'],
          individualid: json['individualid'],
          id: json['id'],
          program_id: json['program_id'],
          phase_id: json['phase_id'],
          project_id: json['project_id'],
          site_id: json['site_id'],
          individual_id: json['individual_id'],
          barcode: json['barcode'],
          ward: json['ward'],
          constituency: json['constituency'],
          county: json['county'],
          district: json['district'],
          photo: (json['photo'] == null) ? null : json['photo'],
          transactions: transactionList);
    } else {
      return BeneficiaryModel(
          name: json['name'],
          householdid: json['householdid'],
          individualid: json['individualid'],
          id: json['beneficiary_id'],
          program_id: json['program_id'],
          phase_id: json['phase_id'],
          project_id: json['project_id'],
          site_id: json['site_id'],
          individual_id: json['individual_id'],
          ward: json['ward'],
          constituency: json['constituency'],
          county: json['county'],
          district: json['district'],
          barcode: json['barcode'],
          photo: json['photo']);
    }
  }
}
