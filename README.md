大法官解釋
===================
從[司法院大法官](http://www.judicial.gov.tw/constitutionalcourt)網頁中擷取，並轉存成 JSON 。

## 檔案
陣列第 0 個元素常留白（`""`或是`{}`），以利取用特定釋字時，不用煩惱索引值和號碼間差一的問題。
* `all.json`: 各個解釋的所有（目前知道怎麼取出的）資料，每個元素均為物件。
* `dates.json`: 各個解釋的公布日期。
* `holdings.json`: 各個解釋的解釋文，各元素為字串。
* `issues.json`: 各個解釋的爭點。
* `titles.json`: 各個解釋的「標題」（700號以後的才有資料）。
* `xss/*.js`: XSS 用，其實就只是把前述的檔案前面再加個 `jyi_*=` 而已，可用於 `<script src="xxxx"></script>` 。理想上應該弄成 JSONP ，不過畢竟這裡只能放靜態資料…

## 每號解釋的JSON
```js
{
	number: 718,
	date: "2014-03-21",
	title: "緊急性及偶發性集會遊行許可案",      ///< 700號開始，司法院有多個「XXXX案」的短述
	issue: "",      ///< 爭點
	holding: "",    ///< 解釋文，有些會分段（如第499號和第585號），則以`\n`為界
	reasoning: "",  ///< 理由書，分段以`\n`為界
}
```

## 技術
使用 npm 的 jsdom 時，注意其 `Node` 類別並沒有 `getElementById`, `getElementsByName` 等相關函數，且遇到不合規定的標籤（如 `<div&nbsp;class='t1'>` ）時運作方式也與真正的瀏覽器不同。
```bash
node download.js # 從司法院網站下載全文。
node parse.js # 從已存在本機的 HTML 檔中轉存成個別的 JSON 。
node mergeAll.js # 取出每個釋字中需要的部分，湊成 JSON 或 XSS 用的檔案。
```

## 資料來源
司法院網頁有下列欄位：
* 解釋字號：700號後還會標註「XXXX案」，格式即為`釋字第 (\d+) 號 (【(.+)】)?`。
* 解釋日期：在`p03_02.asp`則為「解釋公布日期」。
* 解釋爭點：有些會有兩個，例如665, 693, 696, 698
* 解釋文
* 理由書：有時分段的 DOM 結構會出狀況，例如第499號提到德文文獻的時候。另外如第748號的「附註」區結構也跟理由書內文不同。
* 相關法條
* 事實：650號之後才會有，但在此之前其實事實摘要會在「相關附件」的連結。
* 意見書：503號之前才可能有此連結，連結格式為 `P03_01_detail.asp?expno=\d+&showtype=%B7N%A8%A3%AE%D1` 。（504至506號沒有意見書，507之後有意見書的也不會有此欄位，相應連結則沒有意見書內容）
* 相關附件：649號之前的才可能有，相當於「事實」欄位的舊版，只是這個是連結到另一個網頁 `P03_01_detail.asp?expno=\d+&showtype=%AC%DB%C3%F6%AA%FE%A5%F3` 顯示內容。
* "新聞稿、意見書、抄本(含解釋文、理由書、意見書、聲請書及其附件)"：一個或多個檔案連結，似乎是444號之後才固定會有東西（早期偶爾也會有，例如1號和150號）

## 著作權宣告
CC0
