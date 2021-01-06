//
//  SQLViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 11/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//https://stackoverflow.com/questions/24102775/accessing-an-sqlite-database-in-swift

import UIKit

class CSVLoadViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CSVファイル名を引数にしてloadCSVメソッドを使用し、CSVファイルを読み込む
        let csvArray = loadCSV("csvfile")
        //titleLabelにアプリ名を設定
        titleLabel.text = csvArray[0]
        //bodyTextViewにアプリ説明文を設定
        bodyTextView.text = csvArray[1]
        //ボタンの文字を白色に変更
        startButton.setTitleColor(UIColor.red, for: .normal)
        //creditLabelにクレジットを設定
            }
    //CSVファイル読み込みメソッド。引数でファイル名を取得。戻り値はString型の配列。
    
    func loadCSV(_ fileName :String) -> [String]{
        //CSVファイルのデータを格納するStrig型配列
        var csvArray:[String] = []
        //引数filnameからCSVファイルのパスを設定
        let csvBundle = Bundle.main.path(forResource: "csvfile", ofType: "csv")!
        do {
            //csvBundleからファイルを読み込み、エンコーディングしてcsvDataに格納
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            //改行コードが"\r"の場合は"\n"に置換する
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            //"\n"の改行コードで要素を切り分け、配列csvArrayに格納する
            csvArray = lineChange.components(separatedBy: "\n")
        }catch{
            print("エラー")
        }
        return csvArray     //戻り値の配列csvArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
