import FluentKit
import FluentSQL

extension QueryBuilder {
    /// Applies an `ST_Distance` sort to this query. Usually you will use the filter operators to do this.
    ///
    ///     let users = try User.query(on: conn)
    ///         .sortByDistance(\.$position, targetPosition)
    ///         .all()
    ///
    /// - parameters:
    ///     - key: Swift `KeyPath` to a field on the model to filter.
    ///     - value: Geometry value to filter by.
    /// - returns: Query builder for chaining.
    @discardableResult
    public func sortByDistance<F, V>(between field: KeyPath<Model, F>, _ value: V) -> Self
        where F: QueryableProperty, F.Model == Model, V: GeometryConvertible
    {
        self.sortByDistance(
            QueryBuilder.path(field),
            QueryBuilder.queryExpressionGeometry(value)
        )
    }
    
    @discardableResult
    public func sortByDistance<ModelSchema, Field>(
        _ field: KeyPath<ModelSchema, Field>,
        _ value: Field.Value
    ) -> Self
    where ModelSchema: Schema,
          Field: QueryableProperty,
          Field.Model == ModelSchema,
          Field.Value: GeometryConvertible
    {
        self.sortByDistance(
            SQLColumn(QueryBuilder.path(field)),
            QueryBuilder.queryExpressionGeography(value)
        )
    }
}

extension QueryBuilder {
    public func sortByDistance(_ args: SQLExpression...) -> Self {
        self.sort(function: "ST_Distance", args: args)
    }
}
