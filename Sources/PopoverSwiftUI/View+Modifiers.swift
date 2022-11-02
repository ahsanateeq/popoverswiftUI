//
//  View+Modifiers.swift
//  Popovers
//
//  Copyright © 2021 PSPDFKit GmbH. All rights reserved.
//

import SwiftUI
import UIKit

extension View {
    public func popoverView<Content>(isPresented: Binding<Bool>,
                                       arrows: UIPopoverArrowDirection = .any,
                                       background: Color? = nil,
                                       @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        self.modifier(AlwaysPopoverModifier(isPresented: isPresented,
                                            arrowDirection: arrows,
                                            background: background,
                                            contentBlock: content))
    }
}
