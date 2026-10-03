# NES.emu Touch

これは [Rakashazi/emu-ex-plus-alpha](https://github.com/Rakashazi/emu-ex-plus-alpha) の正式なフォーク [mansukoxamel/nes-emu-touch](https://github.com/mansukoxamel/nes-emu-touch) です。ファミコン用の **NES.emu の Android タッチ方向入力** を改善しています。他機種のエミュレーターを削除して別製品にする計画ではありません。元プロジェクトと各コンポーネントのライセンスは、それぞれのソースに記載されています。

左画面の接地点を起点とし、6dp 移動すると8方向の入力を始めます。指を止めても方向を保持し、次の6dp移動で切り替え、指を離すと解除します。A/B ボタンの配置改善は今後の作業です。

Android の診断版 `1.5.85-jinn.2` では、タッチイベント、方向入力としての採用、移動量、キー送出、NES側のボタン状態をログに記録します。取りこぼしの原因はまだ特定していません。CI のデバッグ署名が実行ごとに変わるため、この診断APKだけ `local.jinn.nesemutouchdiag` として既存の改修版と並べてインストールします。ログの確認例:

```powershell
& 'C:\Users\jinn\AppData\Local\Android\Sdk\platform-tools\adb.exe' logcat -v threadtime -s VController NES.emu
```

APK はフォークの `NES.emu Touch APK` GitHub Actions で ARM64 向けに生成します。元の NES.emu とは別のアプリID `local.jinn.nesemutouch` です。バージョンごとの変更は [CHANGELOG_JA.md](CHANGELOG_JA.md) を参照してください。
