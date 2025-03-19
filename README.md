# flutter_jr_sample


## 概要
Flutter Jr. ハッカソンの参考用リポジトリです。
TODO アプリが
- StatefulWidget を使った実装 (``lib/riverpod/``)
- Riverpod を使った実装 (``lib/stateful/``)
の2パターンで作成されています。

## アプリの内容
### 概要
- 1ページ ＋ 1ボトムシートで構成される基本的な TODO アプリです。
- Firebase Firestore と接続し、基本的な CRUD 操作が実装されています。

| ページ | ボトムシート |
|--------|------------|
| <img src="https://github.com/user-attachments/assets/7237c45b-c1df-4ec8-97fa-ef5b8ab202c6" width="200px" /> | <img src="https://github.com/user-attachments/assets/69b5f74d-22bc-4d72-871f-60dd58987e4f" width="200px" /> |

### ページ
現在登録されている TODO が一覧で表示できます。
ステータスの変更、削除を行うことができます。

<img src="https://github.com/user-attachments/assets/0ed7e466-7e37-4bee-88bd-7235d0cc0dea" width="200px" />  

### ボトムシート
TODO の新規作成を行うことができます。
TODO は、タイトル、説明、カテゴリー、締切日時で構成されています。

<img src="https://github.com/user-attachments/assets/4c8e8bb7-c7de-44f9-bff6-0e9df7069e8a" width="200px" /> 

## 使い方
- Flutter プロジェクトの概観を把握したいときや、ハッカソン中の実装に困ったときに参考にしてください。
- StatefulWidget の実装はシンプルな実装になっていますが、一般的に拡張性が低い実装になっています。
- Riverpod の実装は少しとっつきづらい実装になっていますが、拡張性を担保して実装したつもりです。
- チーム内でどのような構成で開発するか決定し、適宜参考にしてください。



## StatefulWidget　バージョン

このTodoアプリケーションは、**StatefulWidget**を利用してUIの状態とロジックを管理しています。Riverpodやコード生成を使わず、**状態管理の責務をUIクラス側が直接担う**形となります。Firestoreへは`TodoLogic`クラスを介してアクセスし、データ取得や更新を行います。

---

### ディレクトリ構成

- **view.dart**  
  StatefulWidgetによるUI（プレゼンテーション＆簡易状態管理）
- **repository.dart**  
  Firestoreとやりとりするロジッククラス
- **entity.dart**  
  Todoモデル定義

---

### プレゼンテーション層

#### HomePage (view.dart)
- `StatefulWidget`で、`initState()`内でFirestoreからTodoリストをロード。結果を`_todos`リストと`_isLoading`フラグに保持。
- ユーザー操作に応じて`_addNewTask`や`_deleteTask`などのメソッドを呼び、Firestoreへの反映＋`setState()`でUIを更新。

```dart
class _HomePageState extends State<HomePage> {
  final _todoLogic = TodoLogic();
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoLogic.getTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  Future<void> _addNewTask(Todo todo) async {
    final id = await _todoLogic.addNewTask(todo);
    setState(() {
      _todos.add(todo.copyWith(id: id));
    });
  }

  // ...
}
```

### ロジック層 (Repository)

#### TodoLogic (repository.dart)
- Firestoreと直接やりとりするクラス。シングルトンパターンで1インスタンスを使い回します。
- `getTodos()`、`addNewTask()`、`deleteTask()`、`updateTask()`などのメソッドを通じてCRUDを行う。

```dart
class TodoLogic {
  factory TodoLogic() => _instance;
  TodoLogic._internal();
  static final TodoLogic _instance = TodoLogic._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Todo> get collection =>
      _db.collection(Todo.collectionName).withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  Future<List<Todo>> getTodos() async {
    return collection
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<String> addNewTask(Todo todo) async {
    final docRef = await collection.add(todo);
    await docRef.update({'id': docRef.id});
    return docRef.id;
  }

  Future<void> deleteTask(String id) async {
    await collection.doc(id).delete();
  }

  Future<void> updateTask(String id, {required bool isDone}) async {
    await collection.doc(id).update({'isDone': isDone});
  }
}
```

### ドメインモデル層 (エンティティ)

#### Todo (entity.dart)
- Todoクラスがタスクの情報を保持。Firestore用のJSON変換ロジックを組み込み。
- `copyWith`メソッドを手動実装し、各フィールドの差し替えを容易にする。

```dart
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isDone,
    this.limitAt,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final bool isDone;
  final DateTime? limitAt;

  static const String collectionName = 'todos';

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        isDone: json['isDone'] as bool,
        limitAt: json['limitAt'] != null
            ? const TimestampConverter().fromJson(json['limitAt'] as Timestamp)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'isDone': isDone,
        'limitAt': limitAt != null
            ? const TimestampConverter().toJson(limitAt)
            : null,
      };

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isDone,
    DateTime? limitAt,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        isDone: isDone ?? this.isDone,
        limitAt: limitAt ?? this.limitAt,
      );
}
```

### 処理の流れ

1. **画面起動 (initState)**
   - `_loadTodos()`がFirestoreからデータを取得し、結果を`_todos`に代入。
