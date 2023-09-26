import 'dart:convert';



class MemberActivityModel {
  int id;
  int groupement_id;
  int beneficiary_id;
  int program_id;
  int project_id;

  int cycle_id;
  int total_saving;
  int total_loans;
  int total_grants_received;
  int total_productives_activities_created;
  String date_sorti_member;
  int flag_member_activity;

  static final columns = [
    "id",
    "groupement_id",
    "beneficiary_id",
    "program_id",
    "project_id",
    "date_sorti_member",
    "cycle_id",
    "total_saving",
    "total_loans",
    "total_grants_received",
    "total_productives_activities_created",
    "flag_member_activity"
  ];

  MemberActivityModel(
      {
      this.id,
      this.groupement_id,
      this.beneficiary_id,
      this.cycle_id,
      this.program_id,
      this.project_id,
      this.date_sorti_member,
      this.total_saving,
      this.total_loans,
      this.total_grants_received,
      this.total_productives_activities_created,
      this.flag_member_activity

      });

  // Used when returning a row from the DB and converting into an object
  factory MemberActivityModel.fromMap(Map<String, dynamic> map) {
    return MemberActivityModel(
      id: map["id"],
      groupement_id: map["groupement_id"],
      beneficiary_id: map["beneficiary_id"],
      program_id: map['program_id'],
      project_id: map['project_id'],
      date_sorti_member: map['date_sorti_member'],
      cycle_id: map['cycle_id'],
      total_saving: map['total_saving'],
      total_loans: map['total_loans'],
      total_grants_received: map['total_grants_received'],
      total_productives_activities_created: map['total_productives_activities_created'],
      flag_member_activity: map['flag_member_activity']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id":this.id,
    "groupement_id" : this.groupement_id,
    "beneficiary_id" : this.beneficiary_id,
    "program_id":this.program_id,
    "project_id" : this.project_id,
    "date_sorti_member" : this.date_sorti_member,
    "cycle_id":this.cycle_id,
    "total_saving" : this.total_saving,
    "total_loans" : this.total_loans,
    "total_grants_received" : this.total_grants_received,
    "total_productives_activities_created" : this.total_productives_activities_created,
    "flag_member_activity" : this.flag_member_activity

      };

  factory MemberActivityModel.fromJson(Map<String, dynamic> json) {
    return MemberActivityModel(
        id: json["id"],
        groupement_id: json["groupement_id"],
        beneficiary_id: json["beneficiary_id"],
        program_id: json['program_id'],
        project_id: json['project_id'],
        date_sorti_member: json['date_sorti_member'],
        cycle_id: json['cycle_id'],
        total_saving: json['total_saving'],
        total_loans: json['total_loans'],
        total_grants_received: json['total_grants_received'],
        total_productives_activities_created: json['total_productives_activities_created'],
        flag_member_activity: json['flag_member_activity']
    );
  }
}

class GroupementActivityModel {
  int id;
  int groupement_id;
  int program_id;
  int project_id;
  int phase_id;
  int cycle_id;
  int solde_cumulated_saving;
  int solde_actual_saving;
  int total_saving;
  int loan_cumulated_actual;
  int total_new_loans;
  int total_new_members_actif;
  int total_excluded_members;
  int total_grants_received;
  int total_grant_amount;
  int total_productives_activities_created;
  int total_members;

  int groupement_activity_flag;

  static final columns = [
    "id",
    "groupement_id",
    "program_id",
    "project_id",
    "phase_id",
    "cycle_id",
    "solde_cumulated_saving",
    "solde_actual_saving",
    "total_saving",
    "loan_cumulated_actual",
    "total_new_loans",
    "total_new_members_actif",
    "total_excluded_members",
    "total_grants_received",
    "total_grant_amount",
    "total_productives_activities_created",
    "total_members",
    "groupement_activity_flag"
  ];

  GroupementActivityModel(
      {this.id,
        this.groupement_id,
        this.cycle_id,
        this.program_id,
        this.project_id,
        this.phase_id,
        this.solde_cumulated_saving,
        this.solde_actual_saving,
        this.total_saving,
        this.loan_cumulated_actual,
        this.total_new_loans,
        this.total_new_members_actif,
        this.total_excluded_members,
        this.total_grants_received,
        this.total_grant_amount,
        this.total_productives_activities_created,
        this.total_members,
        this.groupement_activity_flag
      });

