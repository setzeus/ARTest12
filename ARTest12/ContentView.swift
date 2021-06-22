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
    
    @State var shuffledClicked = true
    
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
        arView.addCoaching()
        arView.scene.addAnchor(mainAnchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        var startingColorR:Float = Float.random(in: 70..<185)/255
        var startingColorG:Float = Float.random(in: 70..<185)/255
        var startingColorB:Float = Float.random(in: 70..<185)/255
        
        if shuffledClicked {
            print("shuffled clicked ran...")
            mainAnchor.children.removeAll()
            for child in -3...3 {
                
                startingColorR = startingColorR + Float(Float(child+3)*5/255)
                startingColorG = startingColorG + Float(Float(child+3)*5/255)
                startingColorB = startingColorB + Float(Float(child+3)*5/255)
                
                let entity = ModelEntity(
                    mesh: MeshResource.generateBox(size: 0.01*Float((child+4))),
                    materials: [SimpleMaterial(color: UIColor(red: CGFloat(startingColorR), green: CGFloat(startingColorG), blue: CGFloat(startingColorB), alpha: 1.0), isMetallic: false)]
                )
                print(startingColorR)
                print(startingColorG)
                print(startingColorB)
                entity.position = [Float(child)/10,0,0]
                mainAnchor.addChild(entity)
            }
            shuffledClicked = false
        }
        
    }
    
}

extension ARView: ARCoachingOverlayViewDelegate {  func addCoaching() {    // Create a ARCoachingOverlayView object
    let coachingOverlay = ARCoachingOverlayView()
    // Make sure it rescales if the device orientation changes
    coachingOverlay.autoresizingMask = [
      .flexibleWidth, .flexibleHeight
    ]
    self.addSubview(coachingOverlay)    // Set the Augmented Reality goal
    coachingOverlay.goal = .horizontalPlane    // Set the ARSession
    coachingOverlay.session = self.session    // Set the delegate for any callbacks
    coachingOverlay.delegate = self
  }  // Example callback for the delegate object
public func coachingOverlayViewDidDeactivate(
    _ coachingOverlayView: ARCoachingOverlayView
  ) {
    print("horizontal surface found")
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