2. **UI表示**
   - `_isLoading`が`false`になったらリスト表示を行う。
3. **タスク追加**
   - + New Taskボタン押下 → `addNewTask()` → Firestore登録 → 成功後に`_todos`更新。
4. **タスク削除・完了**
   - `deleteTask()` or `updateTask()`を呼んでFirestore更新 → `setState()`でUI再構築。

### まとめ

- `HomePage`(`StatefulWidget`)がロジッククラス(`TodoLogic`)を直接呼び出し、Firestore操作とUI更新を行います。
- すべての状態はWidget内(`_todos`など)で保持し、単純な構造ながらコンポーネント間の依存が増えやすいデメリットもあります。
- それでもFirestoreとの連携は`TodoLogic`が隠蔽し、`Todo`エンティティでデータ構造を定義することで、最低限の責務分割を実現しています。






## Riverpod バージョン

このTodoアプリケーションは、**プレゼンテーション層**・**アプリケーション(ロジック)層**・**データ層**の三つの責務を分離して設計されています。FlutterとRiverpodを組み合わせており、Firestoreをデータソースに利用しながらTodoの状態を管理しています。

### ディレクトリ構成

- **view.dart**  
  UI描画（プレゼンテーション層）
- **vm.dart**  
  ViewModel（アプリケーション層 / ロジック層）
- **entity.dart**  
  ドメインモデル定義（Todoエンティティ）
- **repository.dart**  
  データ層（Firestoreからの取得・更新）

### プレゼンテーション層

#### HomePage (view.dart)

- `ConsumerWidget`を継承し、Riverpodの`WidgetRef`を利用してTodo一覧を取得。
- `ref.watch(todoListPageViewModelProvider)`によって`vm.dart`が提供するステートを監視し、`data`・`loading`・`error`に応じたUIを表示。
- ユーザーが新規Todoを追加するボタンを押すと、モーダルボトムシートを開いて新規作成画面へ遷移。

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  return ref.watch(todoListPageViewModelProvider).when(
    data: (data) => Scaffold(
      // UI
    ),
    loading: () => const CircularProgressIndicator(),
    error: (error, stackTrace) => Text(error.toString()),
  );
}
```

### アプリケーション層 (ViewModel)

#### TodoListPageViewModel (vm.dart)

- `@riverpod`のコード生成を利用し、`TodoListPageViewModelProvider`を定義。
- `build()`メソッド内でFirestoreからTodoデータを取得し、`TodoListPageState`にまとめて返却。
- 新規Todoや削除などの操作メソッドを持ち、操作後にキャッシュを更新してUIに反映。

```dart
@riverpod
class TodoListPageViewModel extends _$TodoListPageViewModel {
  Future<TodoListPageState> build() async {
    // Firestoreから取得またはキャッシュ参照
  }
  
  Future<void> addNewTask(Todo todo) async {
    // Repository呼び出し後にキャッシュ更新
  }
  // deleteTask, completeTask など
}
```

### ドメインモデル層 (エンティティ)

#### Todo (entity.dart)

- `id`, `title`, `description`, `category`, `isDone`, `limitAt`などを保持。
- `freezed`と`json_serializable`を利用し、イミュータブルなデータクラスとFirestore用のJSONコンバータを自動生成。

```dart
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required String description,
    required String category,
    required bool isDone,
    DateTime? limitAt,
  }) = _Todo;
  
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  
  static String collectionName = 'todos';
}
```

### データ層 (Repository)

#### TodoRepository (repository.dart)

- Firestoreとやりとりする責務を持つクラス。RiverpodのRefを介しFirebaseFirestoreインスタンスを取得。
- 新規追加・削除・更新などのCRUD操作と、それに対応したキャッシュ(`todoRepoCacheProvider`)の更新を実行。
- `todoRepoCacheProvider`はMap形式でTodoを管理し、FirestoreへのI/Oを減らす。

```dart
class TodoRepository {
  CollectionReference<Todo> get collection => _ref
    .read(firestoreProvider)
    .collection(Todo.collectionName)
    .withConverter<Todo>(...);
    
  Future<List<Todo>> getTodos() async {
    // Firestoreから取得
  }
  
  Future<void> addNewTask(Todo todo) async {
    // Firestoreに追加
  }
  // deleteTask, updateTask など
}
```

### 処理の流れ

1. **画面表示 (HomePage)**
   - TodoListPageViewModelをwatchして、最初にデータを読み込み。
2. **Firestoreアクセス (TodoRepository)**
   - 取得したTodoリストをキャッシュにセット。
3. **UI反映 (ViewModel -> View)**
   - キャッシュされたデータをstateに反映。
4. **新規Todo追加**
   - addNewTask呼び出し → Firestore登録 & キャッシュ更新 → リスト再描画。

### まとめ

- View(UI) → ViewModel(ロジック) → Repository(データ) → Firestoreの流れで処理を行い、キャッシュ更新を通じてUIへ反映されます。
- Riverpodを活用して依存関係を管理し、責務を明確に分割しています。