  // Used when returning a row from the DB and converting into an object
  factory GroupementActivityModel.fromMap(Map<String, dynamic> map) {
    return GroupementActivityModel(
        id: map["id"],
        groupement_id: map["groupement_id"],
        program_id: map['program_id'],
        project_id: map['project_id'],
        phase_id: map['phase_id'],
        cycle_id: map['cycle_id'],
        solde_cumulated_saving: map['solde_cumulated_saving'],
        solde_actual_saving: map['solde_actual_saving'],
        total_saving: map['total_saving'],
        loan_cumulated_actual: map['loan_cumulated_actual'],
        total_new_loans: map['total_new_loans'],
        total_new_members_actif: map['total_new_members_actif'],
        total_excluded_members: map['total_excluded_members'],
        total_grants_received: map['total_grants_received'],
        total_grant_amount: map['total_grant_amount'],
        total_productives_activities_created: map['total_productives_activities_created'],
        total_members: map["total_members"],
        groupement_activity_flag: map['groupement_activity_flag']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id":this.id,
    "groupement_id" : this.groupement_id,
    "program_id":this.program_id,
    "project_id" : this.project_id,
    "phase_id":this.phase_id,
    "cycle_id":this.cycle_id,
    "solde_cumulated_saving" : this.solde_cumulated_saving,
    "solde_actual_saving" : this.solde_actual_saving,
    "total_saving" : this.total_saving,
    "loan_cumulated_actual" : this.loan_cumulated_actual,
    "total_new_loans" : this.total_new_loans,
    "total_new_members_actif" : this.total_new_members_actif,
    "total_excluded_members" : this.total_excluded_members,
    "total_grants_received" : this.total_grants_received,
    "total_grant_amount" : this.total_grant_amount,
    "total_productives_activities_created" : this.total_productives_activities_created,
    "total_members" : this.total_members,
    "groupement_activity_flag" : this.groupement_activity_flag
  };

  factory GroupementActivityModel.fromJson(Map<String, dynamic> json) {
    return GroupementActivityModel(
        id: json["id"],
        groupement_id: json["groupement_id"],
        program_id: json['program_id'],
        project_id: json['project_id'],
        phase_id: json['phase_id'],
        cycle_id: json['cycle_id'],
        solde_cumulated_saving: json['solde_cumulated_saving'],
        solde_actual_saving: json['solde_actual_saving'],
        total_saving: json['total_saving'],
        loan_cumulated_actual: json['loan_cumulated_actual'],
        total_new_loans: json['total_new_loans'],
        total_new_members_actif: json['total_new_members_actif'],
        total_excluded_members: json['total_excluded_members'],
        total_grants_received: json['total_grants_received'],
        total_grant_amount: json['total_grant_amount'],
        total_productives_activities_created: json['total_productives_activities_created'],
        total_members: json["total_members"],
        groupement_activity_flag: json['groupement_activity_flag']
    );
  }
}

class GrantModel {
  int id;
  String type_demandeur;
  int program_id;
  int project_id;
  int sub_project_id;
  //int cycle_id;
  int groupement_id;
  int beneficiary_id;
  int ounit_id;
  int grant_amount;
  String date_granted;
  String date_transferred;
  String date_debited;
  int flag_grant;


  static final columns = [
    "id",
    "type_demandeur",
    "program_id",
    "project_id",
    "sub_project_id",
    //"cycle_id",
    "groupement_id",
    "beneficiary_id",
    "ounit_id",
    "grant_amount",
    "date_granted",
    "date_transferred",
    "date_debited",
    "flag_grant"

  ];

  GrantModel(
      {
        this.id,
        this.type_demandeur,
       // this.cycle_id,
        this.program_id,
        this.project_id,
        this.sub_project_id,
        this.groupement_id,
        this.beneficiary_id,
        this.ounit_id,
        this.grant_amount,
        this.date_granted,
        this.date_transferred,
        this.date_debited,
        this.flag_grant
      });

