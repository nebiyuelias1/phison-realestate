const allUserPaymentScheduleQuery = r'''
query AllUserPaymentSchedules($after: String) {
  allUserPaymentSchedules(first: 20, after: $after) {
    pageInfo {
      hasNextPage
      endCursor
    }
    edges {
      node {
        title
        description
        deadline
        percentage
        amount
        status
        buyer {
          property {
            id
            name
            description
            bedRoomCount
            bathRoomCount
            size
            location
            address
            propertyType
            propertyImage
          }
        }
      }
    }
  }
}
''';
