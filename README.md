# terraform gcp

よくある構成でGCP環境を構築するためのterraform定義ファイル郡。
はじめて利用される場合は、global.tfvars.sample をご参照ください。

## 構成

- WEB
- CMS
- LoadBalancer
- CDN
- Managed SSL Cert
- Firewall Rules

## terraform インストール
```
# brew install terraform
```

## 使い方

### 変数定義ファイルの作成
```
# cp global.tfvars.sample global.tfvars
```
global.tfvars ファイルを構築する環境に合わせて編集してください。

### 実行計画の確認
```
# terraform plan -var-file global.tfvars
```

### 実行
```
# terraform apply -var-file global.tfvars
```
本当に実行しますか？的な確認がうざったい場合は
```
# terraform apply -var-file global.tfvars -auto-approve
```

### 環境破壊
terraformで構築した環境は全て削除されるのでご注意ください
```
# terraform destroy -var-file global.tfvars
```

