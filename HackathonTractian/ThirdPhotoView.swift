//
//  ThirdPhotoView.swift
//  HackathonTractian
//
//  Created by Ricardo de Agostini Neto on 08/08/24.
//

import SwiftUI

struct ThirdPhotoView: View {
    
    
    @State private var isNavigationInitialActive = false
    @StateObject var camera = CameraModel()
    //var classifierManager: ClassifierManager
    @State private var isNavigationUserInput = false
    var classifierManager: ClassifierManager
    
    var image1: CGImage
    var image2: CGImage
    
    
    var body: some View {
        NavigationView {
            VStack {
                
//              
//                Text("Você deverá tirar 3 dfotos, sendo uma do motor, outra da estação de trabalho e outra da placa de identificação")
//                Text("Tire sua terceira, e última foto")
            
                
                GeometryReader { geo in
                CameraPreview(camera: camera, frame: geo.frame(in: .global))
                        
                }
                .ignoresSafeArea()
                
                Spacer()
                
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        //                        Text("Você deverá tirar 3 dfotos, sendo uma do motor, \noutra da estação de trabalho e outra da placa \nde identificação")
                        //                            .foregroundColor(.white)
                        //                            .font(.callout)
                        //                            .fontWeight(.semibold)
                        //                            .padding(.top, 20)
                        //                            .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                        //                            .lineLimit(nil) // Permite que o texto ocupe várias linhas
                        if camera.isTaken {
                        }
                        else {
                            Text("Você deverá tirar 3 fotos, sendo uma do motor")
                                .foregroundColor(.white)
                                .font(.callout)
                                .fontWeight(.regular)
                                .padding(.top, 8)
                                .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                                .lineLimit(nil) // Permite que o texto ocupe várias linhas
                            
                            Text("outra da estação de trabalho e outra da placa")
                                .foregroundColor(.white)
                                .font(.callout)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                                .lineLimit(nil) // Permite que o texto ocupe várias linhas
                            
                            Text("de identificação")
                                .foregroundColor(.white)
                                .font(.callout)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                                .lineLimit(nil) // Permite que o texto ocupe várias linhas
                        }
                        
                        if camera.isTaken {
                            Text("Foto tirada com sucesso!")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.top, 32)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                                .lineLimit(nil) // Permite que o texto ocupe várias linhas
                        }
                        else {
                            Text("Tire sua TERCEIRA foto!")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.top, 8)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center) // Opcional: Alinha o texto ao centro
                                .lineLimit(nil) // Permite que o texto ocupe várias linhas
                        }
                        
                        
                        HStack {
                            
                            if camera.isTaken {
                                
                                Button(action: {camera.reTake()}, label: {
                                    
                                    Text("Tirar novamente")
                                        .tint(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    
                                })
                                .padding(.horizontal, 25)
                                
                                Spacer()
                                
                                
                                //qq coisa descomengtar isso daqui
                                //                        Button {
                                //                            // destination view to navigation to
                                ////                            if let finalImage = camera.finalImage {
                                ////                                AnalysingView(image: finalImage, classifierManager: classifierManager)
                                ////                            }
                                //                            SecondPhotoView()
                                //
                                //
                                //                        } label: {
                                //
                                //                            Text("Usar essa Foto")
                                //                                .tint(.white)
                                //                                .font(.title3)
                                //                                .fontWeight(.semibold)
                                //
                                //                        }.padding(.horizontal, 25)
                                
                                if let finalImage = camera.finalImage {
                                    Button(action: {
                                        
                                        isNavigationUserInput = true
                                    }) {
                                        Text("Usar essa Foto e Finalizar")
                                            .tint(.white)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }.padding(.horizontal, 25)
                                        .background(
                                            NavigationLink(destination: PutInfosView(image1: image1, image2: image2, image3: finalImage, classifierManager: classifierManager), isActive: $isNavigationUserInput) {
                                                EmptyView()
                                            }
                                                .hidden()
                                        )
                                        .padding(.leading, 25)
                                }
                                
                               
                                
                            }
                            else {
                                
                                Button(action: {
                                    camera.session.stopRunning()
                                    
                                    isNavigationInitialActive = true
                                }) {
                                    Text("Cancel")
                                        .tint(.white)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .background(
                                    NavigationLink(destination: InitialView(), isActive: $isNavigationInitialActive) {
                                        EmptyView()
                                    }
                                        .hidden()
                                )
                                .padding(.leading, 25)
                                
                                Spacer()
                                
                                Button(action:
                                        {camera.takePic()
                                },
                                       label: {
                                    
                                    ZStack {
                                        
                                        
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 60)
                                        
                                        Circle()
                                            .stroke(.white, lineWidth: 3)
                                            .frame(width: 70, height: 70)
                                        
                                    }
                                    
                                })
                                Spacer()
                                Spacer()
                            }
                        }/*.frame(height: 70)*/
                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(height: 100)
                    }.padding(.bottom, 60)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 100)
            
                
        }
            .navigationBarBackButtonHidden(true)
        //.padding()
        .onAppear(perform: {
            camera.Check()
        })
        
    }.navigationBarBackButtonHidden(true)
        
    }
}

//
//#Preview {
//
//    CameraView(camera: CameraModel(), classifierManager: ClassifierManager())
//}
