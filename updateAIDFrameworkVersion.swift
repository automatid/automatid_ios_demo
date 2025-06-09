#!/usr/bin/env swift
/**
 * VERSION: 1.1
 * USAGE : it is called during ot_multi and any other release script
 * NOTE : it is not executed when you run in xcode. If you need to update the internal version you need to execute the script manually.
 */
import Foundation

// Inserisci i tuoi path qui
let pathA = "../AutomatID/AutomatID.podspec"
let pathB = "../AutomatID/Source/Lifecycle/AutomatIDFrameworkVersion.h"

do {
    // Legge il contenuto del file A
    let contentA = try String(contentsOfFile: pathA, encoding: .utf8)
    
    print("Contenuto file A:\n\(contentA)") 

    // Trova la riga che contiene la versione
    guard let versionLine = contentA.split(separator: "\n").first(where: { $0.contains("s.version") }),
          let versionMatch = versionLine.range(of: "'(.*?)'", options: .regularExpression)
    else {
        print("Versione non trovata nel file A.")
        exit(1)
    }
    
    // Estrae la versione
    let version = String(versionLine[versionMatch]).trimmingCharacters(in: CharacterSet(charactersIn: "'"))
    
    // Crea il contenuto per il file B
    let newContent = "#define AUTOMATID_SDK_VERSION @\"\(version)\"\n"
    
    // Scrive il nuovo contenuto nel file B
    try newContent.write(toFile: pathB, atomically: true, encoding: .utf8)
    
    print("File B aggiornato con la versione \(version)")
    
} catch {
    print("Errore: \(error)")
    exit(1)
}
