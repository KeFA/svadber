app = angular.module('Svadber', ['ngResource'])

app.factory "Todo", ["$resource", ($resource) ->
  $resource("/todos/:id:format", {id: "@id"})
]

app.factory "Expenditure", ["$resource", ($resource) ->
  $resource("/expenditures/:id:format", {id: "@id"}, {update: {method: "PATCH"}
  })
]

app.directive('ngBlur', ['$parse', ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr['ngBlur'])
    element.bind('blur', (event) ->
      scope.$apply(->
        fn(scope, $event: event)
      )
    )
])