# API #

Inspired by             https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-and-codable-part-1-api-router-349699a47569

## Steps to add an API call ##

### Adding the endpoint ###

- Find or create the related endpoint module named XXXEndpoint.swift

Example:

    AuthEndpoint.swift

- Add a new case into the main enum with the expected parameters from the API doc

Example:

    case login(email: String, password: String)

- Add a new case into the method switch with the expected HTTP method from the API doc

Example:

    var method: HTTPMethod {
        switch self {
        case .login:    return .post
        }
    }

- Add a new case into the path switch with the relative path from the API doc

Example:

    var path: String {
    switch self {
        case .login:    return "/auth/signin"
            }
        }

- Add a new case into the parameters switch with the dictionary of parameters from the API doc

Example:

    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [APIParameterKey.email: email, APIParameterKey.password: password]
        }
    }

- If needed, add a new static constant in the APIParameterKey struct for the new parameter names

Example:

    private struct APIParameterKey {
        static let email = "email"
        static let password = "password"
    }

### Creating the server reponse class ###

- Create a new Decodable struct that is mapping the server JSON response from the API doc to attributes

Example:

    struct LoginResponse: Decodable {
        let token: String
        let userId: String
        let CSRFToken: String
    }

Note: if the server is using a non-Swift compliant attribute name, use the CodingKey protocol for name mapping

Example:

    enum CodingKeys: String, CodingKey {
        case token
        case userId = "user_id"
        case CSRFToken
    }

### Declaring the new call in the APIClient class ###

- create a new static func to perform a request with the parameters and completion handler

Example:

    /// http://
    ///
    /// - parameter email:      User's email
    /// - parameter password:   User's password
    /// - parameter completion: Completion handler with result or error.
    static func login(email: String, password: String, completion: @escaping (Result<LoginResponse>) -> Void) {
        performRequest(route: AuthEndpoint.login(email: email, password: password), completion: completion)
    }

### Use the new call into the related manager ###

- Call the APIClient call and use the result to perform the expected tasks

Example:

    /// Login a new user with email and password
    ///
    /// - parameter email:      User's email
    /// - parameter password:   User's password
    /// - parameter completion: Completion handler with result or error.
    public func login(email: String, password: String, completion: @escaping (Result<Void>) -> Void) {
        APIClient.login(email: email, password: password) { result in
            switch result {
            case .failure(let error):
                completion(Result.failure(error))
            case .success(let login):
                // Do whatever with login (LoginResponse)
                completion(Result.success(true))
            }
        }
    }

