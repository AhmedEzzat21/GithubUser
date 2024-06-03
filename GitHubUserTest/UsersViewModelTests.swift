//
//  UsersViewModelTests.swift
//  GitHubUserTests
//
//  Created by Ahmed Ezzat on 03/06/2024.
//

import XCTest
@testable import GitHubUser

class UsersViewModelTests: XCTestCase {
    var viewModel: UsersViewModel!
    var mockUsersUseCase: MockUsersUseCase!
    var mockImagesRepository: MockImagesRepository!
    var closures: UsersViewModelClosures!
    
    override func setUp() {
        super.setUp()
        mockUsersUseCase = MockUsersUseCase()
        mockImagesRepository = MockImagesRepository()
        closures = UsersViewModelClosures(showUserDetails: { _ in })
        viewModel = UsersViewModel(usersUseCase: mockUsersUseCase, imagesRepository: mockImagesRepository, closures: closures)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUsersUseCase = nil
        mockImagesRepository = nil
        closures = nil
        super.tearDown()
    }
    
    func testViewDidLoadFetchesUsers() {
        // Arrange
        let users = [User(id: 1, login: "John Doe", image: nil)]
        mockUsersUseCase.fetchResult = .success(users)
        
        // Act
        viewModel.viewDidLoad()
        
        // Assert
        XCTAssertEqual(viewModel.items.value.count, 1)
        XCTAssertEqual(viewModel.items.value.first?.user?.login, "John Doe")
    }
    
    func testDidSearchWithQueryFetchesSearchedUsers() {
        // Arrange
        let users = [User(id: 2, login: "Jane Doe", image: nil)]
        mockUsersUseCase.searchResult = .success(users)
        
        // Act
        viewModel.didSearch(query: "Jane")
        
        // Assert
        XCTAssertEqual(viewModel.items.value.count, 1)
        XCTAssertEqual(viewModel.items.value.first?.user?.login, "Jane Doe")
    }
    
    func testDidSelectCallsShowUserDetailsClosure() {
        // Arrange
        let user = User(id: 4,login: "Alice",image: nil)
        let userItemViewModel = UserItemViewModel(user: user)
        var didCallShowUserDetails = false
        closures = UsersViewModelClosures(showUserDetails: { selectedUser in
            didCallShowUserDetails = true
            XCTAssertEqual(selectedUser.id, user.id)
        })
        viewModel = UsersViewModel(usersUseCase: mockUsersUseCase, imagesRepository: mockImagesRepository, closures: closures)
        
        // Act
        viewModel.didSelect(item: userItemViewModel)
        
        // Assert
        XCTAssertTrue(didCallShowUserDetails)
    }
    
    func testItemWillAppearFetchesImage() {
        // Arrange
        let user = User(id: 4,login: "Bob",image: nil)
        let userItemViewModel = UserItemViewModel(user: user)
        let imageData = Data([0x00, 0x01, 0x02, 0x03])
        mockImagesRepository.fetchImageResult = .success(imageData)
        
        // Act
        viewModel.itemWillAppear(item: userItemViewModel)
        
        // Assert
        XCTAssertEqual(userItemViewModel.user?.image, imageData)
    }
    
    func testErrorIsSetOnFetchFailure() {
        // Arrange
        let fetchError = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Fetch failed"])
        mockUsersUseCase.fetchResult = .failure(fetchError)
        
        // Act
        viewModel.viewDidLoad()
        
        // Assert
        XCTAssertEqual(viewModel.error.value, fetchError.localizedDescription)
    }
    
    func testEmptyDataTitleWhenNoItems() {
        // Arrange & Act
        viewModel.items.value = []
        
        // Assert
        XCTAssertTrue(viewModel.isEmpty)
        XCTAssertEqual(viewModel.emptyDataTitle, "Nothing found")
    }
    func testScreenTitleIsCorrect() {
        // Assert
        XCTAssertEqual(viewModel.screenTitle, "Users")
    }
    func testSearchBarPlaceholderIsCorrect() {
        // Assert
        XCTAssertEqual(viewModel.searchBarPlaceholder, "Search users")
    }
    func testFetchImageDoesNotOverwriteExistingImage() {
        // Arrange
        let existingImageData = Data([0x00])
        let user = User(id: 5, login: "Existing Image User", image: existingImageData)
        let userItemViewModel = UserItemViewModel(user: user)
        
        // Act
        viewModel.itemWillAppear(item: userItemViewModel)
        
        // Assert
        XCTAssertEqual(userItemViewModel.user?.image, existingImageData)
    }
    func testErrorIsSetOnImageFetchFailure() {
        // Arrange
        let user = User(id: 6, login: "Error Image User", image: nil)
        let userItemViewModel = UserItemViewModel(user: user)
        let fetchError = NSError(domain: "test", code: 2, userInfo: [NSLocalizedDescriptionKey: "Image fetch failed"])
        mockImagesRepository.fetchImageResult = .failure(fetchError)
        
        // Act
        viewModel.itemWillAppear(item: userItemViewModel)
        
        // Assert
        XCTAssertEqual(viewModel.error.value, fetchError.localizedDescription)
    }
    func testLoadCancelsPreviousTask() {
        // Arrange
        let firstLoadTask = MockCancellable()
        let secondLoadTask = MockCancellable()
        mockUsersUseCase.fetchResult = .success([])
        mockUsersUseCase.fetchClosure = { completion in
            completion(.success([]))
            return firstLoadTask
        }
        
        // Act
        viewModel.viewDidLoad()
        mockUsersUseCase.fetchClosure = { completion in
            completion(.success([]))
            return secondLoadTask
        }
        viewModel.viewDidLoad()
        
        // Assert
        XCTAssertTrue(firstLoadTask.isCancelled)
        XCTAssertFalse(secondLoadTask.isCancelled)
    }
}
