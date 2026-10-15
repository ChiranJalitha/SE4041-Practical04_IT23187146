import SwiftUI

struct ContentView: View {

    @State private var students: [Student] = []
    @State private var studentName = ""
    @State private var markText = ""

    var passedCount: Int {
        students.filter { $0.passed }.count
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 16) {

                TextField("Student Name", text: $studentName)
                    .textFieldStyle(.roundedBorder)

                TextField("Mark", text: $markText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)

                Button("Add Student") {

                    guard !studentName.isEmpty else {
                        return
                    }

                    guard let mark = Int(markText) else {
                        return
                    }

                    guard mark >= 0 && mark <= 100 else {
                        return
                    }

                    let student = Student(
                        name: studentName,
                        mark: mark
                    )

                    students.append(student)

                    studentName = ""
                    markText = ""
                }
                .buttonStyle(.borderedProminent)

                Text("Passed Students: \(passedCount)")
                    .font(.headline)

                List(students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        HStack {
                            Text(student.name)

                            Spacer()

                            Text("\(student.mark)")
                                .bold()
                                .foregroundStyle(
                                    student.passed ? .green : .red
                                )
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("SE4041 Marks")
        }
    }
}

#Preview {
    ContentView()
}
