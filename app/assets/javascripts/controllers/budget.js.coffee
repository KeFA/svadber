@BudgetCtrl = ($scope, Expenditure, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  $scope.expenditures = Expenditure.query()

  $scope.sort =
    column: ''
    descending: false

  $scope.totalCost = ->
    totalCost = 0
    _.each($scope.expenditures, (exp) -> totalCost += exp.cost)
    totalCost

  $scope.totalPaid = ->
    totalPaid = 0
    _.each($scope.expenditures, (exp) -> totalPaid += exp.paid)
    totalPaid

  $scope.totalRemainToPay = ->
    $scope.totalCost() - $scope.totalPaid()

  $scope.updateExpenditure = (expenditure) ->
#    expenditure.$update() doesn' work: it sets content-type: application/xml but should application/json
    $http.put("/expenditures/#{expenditure.id}",
      expenditure:
        description: expenditure.description
        cost: expenditure.cost
        paid: expenditure.paid
    )

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