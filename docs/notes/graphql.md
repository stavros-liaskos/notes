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
  height(unit: LengthUnit = METER): Float
}
```

| Example |Explanation  |
|---|---|
| Character   | GraphQL Object type |
| appearsIn | fields of Character type|
| [Episode!]! | non-nullable array of Episodes |
| Episode! | non-nullable Episode|
`height` has one _argument_, `unit`. Since it's an _optional_ field, it can have a _default_ value, in this case it's set to `METER`.

##### Scalar types
| <!-- -->    | <!-- -->    |
|-------------|-------------|
| Int         | Integer     | 
| Float       | Double      | 
| String      | String      | 
| Boolean     |`true`/`false`| 
| ID          | String      |
`ID` is not intended to be human-readable. It's often used to refetch an object or for caching.   

> You can also define custom scalar types:  
> `scalar Date`  

[source](https://graphql.org/learn/schema/#scalar-types)


##### Enumeration types
_Enums_ are types restricted to a particular set of values.  
```graphql
enum Episode {
  NEWHOPE
  EMPIRE
  JEDI
}
```  
[source](https://graphql.org/learn/schema/#enumeration-types)

##### Interfaces
An _Interface_ is an abstract type that includes a certain set of fields that a type must include to implement the interface.   
```graphql
interface Character {
  name: String!
}

type Human implements Character {
  name: String!
  starships: [Starship]
}

type Droid implements Character {
  name: String!
  primaryFunction: String
}
```  
[source](https://graphql.org/learn/schema/#interfaces)

##### Union types
Union types are very similar to interfaces, but they don't get to specify any common fields between the types.  
`union SearchResult = Human | Droid | Starship`

```graphql
{
  search(text: "an") {
    __typename
    ... on Human {
      name
      height
    }
    ... on Droid {
      name
      primaryFunction
    }
    ... on Starship {
      name
      length
    }
  }
}
```  
[source](https://graphql.org/learn/schema/#union-types)


##### Input types
Inputs are complex object especially useful in case of mutations.   
```graphql
input ReviewInput {
  stars: Int!
  commentary: String
}
```  
Usage:
```graphql
mutation CreateReviewForEpisode($ep: Episode!, $review: ReviewInput!) {
  createReview(episode: $ep, review: $review) {
    stars
    commentary
  }
}
```
[source](https://graphql.org/learn/schema/#input-types)


## Source
[GraphQL queries](https://graphql.org/learn/queries/)  
[GraphQL schema](https://graphql.org/learn/schema/)















