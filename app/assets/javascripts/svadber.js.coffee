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


@BudgetCtrl = ($scope, Expenditure, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  $scope.expenditures = Expenditure.query()

  $scope.sort =
    column: 'description'
    descending: false

  $scope.totalCost = ->
    _.reduce(_.map($scope.expenditures, (exp) -> exp.cost), (a, b) -> a + b
    0)

  $scope.totalPaid = ->
    _.reduce(_.map($scope.expenditures, (exp) -> exp.paid), (a, b) -> a + b
    0)

  $scope.totalRemainToPay = ->
    $scope.totalCost() - $scope.totalPaid()

  $scope.updateExpenditure = (expenditure) ->
#    expenditure.$update() doesn' work: it sets content-type: application/xml but should application/json
    $http.put("/expenditures/#{expenditure.id}", expenditure: expenditure)

  $scope.addExpenditure = ->
    Expenditure.save({}, (newExpenditure) ->
      $scope.expenditures.push(newExpenditure)
    )

  $scope.removeExpenditure = (expenditure) ->
    Expenditure.remove({id: expenditure.id}, ->
      $scope.expenditures = _.reject($scope.expenditures, (item) -> item.id == expenditure.id)
    )

  $scope.updateRemainToPaid = (expenditure) ->
    expenditure.remain_to_paid = expenditure.cost - expenditure.paid

  $scope.changeSortOrder = (sortColumn) ->
    if sortColumn == $scope.sort.column
      $scope.sort.descending = !$scope.sort.descending
    else
      $scope.sort.column = sortColumn
      $scope.sort.descending = false

  $scope.getColumnClass = (column) ->
    if column == $scope.sort.column
      "sort desc-#{$scope.sort.descending}"
    else
      ""