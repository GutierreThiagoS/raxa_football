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

  ConfigurationDao? _configurationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Configuration` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `minuteTimerGame` INTEGER NOT NULL, `qtdPlayers` INTEGER NOT NULL, `time` INTEGER NOT NULL, `maxTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlayerSoccer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `level` INTEGER NOT NULL, `presented` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Team` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `image` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Game` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `idTeam1` INTEGER NOT NULL, `idTeam2` INTEGER NOT NULL, `dateTimeInit` TEXT NOT NULL, `dateTimeFinish` TEXT NOT NULL, `dateTimeCreated` TEXT NOT NULL, `minuteTimeGame` INTEGER NOT NULL, `time` INTEGER NOT NULL, `maxTime` INTEGER NOT NULL, `initGame` INTEGER NOT NULL, `finished` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlayerInTeam` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `gameId` INTEGER NOT NULL, `playerId` INTEGER NOT NULL, `name` TEXT NOT NULL, `teamId` INTEGER NOT NULL, `goals` INTEGER NOT NULL)');

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

  @override
  ConfigurationDao get configurationDao {
    return _configurationDaoInstance ??=
        _$ConfigurationDao(database, changeListener);
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
                  'image': item.image
                }),
        _teamUpdateAdapter = UpdateAdapter(
            database,
            'Team',
            ['id'],
            (Team item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image
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
            image: row['image'] as String));
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
            image: row['image'] as String),
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
            image: row['image'] as String),
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
                  'presented': item.presented ? 1 : 0
                }),
        _playerSoccerUpdateAdapter = UpdateAdapter(
            database,
            'PlayerSoccer',
            ['id'],
            (PlayerSoccer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'presented': item.presented ? 1 : 0
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
            presented: (row['presented'] as int) != 0));
  }

  @override
  Future<List<PlayerSoccer>> getAllNotTeam() async {
    return _queryAdapter.queryList(
        'SELECT PS.* FROM PlayerSoccer PS WHERE NOT EXISTS (SELECT * FROM PlayerInTeam PI INNER JOIN Team T ON PI.teamId = T.id INNER JOIN Game G ON G.id = PI.gameId WHERE PI.playerId = PS.id AND G.finished = 0 )',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            presented: (row['presented'] as int) != 0));
  }

  @override
  Future<List<PlayerSoccer>> getAllInName(String name) async {
    return _queryAdapter.queryList('SELECT * FROM PlayerSoccer WHERE name = ?1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            presented: (row['presented'] as int) != 0),
        arguments: [name]);
  }

  @override
  Future<PlayerSoccer?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM PlayerSoccer WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            presented: (row['presented'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<PlayerSoccer?> getById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM PlayerSoccer WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            presented: (row['presented'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<PlayerSoccer>> getAllInTeam(int team) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlayerSoccer WHERE idTeam = ?1',
        mapper: (Map<String, Object?> row) => PlayerSoccer(
            id: row['id'] as int?,
            name: row['name'] as String,
            level: row['level'] as int,
            presented: (row['presented'] as int) != 0),
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
                  'name': item.name,
                  'teamId': item.teamId,
                  'goals': item.goals
                }),
        _playerInTeamUpdateAdapter = UpdateAdapter(
            database,
            'PlayerInTeam',
            ['id'],
            (PlayerInTeam item) => <String, Object?>{
                  'id': item.id,
                  'gameId': item.gameId,
                  'playerId': item.playerId,
                  'name': item.name,
                  'teamId': item.teamId,
                  'goals': item.goals
                }),
        _playerInTeamDeletionAdapter = DeletionAdapter(
            database,
            'PlayerInTeam',
            ['id'],
            (PlayerInTeam item) => <String, Object?>{
                  'id': item.id,
                  'gameId': item.gameId,
                  'playerId': item.playerId,
                  'name': item.name,
                  'teamId': item.teamId,
                  'goals': item.goals
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlayerInTeam> _playerInTeamInsertionAdapter;

  final UpdateAdapter<PlayerInTeam> _playerInTeamUpdateAdapter;

  final DeletionAdapter<PlayerInTeam> _playerInTeamDeletionAdapter;

  @override
  Future<List<PlayerInTeam>> getAllInIdGameAndTeamId(
    int idGame,
    int idTeam,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlayerInTeam WHERE gameId = ?1 AND teamId = ?2',
        mapper: (Map<String, Object?> row) => PlayerInTeam(
            id: row['id'] as int?,
            gameId: row['gameId'] as int,
            playerId: row['playerId'] as int,
            name: row['name'] as String,
            teamId: row['teamId'] as int,
            goals: row['goals'] as int),
        arguments: [idGame, idTeam]);
  }

  @override
  Future<List<Team>> getIdTeamsInPlayerInTeam(int idGame) async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT T.* FROM Team T LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id WHERE gameId = ?1',
        mapper: (Map<String, Object?> row) => Team(id: row['id'] as int?, name: row['name'] as String, image: row['image'] as String),
        arguments: [idGame]);
  }

  @override
  Future<Team?> getTeamInPlayer(int playerId) async {
    return _queryAdapter.query(
        'SELECT T.* FROM Team T LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id INNER JOIN Game G ON G.id = PI.gameId WHERE PI.playerId = ?1 AND G.finished = 0 LIMIT 1',
        mapper: (Map<String, Object?> row) => Team(id: row['id'] as int?, name: row['name'] as String, image: row['image'] as String),
        arguments: [playerId]);
  }

  @override
  Future<int?> getTeamInPlayerId(int playerId) async {
    return _queryAdapter.query(
        'SELECT T.id FROM Team T LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id INNER JOIN Game G ON G.id = PI.gameId WHERE PI.playerId = ?1 AND G.finished = 0 LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [playerId]);
  }

  @override
  Future<PlayerInTeam?> getPlayerInTeamNotFinish(int playerId) async {
    return _queryAdapter.query(
        'SELECT PI.* FROM PlayerInTeam PI LEFT JOIN Team T ON PI.teamId = T.id INNER JOIN Game G ON G.id = PI.gameId WHERE PI.playerId = ?1 AND G.finished = 0 LIMIT 1',
        mapper: (Map<String, Object?> row) => PlayerInTeam(id: row['id'] as int?, gameId: row['gameId'] as int, playerId: row['playerId'] as int, name: row['name'] as String, teamId: row['teamId'] as int, goals: row['goals'] as int),
        arguments: [playerId]);
  }

  @override
  Future<List<Team>> getAllTeamInPlayer(int idTeam) async {
    return _queryAdapter.queryList(
        'SELECT T.* FROM Team T LEFT JOIN PlayerInTeam PI ON PI.teamId = T.id INNER JOIN Game G ON G.id = PI.gameId WHERE PI.teamId = ?1 AND G.finished = 0',
        mapper: (Map<String, Object?> row) => Team(id: row['id'] as int?, name: row['name'] as String, image: row['image'] as String),
        arguments: [idTeam]);
  }

  @override
  Future<List<int>> getTotalGoals(int playerId) async {
    return _queryAdapter.queryList(
        'SELECT goals FROM PlayerInTeam WHERE playerId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [playerId]);
  }

  @override
  Future<int?> getTotalGamesCount(int playerId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM PlayerInTeam WHERE playerId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [playerId]);
  }

  @override
  Future<PlayerInTeam?> findPlayerInTeam(
    int gameId,
    int playerId,
    int teamId,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM PlayerInTeam WHERE playerId = ?2 AND teamId = ?3 AND gameId = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => PlayerInTeam(id: row['id'] as int?, gameId: row['gameId'] as int, playerId: row['playerId'] as int, name: row['name'] as String, teamId: row['teamId'] as int, goals: row['goals'] as int),
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

  @override
  Future<int> deleteItem(PlayerInTeam item) {
    return _playerInTeamDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$ConfigurationDao extends ConfigurationDao {
  _$ConfigurationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _configurationInsertionAdapter = InsertionAdapter(
            database,
            'Configuration',
            (Configuration item) => <String, Object?>{
                  'id': item.id,
                  'minuteTimerGame': item.minuteTimerGame,
                  'qtdPlayers': item.qtdPlayers,
                  'time': item.time,
                  'maxTime': item.maxTime
                }),
        _configurationUpdateAdapter = UpdateAdapter(
            database,
            'Configuration',
            ['id'],
            (Configuration item) => <String, Object?>{
                  'id': item.id,
                  'minuteTimerGame': item.minuteTimerGame,
                  'qtdPlayers': item.qtdPlayers,
                  'time': item.time,
                  'maxTime': item.maxTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Configuration> _configurationInsertionAdapter;

  final UpdateAdapter<Configuration> _configurationUpdateAdapter;

  @override
  Future<List<Configuration>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Configuration',
        mapper: (Map<String, Object?> row) => Configuration(
            id: row['id'] as int,
            minuteTimerGame: row['minuteTimerGame'] as int,
            qtdPlayers: row['qtdPlayers'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int));
  }

  @override
  Future<List<Configuration>> getAllNoFinish() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Configuration WHERE finished = 0',
        mapper: (Map<String, Object?> row) => Configuration(
            id: row['id'] as int,
            minuteTimerGame: row['minuteTimerGame'] as int,
            qtdPlayers: row['qtdPlayers'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int));
  }

  @override
  Future<Configuration?> findById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM Configuration WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => Configuration(
            id: row['id'] as int,
            minuteTimerGame: row['minuteTimerGame'] as int,
            qtdPlayers: row['qtdPlayers'] as int,
            time: row['time'] as int,
            maxTime: row['maxTime'] as int),
        arguments: [id]);
  }

  @override
  Future<int> insertItem(Configuration item) {
    return _configurationInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateItem(Configuration item) {
    return _configurationUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}
