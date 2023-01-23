const allPropertiesQuery = r'''
query AllProperties($isFeatured: Boolean, $after: String) {
  allProperties(first: 20, isFeatured: $isFeatured, after: $after) {
    pageInfo {
      hasNextPage
      endCursor
    }
    edges {
      node {
        id
        name
        bedRoomCount
        size
        location
        address
        propertyType
        propertyImage
        video
        description
      }
    }
  }
}
''';
