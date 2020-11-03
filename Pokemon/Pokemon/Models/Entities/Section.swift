//
//  Section.swift
//  Pokemon
//
//  Created by Alberto Bo on 26/10/2020.
//

import Foundation
import UIKit


protocol Sectionable {

    var sectionId: UUID { get set }
    var items: [ItemViewModelType] { get set }
    var itemsPerLine: Int { get set }
    var lineSpacing: CGFloat { get set }
    var itemSpacing: CGFloat { get set }
    var edgeInsets: UIEdgeInsets { get set }
    
}


struct Section: Sectionable, Hashable {

    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.sectionId == rhs.sectionId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.sectionId)
    }

    var itemsPerLine: Int = 1
    var lineSpacing: CGFloat = .zero
    var itemSpacing: CGFloat = .zero
    var edgeInsets: UIEdgeInsets = .zero

    var items: [ItemViewModelType] = []
    var sectionId: UUID = UUID()

    init(items: [ItemViewModelType],
         itemsPerLine: Int = 1,
         lineSpacing: CGFloat = .zero,
         itemSpacing: CGFloat = .zero,
         edgeInsets: UIEdgeInsets = UIEdgeInsets(top: .zero, left: 12.0, bottom: .zero, right: 12.0)) {
        
        self.itemsPerLine = itemsPerLine
        self.lineSpacing = lineSpacing
        self.itemSpacing = itemSpacing
        self.edgeInsets = edgeInsets
        self.items = items
    }

}
