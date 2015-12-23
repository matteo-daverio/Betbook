//
//  CoverageCalculator.swift
//  MyApp
//
//  Created by Matteo on 23/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

public class CoverageCalculator {
    
    private let esito: String
    private let giocata: String
    
    public init(esito: String, giocata: String) {
        self.esito = esito
        self.giocata = giocata
    }
    
    
    // return (String, String), containing "esito" and "giocata" to play to cover the bet
    public func calculateCoverage() -> (String,String) {
        
        switch esito {
        case "Esito Finale":
            switch giocata {
            case "1":
                return ("Doppia Chance","X2")
            case "2":
                return ("Doppia Chance","1X")
            case "X":
                return ("Doppia Chance","12")
            default:
                return ("Error", "Error")
            }
        case "Primo Tempo":
            switch giocata {
            default:
                return ("Error", "Error")
            }
        case "Doppia Chance":
            switch giocata {
            case "1X":
                return ("Doppia Chance","2")
            case "X2":
                return ("Doppia Chance","1")
            case "12":
                return ("Doppia Chance","X")
            default:
                return ("Error", "Error")
            }
        case "Under/Over 0.5":
            switch giocata {
            case "Under":
                return ("Under/Over 0.5","Over")
            case "Over":
                return ("Under/Over 0.5","Under")
            default:
                return ("Error", "Error")
            }
        case "Under/Over 1.5":
            switch giocata {
            case "Under":
                return ("Under/Over 1.5","Over")
            case "Over":
                return ("Under/Over 1.5","Under")
            default:
                return ("Error", "Error")
            }
        case "Under/Over 2.5":
            switch giocata {
            case "Under":
                return ("Under/Over 2.5","Over")
            case "Over":
                return ("Under/Over 2.5","Under")
            default:
                return ("Error", "Error")
            }
        case "Under/Over 3.5":
            switch giocata {
            case "Under":
                return ("Under/Over 3.5","Over")
            case "Over":
                return ("Under/Over 3.5","Under")
            default:
                return ("Error", "Error")
            }
        case "Under/Over 4.5":
            switch giocata {
            case "Under":
                return ("Under/Over 4.5","Over")
            case "Over":
                return ("Under/Over 4.5","Under")
            default:
                return ("Error", "Error")
            }
        case "Gol/No Gol":
            switch giocata {
            case "Gol":
                return ("Gol/No Gol","No Gol")
            case "No Gol":
                return ("Gol/No Gol","Gol")
            default:
                return ("Error", "Error")
            }
        case "Primo Tempo Gol/No Gol":
            switch giocata {
            case "Gol":
                return ("Primo Tempo Gol/No Gol","No Gol")
            case "No Gol":
                return ("Primo Tempo Gol/No Gol","Gol")
            default:
                return ("Error", "Error")
            }
        case "Secondo Tempo Gol/No Gol":
            switch giocata {
            case "Gol":
                return ("Secondo Tempo Gol/No Gol","No Gol")
            case "No Gol":
                return ("Secondo Tempo Gol/No Gol","Gol")
            default:
                return ("Error", "Error")
            }
        case "Pari/Dispari":
            switch giocata {
            case "Pari":
                return ("Pari/Dispari","Dispari")
            case "Dispari":
                return ("Pari/Dispari","Pari")
            default:
                return ("Error", "Error")
            }
        default:
            return ("Error", "Error")
        }
        
    }
    
    
}

