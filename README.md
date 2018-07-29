# Ultra96用 サンプルプロジェクト

## 概要

Ultra96で遊ぶための非公式サンプルプロジェクト。

## 内容

今のところはPL側のロジックを使ってLチカを行うもののみ。

## 環境

* Vivado 2018.2
* PetaLinux 2018.2
* Windowsでビルドスクリプトを実行するにはWSLが必要

## 下準備

* AVNETのチュートリアルに従って、Ultra96のボードパッケージをインストールしておく。
    * http://www.zedboard.org/support/documentation/2416
        * Installing Board Definition Files
        * http://www.zedboard.org/sites/default/files/documentations/Installing-Board-Definition-Files_v1_0.pdf
    * AVNETの [GitHubリポジトリ](https://github.com/Avnet/bdf) からBDFファイルをダウンロードして、Vivadoのインストールディレクトリの `data/boards/board_files` にコピーする

* XilinxのページからUltra96用のBSPをダウンロードしておく。
    * https://japan.xilinx.com/support/download/index.html/content/xilinx/ja/downloadNav/embedded-design-tools.html
    * 3[GiB]弱ある

## ハードウェアのビルド方法


* Linuxの場合はVivadoのパスを通す
    * 例：/opt/Xilinx/Vivado/2018.2にVivadoが入っている場合
    ```bash
    $ export PATH=$PATH:/opt/Xilinx/Vivado/2018.2/bin
    ```

* Windowsの場合は、VIVADO_ROOT環境変数にVivadoのルートディレクトリのパスを設定する。
    * 例：C:\Xilinx\Vivado\2018.2にVivadoが入っている場合
    ```
    $ export VIVADO_ROOT=/mnt/c/Xilinx/Vivado/2018.2
    ```

* `ultra96hw` ディレクトリで`make`を実行すると、プロジェクトの復元から論理合成まで一通り実行する。
    ```
    $ cd ultra96hw
    $ make
    ```

    * プロジェクトの復元のみ行いたい場合は、 `make restore` を実行する。
    ```
    $ cd ultra96hw
    $ make restore
    ```

## PetaLinuxのビルド方法

### PetaLinuxの準備

* Ubuntu上で実行する前提で説明する。
* TODO: 必要なパッケージを記載する
* /opt/Xilinx/PetaLinux にインストールしたものとする。
* `settings.sh`をsourceしておく
    ```
    $ source /opt/Xilinx/PetaLinux/settings.sh
    ```

### PetaLinuxプロジェクトの作成

* ホームディレクトリにUltra96用BSP ( `xilinx-ultra96-reva-v2018.2-final.bsp` ) があることとする。
* このリポジトリのワーキングツリーのルートで実行することとする。

```bash
$ petalinux-create -t project -s ~/xilinx-ultra96-reva-v2018.2-final.bsp -n ultra96_linux
$ cd ultra96_linux
$ petalinux-config --get-hw-description ../ultra96hw/ultra96hw.sdk
```

* 以降、`ultra96_linux` 以下で作業する。

### 追加のデバイスツリー設定のコピー
```
$ cp ../system-user.dtsi project-spec/meta-user/recipes-bsp/device-tree/files/
```

### PetaLinuxのビルド

```
$ petalinux-build
```

* ディスク空き容量が40GBくらい必要
* そこそこ時間がかかる。


### BOOT.binを作成
```
$ petalinux-package  --boot --uboot images/linux/u-boot.elf --fpga images/linux/system.bit --force
```

### SDカードにコピー

* 以下のファイルをSDカードにコピー
    * ultra96_linux/images/linux/BOOT.BIN
    * ultra96_linux/images/linux/image.ub
    * uboot.env

