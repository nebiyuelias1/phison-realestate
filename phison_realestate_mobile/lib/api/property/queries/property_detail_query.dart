const propertyDetailQuery = r'''
query PropertyDetail($id: ID!) {
  property(id: $id) {
    id
    name
    bedRoomCount
    bathRoomCount
    size
    location
    address
    propertyType
    propertyImage
    video
    description
    paymentInfos {
		  edges {
		    node {
          title
          timePeriod
          amount
          description
		    }
		  }
		}
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
