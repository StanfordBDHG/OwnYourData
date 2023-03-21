//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import FirebaseAccount
import FirebaseAuth

struct HealthRecordView: View {
    var body: some View {
        VStack {
            HStack {
                healthRecordButton(label: "Conditions", destination: ConditionsView())
                healthRecordButton(label: "Medication Records", destination: MedicationRecordsView())
            }
            HStack {
                healthRecordButton(label: "Allergies", destination: AllergiesView())
                healthRecordButton(label: "Immunizations", destination: ImmunizationsView())
            }
            HStack {
                healthRecordButton(label: "Clinical Vitals", destination: ClinicalVitalsView())
                healthRecordButton(label: "Lab Results", destination: LabResultsView())
            }
            HStack {
                healthRecordButton(label: "Procedures", destination: ProceduresView())
                healthRecordButton(label: "Other Documents", destination: OtherDocumentsGallery())
            }
        }.padding()
    }

    private func healthRecordButton<Destination: View>(label: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            Text(label)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }.padding(.horizontal)
    }
}

struct HealthRecordView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordView()
    }
}

// Replace the following placeholder views with the actual implementation for each data element category
struct ConditionsView: View { var body: some View { Text("Conditions View") } }
struct MedicationRecordsView: View { var body: some View { Text("Medication Records View") } }
struct AllergiesView: View { var body: some View { Text("Allergies View") } }
struct ImmunizationsView: View { var body: some View { Text("Immunizations View") } }
struct ClinicalVitalsView: View { var body: some View { Text("Clinical Vitals View") } }
struct LabResultsView: View { var body: some View { Text("Lab Results View") } }
struct ProceduresView: View { var body: some View { Text("Procedures View") } }
struct OtherDocumentsGallery: View { var body: some View { Text("Other Documents Gallery") } }


