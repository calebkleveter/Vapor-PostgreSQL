import Vapor

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        /// GET /
        builder.get { req in
            return try self.view.make("welcome")
        }
        
        /// GET /hello/...
        builder.resource("hello", HelloController(view))
        
        // response to requests to /info domain
        // with a description of the request
        builder.get("info") { req in
            return req.description
        }
        
        builder.post("user", "new") { (request) -> ResponseRepresentable in
            guard let userName = request.data["username"]?.string,
                  let password = request.data["password"]?.string,
                  let email = request.data["email"]?.string else {
                    throw Abort.badRequest
            }
            
            let user = User(userName: userName, email: email, password: password)
            try user.save()
            
            return "Success!\n\nUser Info:\nName: \(user.userName)\nPassword: \(user.password)\nEmail: \(user.email)\nID: \(String(describing: user.id?.wrapped))"
        }
    }
}
