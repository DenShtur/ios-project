// MARK: - Sync test comment from Copilot
// MARK: - Copilot sync test comment
import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.chats) { chat in
                NavigationLink(destination: ChatView(chat: chat)) {
                    HStack {
                        // Аватар
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text(chat.name)
                                .font(.headline)
                            if let lastMessage = chat.lastMessage {
                                Text(lastMessage.text ?? "[Медиа]")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
                .navigationTitle("Chats")
            .onAppear {
                viewModel.loadChats()
            }
        }
    }
}
