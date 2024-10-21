# docker-terraformer-sample

Docker環境でterraformerを使い、AWSからIaCを生成するサンプルリポジトリ

## envファイル設定

- 下記コマンドを実行し、.envファイルを生成する
- AWS_ACCESS_KEY_ID と AWS_SECRET_ACCESS_KEY に、AWSアクセスキーとシークレットキーを設定する

```shell
make env
```

## terraformer init

- 下記コマンドを実行し、terraformer initを実行する

```shell
make terraformer/init
```

## terraformer import

- docker/run のcommand引数に実行したいimportコマンドを渡す
- 下記はecsのリソースをimportする例

```shell
make docker/run command="import aws --resources ecs --regions ap-northeast-1 --profile ''"
```