//
//  AlwaysPopoverModifier.swift
//  Popovers
//
//  Copyright © 2021 PSPDFKit GmbH. All rights reserved.
//

import SwiftUI
import UIKit

//public enum ArrowDirection {
//    case any, up, down, left, right
//
//    var popoverDirection: UIPopoverArrowDirection {
//        switch self {
//        case .any:
//            return .any
//        case .up:
//            return .up
//        case .down:
//            return .down
//        case .left:
//            return .left
//        case .right:
//            return .right
//        }
//    }
//}

struct AlwaysPopoverModifier<PopoverContent>: ViewModifier where PopoverContent: View {
    
    let isPresented: Binding<Bool>
    let arrowDirection: UIPopoverArrowDirection
    let background: Color?
    let contentBlock: () -> PopoverContent
    
    // Workaround for missing @StateObject in iOS 13.
    private struct Store {
        var anchorView = UIView()
    }
    @State private var store = Store()
    
    func body(content: Content) -> some View {
        if isPresented.wrappedValue {
            presentPopover()
        } else {
            dismissPopOver()
        }
        
        return content
            .background(InternalAnchorView(uiView: store.anchorView))
    }
    
    private func presentPopover() {
        let contentController = ContentViewController(rootView: contentBlock(), isPresented: isPresented)
        contentController.modalPresentationStyle = .popover
        if let background = self.background {
            let color = UIColor(background)
            contentController.view.backgroundColor = color
        }
        
        let view = store.anchorView
        guard let popover = contentController.popoverPresentationController else { return }
        popover.sourceView = view
        popover.sourceRect = view.bounds
        popover.delegate = contentController
        popover.permittedArrowDirections = arrowDirection
        
        guard let sourceVC = view.closestVC() else { return }
        if let presentedVC = sourceVC.presentedViewController {
            presentedVC.dismiss(animated: true) {
                sourceVC.present(contentController, animated: true)
            }
        } else {
            sourceVC.present(contentController, animated: true)
        }
    }
    
    private func dismissPopOver() {
        guard let sourceVC = store.anchorView.closestVC(),
              let presentedVC = sourceVC.presentedViewController else { return }
        presentedVC.dismiss(animated: true)
    }
    
    private struct InternalAnchorView: UIViewRepresentable {
        typealias UIViewType = UIView
        let uiView: UIView
        
        func makeUIView(context: Self.Context) -> Self.UIViewType {
            uiView
        }
        
        func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) { }
    }
}
