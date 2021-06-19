//
//  ContentView.swift
//  ARTest12
//
//  Created by Jesus Najera on 6/19/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    
    @State var shuffledClicked = false
    
    var body: some View {
        ZStack {
            ARViewContainer(shuffledClicked: $shuffledClicked).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        shuffledClicked = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 70, height:70)
                                .foregroundColor(.black)
                                .opacity(0.5)
                            Image(systemName: "shuffle")
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }.padding(.bottom, 45)
                    })
                    Spacer()
                }
            }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var shuffledClicked:Bool
    
    
    let mainAnchor = AnchorEntity(plane: .horizontal)
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.scene.addAnchor(mainAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if shuffledClicked {
            print("shuffled clicked ran...")
            for child in -3...3 {
                let entity = ModelEntity(
                    mesh: MeshResource.generateBox(size: 0.01*Float((child+4))),
                    materials: [SimpleMaterial(color: .white, isMetallic: true)]
                )
                entity.position = [Float(child)/10,0,0]
                mainAnchor.addChild(entity)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
