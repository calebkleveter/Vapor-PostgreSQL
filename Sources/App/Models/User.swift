import PostgreSQLProvider

final class User: Model {
    let storage = Storage()
    let userName: String
    let email: String
    let password: String
    
    init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
    
    init(row: Row) throws {
        self.userName = try row.get("username")
        self.email = try row.get("email")
        self.password = try row.get("password")
    }
}

extension User: RowRepresentable {
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("username", userName)
        try row.set("email", email)
        try row.set("password", password)
        return row
    }
}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (user) in
            user.id()
            user.string("username")
            user.string("email")
            user.string("password")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
