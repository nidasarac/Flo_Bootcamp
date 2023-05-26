//
//  CaseTwo.swift
//  CaseOne
//
//  Created by Nida Saraç on 26.05.2023.
//

import Foundation

struct Depo {
    var stok: [String: Int] = ["U01": 0, "U02": 0, "U03": 0]
    var sonIslem: (tur: String, miktar: Int)?
    
    mutating func malEkle() {
        print("1- Ayakkabı")
        print("2- Çanta")
        print("3- Gözlük")
        print("4- Vazgeç")
        print("Seçim=", terminator: "")
        
        if let secimStr = readLine(), let secim = Int(secimStr), secim >= 1, secim <= 3 {
            let malKodu = "U0\(secim)"
            
            print("\(malKodu) Ekleme")
            print("-------------------------------")
            
            var toplamMiktar = 0
            
            while true {
                print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
                
                if let miktarStr = readLine(), let miktar = Int(miktarStr), miktar >= 0 {
                    if miktar == 0 {
                        break
                    }
                    
                    toplamMiktar += miktar
                } else {
                    print("Geçersiz bir miktar girdiniz.")
                }
            }
            
            stok[malKodu] = (stok[malKodu] ?? 0) + toplamMiktar
            sonIslem = (tur: malKodu, miktar: toplamMiktar)
            
            print("-------------------------------")
            print("\(malKodu) stoğuna toplam \(toplamMiktar) adet \(malKodu) eklendi.")
        } else {
            print("Geçersiz bir seçim yaptınız.")
        }
    }
    
    mutating func malCikart() {
        print("1- Ayakkabı")
        print("2- Çanta")
        print("3- Gözlük")
        print("4- Vazgeç")
        print("Seçim=", terminator: "")
        
        if let secimStr = readLine(), let secim = Int(secimStr), secim >= 1, secim <= 3 {
            let malKodu = "U0\(secim)"
            
            if let stokMiktar = stok[malKodu], stokMiktar > 0 {
                print("\(malKodu) Çıkartma, Stok Miktarı= \(stokMiktar) adet")
                print("-------------------------------")
                
                var cikartilanMiktar = 0
                
                while true {
                    print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
                    
                    if let miktarStr = readLine(), let miktar = Int(miktarStr), miktar >= 0 {
                        if miktar == 0 {
                            break
                        }
                        
                        if miktar > stokMiktar {
                            print("Stokta bu kadar yok, \(stokMiktar) adet kaldı...")
                        } else {
                            cikartilanMiktar += miktar
                            stok[malKodu] = stokMiktar - miktar
                        }
                    } else {
                        print("Geçersiz bir miktar girdiniz.")
                    }
                }
                
                print("------------------------------")
                print("\(malKodu) stoğundan toplam \(cikartilanMiktar) adet \(malKodu) çıkarıldı.")
            } else {
                print("Seçtiğiniz mal türü stokta bulunmamaktadır.")
            }
        } else {
            print("Geçersiz bir seçim yaptınız.")
        }
    }
    
    func ara() {
        print("1- Ayakkabı")
        print("2- Çanta")
        print("3- Gözlük")
        print("4- Vazgeç")
        print("Seçim=", terminator: "")
        
        if let secimStr = readLine(), let secim = Int(secimStr), secim >= 1, secim <= 3 {
            let malKodu = "U0\(secim)"
            
            if let stokMiktar = stok[malKodu] {
                print("Stok Miktarı: \(stokMiktar) adet")
            } else {
                print("Seçtiğiniz mal türü stokta bulunmamaktadır.")
            }
        } else {
            print("Geçersiz bir seçim yaptınız.")
        }
    }
    
    func listele() {
        print("Ayakkabı: \(stok["U01"] ?? 0) adet")
        print("Çanta: \(stok["U02"] ?? 0) adet")
        print("Gözlük: \(stok["U03"] ?? 0) adet")
    }
    
    func sonIslemiYazdir() {
        if let sonIslem = sonIslem {
            print("Son İşlem: \(sonIslem.tur) \(sonIslem.miktar) adet")
        } else {
            print("Henüz bir işlem yapılmamıştır.")
        }
    }
}

func depoFLOProgrami() {
    var depo = Depo()
    
    while true {
        print("---- DepoFLO v1.0 ----")
        print("1- Mal Ekle")
        print("2- Mal Çıkart")
        print("3- Stok Ara")
        print("4- Stok Listele")
        print("5- Son İşlem")
        print("6- Çık")
        print("Seçim: ", terminator: "")
        
        if let secimStr = readLine(), let secim = Int(secimStr), secim >= 1, secim <= 6 {
            switch secim {
            case 1:
                depo.malEkle()
            case 2:
                depo.malCikart()
            case 3:
                depo.ara()
            case 4:
                depo.listele()
            case 5:
                depo.sonIslemiYazdir()
            case 6:
                return
            default:
                break
            }
        } else {
            print("Geçersiz bir seçim yaptınız.")
        }
        
        print("\n")
    }
}

//depoFLOProgrami()
