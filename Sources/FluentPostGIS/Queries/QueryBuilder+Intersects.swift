import FluentSQL
import WKCodable

extension QueryBuilder {
    /// Applies an ST_Intersects filter to this query. Usually you will use the filter operators to do this.
    ///
    ///     let users = try User.query(on: conn)
    ///         .filterGeometryIntersects(\.area, path)
    ///         .all()
    ///
    /// - parameters:
    ///     - key: Swift `KeyPath` to a field on the model to filter.
    ///     - value: Geometry value to filter by.
    /// - returns: Query builder for chaining.
    @discardableResult
    public func filterGeometryIntersects<F, V>(_ field: KeyPath<Model, F>, _ value: V) -> Self
        where F: QueryableProperty, F.Model == Model, V: GeometryConvertible
    {
        self.queryGeometryIntersects(
            QueryBuilder.path(field),
            QueryBuilder.queryExpressionGeometry(value)
        )
    }

    /// Applies an ST_Intersects filter to this query. Usually you will use the filter operators to do this.
    ///
    ///     let users = try User.query(on: conn)
    ///         .filterGeometryIntersects(area, \.path)
    ///         .all()
    ///
    /// - parameters:
    ///     - value: Geometry value to filter by.
    ///     - key: Swift `KeyPath` to a field on the model to filter.
    /// - returns: Query builder for chaining.
    @discardableResult
    public func filterGeometryIntersects<F, V>(_ value: V, _ field: KeyPath<Model, F>) -> Self
        where F: QueryableProperty, F.Model == Model, V: GeometryConvertible
    {
        self.queryGeometryIntersects(
            QueryBuilder.queryExpressionGeometry(value),
            QueryBuilder.path(field)
        )
    }
}

extension QueryBuilder {
    /// Creates an instance of `QueryFilter` for ST_Intersects from a field and value.
    ///
    /// - parameters:
    ///     - field: Field to filter.
    ///     - value: Value type.
    public func queryGeometryIntersects(_ path: String, _ value: SQLExpression) -> Self {
        self.applyFilter(function: "ST_Intersects", path: path, value: value)
        return self
    }

    /// Creates an instance of `QueryFilter` for ST_Intersects from a field and value.
    ///
    /// - parameters:
    ///     - value: Value type.
    ///     - field: Field to filter.
    public func queryGeometryIntersects(_ value: SQLExpression, _ path: String) -> Self {
        self.applyFilter(function: "ST_Intersects", value: value, path: path)
        return self
    }
}
