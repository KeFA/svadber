svadber = angular.module('svadber', ['ngResource', 'ui.sortable'])

svadber.factory "Todo", ["$resource", ($resource) ->
  $resource("/todos/:id.json", {id: "@id"}, {update: {method: "PATCH"}})
]

svadber.factory "Expenditure", ["$resource", ($resource) ->
  $resource("/expenditures/:id:format", {id: "@id"}, {update: {method: "PATCH"}})
]

svadber.factory "Guest", ["$resource", ($resource) ->
  $resource("/guests/:id:format", {id: "@id"}, {update: {method: "PATCH"}})
]

svadber.factory "Car", ["$resource", ($resource) ->
  $resource("/cars/:id:format", {id: "@id"}, {update: {method: "PATCH"}})
]

svadber.directive('ngBlur', ['$parse', ($parse) ->
  (scope, element, attr) ->
    fn = $parse(attr['ngBlur'])
    element.bind('blur', (event) ->
      scope.$apply(->
        fn(scope, $event: event)
      )
    )
])
