## Flutter Amplify Sample

### Install the Amplify CLI

```
npm install -g @aws-amplify/cli
```

### Configure the Amplify CLI

```
amplify configure
```

IAM 権限含めた権限を持つユーザの access key と secret を入力する。

以降、Flutter Project 配下でやる

### Amplify init

```
amplify init
```

以下のプロジェクトを作成する

```
Project information
| Name: FlutterAmplifySample
| Environment: dev
| Default editor: Visual Studio Code
| App type: flutter
| Javascript framework: none
| Source Directory Path: src
| Distribution Directory Path: dist
| Build Command: npm run-script build
| Start Command: npm run-script start
```

./lib 以下に作成しますか？と聞かれるので、Yes とする

### Amplify add API

```
amplify add api
```

とりあえず以下な感じ

```
? Select from one of the below mentioned services: GraphQL
? Here is the GraphQL API that we will create. Select a setting to edit or continue Conflict detection (required for DataStore): Disabled
? Enable conflict detection? Yes
? Select the default resolution strategy Auto Merge
? Here is the GraphQL API that we will create. Select a setting to edit or continue Continue
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)
```

[model](amplify/backend/api/flutteramplifysample/schema.graphql)を vscode で書いちゃう。

### Amplify codegen models

```
amplify codegen models
```
