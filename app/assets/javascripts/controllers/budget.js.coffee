@BudgetCtrl = ($scope, Expenditure, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

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

  $scope.updatePaymentStatistic = ->
    $scope.totalCostValue = $scope.totalCost()
    $scope.totalPaidValue = $scope.totalPaid()
    $scope.totalRemainToPayValue = $scope.totalRemainToPay()

  $scope.expenditures = Expenditure.query(->
    $scope.updatePaymentStatistic()
  )

  $scope.updateExpenditure = (expenditure) ->
#    expenditure.$update() doesn' work: it sets content-type: application/xml but should application/json
    $http.put("/expenditures/#{expenditure.id}", expenditure).success(->
      $scope.updatePaymentStatistic()
    )

  $scope.addExpenditure = ->
    Expenditure.save({}, (newExpenditure) ->
      $scope.expenditures.push(newExpenditure)
    )

  $scope.removeExpenditure = (expenditure) ->
    Expenditure.remove({id: expenditure.id}, ->
      $scope.expenditures = _.reject($scope.expenditures, (item) -> item.id == expenditure.id)
      $scope.updatePaymentStatistic()
    )
