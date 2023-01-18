const allUserPaymentScheduleQuery = r'''
query AllUserPaymentSchedules($after) {
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
      }
    }
  }
}
''';
