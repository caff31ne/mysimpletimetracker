//
//  ProgressBarView.swift
//  MySimpleTimeTracker
//
//  Created by Vitalii Bondur on 1/26/25.
//

import SwiftUI

struct ProgressBarView: View {
    
    var value: Double = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color(white: 0.9))
                    .frame(height: geometry.size.height)
                
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: geometry.size.width * min(value, 1), height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ProgressBarView(value: 0.3)
}
