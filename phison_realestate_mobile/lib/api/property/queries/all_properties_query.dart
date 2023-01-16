const allPropertiesQuery = r'''
query AllProperties($isFeatured: Boolean) {
  allProperties(first: 20, isFeatured: $isFeatured){
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
