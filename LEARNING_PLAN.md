# Rails API x React TODO アプリ 学習プラン

## プロジェクト概要

Rails 8.1.2 API モード + React + TypeScript で TODO アプリを作りながら、実務で使えるベストプラクティスを学ぶプロジェクト。

---

## Claude の役割と振る舞い

### 基本姿勢
- **先生役**: コードを書くのはあなた。Claude は課題を提示し、解説する。
- **段階的学習**: 一度に全てを渡さず、一つずつ課題をクリアしていく。
- **理由を説明**: 「なぜこうするのか」を必ず説明する。
- **動作確認重視**: 各ステップで実際に動かして確認してから次へ。

### 学習フロー
1. **課題提示**: 「次はこれを実装してください」と具体的な課題を出す
2. **ヒント提供**: 必要に応じてヒントやドキュメントへのリンクを提示
3. **質問対応**: 分からないことがあれば解説する
4. **コードレビュー**: 実装後にコードを確認し、改善点を指摘
5. **解説**: なぜこのように実装するのか、実務での意味を説明
6. **次へ進む**: 理解を確認してから次の課題へ

### Claude が直接コードを書く場合
- 複雑な設定ファイル（初期設定など）
- ボイラープレートコード
- テストコードの例（参考として）

---

## 技術スタック

### バックエンド (Rails)
- Rails 8.1.2 (API モード)
- PostgreSQL
- RSpec + FactoryBot (テスト)
- jsonapi-serializer (JSON:API 仕様)
- devise + devise-jwt (認証)

### フロントエンド (React)
- Vite + React 18 + TypeScript
- React Router v6 (ルーティング)
- TanStack Query (React Query v5) - サーバー状態管理
- Zustand - クライアント状態管理
- axios - HTTP クライアント
- react-hook-form + zod (フォームバリデーション)
- TailwindCSS (スタイリング)

---

## 学習プラン全体構成

### 【第1部】Rails API 基礎編 (認証なし)
→ シンプルな TODO CRUD で Rails API の基本を学ぶ

### 【第2部】Rails API 認証編
→ JWT 認証を追加してユーザーごとの TODO を実装

### 【第3部】React 基礎編
→ Vite + React + TypeScript の環境構築と基本実装

### 【第4部】React 状態管理編
→ TanStack Query と Zustand で実務的な状態管理

### 【第5部】統合・発展編
→ 認証連携、エラーハンドリング、楽観的更新など

---

## 【第1部】Rails API 基礎編 (認証なし)

### 学習目標
- Rails API モードの基本を理解する
- RESTful API の設計を学ぶ
- RSpec でのテスト駆動開発を体験する
- JSON:API 仕様に準拠した API レスポンスを作る

### Phase 0: テスト環境セットアップ

**課題0-1: Gemfile の編集**
- `rspec-rails`, `factory_bot_rails`, `faker`, `jsonapi-serializer`, `rack-cors` を追加
- `bundle install` を実行

**学ぶポイント**:
- なぜテスト環境を最初にセットアップするのか
- 各 gem の役割と選定理由
- 実務での gem 選定基準

**課題0-2: RSpec の初期化**
```bash
rails generate rspec:install
```

**課題0-3: RSpec の設定**
- `spec/rails_helper.rb` に FactoryBot の設定を追加

**学ぶポイント**:
- RSpec の基本構造
- FactoryBot を使う理由

---

### Phase 1: TODO モデル設計

**課題1-1: TODO モデルの生成**
```bash
rails generate model Todo title:string description:text completed:boolean priority:integer due_date:date user_id:bigint
```

**学ぶポイント**:
- マイグレーションファイルの役割
- データ型の選び方
- `user_id` を最初から用意する理由（将来の拡張性）

**課題1-2: マイグレーションファイルの編集**
- `NOT NULL` 制約の追加
- デフォルト値の設定
- インデックスの追加

**学ぶポイント**:
- データベース制約の重要性
- インデックスのパフォーマンス効果
- 複合インデックスの使いどころ

**課題1-3: マイグレーション実行**
```bash
rails db:migrate
```

**課題1-4: モデルにバリデーションを追加**
- `title` の presence と length
- `priority` の範囲チェック
- `completed` の boolean チェック

**学ぶポイント**:
- バリデーションの種類と使い分け
- データベース制約とモデルバリデーションの違い
- `allow_nil: true` の使いどころ

**課題1-5: スコープの実装**
- `completed`, `incomplete`, `overdue`, `ordered_by_priority` など

**学ぶポイント**:
- スコープの役割（ビジネスロジックをモデルに集約）
- メソッドチェーンの利便性
- N+1 問題を避けるクエリ設計

**課題1-6: ビジネスロジックメソッドの実装**
- `overdue?`, `high_priority?` など

