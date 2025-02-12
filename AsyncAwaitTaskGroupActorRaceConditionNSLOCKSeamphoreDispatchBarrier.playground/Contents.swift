import Foundation
import UIKit

// async and await
func fetchPatientData() async -> String {
    try! await Task.sleep(nanoseconds: 2_000_000_000)
    return "Patient data fetched"
}

Task {
    let result = await fetchPatientData()
    print(result)
}

// taskGroups
func fetchMedicalRecords() async -> [String] {
    return await withTaskGroup(of: String.self) { group in
        for i in 1...5 {
            group.addTask {
                try! await Task.sleep(nanoseconds: UInt64(i) * 1_000_000_000)
                return "Medical record for patient \(i)"
            }
        }

        var records: [String] = []
        for await record in group {
            records.append(record)
        }
        return records
    }
}

Task {
    let records = await fetchMedicalRecords()
    print(records)
}

// actor
actor HospitalResources {
    var availableBeds: Int = 10
    
    func allocateBed() {
        availableBeds -= 1
    }
}

let resources = HospitalResources()
Task {
    await resources.allocateBed()
    print(await resources.availableBeds)
}

// race condition
actor Hospital {
    var admittedPatients: Int = 0
    
    func admitPatient() {
        admittedPatients += 1
    }
}

let hospital = Hospital()
let group = DispatchGroup()

for _ in 1...100 {
    group.enter()
    Task {
        await hospital.admitPatient()
        group.leave()
    }
}

group.notify(queue: .main) {
    Task {
        print("Admitted patients: \(await hospital.admittedPatients)")
    }
}

// dispatchBarrier
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

for i in 1...5 {
    concurrentQueue.async {
        print("Processing patient \(i)")
    }
}

concurrentQueue.async(flags: .barrier) {
    print("Updating all patient records")
}

for i in 6...10 {
    concurrentQueue.async {
        print("Processing patient \(i)")
    }
}
