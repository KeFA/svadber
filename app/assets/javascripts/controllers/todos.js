angular.module('svadber').controller('TodosCtrl', ['$scope', 'Todo', '$http', function($scope, Todo, $http) {
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
  $http.defaults.headers.common["Content-Type"] = "application/json";

  $scope.todos = Todo.query();

  $scope.addTodo = function() {
    if (!$scope.addTodoText) return;

    Todo.save({description: $scope.addTodoText}, function(createdTodo) {
      $scope.todos.push(createdTodo);
      $scope.addTodoText = '';
    });
  };

  $scope.updateTodo = function(todo) {
    todo.done = !todo.done;
    Todo.update({id: todo.id, done: todo.done});
  };

  $scope.removeTodo = function(id) {
    Todo.remove({id: id}, function () {
      $scope.todos = _.reject($scope.todos, function(item) {
        return item.id == id;
      })
    });
  }
}]);