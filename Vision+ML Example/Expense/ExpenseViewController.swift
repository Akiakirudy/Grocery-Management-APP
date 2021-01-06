//
//  ExpenseViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 11/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftUI
import Charts

class ExpenseViewController: UIViewController {
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var barChartView: BarChartView!
    
    var expe_aki = AkiExpense()
    var expe_shu = ShuExpense()
    open var barWidth = Double(0.85)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = String(expe_aki)
        label2.text = String(expe_shu)
        
        if expe_aki >= expe_shu {
            let discrepancy = expe_aki - expe_shu
            label3.text = "User2 owes $\(discrepancy)"
        } else {
            let discrepancy = expe_shu - expe_aki
            label3.text = "User1 owes $\(discrepancy)"
        }
        
        let rawData: [Float] = [expe_aki, expe_shu]
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        let dataSet = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = Double(0.5)
        barChartView.data = data
    
        // X軸のラベルの色を設定
        barChartView.xAxis.labelTextColor = .systemGray
        // X軸の線、グリッドを非表示にする
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.drawZeroLineEnabled = true
        barChartView.leftAxis.zeroLineColor = .white
        // ラベルの色を設定
        barChartView.leftAxis.labelTextColor = .white
        // グリッドの色を設定
        barChartView.leftAxis.gridColor = .white
        // 軸線は非表示にする
        barChartView.leftAxis.drawAxisLineEnabled = false
        //平均線の設定
        let avg = rawData.reduce(0) { return $0 + Int($1) } / rawData.count
        let limitLine = ChartLimitLine(limit: Double(avg))
        limitLine.lineColor = .green
        limitLine.lineDashLengths = [4]
        barChartView.leftAxis.addLimitLine(limitLine)
        //棒グラフの色
        dataSet.colors = [#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)]
    }
}

func AkiExpense() -> Float {
    var csvArray:[String] = []
    var shunsaku_expense: Float = 0
    var akira_expense: Float = 0
    let viewController = CSVLoadViewController()
    csvArray = viewController.loadCSV("csvfile")

   
    for list in csvArray {
        let listItems = list.components(separatedBy: ",")
        
        switch listItems[0] {
            case "Shunsaku":
                let price = Float(listItems[3]) ?? 0.0
                shunsaku_expense += Float(price)
            case "Akira":
                let price =  Float(listItems[3]) ?? 0.0
                akira_expense += Float(price)
            default:
                print("who")
                }
            }
        return  akira_expense
                //func didReceiveMemoryWarning() {
                //super.didReceiveMemoryWarning()
}

func ShuExpense() -> Float {
    var csvArray:[String] = []
    var shunsaku_expense: Float = 0
    var akira_expense: Float = 0
    let viewController = CSVLoadViewController()
    csvArray = viewController.loadCSV("csvfile")

   
    for list in csvArray {
        let listItems = list.components(separatedBy: ",")
        
        switch listItems[0] {
            case "Shunsaku":
                let price = Float(listItems[3]) ?? 0.0
                shunsaku_expense += Float(price)
            case "Akira":
                let price =  Float(listItems[3]) ?? 0.0
                akira_expense += Float(price)
            default:
                print("who")
                }
            }
        return shunsaku_expense
                //func didReceiveMemoryWarning() {
                //super.didReceiveMemoryWarning()
}

