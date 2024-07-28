//
//  ContentView.swift
//  Run Tracker
//
//  Created by Justyn Jones on 7/25/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var distanceRan: String = ""
    @State private var averageIncline: String = ""
    @State private var runDuration: String = ""

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Run.timestamp, ascending: false)],
        animation: .default)
    private var runs: FetchedResults<Run>

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Distance Ran: ")
                    Spacer()
                    TextField("", text: $distanceRan)
                        .padding([.leading, .trailing], 5)
                        .border(.secondary)
                }
                .padding()
                HStack {
                    Text("Average Incline:")
                    Spacer()
                    TextField("", text: $averageIncline)
                        .padding([.leading, .trailing], 5)
                        .border(.secondary)
                }
                .padding([.leading, .trailing, .bottom])
                HStack {
                    Text("Run Duration:")
                    Spacer()
                    TextField("", text: $runDuration)
                        .padding([.leading, .trailing], 5)
                        .border(.secondary)
                }
                .padding([.leading, .trailing, .bottom])
                
                Button("Add Run") {
                    addItem()
                }
                List {
                    ForEach(runs) { run in
                        NavigationLink {
                            RunDetailView(run: run)
                        } label: {
                            Text("Run at \(run.timestamp!, formatter: timeStampFormatter) for duration \(run.runDuration)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .padding([.bottom])
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newRun = Run(context: viewContext)
            newRun.timestamp = Date()
            newRun.runDuration = Int64(distanceRan) ?? 0
            newRun.averageIncline = NSDecimalNumber(string: averageIncline)
            newRun.distanceRan = NSDecimalNumber(string: runDuration)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { runs[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
