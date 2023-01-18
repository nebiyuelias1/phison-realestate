const allNotificationsQuery = r'''
query AllUserNotifications($isRead: Boolean, $after: String)  {
  allUserNotifications(first: 20, isRead: $isRead, after: $after) {
    pageInfo {
      hasNextPage
      endCursor
    }
    edges {
      node {
        createdAt
        updatedAt
        isRead
        notificationType
        data
      }
    }
  }
}
''';
