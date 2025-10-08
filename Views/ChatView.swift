import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    
    init(chat: Chat) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(chat: chat))
    }
    
    @State private var messageText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(viewModel.messages) { message in
                        let isMe = message.sender.id == (viewModel.chat.participants.first?.id ?? "me")
                        HStack {
                            if isMe {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let text = message.text {
                                        Text(text)
                                            .padding(10)
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(12)
                                            .foregroundColor(.black)
                                    } else if let media = message.media {
                                        Text("[Медиа: \(media.type.rawValue)]")
                                            .italic()
                                    }
                                    Text("\(message.timestamp, formatter: dateFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                VStack(alignment: .leading) {
                                    Text(message.sender.name)
                                        .font(.caption)
                                    if let text = message.text {
                                        Text(text)
                                            .padding(10)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(12)
                                            .foregroundColor(.black)
                                    } else if let media = message.media {
                                        Text("[Медиа: \(media.type.rawValue)]")
                                            .italic()
                                    }
                                    Text("\(message.timestamp, formatter: dateFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.vertical)
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