  // Used when returning a row from the DB and converting into an object
  factory GrantModel.fromMap(Map<String, dynamic> map) {
    return GrantModel(
        id: map["id"],
        type_demandeur: map["type_demandeur"],
        program_id: map['program_id'],
        project_id: map['project_id'],
        sub_project_id: map['sub_project_id'],
        //cycle_id: map['cycle_id'],
        groupement_id: map['groupement_id'],
        beneficiary_id: map['beneficiary_id'],
        ounit_id: map['ounit_id'],
        grant_amount: map['grant_amount'],
        date_granted: map['date_granted'],
        date_transferred: map['date_transferred'],
        date_debited: map['date_debited'],
        flag_grant: map['flag_grant']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id":this.id,
    "type_demandeur" : this.type_demandeur,
    "program_id":this.program_id,
    "project_id" : this.project_id,
    "sub_project_id":this.sub_project_id,
    //"cycle_id":this.cycle_id,
    "groupement_id" : this.groupement_id,
    "beneficiary_id" : this.beneficiary_id,
    "ounit_id" : this.ounit_id,
    "grant_amount" : this.grant_amount,
    "date_granted" : this.date_granted,
    "date_transferred" : this.date_transferred,
    "date_debited" : this.date_debited,
    "flag_grant" : this.flag_grant
  };

 fromJson(Map<String, dynamic> json) {
    return GrantModel(
        id: json["id"],
        type_demandeur: json["type_demandeur"],
        program_id: json['program_id'],
        project_id: json['project_id'],
        sub_project_id: json['sub_project_id'],
        //cycle_id: json['cycle_id'],
        groupement_id: json['groupement_id'],
        beneficiary_id: json['beneficiary_id'],
        ounit_id: json['ounit_id'],
        grant_amount: json['grant_amount'],
        date_granted: json['date_granted'],
        date_transferred: json['date_transferred'],
        date_debited: json['date_debited'],
        flag_grant: json['flag_grant']
    );
  }
}


class ProductiveActivityModel {
  int id;
  String type_financement;
  String type_activite;
  String nature_activite;
  String start_date;
  String end_date;
  int sub_project_id;
  int groupement_id;
  int beneficiary_id;
  String ward;
  int amount;
  int flag_productive_activity;


  static final columns = [
    "id",
    "type_financement",
    "type_activite",
    "nature_activite",
    "start_date",
    "end_date",
    "sub_project_id",
    "groupement_id",
    "beneficiary_id",
    "ward",
    "amount",
    "flag_productive_activity"

  ];

  ProductiveActivityModel(
      {
        this.id,
        this.type_financement,
        this.type_activite,
        this.nature_activite,
        this.start_date,
        this.end_date,

        this.sub_project_id,
        this.groupement_id,
        this.beneficiary_id,
        this.ward,
        this.amount,

        this.flag_productive_activity
      });

  // Used when returning a row from the DB and converting into an object
  factory ProductiveActivityModel.fromMap(Map<String, dynamic> map) {
    return ProductiveActivityModel(
        id: map["id"],
        type_financement: map["type_financement"],
        type_activite: map["type_activite"],
        nature_activite: map['nature_activite'],

        groupement_id: map['groupement_id'],
        beneficiary_id: map['beneficiary_id'],
        ward: map['ward'],
        amount: map['amount'],
        start_date: map['start_date'],
        end_date: map['end_date'],

        flag_productive_activity: map['flag_productive_activity']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id":this.id,
    "type_financement" : this.type_financement,
    "type_activite" : this.type_activite,
    "nature_activite" : this.nature_activite,

    "sub_project_id":this.sub_project_id,

    "groupement_id" : this.groupement_id,
    "beneficiary_id" : this.beneficiary_id,
    "ward" : this.ward,
    "amount" : this.amount,
    "start_date" : this.start_date,
    "end_date" : this.end_date,

    "flag_productive_activity" : this.flag_productive_activity
  };

  fromJson(Map<String, dynamic> json) {
    return ProductiveActivityModel(
        id: json["id"],
        type_financement: json["type_financement"],
        type_activite: json["type_activite"],
        nature_activite: json['nature_activite'],

        groupement_id: json['groupement_id'],
        beneficiary_id: json['beneficiary_id'],
        ward: json['ward'],
        amount: json['amount'],
        start_date: json['start_date'],
        end_date: json['end_date'],

        flag_productive_activity: json['flag_productive_activity']
    );
  }
}


class GroupementModel {
  int id;
  String type_groupement_id;
  String ounit_groupement_id;
  String nature_groupement_id;
  String code;
  String label;
  int total_members;
  String group_terminated_at;
  String group_created_at;
  int groupement_flag;
  List<GroupementActivityModel> activitiesG;
  List<MemberActivityModel> activitiesM;
  List<GroupementBeneficiaryModel> members;

  static final columns = [
    "id",
    "type_groupement_id",
    "ounit_groupement_id",
    "nature_groupement_id",
    "code",
    "label",
    "total_members",
    "group_terminated_at",
    "group_created_at",
    "groupement_flag",

  ];

