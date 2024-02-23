// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TeamDao? _teamDaoInstance;

  PlayerSoccerDao? _playerSoccerDaoInstance;

  GameDao? _gameDaoInstance;

  PlayerInTeamDao? _playerInTeamDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlayerSoccer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `level` INTEGER NOT NULL, `gols` INTEGER NOT NULL, `partidas` INTEGER NOT NULL, `idTeam` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Team` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `image` TEXT NOT NULL, `gol` INTEGER NOT NULL, `totalGolGames` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Game` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `idTeam1` INTEGER NOT NULL, `idTeam2` INTEGER NOT NULL, `dateTimeInit` TEXT NOT NULL, `dateTimeFinish` TEXT NOT NULL, `dateTimeCreated` TEXT NOT NULL, `minuteTimeGame` INTEGER NOT NULL, `time` INTEGER NOT NULL, `maxTime` INTEGER NOT NULL, `initGame` INTEGER NOT NULL, `finished` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlayerInTeam` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `gameId` INTEGER NOT NULL, `playerId` INTEGER NOT NULL, `teamId` INTEGER NOT NULL, `gol` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TeamDao get teamDao {
    return _teamDaoInstance ??= _$TeamDao(database, changeListener);
  }

  @override
  PlayerSoccerDao get playerSoccerDao {
    return _playerSoccerDaoInstance ??=
        _$PlayerSoccerDao(database, changeListener);
  }

  @override
  GameDao get gameDao {
    return _gameDaoInstance ??= _$GameDao(database, changeListener);
  }

  @override
  PlayerInTeamDao get playerInTeamDao {
    return _playerInTeamDaoInstance ??=
        _$PlayerInTeamDao(database, changeListener);
  }
}

class _$TeamDao extends TeamDao {
  _$TeamDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _teamInsertionAdapter = InsertionAdapter(
            database,
            'Team',
            (Team item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'gol': item.gol,
                  'totalGolGames': item.totalGolGames
                }),
        _teamUpdateAdapter = UpdateAdapter(
            database,
            'Team',
            ['id'],
            (Team item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'gol': item.gol,
                  'totalGolGames': item.totalGolGames
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Team> _teamInsertionAdapter;

  final UpdateAdapter<Team> _teamUpdateAdapter;

  @override
  Future<List<Team>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Team',
        mapper: (Map<String, Object?> row) => Team(
            id: row['id'] as int?,
            name: row['name'] as String,
            image: row['image'] as String,
            gol: row['gol'] as int,
            totalGolGames: row['totalGolGames'] as int));
  }

  @override
  Future<List<Team>> getTeamInName(
    String name,
    String image,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Team WHERE name = ?1 AND image = ?2',
        mapper: (Map<String, Object?> row) => Team(
            id: row['id'] as int?,
            name: row['name'] as String,
            image: row['image'] as String,
            gol: row['gol'] as int,
            totalGolGames: row['totalGolGames'] as int),
        arguments: [name, image]);
  }

  @override
  Future<List<Team>> getTeamInGame(List<int> teams) async {
    const offset = 1;
    final _sqliteVariablesForTeams =
        Iterable<String>.generate(teams.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM Team WHERE id IN (' + _sqliteVariablesForTeams + ')',
        mapper: (Map<String, Object?> row) => Team(
            id: row['id'] as int?,
            name: row['name'] as String,
            image: row['image'] as String,
            gol: row['gol'] as int,
            totalGolGames: row['totalGolGames'] as int),
        arguments: [...teams]);
  }

  @override
  Future<int> insertItem(Team team) {
    return _teamInsertionAdapter.insertAndReturnId(
        team, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Team team) {
    return _teamUpdateAdapter.updateAndReturnChangedRows(
        team, OnConflictStrategy.abort);
  }
}

class _$PlayerSoccerDao extends PlayerSoccerDao {
  _$PlayerSoccerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _playerSoccerInsertionAdapter = InsertionAdapter(
            database,
            'PlayerSoccer',
            (PlayerSoccer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'gols': item.gols,
                  'partidas': item.partidas,
                  'idTeam': item.idTeam
                }),
        _playerSoccerUpdateAdapter = UpdateAdapter(
            database,
            'PlayerSoccer',
            ['id'],
            (PlayerSoccer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'gols': item.gols,
                  'partidas': item.partidas,
                  'idTeam': item.idTeam
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlayerSoccer> _playerSoccerInsertionAdapter;

  final UpdateAdapter<PlayerSoccer> _playerSoccerUpdateAdapter;

  @override
  Future<List<PlayerSoccer>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM PlayerSoccer',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            gols: row['gols'] as int,
            partidas: row['partidas'] as int,
            idTeam: row['idTeam'] as int));
  }

  @override
  Future<List<PlayerSoccer>> getAllNotTeam() async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlayerSoccer WHERE idTeam = -1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            gols: row['gols'] as int,
            partidas: row['partidas'] as int,
            idTeam: row['idTeam'] as int));
  }

  @override
  Future<List<PlayerSoccer>> getAllInName(String name) async {
    return _queryAdapter.queryList('SELECT * FROM PlayerSoccer WHERE name = ?1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            gols: row['gols'] as int,
            partidas: row['partidas'] as int,
            idTeam: row['idTeam'] as int),
        arguments: [name]);
  }

  @override
  Future<List<PlayerSoccer>> getAllInTeam(int team) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlayerSoccer WHERE idTeam = ?1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            gols: row['gols'] as int,
            partidas: row['partidas'] as int,
            idTeam: row['idTeam'] as int),
        arguments: [team]);
  }

  @override
  Future<int> insertItem(PlayerSoccer item) {
    return _playerSoccerInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(PlayerSoccer item) {
    return _playerSoccerUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

class _$GameDao extends GameDao {
  _$GameDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _gameInsertionAdapter = InsertionAdapter(
            database,
            'Game',
            (Game item) => <String, Object?>{
                  'id': item.id,
                  'idTeam1': item.idTeam1,
                  'idTeam2': item.idTeam2,
                  'dateTimeInit': item.dateTimeInit,
                  'dateTimeFinish': item.dateTimeFinish,
                  'dateTimeCreated': item.dateTimeCreated,
                  'minuteTimeGame': item.minuteTimeGame,
                  'time': item.time,
                  'maxTime': item.maxTime,
                  'initGame': item.initGame ? 1 : 0,
                  'finished': item.finished ? 1 : 0
                }),
        _gameUpdateAdapter = UpdateAdapter(
            database,
            'Game',
            ['id'],
            (Game item) => <String, Object?>{
                  'id': item.id,
                  'idTeam1': item.idTeam1,
                  'idTeam2': item.idTeam2,
                  'dateTimeInit': item.dateTimeInit,
                  'dateTimeFinish': item.dateTimeFinish,
                  'dateTimeCreated': item.dateTimeCreated,
                  'minuteTimeGame': item.minuteTimeGame,
                  'time': item.time,
                  'maxTime': item.maxTime,
                  'initGame': item.initGame ? 1 : 0,
                  'finished': item.finished ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Game> _gameInsertionAdapter;

  final UpdateAdapter<Game> _gameUpdateAdapter;

  @override
  Future<List<Game>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Game',
        mapper: (Map<String, Object?> row) => Game(
            id: row['id'] as int?,
            idTeam1: row['idTeam1'] as int,
            idTeam2: row['idTeam2'] as int,
            dateTimeInit: row['dateTimeInit'] as String,
            dateTimeFinish: row['dateTimeFinish'] as String,
            minuteTimeGame: row['minuteTimeGame'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int,
            dateTimeCreated: row['dateTimeCreated'] as String,
            initGame: (row['initGame'] as int) != 0,
            finished: (row['finished'] as int) != 0));
  }

  @override
  Future<List<Game>> getAllNoFinish() async {
    return _queryAdapter.queryList('SELECT * FROM Game WHERE finished = 0',
        mapper: (Map<String, Object?> row) => Game(
            id: row['id'] as int?,
            idTeam1: row['idTeam1'] as int,
            idTeam2: row['idTeam2'] as int,
            dateTimeInit: row['dateTimeInit'] as String,
            dateTimeFinish: row['dateTimeFinish'] as String,
            minuteTimeGame: row['minuteTimeGame'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int,
            dateTimeCreated: row['dateTimeCreated'] as String,
            initGame: (row['initGame'] as int) != 0,
            finished: (row['finished'] as int) != 0));
  }

  @override
  Future<Game?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Game WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => Game(
            id: row['id'] as int?,
            idTeam1: row['idTeam1'] as int,
            idTeam2: row['idTeam2'] as int,
            dateTimeInit: row['dateTimeInit'] as String,
            dateTimeFinish: row['dateTimeFinish'] as String,
            minuteTimeGame: row['minuteTimeGame'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int,
            dateTimeCreated: row['dateTimeCreated'] as String,
            initGame: (row['initGame'] as int) != 0,
            finished: (row['finished'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<int> insertItem(Game item) {
    return _gameInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Game item) {
    return _gameUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

class _$PlayerInTeamDao extends PlayerInTeamDao {
  _$PlayerInTeamDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _playerInTeamInsertionAdapter = InsertionAdapter(
            database,
            'PlayerInTeam',
            (PlayerInTeam item) => <String, Object?>{
                  'id': item.id,
                  'gameId': item.gameId,
                  'playerId': item.playerId,
                  'teamId': item.teamId,
                  'gol': item.gol
                }),
        _playerInTeamUpdateAdapter = UpdateAdapter(
            database,
            'PlayerInTeam',
            ['id'],
            (PlayerInTeam item) => <String, Object?>{
                  'id': item.id,
                  'gameId': item.gameId,
                  'playerId': item.playerId,
                  'teamId': item.teamId,
                  'gol': item.gol
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlayerInTeam> _playerInTeamInsertionAdapter;

  final UpdateAdapter<PlayerInTeam> _playerInTeamUpdateAdapter;

  @override
  Future<List<PlayerInTeam>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM PlayerInTeam',
        mapper: (Map<String, Object?> row) => PlayerInTeam(
            id: row['id'] as int?,
            gameId: row['gameId'] as int,
            playerId: row['playerId'] as int,
            teamId: row['teamId'] as int,
            gol: row['gol'] as int));
  }

  @override
  Future<PlayerInTeam?> findPlayerInTeam(
    int gameId,
    int playerId,
    int teamId,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM PlayerInTeam WHERE gameId = ?1 AND playerId = ?2 AND teamId = ?3 LIMIT 1',
        mapper: (Map<String, Object?> row) => PlayerInTeam(id: row['id'] as int?, gameId: row['gameId'] as int, playerId: row['playerId'] as int, teamId: row['teamId'] as int, gol: row['gol'] as int),
        arguments: [gameId, playerId, teamId]);
  }

  @override
  Future<int> insertItem(PlayerInTeam item) {
    return _playerInTeamInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(PlayerInTeam item) {
    return _playerInTeamUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}
