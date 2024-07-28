//
//  RunDetailView.swift
//  Run Tracker
//
//  Created by Justyn Jones on 7/27/24.
//

import SwiftUI

struct RunDetailView: View {
    @ObservedObject var run: Run
    
    var body: some View {
        VStack {
            Text("Run at: \(run.timestamp!, formatter:timeStampFormatter)")
            Text("Distance Ran: \(run.distanceRan!)")
            Text("Run Duration: \(run.runDuration)")
            Text("Average Incline: \(run.averageIncline!)")
        }
    }
}

#Preview {
    return RunDetailView(run: Run())
}