  GroupementModel(
      {
        this.id,
        this.type_groupement_id,
        this.ounit_groupement_id,
        this.nature_groupement_id,
        this.code,
        this.label,
        this.total_members,
        this.group_terminated_at,
        this.group_created_at,
        this.groupement_flag,
        this.activitiesG,
        this.activitiesM,
        this.members
      });

  // Used when returning a row from the DB and converting into an object
  factory GroupementModel.fromMap(Map<String, dynamic> map) {
    return GroupementModel(
        id: map["id"],
        type_groupement_id: map["type_groupement_id"],
        nature_groupement_id: map["nature_groupement_id"],
        ounit_groupement_id: map["ounit_groupement_id"],
        code: map["code"],
        label: map['label'],
        total_members: map['total_members'],
        group_terminated_at: map['group_terminated_at'],
        group_created_at: map['group_created_at'],
        groupement_flag: map['groupement_flag']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id": this.id,
    "type_groupement_id": this.type_groupement_id,
    "nature_groupement_id": this.nature_groupement_id,
    "ounit_groupement_id": this.ounit_groupement_id,
    "code": this.code,
    "label": this.label,
    "total_members": this.total_members,
    "group_terminated_at": this.group_terminated_at,
    "group_created_at": this.group_created_at,
    "groupement_flag": this.groupement_flag
  };

  fromJson(Map<String, dynamic> json) {

    List<dynamic> listA = json["activitiesG"];
    List<dynamic> listMA = json["activitiesM"];
    List<dynamic> listM = json["membres"];

   return GroupementModel(
          id: json["id"],
          type_groupement_id: json["type_groupement_id"],
          nature_groupement_id: json["nature_groupement_id"],
          ounit_groupement_id: json["ounit_groupement_id"],
          code: json["code"],
          label: json['label'],
          total_members: json['total_members'],
          group_terminated_at: json['group_terminated_at'],
          group_created_at: json['group_created_at'],
          groupement_flag: json['groupement_flag'],
          activitiesG: listA.map((i) => GroupementActivityModel.fromJson(i)).toList() ,
          activitiesM: listMA.map((i) => MemberActivityModel.fromJson(i)).toList() ,
          members : listM.map((i) => GroupementBeneficiaryModel.fromJson(i)).toList()  ,
      );
  }

}

class GroupementBeneficiaryModel {
  int id;
  // GroupementModel groupement;
  // BeneficiaryModel beneficiaire;
  int groupement_id;
  int beneficiary_id;
  String adhesion_at;
  String role;
  String terminaison_at;
  int groupement_beneficiary_flag;

  static final columns = [
    "id",
    "groupement_id",
    "beneficiary_id",
    "adhesion_at",
    "role",
    "terminaison_at",
    "groupement_beneficiary_flag"
  ];

  GroupementBeneficiaryModel(
      {this.id,
        this.groupement_id,
        this.beneficiary_id,
        this.adhesion_at,
        this.role,
        this.terminaison_at,
        this.groupement_beneficiary_flag
      });

  // Used when returning a row from the DB and converting into an object
  factory GroupementBeneficiaryModel.fromMap(Map<String, dynamic> map) {
    return GroupementBeneficiaryModel(
        id: map["id"],
        groupement_id: map["groupement_id"],
        beneficiary_id: map["beneficiary_id"],
        adhesion_at: map["adhesion_at"],
        role: map["role"],
        terminaison_at: map['terminaison_at'],
        groupement_beneficiary_flag: map['groupement_beneficiary_flag']
    );
  }
  // Will be used when inserting a row into the database
  Map<String, dynamic> toMap() => {
    "id": this.id,
    "groupement_id": this.groupement_id,
    "beneficiary_id": this.beneficiary_id,
    "adhesion_at": this.adhesion_at,
    "role": this.role,
    "terminaison_at": this.terminaison_at,
    "groupement_beneficiary_flag": this.groupement_beneficiary_flag,

  };

  factory GroupementBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return GroupementBeneficiaryModel(
        id: json['id'],
        groupement_id: json['groupement_id'],
        beneficiary_id: json['beneficiary_id'],
        adhesion_at: json['adhesion_at'],
        role: json['role'],
        terminaison_at: json['terminaison_at'],
        groupement_beneficiary_flag: json['groupement_beneficiary_flag']
    );
  }
}