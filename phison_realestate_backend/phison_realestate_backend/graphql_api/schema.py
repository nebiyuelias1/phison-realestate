from graphene import Schema

from phison_realestate_backend.graphql_api.mutations import Mutation
from phison_realestate_backend.graphql_api.queries import Query

schema = Schema(query=Query, mutation=Mutation)
