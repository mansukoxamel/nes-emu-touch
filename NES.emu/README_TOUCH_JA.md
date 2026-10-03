# NES.emu Touch

これは [Rakashazi/emu-ex-plus-alpha](https://github.com/Rakashazi/emu-ex-plus-alpha) の正式なフォーク [mansukoxamel/nes-emu-touch](https://github.com/mansukoxamel/nes-emu-touch) です。ファミコン用の **NES.emu の Android タッチ方向入力** を改善しています。他機種のエミュレーターを削除して別製品にする計画ではありません。元プロジェクトと各コンポーネントのライセンスは、それぞれのソースに記載されています。

左画面の接地点を起点とし、6dp 移動すると8方向の入力を始めます。指を止めても方向を保持し、次の6dp移動で切り替え、指を離すと解除します。A/B ボタンの配置改善は今後の作業です。

Android の診断版 `1.5.85-jinn.2` では、タッチイベント、方向入力としての採用、移動量、キー送出、NES側のボタン状態をログに記録します。取りこぼしの原因は特定していません。Android ではログタグが `imagine` なので、診断版を調べる際は以下のように取得します。

```powershell
& 'C:\Users\jinn\AppData\Local\Android\Sdk\platform-tools\adb.exe' logcat -v threadtime -s imagine:I
```

`1.5.85-touch3` では左の固定十字キー画像を非表示にし、A/B を拡大、Select と Start を右側にまとめました。ユーザーが実機で選んだ画面比率 1:1 を既定値とし、右の余白へボタンを置きます。診断ログは通常版の操作負荷を避けるため除いています。

APK はフォークの `NES.emu Touch APK` GitHub Actions で ARM64 向けに生成します。ソース上のアプリIDは `local.jinn.nesemutouch` です。CIの一時的なデバッグ署名は毎回変わるため、端末での試験用APKは既存版を消さずに追加できるよう `local.jinn.nesemutouch3` として作成します。バージョンごとの変更は [CHANGELOG_JA.md](CHANGELOG_JA.md) を参照してください。
