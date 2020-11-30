;===============================================================================
; タイトル画面のサンプルシナリオ
;===============================================================================

[wait time=200]
*title|タイトル
[startanchor]
[clearvar]
[store enabled="false"]
[history enabled="false" output="false"]
[rclick enabled="false"]

[delay speed="nowait"]
[link target="*start"]スタート[endlink][r]
[link target="*load"]ロード[endlink][r]
[if exp='Storages.isExistentStorage("%s/%s%d.bmp".sprintf(kag.saveDataLocation, kag.dataName, MBSystemPref.quickSaveBookMark))']
	[link target="*continue"]コンティニュー[endlink][r]
[endif]
[link target="*config"]コンフィグ[endlink][r]
[link target="*exit"]終了[endlink][r]
[delay speed="user"]
[s]

;-------------------------------------------------------------------------------
; 最初からスタート
*start
[cm]
[history enabled="true" output="true"]
[store enabled="true"]
[rclick enabled="true"]
[jump storage="1.ks"]
[s]

;-------------------------------------------------------------------------------
; プレイデータをロード
*load
[cm]
[rclick enabled="true"]
[eval exp="SystemManager.startPlayDataStorager('load')"]
[waittrig name="CLOSE_BOOKMARK_WINDOW"]
[rclick enabled="false"]
[jump target="*title"]
[s]

;-------------------------------------------------------------------------------
; クイックロード
*continue
[cm]
[rclick enabled="true"]
[load place="&MBSystemPref.quickSaveBookMark" ask="false"]
[s]

;-------------------------------------------------------------------------------
; 環境設定
*config
[cm]
[rclick enabled="true"]
[iscript]
tf.config = new MBControlPanelContainer(kag, kag.fore.base);
MBSystem.addTempObject(tf.config);
[endscript]
[waittrig name="end_config_from_kag"]
[eval exp="MBSystem.removeTempObject(tf.config);"]
[rclick enabled="false"]
[jump target="*title"]
[s]

;-------------------------------------------------------------------------------
; ゲーム終了
*exit
[close]
[unlocklink]
[s]
