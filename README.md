# Common Lisp 開発環境セットアップ（Docker + SBCL + Quicklisp + ALIVE）

このリポジトリは、**Docker を使った Common Lisp 開発環境**を快速で構築できるテンプレートです。VS Code の ALIVE 拡張機能で、対話的に Lisp コードが書けます！🚀

---

## 📋 必要なもの

- **Docker** と **Docker Compose** がインストール済み
- **VS Code** + **ALIVE 拡張機能** (REPL との連携用)
- WSL 2 を使用している場合は、Docker Desktop の WSL 2 統合を有効化

---

## 🚀 クイックスタート

### 1. リポジトリをクローン（またはコピー）

```bash
git clone https://github.com/tomoaki-dev-jp/lisp_startup.git
cd list_startup
```

### 2. Docker イメージをビルド

```bash
docker compose build
```

### 3. コンテナ起動

```bash
docker compose up -d
```

---

## ⚙️ Quicklisp セットアップ（初回のみ）

コンテナが起動したら、Quicklisp をインストールします。

```bash
docker compose exec commonlisp bash -c '
  curl -s https://beta.quicklisp.org/quicklisp.lisp > /tmp/quicklisp.lisp
  sbcl \
    --eval "(load \"/tmp/quicklisp.lisp\")" \
    --eval "(quicklisp-quickstart:install)" \
    --eval "(ql:add-to-init-file)" \
    --eval "(sb-ext:exit)"
'
```

プロンプトが出たら **Enter キー**を何度か押して完了します。✅

---

## 🔌 ALIVE（VS Code）との連携

### 1. REPL を起動

```bash
docker compose exec commonlisp sbcl
```

### 2. Swank サーバーをロードして起動

REPL 内で以下を実行：

```lisp
* (ql:quickload :swank)
; => (:SWANK) が出力されたら成功

* (swank:create-server :port 4005 :dont-close t :interface "0.0.0.0")
; サーバーが起動（ターミナルは止まったように見えます = 正常）
```

### 3. VS Code ALIVE を設定

1. VS Code で ALIVE 拡張機能を開く（サイドバー）
2. **LSP Connection** セクションで以下を設定：
   - **Host:** `localhost`
   - **Port:** `4005`
3. **Connect** ボタンをクリック
4. 上記の設定がなくてもイケるかも？

### 4. コード編集＆実行

`./lisp_code/test.lisp` などに Lisp コードを書いて、**Ctrl+Enter** で実行！

---

## 📁 ディレクトリ構成

```
.
├── Dockerfile              # SBCL + ビルドツール設定
├── docker-compose.yml      # Docker Compose 設定
├── README.md              # このファイル
└── lisp_code/             # ホストからマウントされるコード用フォルダ
    └── test.lisp          # テスト用ファイル（例）
```

---

## 🧪 テストコード例

`./lisp_code/test.lisp` を作成して、以下を書き込み：

```lisp
;;; Hello World
(format t "Hello, Common Lisp!~%")

;;; 簡単な関数
(defun add (a b)
  "2つの数を足す"
  (+ a b))

;;; テスト実行
(print (add 10 20))
; => 30
```

REPL から：
```lisp
* (load "/app/test.lisp")
; コンパイル＆実行
```

---

## 🛠️ よくある問題

### Q. `Package QL does not exist` エラーが出る

**A.** Quicklisp がきちんとロードされていません。Quicklisp セットアップ手順を再度実行してください。

### Q. ALIVE が Swank に繋がらない

**A.** 以下を確認：
1. `docker compose ps` でコンテナが実行中か確認
2. `docker compose logs commonlisp` でエラーをチェック
3. Swank サーバーが起動しているか確認（REPL でコマンド実行後、ターミナルが応答しない状態 = 正常）

### Q. `localhost:4005` に接続できない

**A.** `docker-compose.yml` で以下が設定されているか確認：
```yaml
ports:
  - "4005:4005"
```

---

## 🎯 次のステップ

- [Quicklisp 公式](https://www.quicklisp.org/)でライブラリを探す
- [Common Lisp Cookbook](https://lispcookbook.github.io/cl-cookbook/) で学習
- ALIVE での開発に慣れたら、より大きなプロジェクトに挑戦！

---

## 📝 注意事項

- このセットアップは**開発用**です。本番環境では別途設定が必要です
- Quicklisp は初回セットアップ時にネットワークを使用します
- ALIVE の SWANK サーバーはローカルホストのみバインドされています

---

## 🤝 貢献

改善案や質問は Issue や PR でお待ちしています！

---

## 📄 ライセンス

MIT License

---

**Happy Lisp Hacking! 🎉**
