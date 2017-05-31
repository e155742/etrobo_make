一部の警告を無視するmakeコマンドシェルスクリプト
====
Redmine [チケット#3621](https://redmine.ie.u-ryukyu.ac.jp/issues/3621)  

普通にmakeすると以下のwarningが大量にでます。

```bash
warning: command line option '-fno-use-cxa-atexit' is valid for C++/ObjC++ but not for C
```

Makefile.incの該当するオプションを指定している部分を``CXXOPTS``にしたり、``ifeq ($(CC),CXX)``で囲ったりするとリンクがうまくいかなくなります。ヘッダを``#pragma GCC diagnostic ignored``で色々試してもうまくいきません。  
ムカついたので```grep -v -- -fno-use-cxa-atexit```することにしました。  
一応他のwarning:とerror:には色がつくようにしてありますが、太字の出力ができなくなりました。また、ビルドが全て終わってから一気に出力されるので、途中経過がリアルタイムで見れなくなりました。
zshじゃないとうまく動きません。bashやshじゃダメです。


#### 使い方
ダウンロード  
普段makeしている場所(hrp2/sdk/workspaceなど)に落とすと何かと都合がいいでしょう。
```bash
$ git clone https://github.com/e155742/etrobo_make.git
$ cp etrobo_make/romake.zsh ./
```


makeの部分をそのままこのスクリプトに置き換えるだけです。
```bash
$ ./romake.zsh clean
```
や
```bash
$ ./romake.zsh app=hoge
```
など  


以下のエラーが出たらシェバングが違うので
```bash
zsh: ./romake.zsh: bad interpreter: /usr/local/bin/zsh: no such file or directory
```
以下のコマンドで直す.
```bash
$ sed -i -e "s/\/usr\/local\/bin\/zsh/$(which zsh | sed "s/\//\\\\\//g")/g" romake.zsh
```


パス通すかaliasかければ ./ も .zsh もいらなくなります。  
romake.zshがあるディレクトリで以下のコマンドを打てばいい。
```bash
$ echo "alias romake='$(pwd)/romake.zsh'" >> ~/.zshrc
$ source ~/.zshrc
```
これで
```bash
$ romake app=hoge
```
とできるようになる。

