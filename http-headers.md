# HTTPリクエストのヘッダー指定まとめ

## HTTPリクエストの構造

HTTPリクエストは大きく3つの部分から構成される。

```
┌─────────────────────────────────┐
│  リクエストライン                │  ← POST /api/v1/todos HTTP/1.1
├─────────────────────────────────┤
│  ヘッダー                        │  ← メタ情報（複数行）
├─────────────────────────────────┤
│  ボディ                          │  ← 実際のデータ（JSONなど）
└─────────────────────────────────┘
```

## ヘッダーとは

**「本文についての情報」を伝えるメタデータ**。

手紙に例えると：

| 手紙 | HTTPリクエスト |
|------|----------------|
| 封筒に書く情報（宛先、差出人、速達マーク） | **ヘッダー** |
| 封筒の中の手紙本文 | **ボディ** |

サーバーはボディを読む前に、ヘッダーを見てどう処理すべきか判断する。

## 具体例

```
POST /api/v1/todos HTTP/1.1
Host: localhost:3000
Content-Type: application/json    ← 「中身はJSON形式」
Content-Length: 42                ← 「中身は42バイト」
Authorization: Bearer abc123      ← 「認証トークン」

{"todo": {"content": "買い物"}}   ← ボディ（実際のデータ）
```

---

## リクエストヘッダー（クライアント → サーバー）

| ヘッダー | 意味 | 例 |
|----------|------|-----|
| `Content-Type` | 送信データの形式 | `application/json` |
| `Accept` | 欲しいレスポンス形式 | `application/json` |
| `Authorization` | 認証情報 | `Bearer eyJhbGciOi...` |
| `User-Agent` | クライアントの種類 | `Mozilla/5.0...`, `curl/7.64.1` |
| `Cookie` | クッキー情報 | `session_id=abc123` |
| `Accept-Language` | 希望する言語 | `ja, en-US` |

## レスポンスヘッダー（サーバー → クライアント）

| ヘッダー | 意味 | 例 |
|----------|------|-----|
| `Content-Type` | 返すデータの形式 | `application/json; charset=utf-8` |
| `Set-Cookie` | クッキーを保存させる | `session_id=abc123; HttpOnly` |
| `Location` | リダイレクト先 | `https://example.com/new-page` |
| `Cache-Control` | キャッシュの指示 | `no-cache`, `max-age=3600` |
| `Access-Control-Allow-Origin` | CORS許可 | `*`, `https://example.com` |

---

## Content-Type の主な種類

| 値 | 用途 |
|----|------|
| `application/json` | JSON（API通信で最も多い） |
| `application/x-www-form-urlencoded` | HTMLフォーム送信 |
| `multipart/form-data` | ファイルアップロード |
| `text/html` | HTMLページ |
| `text/plain` | プレーンテキスト |

---

## curlでのヘッダー指定

### 基本構文

```bash
curl -H "ヘッダー名: 値" URL
```

### よく使うパターン

**JSON送信**
```bash
curl -X POST http://localhost:3000/api/v1/todos \
  -H "Content-Type: application/json" \
  -d '{"todo": {"content": "買い物に行く"}}'
```

**API認証**
```bash
curl -X GET http://api.example.com/users \
  -H "Authorization: Bearer eyJhbGciOi..."
```

**複数ヘッダー指定**
```bash
curl -X POST http://api.example.com/todos \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer token123" \
  -d '{"content": "test"}'
```
