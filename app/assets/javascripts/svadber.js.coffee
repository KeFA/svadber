app = angular.module('Svadber', ['ngResource'])


app.factory "Todo", ["$resource", ($resource) ->
  $resource("/todos/:id:format", {id: "@id"}, {update: {method: "PATCH"}})
]


@TodosCtrl = ($scope, Todo, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  $scope.items = Todo.query()

  $scope.addTodo = ->
    Todo.save({description: $scope.addTodoText}, (created_todo) ->
      $scope.items.push(created_todo)
      $scope.addTodoText = ''
    )

  $scope.removeTodo = (todoIdToRemove) ->
    Todo.remove({id: todoIdToRemove}, ->
      $scope.items = _.filter($scope.items, (item) ->
        item.id != todoIdToRemove
      )
    )