**学ぶポイント**:
- Fat Model, Skinny Controller の原則
- ビジネスロジックをモデルに書く理由

**課題1-7: Normalizable Concern の作成**
- 空文字列を `nil` に変換する処理

**学ぶポイント**:
- Rails の Concern パターン
- CLAUDE.md ルールの実装方法
- コードの再利用性

**課題1-8: Factory の作成**
- `spec/factories/todos.rb` を編集
- Trait の作成（`:completed`, `:overdue` など）

**学ぶポイント**:
- Factory Bot の基本
- Trait を使ったテストデータのバリエーション
- Faker の活用方法

**課題1-9: Model Spec の作成**
- バリデーションのテスト
- スコープのテスト
- メソッドのテスト

**学ぶポイント**:
- RSpec の基本文法（`describe`, `it`, `expect`）
- テストの書き方（AAA パターン: Arrange, Act, Assert）
- Factory の使い方（`build`, `create`）

**課題1-10: テストの実行**
```bash
bundle exec rspec spec/models/todo_spec.rb
```

**学ぶポイント**:
- テストが通ることの確認
- Red-Green-Refactor サイクル

---

### Phase 2: API エンドポイント実装

**課題2-1: routes.rb の設定**
- `namespace :api` と `namespace :v1` の追加
- `resources :todos` の設定

**学ぶポイント**:
- API バージョニングの重要性
- RESTful なルーティング
- 7つの標準アクション

**課題2-2: コントローラーの生成**
```bash
rails generate controller Api::V1::Todos
```

**課題2-3: コントローラーの実装**
- `index`, `show`, `create`, `update`, `destroy` アクション
- `before_action :set_todo`
- Strong Parameters

**学ぶポイント**:
- コントローラーの責務（薄く保つ）
- エラーハンドリング（404, 422 など）
- HTTP ステータスコードの使い分け
- Strong Parameters による Mass Assignment 攻撃防止

**課題2-4: Serializer の作成**
- `app/serializers/todo_serializer.rb` を作成
- JSON:API 形式でのレスポンス

**学ぶポイント**:
- Serializer の役割
- JSON:API 仕様のメリット
- カスタム属性の追加方法

**課題2-5: Request Spec の作成**
- 各エンドポイントのテスト
- 正常系・異常系のテスト

**学ぶポイント**:
- Request Spec の書き方
- HTTP メソッドのテスト（GET, POST, PATCH, DELETE）
- JSON レスポンスの検証

**課題2-6: テストの実行**
```bash
bundle exec rspec spec/requests/api/v1/todos_spec.rb
```

---

### Phase 3: CORS 設定

**課題3-1: CORS 設定ファイルの作成**
- `config/initializers/cors.rb` を作成
- 開発環境と本番環境で異なる設定

**学ぶポイント**:
- CORS とは何か
- Same-Origin Policy の理解
- セキュリティとのバランス

---

### Phase 4: シードデータ作成

**課題4-1: seeds.rb の編集**
- Faker を使ったダミーデータ作成

**課題4-2: データベースの初期化とシード実行**
```bash
rails db:create
rails db:migrate
rails db:seed
```

**学ぶポイント**:
- シードデータの役割
- 開発効率を上げるデータ準備

---

### Phase 5: 動作確認

**課題5-1: Rails サーバー起動**
```bash
rails server
```

**課題5-2: curl での API 確認**
- GET /api/v1/todos
- POST /api/v1/todos
- PATCH /api/v1/todos/:id
- DELETE /api/v1/todos/:id

**学ぶポイント**:
- curl コマンドの使い方
- HTTP リクエスト・レスポンスの確認
- JSON:API レスポンスの構造

**課題5-3: 全テスト実行**
```bash
bundle exec rspec
```

---

## 【第2部】Rails API 認証編

### 学習目標
- JWT 認証の仕組みを理解する
- Devise の使い方を学ぶ
- ユーザーごとのデータ管理を実装する

### Phase 6: 認証機能の追加

**課題6-1: devise と devise-jwt の導入**
- Gemfile に追加して bundle install

**課題6-2: Devise のセットアップ**
```bash
rails generate devise:install
rails generate devise User
```

**学ぶポイント**:
- Devise の基本設定
- User モデルの役割

**課題6-3: JwtDenylist モデルの作成**
- トークンの無効化管理

**課題6-4: Devise の設定**
- `config/initializers/devise.rb` の編集
- JWT 設定の追加

**学ぶポイント**:
- JWT の仕組み
- トークンのライフサイクル
- セキュリティ考慮事項

**課題6-5: User と Todo の関連付け**
- `user_id` を NOT NULL に変更
- 外部キー制約の追加
- `has_many :todos` と `belongs_to :user`

