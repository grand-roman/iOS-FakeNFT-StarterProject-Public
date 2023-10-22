import Foundation

typealias ProfileFavoriteNFTCellViewModels = [ProfileFavoriteNFTCellViewModel]

struct ProfileFavoriteNFTCellViewModel {
    let url: URL?
    let name: String
    let rating: Int
    let price: String
    let id: String

    init(from: ProfileNFT) {
        self.url = URL(string: from.images[0])
        self.name = from.name
        self.rating = from.rating
        currencyFormatter.numberStyle = .currency
        self.price = currencyFormatter.string(from: from.price as NSNumber)!
        self.id = from.id
    }
}
