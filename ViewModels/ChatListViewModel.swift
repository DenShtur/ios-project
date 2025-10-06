import Foundation
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chats: [Chat] = []
    private let apiService = MattermostAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    func loadChats() {
        apiService.fetchChats { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chats):
                    self?.chats = chats
                case .failure(let error):
                    print("Ошибка загрузки чатов: \(error)")
                }
            }
        }
    }
}
