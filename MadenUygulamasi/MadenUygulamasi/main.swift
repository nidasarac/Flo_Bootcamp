//
//  main.swift
//  MadenUygulamasi
//
//  Created by Nida Saraç on 30.05.2023.
//
import Foundation

func cevherFiyat(_ cevherKodu: String) -> Int {
    switch cevherKodu {
    case "DMR":
        return 1500
    case "KRM":
        return 5000
    case "BKR":
        return 3000
    case "KMR":
        return 500
    default:
        return 0
    }
}


func taneEtkisi(_ taneKodu: Int) -> Double {
    switch taneKodu {
    case 1:
        return -0.15
    case 2:
        return -0.10
    case 3:
        return 0.0
    default:
        return 0.0
    }
}


func temizlikEtkisi(_ temizlikOrani: Int, _ birimFiyat: Double) -> Double {
    let etkisi = birimFiyat * (1 - Double(temizlikOrani) / 100)
    return birimFiyat - etkisi
}


func hesapla() {
    
    print("** cevher v1.0 **")
    print("*müşterinin")
    print("adı: ", terminator: "")
    let ad = readLine() ?? ""
    print("soyadı: ", terminator: "")
    let soyad = readLine() ?? ""
    
    
    print("cevherin kodu: ", terminator: "")
    let cevherKodu = readLine() ?? ""
    print("tane büyüklüğü: ", terminator: "")
    let taneKodu = Int(readLine() ?? "") ?? 0
    print("temizlik oranı: ", terminator: "")
    let temizlikOrani = Int(readLine() ?? "") ?? 0
    print("miktar(ton): ", terminator: "")
    let miktar = Int(readLine() ?? "") ?? 0
    
    
    let birimFiyat = Double(cevherFiyat(cevherKodu))
    let taneFiyat = birimFiyat * (1 + taneEtkisi(taneKodu))
    let temizlikEtki = temizlikEtkisi(temizlikOrani, taneFiyat)
    let toplamFiyat = temizlikEtki * Double(miktar)
    let kdv = toplamFiyat * 0.08
    let genelToplam = toplamFiyat + kdv
    
    
    print("\n*****Fatura********")
    print("alıcı: \(ad) \(soyad)\n")
    switch cevherKodu {
    case "DMR":
        print("cevher türü: demir")
    case "KRM":
        print("cevher türü: krom")
    case "BKR":
        print("cevher türü: bakır")
    case "KMR":
        print("cevher türü: kömür")
    default:
        print("cevher türü: bilinmeyen")
    }
    print("normal birim fiyatı: \(cevherFiyat(cevherKodu)) tl")
    switch taneKodu {
    case 1:
        print("tane: erik (-%15)")
    case 2:
        print("tane: portakal (-%10)")
    case 3:
        print("tane: karpuz")
    default:
        print("tane: bilinmeyen")
    }
    print("erik fiyat: \(taneFiyat) ton/tl")
    print("temizlik: %\(temizlikOrani), etkisi: \(taneFiyat - temizlikEtki) tl")
    print("temizlik etkisi sonrası")
    print("birim fiyat: \(temizlikEtki) ton/tl")
    print("toplam: \(toplamFiyat) tl")
    print("kdv(%18): \(kdv) tl")
    print("genel toplam: \(genelToplam) tl")
    print("\nMega Madencilik, 2016")
    print("\n**********")
}

hesapla()
