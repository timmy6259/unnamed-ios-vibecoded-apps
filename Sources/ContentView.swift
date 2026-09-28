import SwiftUI

struct ContentView: View {
    @StateObject private var store = TodoStore()
    @State private var newTask = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Add a task", text: $newTask)
                        .textFieldStyle(.roundedBorder)

                    Button("Add") {
                        store.addTask(newTask)
                        newTask = ""
                    }
                    .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()

                List {
                    ForEach(store.tasks) { task in
                        HStack {
                            Button {
                                store.toggleTask(task)
                            } label: {
                                Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(task.isDone ? .green : .gray)
                            }
                            .buttonStyle(.plain)

                            Text(task.title)
                                .strikethrough(task.isDone)
                                .foregroundStyle(task.isDone ? .secondary : .primary)

                            Spacer()

                            Button {
                                store.deleteTask(task)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear done") {
                        store.clearCompleted()
                    }
                    .disabled(store.tasks.filter(\.isDone).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
