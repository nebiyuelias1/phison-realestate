const propertyDetailQuery = r'''
query PropertyDetail($id: String!) {
  property(id: $id) {
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
    images {
      edges {
        node {
          id
          image
          height
          width
        }
      }
    }
  }
}
''';
