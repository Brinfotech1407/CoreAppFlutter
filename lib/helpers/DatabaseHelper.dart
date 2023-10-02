import 'dart:io';

import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final _databaseName = "eSPMIS.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      var databaseFac = databaseFactoryFfi;
      _database = await databaseFac.openDatabase(_databaseName);
      await _onCreate(_database, _databaseVersion);
    } else {
      _database = await _initDatabase();
    }

    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_beneficiaries");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_beneficiaries (
            id INTEGER PRIMARY KEY NOT NULL,
            name TEXT NOT NULL,
            individual_id INTEGER NULL,
            program_id INTEGER NULL,
            project_id INTEGER NULL,
            phase_id INTEGER NULL,
            site_id INTEGER NULL,
            householdid TEXT NULL,
            individualid TEXT NULL,
            ward TEXT NULL,
            constituency TEXT NULL,
            county TEXT NULL,
            district TEXT NULL,
            barcode TEXT NULL,
            photo TEXT NULL
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_transactions");
    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_transactions (
            id INTEGER PRIMARY KEY NOT NULL,
            beneficiary_id INTEGER NOT NULL,
            benefit_id INTEGER NULL,
            benefitlist_id INTEGER NULL,
            cycle_id INTEGER NULL,
            site_id INTEGER NULL,
            transaction_site TEXT NULL,
            transaction_date TEXT NULL,
            transaction_scan_date TEXT NULL,
            start_date TEXT NULL,
            end_date TEXT NULL,
            transaction_effective_date TEXT NULL,
            transaction_type TEXT NULL,
            transaction_status TEXT NULL,
            transaction_new_status TEXT NULL,
            amount INTEGER NULL,
            FOREIGN KEY (beneficiary_id) REFERENCES espmis_beneficiaries (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_grievances");
    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_grievances (
            id INTEGER PRIMARY KEY NOT NULL,
            beneficiary_id INTEGER NOT NULL,
            site_id INTEGER NULL,
            grievance_types_id INTEGER NULL,
            grievance_categories_id INTEGER NULL,
            grievance_flag TEXT NULL,
            grievance_date TEXT NULL,
            grievance_sync_date TEXT NULL,
            grievance_date_open TEXT NULL,
            grievance_date_start_approbal TEXT NULL,
            grievance_date_end_approbal TEXT NULL,
            grievance_date_rejected TEXT NULL,
            grievance_date_close TEXT NULL,
            grievance_date_executed TEXT NULL,
            description TEXT NULL,
            decision TEXT NULL,
            rejet TEXT NULL,
            FOREIGN KEY (beneficiary_id) REFERENCES espmis_beneficiaries (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_groupements_activities");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_groupements_activities (
            id INTEGER PRIMARY KEY NOT NULL,
            cycle_id INTEGER NULL,
            program_id INTEGER NULL,
            project_id INTEGER NULL,
            phase_id INTEGER NULL,
            groupement_id INTEGER NOT NULL,
            solde_cumulated_saving INTEGER NULL,
            solde_actual_saving INTEGER NULL,
            total_saving INTEGER NULL,
            loan_cumulated_actual INTEGER NULL,
            total_new_loans INTEGER NULL,
            total_new_members_actif INTEGER NULL,
            total_excluded_members INTEGER NULL,
            total_grants_received INTEGER NULL,
            total_grant_amount INTEGER NULL,
            total_productives_activities_created INTEGER NULL,
            total_members INTEGER NULL,
            groupement_activity_flag INTEGER NULL,
            FOREIGN KEY (groupement_id) REFERENCES espmis_groupements (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_members_activities");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_members_activities (
            id INTEGER PRIMARY KEY NOT NULL,
            cycle_id INTEGER NULL,
            program_id INTEGER NULL,
            project_id INTEGER NULL,
            phase_id INTEGER NULL,
            groupement_id INTEGER NOT NULL,
            beneficiary_id INTEGER NOT NULL,
            total_loans INTEGER NULL,
            total_grants_received INTEGER NULL,
            date_sorti_member TEXT NULL,
            total_saving INTEGER NULL,
            total_productives_activities_created INTEGER NULL,
            flag_member_activity INTEGER NULL,
            FOREIGN KEY (groupement_id) REFERENCES espmis_groupements (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_groupements");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_groupements (
            id INTEGER PRIMARY KEY NOT NULL,
            code TEXT NULL,
            label TEXT NULL,
            type_groupement_id INTEGER NULL,
            ounit_groupement_id INTEGER NULL,
            nature_groupement_id INTEGER NULL,
            total_members INTEGER NULL,
            group_created_at TEXT NULL,
            group_terminated_at TEXT NULL,
            groupement_flag INTEGER NULL
          
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_groupements_members");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_groupements_members (
            id INTEGER PRIMARY KEY NOT NULL,
            groupement_id INTEGER NULL,
            beneficiary_id INTEGER NULL,
            terminaison_at TEXT NULL,
            adhesion_at TEXT NULL,
            role TEXT NULL,
            groupement_beneficiary_flag INTEGER NULL
          
            
          )
          ''');
    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_grants");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_grants (
            id INTEGER PRIMARY KEY NOT NULL,
            type_demandeur TEXT NULL,
            program_id INTEGER NULL,
            project_id INTEGER NULL,
            sub_project_id INTEGER NULL,
            cycle_id INTEGER NULL,
            groupement_id INTEGER NULL,
            beneficiary_id INTEGER NULL,
            ounit_id INTEGER NULL,
            grant_amount INTEGER NULL,
            date_granted TEXT NULL,
            date_transferred TEXT NULL,
            date_debited TEXT NULL,
            flag_grant INTEGER NULL
            
          )
          ''');

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS espmis_productives_activities");

    await db.execute('''
          CREATE TABLE IF NOT EXISTS espmis_productives_activities (
            id INTEGER PRIMARY KEY NOT NULL,
            type_financement TEXT NULL,
            type_activite TEXT NULL,
            nature_activite TEXT NULL,
            
            sub_project_id INTEGER NULL,
            
            groupement_id INTEGER NULL,
            beneficiary_id INTEGER NULL,
            ward TEXT NULL,
            amount INTEGER NULL,
            start_date TEXT NULL,
            end_date TEXT NULL,
            
            flag_productive_activity INTEGER NULL
            
          )
          ''');
  }

  // Grant Loading
  Future<int> insertGrants(GrantModel _parsedJson) async {
    Database db = await instance.database;
    var queryGrant = await db.insert("espmis_grants", _parsedJson.toMap());

    return queryGrant;
  }

  // Productives Activities Loading
  Future<int> insertProductivesActivities(
      ProductiveActivityModel _parsedJson) async {
    Database db = await instance.database;
    var queryProductiveActivity =
        await db.insert("espmis_productives_activities", _parsedJson.toMap());

    return queryProductiveActivity;
  }

  //Productive Activity - retrieve by id
  Future<List<ProductiveActivityModel>> fetchProductivesActivities(
      int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_productives_activities",
        columns: ProductiveActivityModel.columns,
        where: "groupement_id = ?",
        whereArgs: [id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return ProductiveActivityModel.fromMap(results[i]);
          })
        : null;
  }

  //Productive Activity - retrieve by id
  Future<List<ProductiveActivityModel>>
      fetchProductivesActivitiesForBeneficiary(int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_productives_activities",
        columns: ProductiveActivityModel.columns,
        where: "beneficiary_id = ?",
        whereArgs: [id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return ProductiveActivityModel.fromMap(results[i]);
          })
        : null;
  }

  //Grant - retrieve by id
  Future<List<GrantModel>> fetchGrants(int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_grants",
        columns: GrantModel.columns,
        where: "groupement_id = ?",
        whereArgs: [id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return GrantModel.fromMap(results[i]);
          })
        : null;
  }

  //Grant - retrieve by id
  Future<List<GrantModel>> fetchGrantsForBeneficiary(int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_grants",
        columns: GrantModel.columns,
        where: "beneficiary_id = ?",
        whereArgs: [id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return GrantModel.fromMap(results[i]);
          })
        : null;
  }

  // Groupements and Activities Loading
  Future<int> insertGroupementsAndActivities(
      GroupementModel _parsedJson) async {
    Database db = await instance.database;
    var queryGroupement =
        await db.insert("espmis_groupements", _parsedJson.toMap());

    if (_parsedJson.activitiesG != null) {
      List<GroupementActivityModel> t = _parsedJson.activitiesG;
      for (var i = 0; i < t.length; i++) {
        if (t[i] != null) {
          var queryGroupementActivities = await db.insert(
              "espmis_groupements_activities", t[i].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    }
    if (_parsedJson.members != null) {
      List<GroupementBeneficiaryModel> m = _parsedJson.members;
      for (var i = 0; i < m.length; i++) {
        if (m[i] != null) {
          var queryMembers = await db.insert(
              "espmis_groupements_members", m[i].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    }

    if (_parsedJson.activitiesM != null) {
      List<MemberActivityModel> t = _parsedJson.activitiesM;
      for (var i = 0; i < t.length; i++) {
        if (t[i] != null) {
          var queryMemberActivities = await db.insert(
              "espmis_members_activities", t[i].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    }

    return queryGroupement;
  }

  //Groupement - insert
  Future<int> insertGroupement(GroupementModel g) async {
    Database db = await database;
    return await db.insert("espmis_groupements", g.toMap());
  }

//Groupement - update
  Future<int> updateGroupement(GroupementModel g) async {
    Database db = await database;
    return await db.update("espmis_groupements", g.toMap(),
        where: '${g.id}=?', whereArgs: [g.id]);
  }

  //Groupement - retrieve by id
  Future<List<GroupementModel>> fetchGroupement(int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_groupements",
        columns: GroupementModel.columns, where: "id = ?", whereArgs: [id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return GroupementModel.fromMap(results[i]);
          })
        : null;
  }

  //Members - retrieve all
  Future<List<Map<String, dynamic>>> fetchMembers(int groupement_id) async {
    Database db = await instance.database;

    String query =
        "SELECT name, role, adhesion_at, terminaison_at, groupement_beneficiary_flag " +
            "FROM espmis_groupements_members g " +
            "JOIN espmis_beneficiaries b ON b.id = g.beneficiary_id " +
            "WHERE g.groupement_id = " +
            groupement_id.toString() +
            "";

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  //Members - retrieve all
  Future<List<Map<String, dynamic>>> fetchMembership(int beneficiary_id) async {
    Database db = await instance.database;

    String query =
        "SELECT label,role, type_groupement_id, adhesion_at, terminaison_at, groupement_beneficiary_flag " +
            "FROM espmis_groupements_members m " +
            "JOIN espmis_beneficiaries b ON b.id = m.beneficiary_id " +
            "JOIN espmis_groupements g ON g.id = m.groupement_id " +
            "WHERE m.beneficiary_id = " +
            beneficiary_id.toString() +
            "";

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  //Grievance - retrieve all
  Future<List<GroupementBeneficiaryModel>> fetchListMembers(
      int groupement_id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_groupements_members",
        columns: GroupementBeneficiaryModel.columns,
        where: "groupement_id = ?",
        whereArgs: [groupement_id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return GroupementBeneficiaryModel.fromMap(results[i]);
          })
        : null;
  }

  //Groupement - retrieve by name
  Future<List<GroupementModel>> fetchGroupementByName(String name) async {
    Database db = await instance.database;

    List<Map> result = await db.query("espmis_groupements",
        columns: GroupementModel.columns,
        where: "label like ?",
        whereArgs: ['%$name%']);

    List<GroupementModel> data = List();
    for (var i = 0; i < result.length; i++) {
      GroupementModel g = GroupementModel.fromMap(result[i]);

      var members = await fetchListMembers(g.id);
      if (members != null) {
        g.members = members;
      } else {
        g.members = null;
      }
      data.add(g);
    }
    return data;
  }

  //Groupement - insert
  Future<int> insertGroupementActivity(GroupementModel g) async {
    Database db = await database;
    return await db.insert("espmis_groupements_activities", g.toMap());
  }

//Groupement Activity - update
  Future<int> updateGroupementActivity(GroupementActivityModel g) async {
    Database db = await database;
    return await db.update("espmis_groupements_activities", g.toMap(),
        where: '${g.id}=?', whereArgs: [g.id]);
  }

  // Helper methods
  //Grievance - insert
  Future<int> insertGrievance(GrievanceModel g) async {
    Database db = await database;
    return await db.insert("espmis_grievances", g.toMap());
  }

//Grievance - update
  Future<int> updateGrievance(GrievanceModel g) async {
    Database db = await database;
    return await db.update("espmis_grievances", g.toMap(),
        where: '${g.id}=?', whereArgs: [g.id]);
  }

//Grievance - delete
  Future<int> deleteGrievance(int id) async {
    Database db = await database;
    return await db.delete("espmis_grievances", where: 'id=?', whereArgs: [id]);
  }

//Grievance - retrieve all
  Future<List<GrievanceModel>> fetchGrievances(int beneficiary_id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_grievances",
        columns: GrievanceModel.columns,
        where: "beneficiary_id = ?",
        whereArgs: [beneficiary_id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return GrievanceModel.fromMap(results[i]);
          })
        : null;
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;

    int result = await db.insert(table, row);
    print("insertion $result   $row ok ");
  }

  Future<int> insertBeneficiariesAndTransactions(
      BeneficiaryModel _parsedJson) async {
    Database db = await instance.database;
    var queryBeneficiary =
        await db.insert("espmis_beneficiaries", _parsedJson.toMap());
    if (_parsedJson.transactions != null) {
      List<TransactionModel> t = _parsedJson.transactions;
      for (var i = 0; i < t.length; i++) {
        if (t[i] != null) {
          var queryTransaction =
              await db.insert("espmis_transactions", t[i].toMap());
        }
      }
    }

    if (_parsedJson.grievances != null) {
      List<GrievanceModel> g = _parsedJson.grievances;
      for (var i = 0; i < g.length; i++) {
        if (g[i] != null) {
          var queryGrievance =
              await db.insert("espmis_grievances", g[i].toMap());
        }
      }
    }

    return queryBeneficiary;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;

    return await db.query(table);
  }

  Future<List<BeneficiaryModel>> fetchAllBeneficiaries() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query("espmis_beneficiaries");
    List<BeneficiaryModel> data = List();
    for (var i = 0; i < result.length; i++) {
      BeneficiaryModel b = BeneficiaryModel.fromMap(result[i]);
      b.transactions = await fetchTransactions(b.id);
      b.grievances = await fetchGrievances(b.id);
      data.add(b);
    }

    return data;
  }

  Future<List<Map>> fetchQuery(String query) async {
    Database db = await instance.database;
    return await db.rawQuery(query);
  }

  Future<BeneficiaryModel> fetchBeneficiaryAndTransaction(
      int beneficiary_id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("story",
        columns: BeneficiaryModel.columns,
        where: "id = ?",
        whereArgs: [beneficiary_id]);

    BeneficiaryModel b = BeneficiaryModel.fromMap(results[0]);
    b.transactions = await fetchTransactions(b.id);

    return b;
  }

  Future<BeneficiaryModel> fetchBeneficairyById(int id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_beneficiaries",
        columns: BeneficiaryModel.columns, where: "id = ?", whereArgs: [id]);
    return results.isNotEmpty ? BeneficiaryModel.fromMap(results[0]) : null;
  }

  Future<List<BeneficiaryModel>> fetchBeneficairyByName(String name) async {
    Database db = await instance.database;

    List<Map> result = await db.query("espmis_beneficiaries",
        columns: BeneficiaryModel.columns,
        where: "name like ?",
        whereArgs: ['$name%']);

    List<BeneficiaryModel> data = List();
    for (var i = 0; i < result.length; i++) {
      BeneficiaryModel b = BeneficiaryModel.fromMap(result[i]);
      var result2 = await fetchTransactions(b.id);
      if (result2 != null) {
        b.transactions = result2;
      } else {
        b.transactions = null;
      }
      //b.transactions = await fetchTransactions(b.id);
      data.add(b);
    }
    return data;
  }

  Future<BeneficiaryModel> fetchBeneficairyByBarcode(
      List<String> barcode) async {
    Database db = await instance.database;
    List<Map> result = await db.query("espmis_beneficiaries",
        columns: BeneficiaryModel.columns,
        where: "id = ? and householdid = ? and individualid = ?",
        whereArgs: [barcode[0], barcode[1], barcode[2]]);
    if (result != null) {
      BeneficiaryModel b = BeneficiaryModel.fromMap(result[0]);
      var result2 = await fetchTransactionNotPaid(b.id);
      if (result2 != null) {
        b.transactions = result2;
      } else {
        b.transactions = null;
      }
      print("B :" + b.individualid);
      return b;
    } else
      return null;
  }

  Future<List<Map<String, dynamic>>> fetchTransactionsToBeSync() async {
    Database db = await instance.database;
    String query =
        "SELECT t.id as benefitbeneficiary_id,t.beneficiary_id as beneficiary_id,t.benefit_id as benefit_id, t.benefitlist_id as benefitlist_id, t.cycle_id as cycle_id,t.site_id as site_id,t.transaction_site as siteLabel, t.transaction_status as benefit_flag, t.transaction_new_status as new_benefit_flag, t.transaction_scan_date as synchronization_date, t.transaction_date as transaction_date, " +
            "b.name as name FROM espmis_beneficiaries b JOIN espmis_transactions t ON b.id = t.beneficiary_id WHERE transaction_new_status = '1'  ";

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  Future<List<Map<String, dynamic>>> fetchGrievancesToBeSync() async {
    Database db = await instance.database;
    String query =
        "SELECT g.id as id, g.beneficiary_id as beneficiary_id, g.site_id as guichet_id,g.description as description,g.grievance_date as grievance_date, g.grievance_types_id as grievance_types_id, g.grievance_categories_id as grievance_categories_id, g.grievance_flag as grievance_flag,g.grievance_sync_date as grievance_sync_date," +
            "b.name as name FROM espmis_beneficiaries b JOIN espmis_grievances g ON b.id = g.beneficiary_id  ";

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  Future<List<Map<String, dynamic>>> fetchTransactionsToBePaid() async {
    Database db = await instance.database;
    String query =
        "SELECT t.id as benefitbeneficiary_id,t.beneficiary_id as beneficiary_id,t.benefit_id as benefit_id, t.benefitlist_id as benefitlist_id, t.cycle_id as cycle_id,t.site_id as site_id,t.transaction_site as siteLabel, t.transaction_status as benefit_flag, t.transaction_new_status as new_benefit_flag, t.transaction_scan_date as synchronization_date, t.transaction_date as transaction_date, " +
            "b.name as name FROM espmis_beneficiaries b JOIN espmis_transactions t ON b.id = t.beneficiary_id WHERE transaction_status = '2' ";

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  Future<List<TransactionModel>> fetchTransactionNotPaid(
      int beneficiary_id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_transactions",
        columns: TransactionModel.columns,
        where:
            "beneficiary_id = ? and transaction_status = ? and transaction_new_status = ?",
        whereArgs: [beneficiary_id, "2", ""]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return TransactionModel.fromMap(results[i]);
          })
        : null;
  }

  Future<List<TransactionModel>> fetchTransactions(int beneficiary_id) async {
    Database db = await instance.database;
    List<Map> results = await db.query("espmis_transactions",
        columns: TransactionModel.columns,
        where: "beneficiary_id = ?",
        whereArgs: [beneficiary_id]);

    return results.isNotEmpty
        ? List.generate(results.length, (i) {
            return TransactionModel.fromMap(results[i]);
          })
        : null;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<String> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $table'))
        .toString();
  }

  Future<String> queryTransactionToDo() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM espmis_transactions WHERE transaction_new_status = '' and transaction_status = '2' "))
        .toString();
  }

  Future<String> queryTransactionToSync() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM  espmis_transactions WHERE transaction_new_status = '1' and transaction_scan_date = ''"))
        .toString();
  }

  Future<String> queryTransactionSync() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM  espmis_transactions WHERE transaction_new_status = '1' and transaction_scan_date <> '' "))
        .toString();
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row["id"];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTransactions(List<TransactionModel> t) async {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    Database db = await instance.database;
    for (var i = 0; i < t.length; i++) {
      await db.transaction((txn) async {
        return await txn.rawUpdate(
            "UPDATE espmis_transactions set transaction_new_status = '1', transaction_date = '" +
                dateParse.toIso8601String() +
                "' WHERE id = " +
                t[i].id.toString());
      });
    }
  }

  Future<int> updateTransactionById(int t) async {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    Database db = await instance.database;

    await db.transaction((txn) async {
      return await txn.rawUpdate(
          "UPDATE espmis_transactions set transaction_scan_date = '" +
              dateParse.toIso8601String() +
              "' WHERE id = $t ");
    });
  }

  Future<int> updateGrievanceById(int t) async {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    Database db = await instance.database;

    await db.transaction((txn) async {
      return await txn.rawUpdate(
          "UPDATE espmis_grievances set grievance_flag = '1',grievance_sync_date = '" +
              dateParse.toIso8601String() +
              "' WHERE id = $t ");
    });
  }

  Future<int> updateGroupmentId({
    int groupmentID,
    int soldeCumulatedSaving,
    int solde_actual_saving,
    int total_saving,
    int total_new_members_actif,
    int total_excluded_members,
    int total_members,
    int loan_cumulated_actual,
    int total_new_loans,
    int total_grants_received,
    int total_grant_amount,
    int total_productives_activities_created,
    int groupement_activity_flag,
  }) async {
    Database db = await instance.database;

    int i=await db.transaction((txn) async {
      return await txn.rawUpdate(
          "UPDATE espmis_groupements_activities set solde_cumulated_saving = '$soldeCumulatedSaving',solde_actual_saving = '$solde_actual_saving',total_saving = '$total_saving',total_new_members_actif = '$total_new_members_actif',total_excluded_members = '$total_excluded_members',total_members = '$total_members',loan_cumulated_actual = '$loan_cumulated_actual',total_new_loans = '$total_new_loans',total_grants_received = '$total_grants_received',total_grant_amount = '$total_grant_amount',total_productives_activities_created = '$total_productives_activities_created',groupement_activity_flag = '$groupement_activity_flag' WHERE groupement_id = $groupmentID ");
    });

    return i;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  void clearAll(table) async {
    Database db = await instance.database;
    await db.transaction((txn) async {
      int n = await txn.rawDelete("DELETE FROM $table");
      print('$table deleted - $n rows');
    });
  }

  Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

  Future closeDb() async {
    Database db = await instance.database;
    db.close();
  }
}
