// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ value: MXLBeater.Value) -> String {
        switch value {
        case .bow:
            "Bow"

        case .chimeHammer:
            "Chime hammer"

        case .coin:
            "Coin"

        case .drumStick:
            "Drum stick"

        case .finger:
            "Finger"

        case .fingernail:
            "Fingernail"

        case .fist:
            "Fist"

        case .guiroScraper:
            "Guiro scraper"

        case .hammer:
            "Hammer"

        case .hand:
            "Hand"

        case .jazzStick:
            "Jazz stick"

        case .knittingNeedle:
            "Knitting needle"

        case .metalHammer:
            "Metal hammer"

        case .slideBrushOnGong:
            "Slide brush on gong"

        case .snareStick:
            "Snare stick"

        case .spoonMallet:
            "Spoon mallet"

        case .superball:
            "Superball"

        case .triangleBeater:
            "Triangle beater"

        case .triangleBeaterPlain:
            "Triangle beater plain"

        case .wireBrush:
            "Wire brush"
        }
    }

    internal func format(_ value: MXLEffect.Value) -> String {
        switch value {
        case .anvil:
            "Anvil"

        case .autoHorn:
            "Auto horn"

        case .birdWhistle:
            "Bird whistle"

        case .cannon:
            "Cannon"

        case .duckCall:
            "Duck call"

        case .gunShot:
            "Gun shot"

        case .klaxonHorn:
            "Klaxon horn"

        case .lionsRoar:
            "Lions roar"

        case .lotusFlute:
            "Lotus flute"

        case .megaphone:
            "Megaphone"

        case .policeWhistle:
            "Police whistle"

        case .siren:
            "Siren"

        case .slideWhistle:
            "Slide whistle"

        case .thunderSheet:
            "Thunder sheet"

        case .windMachine:
            "Wind machine"

        case .windWhistle:
            "Wind whistle"
        }
    }

    internal func format(_ value: MXLMembrane.Value) -> String {
        switch value {
        case .bassDrum:
            "Bass drum"

        case .bassDrumOnSide:
            "Bass drum on side"

        case .bongos:
            "Bongos"

        case .chineseTomtom:
            "Chinese tomtom"

        case .congaDrum:
            "Conga drum"

        case .cuica:
            "Cuica"

        case .gobletDrum:
            "Goblet drum"

        case .indoAmericanTomtom:
            "Indo-American tomtom"

        case .japaneseTomtom:
            "Japanese tomtom"

        case .militaryDrum:
            "Military drum"

        case .snareDrum:
            "Snare drum"

        case .snareDrumSnaresOff:
            "Snare drum snares off"

        case .tabla:
            "Tabla"

        case .tambourine:
            "Tambourine"

        case .tenorDrum:
            "Tenor drum"

        case .timbales:
            "Timbales"

        case .tomtom:
            "Tomtom"
        }
    }

    internal func format(_ value: MXLMetal.Value) -> String {
        switch value {
        case .agogo:
            "Agogo"

        case .almglocken:
            "Almglocken"

        case .bell:
            "Bell"

        case .bellPlate:
            "Bell plate"

        case .bellTree:
            "Bell tree"

        case .brakeDrum:
            "Brake drum"

        case .cencerro:
            "Cencerro"

        case .chainRattle:
            "Chain rattle"

        case .chineseCymbal:
            "Chinese cymbal"

        case .cowbell:
            "Cowbell"

        case .crashCymbals:
            "Crash cymbals"

        case .crotale:
            "Crotale"

        case .cymbalTongs:
            "Cymbal tongs"

        case .domedGong:
            "Domed gong"

        case .fingerCymbals:
            "Finger cymbals"

        case .flexatone:
            "Flexatone"

        case .gong:
            "Gong"

        case .handbell:
            "Handbell"

        case .highHatCymbals:
            "High-hat cymbals"

        case .hiHat:
            "Hi-hat"

        case .jawHarp:
            "Jaw harp"

        case .jingleBells:
            "Jingle bells"

        case .musicalSaw:
            "Musical saw"

        case .shellBells:
            "Shell bells"

        case .sistrum:
            "Sistrum"

        case .sizzleCymbal:
            "Sizzle cymbal"

        case .sleighBells:
            "Sleigh bells"

        case .suspendedCymbal:
            "Suspended cymbal"

        case .tamTam:
            "Tam tam"

        case .tamTamWithBeater:
            "Tam tam with beater"

        case .triangle:
            "Triangle"

        case .vietnameseHat:
            "Vietnamese hat"
        }
    }

    internal func format(_ value: MXLPitched.Value) -> String {
        switch value {
        case .celesta:
            "Celesta"

        case .chimes:
            "Chimes"

        case .glockenspiel:
            "Glockenspiel"

        case .lithophone:
            "Lithophone"

        case .mallet:
            "Mallet"

        case .marimba:
            "Marimba"

        case .steelDrums:
            "Steel drums"

        case .tubaphone:
            "Tubaphone"

        case .tubularChimes:
            "Tubular chimes"

        case .vibraphone:
            "Vibraphone"

        case .xylophone:
            "Xylophone"
        }
    }

    internal func format(_ value: MXLWood.Value) -> String {
        switch value {
        case .bambooScraper:
            "Bamboo scraper"

        case .boardClapper:
            "Board clapper"

        case .cabasa:
            "Cabasa"

        case .castanets:
            "Castanets"

        case .castanetsWithHandle:
            "Castanets with handle"

        case .claves:
            "Claves"

        case .footballRattle:
            "Football rattle"

        case .guiro:
            "Guiro"

        case .logDrum:
            "Log drum"

        case .maraca:
            "Maraca"

        case .maracas:
            "Maracas"

        case .quijada:
            "Quijada"

        case .rainstick:
            "Rainstick"

        case .ratchet:
            "Ratchet"

        case .recoReco:
            "Reco-reco"

        case .sandpaperBlocks:
            "Sandpaper blocks"

        case .slitDrum:
            "Slit drum"

        case .templeBlock:
            "Temple block"

        case .vibraslap:
            "Vibraslap"

        case .whip:
            "Whip"

        case .woodBlock:
            "Wood block"
        }
    }
}
