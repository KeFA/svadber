app = angular.module('Svadber', ['ngResource'])


app.factory "Todo", ["$resource", ($resource) ->
  $resource("/todos.json/:id.:format", {id: "@id"}, {update: {method: "PATCH"}})
]

@TodosCtrl = ($scope, Todo) ->
  $scope.items = Todo.query()

