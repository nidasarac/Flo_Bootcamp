//
//  ViewController.swift
//  BaharatApp
//
//  Created by Nida Saraç on 29.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var baharatTextField: UITextField!
    @IBOutlet weak var birimFiyatTextField: UITextField!
    @IBOutlet weak var kgSayisiTextField: UITextField!
    @IBOutlet weak var tazeMiSwitch: UISwitch!
    
    let indirimOranlari: [String: Float] = [
           "kekik": 0.1,
           "nane": 0.2,
           "fesleğen": 0.1,
           "reyhan": 0.25
       ]

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hesaplaButtonTapped(_ sender: Any) {
    
        guard let baharatAdi = baharatTextField.text, !baharatAdi.isEmpty else {
                   print("Baharat adı boş")
                   return
               }

               guard let birimFiyatText = birimFiyatTextField.text, let birimFiyat = Float(birimFiyatText) else {
                   print("Geçersiz birim fiyatı")
                   return
               }

               guard let kgSayisiText = kgSayisiTextField.text, let kgSayisi = Float(kgSayisiText) else {
                   print("Geçersiz kg sayısı")
                   return
               }

               let tazeMi = tazeMiSwitch.isOn
               var indirimOrani: Float = 0.0

               if !tazeMi, let baharatIndirimOrani = indirimOranlari[baharatAdi] {
                   indirimOrani = baharatIndirimOrani
               }

               let indirimliBirimFiyat = birimFiyat - (birimFiyat * indirimOrani)

               let tutar = indirimliBirimFiyat * kgSayisi
               let kdvOrani: Float = 0.18
               let kdvTutari = tutar * kdvOrani
               let toplamTutar = tutar + kdvTutari

               let indirimMesaji = !tazeMi ? "Tazelik indirimi alındı\n" : ""

               let alert = UIAlertController(title: "Fatura", message: "\(indirimMesaji)Toplam Tutar: \(String(format: "%.2f", toplamTutar)) TL\nKDV Tutarı: \(String(format: "%.2f", kdvTutari)) TL", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       }
