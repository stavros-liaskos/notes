## GraphQL Basics

```graphql
query Hero($episode: Episode, $withFriends: Boolean! = true) {
  hero(episode: $episode) {
    name
    friends @include(if: $withFriends) {
      name
    }
  }
}
```

##### Variables
Example: `$withFriends: Boolean! = true`  

| Example | Explanation  |
|---|---|
|$withFriends   | variable name |
| Boolean  | type   |
| ! | required var  |
| true | default value  |

##### Directives
@include(if: Boolean) Only include this field in the result if the argument is `true`  
@skip(if: Boolean) Skip this field if the argument is `true`


##### Aliases
Help you rename the result of a field to anything you want.
```graphql
{
   empireHero: hero(episode: EMPIRE) {
     name
   }
   jediHero: hero(episode: JEDI) {
     name
   }
}
```

##### Fragments
Fragments are reusable units, you can think of them as functions that return common fractions  
```graphql
query HeroComparison($first: Int = 3) {
  leftComparison: hero(episode: EMPIRE) {
    ...comparisonFields
  }
  rightComparison: hero(episode: JEDI) {
    ...comparisonFields
  }
}

fragment comparisonFields on Character {
  name
  friendsConnection(first: $first) {
    totalCount
  }
}
``` 

##### Mutations
Mutations can modify server-side data and return nested fields  
```graphql
mutation CreateReviewForEpisode($ep: Episode!, $review: ReviewInput!) {
  createReview(episode: $ep, review: $review) {
    stars
    commentary
  }
}
``` 

## GraphQL Schemas
Schemas can be useful in a few cases, for example, when we want to predict the outcome of the query, What fields can we 
select, what kind of object it could return and more.   
Because GraphQL can be implemented in any language, there is its own implementation for defining schemas, GraphQL Schema 
language.   
Example:
```graphql
type Character {
  appearsIn: [Episode!]!
}
```

| Example |Explanation  |
|---|---|
| Character   | GraphQL Object type |
| appearsIn | fields of Character type|
| [Episode!]! | non-nullable array of Episodes |
| Episode! | non-nullable Episode|



## Source
[GraphQL queries](https://graphql.org/learn/queries/)  
[GraphQL schema](https://graphql.org/learn/schema/)
