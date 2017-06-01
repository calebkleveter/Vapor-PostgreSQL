import LeafProvider
import PostgreSQLProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [JSON.self, Node.self]

        try setupProviders()
        addPreparations()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(LeafProvider.Provider.self)
        try addProvider(PostgreSQLProvider.Provider.self)
    }
    
    private func addPreparations() {
        preparations.append(User.self)
    }
}
