// SPDX-FileCopyrightText: 2021 2020 SAP SE or an SAP affiliate company and cloud-sdk-ios-fioriarkit contributors
//
// SPDX-License-Identifier: Apache-2.0

//
//  ARViewContainer.swift
//  ARTestApp
//
//  Created by O'Brien, Patrick on 1/20/21.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARContainer<ARModel: HasARModel>: UIViewRepresentable {
    @ObservedObject var arState: ARModel
    
    func makeUIView(context: Context) -> ARView {
        return arState.arView ?? ARView(frame: .zero)
    }
    func updateUIView(_ arView: ARView, context: Context) {}
}

protocol HasARModel: ObservableObject {
    var arView: ARView? { get }
    func updateScene(on event: SceneEvents.Update)
}

public protocol AnnotationLoadingStrategy {
    associatedtype CardItem: CardItemModel
    var cardContents: [CardItem] { get }
    func load(arView: ARView) -> [ScreenAnnotation<CardItem>]
}

typealias AnchorID = UUID
public typealias RealityScene = RealityKit.Entity & RealityKit.HasAnchoring