**課題6-6: コントローラーの修正**
- `before_action :authenticate_user!`
- `current_user.todos` でスコープを絞る

**課題6-7: 認証エンドポイントの追加**
- サインアップ、ログイン、ログアウト

**課題6-8: テストの修正**
- 認証が必要なテストの対応

**学ぶポイント**:
- 認証付き API のテスト方法
- JWT トークンの扱い方

---

## 【第3部】React 基礎編

### 学習目標
- Vite で React プロジェクトをセットアップする
- TypeScript の基本を理解する
- React Router でのルーティングを学ぶ
- TailwindCSS でのスタイリングを学ぶ

### Phase 7: React 環境構築

**課題7-1: Vite プロジェクト作成**
```bash
npm create vite@latest frontend -- --template react-ts
cd frontend
npm install
```

**学ぶポイント**:
- Vite とは何か（従来の Create React App との違い）
- TypeScript を選ぶ理由

**課題7-2: 必要なライブラリのインストール**
```bash
npm install react-router-dom @tanstack/react-query axios zustand
npm install react-hook-form zod @hookform/resolvers
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

**学ぶポイント**:
- 各ライブラリの役割
- なぜこの組み合わせが実務的か

**課題7-3: TailwindCSS の設定**
- `tailwind.config.js` の編集
- `index.css` への import

**課題7-4: ディレクトリ構成の作成**
```
frontend/src/
├── components/     # 再利用可能なコンポーネント
├── features/       # 機能別コンポーネント
│   └── todos/
├── hooks/          # カスタムフック
├── lib/            # ライブラリ設定
├── pages/          # ページコンポーネント
├── types/          # TypeScript 型定義
└── utils/          # ユーティリティ関数
```

**学ぶポイント**:
- Feature-based ディレクトリ構成
- スケーラブルなプロジェクト構造

**課題7-5: 開発サーバー起動**
```bash
npm run dev
```

---

### Phase 8: React Router セットアップ

**課題8-1: ルーティングの基本設定**
- `App.tsx` にルーター設定
- `/`, `/todos`, `/todos/:id` などのルート定義

**学ぶポイント**:
- React Router v6 の使い方
- ネストされたルート
- 動的ルートパラメータ

**課題8-2: レイアウトコンポーネントの作成**
- ヘッダー、ナビゲーションなどの共通 UI

**学ぶポイント**:
- レイアウトコンポーネントのパターン
- Outlet を使ったネストルート

---

### Phase 9: axios のセットアップ

**課題9-1: axios インスタンスの作成**
- `lib/api.ts` にベース設定
- baseURL, headers などの設定

**学ぶポイント**:
- axios インスタンスの利点
- interceptor の使い方

**課題9-2: 型定義の作成**
- `types/todo.ts` に Todo 型を定義
- JSON:API レスポンス型の定義

**学ぶポイント**:
- TypeScript での型定義
- バックエンド API との型の整合性

---

### Phase 10: TanStack Query セットアップ

**課題10-1: QueryClient の設定**
- `lib/queryClient.ts` を作成
- デフォルト設定（staleTime, cacheTime など）

**課題10-2: App に QueryClientProvider を追加**

**学ぶポイント**:
- TanStack Query（React Query）とは
- サーバー状態とクライアント状態の違い
- キャッシング戦略

---

### Phase 11: TODO 一覧表示

**課題11-1: カスタムフック作成**
- `hooks/useTodos.ts` を作成
- `useQuery` で TODO 一覧を取得

**学ぶポイント**:
- カスタムフックのパターン
- useQuery の基本
- ローディング状態とエラー処理

**課題11-2: TodoList コンポーネント作成**
- `features/todos/TodoList.tsx`
- TODO 一覧の表示

**学ぶポイント**:
- コンポーネント設計
- map を使ったリスト表示
- TailwindCSS でのスタイリング

**課題11-3: TodoItem コンポーネント作成**
- 個別 TODO の表示
- 完了チェックボックス

**学ぶポイント**:
- コンポーネントの分割
- props の型定義

---

## 【第4部】React 状態管理編

### 学習目標
- TanStack Query で CRUD 操作を実装する
- Zustand でクライアント状態を管理する
- react-hook-form + zod でフォームを作る

### Phase 12: TODO 作成機能

**課題12-1: useMutation フックの作成**
- `hooks/useCreateTodo.ts`

**課題12-2: react-hook-form + zod でフォーム作成**
- バリデーションスキーマの定義
- `TodoForm.tsx` コンポーネント

**学ぶポイント**:
- useMutation の基本
- react-hook-form の使い方
- zod によるスキーマバリデーション
- 型安全なフォーム

**課題12-3: 楽観的更新の実装**
- `onMutate`, `onError`, `onSettled` の活用

**学ぶポイント**:
- 楽観的更新とは
- UX を向上させるテクニック

---

### Phase 13: TODO 更新・削除機能

**課題13-1: 更新機能の実装**
- `useUpdateTodo.ts`
- インライン編集 UI

**課題13-2: 削除機能の実装**
- `useDeleteTodo.ts`
- 削除確認ダイアログ

**学ぶポイント**:
- CRUD の完成
- キャッシュの invalidate

---

### Phase 14: Zustand で UI 状態管理

**課題14-1: Zustand ストアの作成**
- `stores/uiStore.ts`
- モーダル開閉状態、フィルター状態など

**学ぶポイント**:
- Zustand の基本
- いつ Zustand を使い、いつ TanStack Query を使うか
- 状態管理ライブラリの選び方

**課題14-2: フィルター機能の実装**
- 完了/未完了の切り替え
- 優先度でのフィルタ

---

## 【第5部】統合・発展編

### 学習目標
- 認証機能を React 側に実装する
- エラーハンドリングを洗練させる
- 実務的な機能を追加する

### Phase 15: 認証機能の統合

**課題15-1: ログイン画面の作成**
- JWT トークンの保存（localStorage）

**課題15-2: 認証状態管理**
- Zustand で認証状態を管理
- Private Route の実装

**課題15-3: axios interceptor で認証ヘッダー追加**

**学ぶポイント**:
- JWT トークンの管理
- 認証フローの実装
- セキュリティ考慮事項

---

### Phase 16: エラーハンドリング強化

**課題16-1: エラーバウンダリの作成**

**課題16-2: トーストによる通知**
- 成功・エラーメッセージの表示

**学ぶポイント**:
- React のエラーバウンダリ
- ユーザーフレンドリーなエラー表示

---

### Phase 17: 発展的な機能

**課題17-1: ペジネーションの実装**
- `useInfiniteQuery` の活用

**課題17-2: 検索機能の実装**
- デバウンスの実装

**課題17-3: ソート機能**

**学ぶポイント**:
- パフォーマンス最適化
- 実務でよく使うパターン

---

### Phase 18: テストの追加（余力があれば）

**課題18-1: コンポーネントテスト**
- React Testing Library

**課題18-2: カスタムフックのテスト**

---

## 学習プラン完了後に身につくスキル

### Rails API
- ✅ Rails API モードの基本
- ✅ RESTful API 設計
- ✅ JWT 認証の実装
- ✅ RSpec によるテスト駆動開発
- ✅ JSON:API 仕様に準拠した設計

### React + TypeScript
- ✅ Vite による開発環境構築
- ✅ React Router によるルーティング
- ✅ TanStack Query によるサーバー状態管理
- ✅ Zustand によるクライアント状態管理
- ✅ react-hook-form + zod による型安全なフォーム
- ✅ TailwindCSS によるスタイリング
- ✅ TypeScript による型安全な開発

### 実務的なスキル
- ✅ フロントエンドとバックエンドの連携
- ✅ エラーハンドリング
- ✅ パフォーマンス最適化（楽観的更新、キャッシング）
- ✅ セキュリティ考慮（CORS, JWT, XSS 対策）
- ✅ スケーラブルなディレクトリ構成

---

## 推奨学習ペース

- **Phase 0-5**: 1週間（Rails API 基礎）
- **Phase 6**: 3日（認証機能）
- **Phase 7-10**: 3日（React 環境構築）
- **Phase 11**: 2日（TODO 一覧表示）
- **Phase 12-14**: 1週間（CRUD + 状態管理）
- **Phase 15-17**: 1週間（認証統合 + 発展機能）

**合計**: 約4-5週間でフルスタック開発の基礎を習得

---

## 参考リソース

### Rails
- [Rails Guides](https://guides.rubyonrails.org/)
- [RSpec Documentation](https://rspec.info/)
- [JSON:API Specification](https://jsonapi.org/)

### React
- [React Documentation](https://react.dev/)
- [TanStack Query Documentation](https://tanstack.com/query/latest)
- [React Router Documentation](https://reactrouter.com/)
- [Zustand Documentation](https://github.com/pmndrs/zustand)
- [TailwindCSS Documentation](https://tailwindcss.com/)

---

## 次のステップ

学習完了後は以下のような発展が可能:

1. **デプロイ**: Heroku / Render / Vercel へのデプロイ
2. **機能追加**: タグ機能、カテゴリー、共有機能など
3. **リアルタイム**: ActionCable / WebSocket の追加
4. **モバイル対応**: React Native への応用
5. **CI/CD**: GitHub Actions によるテスト自動化

---

このプランに沿って一緒に学習を進めていきましょう！
各 Phase で分からないことがあれば、いつでも質問してください。
