import FluentKit
import SQLKit

public struct EnablePostGISMigration: AsyncMigration {
    public init() {}

    public enum EnablePostGISMigrationError: Error {
        case notSqlDatabase
    }

    public func prepare(on database: Database) async throws {
        guard let db = database as? SQLDatabase else {
            throw EnablePostGISMigrationError.notSqlDatabase
        }
        try await db.raw("CREATE EXTENSION IF NOT EXISTS \"postgis\"").run()
    }

    public func revert(on database: Database) async throws {
        guard let db = database as? SQLDatabase else {
            throw EnablePostGISMigrationError.notSqlDatabase
        }
        try await db.raw("DROP EXTENSION IF EXISTS \"postgis\"").run()
    }
}

public var FluentPostGISSrid: UInt = 4326
