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
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        VStack {
            HStack {
                Text("Distance Ran: ")
                Spacer()
                TextField("", text: $distanceRan)
                    .padding([.leading, .trailing], 5)
                    .border(.secondary)
            }
            .padding([.leading, .trailing, .bottom])
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
            List {
                ForEach(runs) { run in
                    Text("Run at \(run.timestamp!, formatter: itemFormatter) for duration \(run.runDuration)")
                }
                .onDelete(perform: deleteItems)
            }
            
            Spacer()
            Button("Add Run") {
                addItem()
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
