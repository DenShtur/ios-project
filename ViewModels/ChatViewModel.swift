import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    let chat: Chat
    private let apiService = MattermostAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    init(chat: Chat) {
        self.chat = chat
    }
    
    func loadMessages() {
        apiService.fetchMessages(chatId: chat.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.messages = messages
                case .failure(let error):
                    print("Ошибка загрузки сообщений: \(error)")
                }
            }
        }
    }
    
    func sendMessage(text: String) {
        // TODO: Создать Message и отправить через apiService
    }
}
