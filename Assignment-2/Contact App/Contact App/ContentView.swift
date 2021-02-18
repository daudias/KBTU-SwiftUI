//
//  ContentView.swift
//  Contact App
//
//  Created by Dias on 2/18/21.
//

import SwiftUI

struct Contact: Identifiable {
    var name: String
    var phoneNumber: String
    var gender: Gender = .male
    var id = UUID()
    
    enum Gender: String, CaseIterable {
        case male = "male", female = "female"
    }
}

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func deleteContact(at indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
    }
    func deleteContact(_ contact: Contact) {
        for i in contacts.indices {
            if contacts[i].id == contact.id {
                contacts.remove(at: i)
                break
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var contactViewModel = ContactViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(contactViewModel.contacts) { contact in
                    NavigationLink(destination: ContactInfoView(contact: contact, contactViewModel: contactViewModel)) {
                        ContactView(contact: contact)
                    }
                }.onDelete(perform: contactViewModel.deleteContact)
            }
            .navigationBarTitle("Contacts", displayMode: .inline)
            .toolbar(content: {
                NavigationLink(destination: NewContactView(contactViewModel: contactViewModel)) {
                    Text("+")
                }
            })
        }
    }
}

struct ContactView: View {
    private let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var body: some View {
        HStack {
            Image(contact.gender.rawValue)
                .resizable()
                .frame(width: 80, height: 80)
            Spacer()
            VStack(spacing: 5) {
                Text(contact.name)
                Text(contact.phoneNumber)
            }
            Spacer()
        }
    }
}

struct NewContactView: View {
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var gender: Contact.Gender = .male
    var contactViewModel: ContactViewModel
    var body: some View {
        
        VStack(spacing: 40) {
            TextField("Name", text: $name).border(Color.black, width: 1)
            TextField("Phone number", text: $phoneNumber).border(Color.black, width: 1)
            Picker("Gender", selection: $gender) {
                ForEach(Contact.Gender.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.pickerStyle(WheelPickerStyle())
            Spacer()
            Button("Save") {
                contactViewModel.addContact(Contact(name: name, phoneNumber: phoneNumber, gender: gender))
            }.frame(maxWidth: .infinity).background(Color.green)
        }
    }
}

struct ContactInfoView: View {
    let contact: Contact
    let contactViewModel: ContactViewModel
    var body: some View {
        VStack {
            ContactView(contact: contact)
            Spacer()
            Button("Delete") {
                contactViewModel.deleteContact(contact)
            }.foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
