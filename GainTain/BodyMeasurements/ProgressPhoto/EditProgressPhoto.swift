//
//  EditProgressPhoto.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import CoreData
import SwiftUI

struct EditProgressPhoto: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @Binding var navigationState: NavigationPath
    private var progressPhoto: ProgressPhoto
    private var progress_photo_front: EditingPhoto
    private var progress_photo_side: EditingPhoto
    private var progress_photo_back: EditingPhoto
    
    init(progressPhoto: ProgressPhoto, navigationState: Binding<NavigationPath>) {
        self.progressPhoto = progressPhoto
        progress_photo_front = EditingPhoto(data: progressPhoto.front)
        progress_photo_side = EditingPhoto(data: progressPhoto.side)
        progress_photo_back = EditingPhoto(data: progressPhoto.back)
        _navigationState = navigationState
   }
    
    var body: some View {
        VStack(alignment: .leading) {
            PhotoField(name: "Front", editingPhoto: progress_photo_front)
            PhotoField(name: "Side", editingPhoto: progress_photo_side)
            PhotoField(name: "Back", editingPhoto: progress_photo_back)
            Spacer()
            HStack {
                Button(role: .destructive) { navigationState = NavigationPath() } label: { Text("Cancel").padding() }
                Spacer()
                Button {
                    save()
                    navigationState = NavigationPath()
                } label: { Text("Save").padding() }
            }
        }
        .padding()
    }
    
    private func save() {
        withAnimation {
            progressPhoto.created_at = progressPhoto.created_at ?? Date()
            progressPhoto.front = progress_photo_front.data
            progressPhoto.side = progress_photo_side.data
            progressPhoto.back = progress_photo_back.data
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError(
                    "Unresolved error \(nsError), \(nsError.userInfo)"
                )
            }
        }
    }
}

#Preview {
    EditProgressPhoto(progressPhoto: ProgressPhoto(), navigationState: .constant(NavigationPath()))
}
