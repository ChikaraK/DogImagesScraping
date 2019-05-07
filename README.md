# DogImagesScraping 
DogImagesScrapingはImagga Apiを用いて  
画像解析を行うアプリケーションです。  
当初の予定と変わり、犬以外にも一応の対応をしているため
正確にはImageScraperです。  
  
## 使い方:  
api_keyを環境変数で管理しているため、当アプリをお使いの場合は  
1. https://imagga.com/ :に登録</br>
2. ルートディレクトリ下に.envファイルを製作の上</br>
　　API_KEY = "人により"</br>
　　API_SECRET = "違います"</br>
の二つを定義して（ご自分のkeyに書き換えて）ご利用ください。  
  
  
2019/05/01  
Flickrのみの対応です。  
該当検索結果がない場合、白い画面が出るだけですので、ほかのキーワードにして試してみてください。
