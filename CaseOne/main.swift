//
//  main.swift
//  CaseOne
//
//  Created by Nida Saraç on 25.05.2023.
//

import Foundation

// Otların birim fiyatlarını tutan sözlük
var otFiyatlari: [String: Double] = [:]

// O günün ot birim fiyatlarını girer
func girisYap() {
    print("Günün ot birim fiyatlarını girin:")
    otFiyatlari["kekik"] = otBirimFiyat("kekik")
    otFiyatlari["nane"] = otBirimFiyat("nane")
    otFiyatlari["fesleğen"] = otBirimFiyat("fesleğen")
    otFiyatlari["reyhan"] = otBirimFiyat("reyhan")
}

// Ot birim fiyatını döndüren fonksiyon
func otBirimFiyat(_ otAdi: String) -> Double {
    let birimFiyat: Double
    switch otAdi {
    case "kekik":
        print("Kekik otunun birim fiyatını (kg başına) girin:")
        birimFiyat = Double(readLine() ?? "0.0") ?? 0.0
    case "nane":
        print("Nane otunun birim fiyatını (kg başına) girin:")
        birimFiyat = Double(readLine() ?? "0.0") ?? 0.0
    case "fesleğen":
        print("Fesleğen otunun birim fiyatını (kg başına) girin:")
        birimFiyat = Double(readLine() ?? "0.0") ?? 0.0
    case "reyhan":
        print("Reyhan otunun birim fiyatını (kg başına) girin:")
        birimFiyat = Double(readLine() ?? "0.0") ?? 0.0
    default:
        birimFiyat = 0.0
    }
    return birimFiyat
}

// Otun tazelik etkisini hesaplayan fonksiyon
func tazelikEtkisi(_ otAdi: String) -> Double {
    let tazelikKaybi: Double
    switch otAdi {
    case "kekik", "fesleğen":
        tazelikKaybi = -0.1
    case "nane":
        tazelikKaybi = -0.2
    case "reyhan":
        tazelikKaybi = -0.25
    default:
        tazelikKaybi = 0.0
    }
    return tazelikKaybi
}

// Satış tutarını hesaplayan fonksiyon
func satisTutariHesapla() {
    print("Satın alacağınız otun adını girin (kekik, nane, fesleğen, reyhan):")
    if let otAdi = readLine() {
        print("Miktarı (kg) girin:")
        if let miktarStr = readLine(), let miktar = Double(miktarStr) {
            print("Taze mi? (1: Taze, 0: Değil)")
            if let tazeStr = readLine(), let taze = Int(tazeStr) {
                let birimFiyat = otFiyatlari[otAdi] ?? 0.0
                let toplamFiyat = birimFiyat * miktar
                let tazelikEtki = tazelikEtkisi(otAdi)
                let sonFiyat = toplamFiyat + (toplamFiyat * tazelikEtki)
                
                print("\(otAdi): \(miktar)kg x \(birimFiyat * tazelikEtki)TL = \(sonFiyat)TL", terminator: " ")
                print(taze == 1 ? "Taze" : "Taze değil", terminator: ". ")
                faturaYazdir(sonFiyat)
            }
        }
    }
}

// Faturayı yazdıran fonksiyon
func faturaYazdir(_ tutar: Double) {
    let kdvOrani = 0.18
    let kdvTutari = tutar * kdvOrani
    let toplamTutar = tutar + kdvTutari
    
    print("KDV (%\(kdvOrani * 100)): \(kdvTutari) TL", terminator: " ")
    print("Genel Toplam: \(toplamTutar) TL")
}

// Programı çalıştır
girisYap()
satisTutariHesapla()
