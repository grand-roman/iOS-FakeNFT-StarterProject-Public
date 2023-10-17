import Foundation

protocol ProfileServiceProtocol {
    func getProfile(with request: NetworkRequest, completion: @escaping (Result<Profile, Error>) -> Void)
    func checkError() -> Bool
    var error: Error? { get }
}

final class ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient
    private(set) var error: Error?

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func checkError() -> Bool {
        if error?.localizedDescription == NetworkClientError.httpStatusCode(429).localizedDescription {
            error = nil
            return true
        } else {
            error = nil
            return false
        }
    }

    func getProfile(with request: NetworkRequest, completion: @escaping (Result<Profile, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            self.networkClient.send(
                request: request,
                type: Profile.self
            ) { (result: Result<Profile, Error>) in
                switch result {
                case .success(let profile):
                    DispatchQueue.main.async {
                        completion(.success(profile))
                    }
                case .failure(let error):
                    self.error = error
                    completion(.failure(error))
                }
            }
        }
    }
}

extension ProfileService {
    private enum Constants: String {
        case author, NFT
    }
}
