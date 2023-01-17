const allPropertiesQuery = r'''
query AllProperties($isFeatured: Boolean, $after: String) {
  allProperties(first: 2, isFeatured: $isFeatured, after: $after) {
    pageInfo {
      hasNextPage
      endCursor
    }
    edges {
      node {
        name
        bedRoomCount
        size
        location
        address
        propertyType
        propertyImage
      }
    }
  }
}
''';
