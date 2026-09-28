import Foundation

struct TodoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var isDone: Bool

    init(title: String, isDone: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isDone = isDone
    }
}

final class TodoStore: ObservableObject {
    @Published var tasks: [TodoItem] {
        didSet {
            saveTasks()
        }
    }

    private let storageKey = "todo-items"

    init() {
        self.tasks = Self.loadTasks()
    }

    func addTask(_ title: String) {
        let cleaned = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleaned.isEmpty else { return }
        tasks.insert(TodoItem(title: cleaned), at: 0)
    }

    func toggleTask(_ task: TodoItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }

    func deleteTask(_ task: TodoItem) {
        tasks.removeAll { $0.id == task.id }
    }

    func clearCompleted() {
        tasks.removeAll { $0.isDone }
    }

    private func saveTasks() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(tasks) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private static func loadTasks() -> [TodoItem] {
        guard let data = UserDefaults.standard.data(forKey: "todo-items") else {
            return [
                TodoItem(title: "Write your first task"),
                TodoItem(title: "Learn SwiftUI", isDone: true)
            ]
        }

        let decoder = JSONDecoder()
        if let tasks = try? decoder.decode([TodoItem].self, from: data) {
            return tasks
        }

        return []
    }
}
