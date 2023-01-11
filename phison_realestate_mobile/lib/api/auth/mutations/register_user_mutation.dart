const String registerUserMutation = r'''
  mutation RegisterUser($email: String!,
                        $phoneNumber: String!,
                        $name: String!,
                        $token: String!) {
      register(input: {email: $email,
                      phoneNumber: $phoneNumber,
                      name: $name,
                      token: $token}) {
          name
          email
          phoneNumber
      }
  }
''';
