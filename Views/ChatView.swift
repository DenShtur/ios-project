import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    
    init(chat: Chat) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(chat: chat))
    }
    
    @State private var messageText: String = ""
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                HStack(alignment: .top) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    VStack(alignment: .leading) {
                        Text(message.sender.name)
                            .font(.caption)
                        if let text = message.text {
                            Text(text)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        } else if let media = message.media {
                            Text("[Медиа: \(media.type.rawValue)]")
                                .italic()
                        }
                        Text("\(message.timestamp, formatter: dateFormatter)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            HStack {
                TextField("Сообщение...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(text: messageText)
                    messageText = ""
                }) {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.chat.name)
        .onAppear {
            viewModel.loadMessages()
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
