import Foundation

class MattermostAPIService {
    private let baseURL = URL(string: "https://your-mattermost-server.com/api/v4")!
    private let token = "YOUR_MATTERMOST_TOKEN" // Замените на реальный токен
    
    // Получение списка чатов
    func fetchChats(completion: @escaping (Result<[Chat], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("channels")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MattermostAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Нет данных от сервера"])))
                return
            }
            do {
                let channels = try JSONDecoder().decode([MattermostChannel].self, from: data)
                let chats = channels.map { $0.toChat() }
                completion(.success(chats))
            } catch {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка парсинга: \(error)")
            }
        }
        task.resume()
    }
    
    // Получение сообщений чата/канала
    func fetchMessages(chatId: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("channels/\(chatId)/posts")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MattermostAPI", code: 2, userInfo: [NSLocalizedDescriptionKey: "Нет данных от сервера"])))
                return
            }
            do {
                let postsResponse = try JSONDecoder().decode(MattermostPostsResponse.self, from: data)
                let messages = postsResponse.posts.values.map { $0.toMessage(chatId: chatId) }
                completion(.success(messages))
            } catch {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка парсинга: \(error)")
            }
        }
        task.resume()
    }
    
    // Отправка сообщения
    func sendMessage(chatId: String, message: Message, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "channel_id": chatId,
            "message": message.text ?? "",
            "user_id": message.sender.id
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка отправки сообщения: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(NSError(domain: "MattermostAPI", code: 3, userInfo: [NSLocalizedDescriptionKey: "Ошибка отправки сообщения"])))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
    
    // Загрузка медиа
    func uploadMedia(data: Data, type: MediaType, completion: @escaping (Result<Media, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("files")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        let filename = "upload.\(type.rawValue)"
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"files\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка загрузки медиа: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MattermostAPI", code: 4, userInfo: [NSLocalizedDescriptionKey: "Нет данных от сервера"])))
                return
            }
            do {
                let response = try JSONDecoder().decode(MattermostFileUploadResponse.self, from: data)
                guard let fileInfo = response.file_infos.first else {
                    completion(.failure(NSError(domain: "MattermostAPI", code: 5, userInfo: [NSLocalizedDescriptionKey: "Нет информации о файле"])))
                    return
                }
                let media = Media(id: fileInfo.id, type: type, url: URL(string: fileInfo.link)!, thumbnailURL: nil)
                completion(.success(media))
            } catch {
                completion(.failure(error))
                print("[MattermostAPIService] Ошибка парсинга ответа: \(error)")
            }
        }
        task.resume()
    }
}

struct MattermostChannel: Codable {
    let id: String
    let display_name: String
    let type: String
    // Добавьте другие поля по необходимости
    
    func toChat() -> Chat {
        Chat(id: id, name: display_name, isGroup: type != "D", participants: [], lastMessage: nil)
    }
}

struct MattermostPostsResponse: Codable {
    let posts: [String: MattermostPost]
}

struct MattermostPost: Codable {
    let id: String
    let user_id: String
    let message: String
    let create_at: Int64
    // Добавьте другие поля по необходимости
    
    func toMessage(chatId: String) -> Message {
        Message(
            id: id,
            chatId: chatId,
            sender: User(id: user_id, name: "", avatarURL: nil, status: nil),
            text: message,
            media: nil,
            timestamp: Date(timeIntervalSince1970: Double(create_at) / 1000),
            isRead: false
        )
    }
}

struct MattermostFileUploadResponse: Codable {
    let file_infos: [MattermostFileInfo]
}

struct MattermostFileInfo: Codable {
    let id: String
    let link: String
}
