@TodosCtrl = ($scope, Todo, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
  $http.defaults.headers.common["Content-Type"] = "application/json";

  $scope.items = Todo.query()

  $scope.addTodo = ->
    return if not $scope.addTodoText

    Todo.save({description: $scope.addTodoText}, (created_todo) ->
      $scope.items.push(created_todo)
      $scope.addTodoText = ''
    )

  $scope.removeTodo = (todoIdToRemove) ->
    Todo.remove({id: todoIdToRemove}, ->
      $scope.items = _.reject($scope.items, (item) ->
        item.id == todoIdToRemove
      )
    )
