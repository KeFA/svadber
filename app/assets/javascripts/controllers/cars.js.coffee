angular.module('svadber').controller('CarsCtrl', ['$scope', 'Car', '$http', ($scope, Car, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  $scope.totalCost = ->
    totalCost = 0
    _.each($scope.cars, (car) ->
      totalCost += car.cost)
    totalCost

  $scope.totalPaid = ->
    totalPaid = 0
    _.each($scope.cars, (car) ->
      totalPaid += car.paid)
    totalPaid

  $scope.totalRemainToPay = ->
    totalRemainToPay = 0
    _.each($scope.cars, (car) ->
      totalRemainToPay += car.remain_to_pay)
    totalRemainToPay

  $scope.updatePaymentStatistic = ->
    $scope.totalCostValue = $scope.totalCost()
    $scope.totalPaidValue = $scope.totalPaid()
    $scope.totalRemainToPayValue = $scope.totalRemainToPay()


  $scope.cars = Car.query(->
    $scope.updatePaymentStatistic()
  )

  $scope.updateCar = (car) ->
    $http.put("/cars/#{car.id}", car).success(->
      updated_car = Car.get({id: car.id}, ->
        _.each($scope.cars, (car, i) ->
          if updated_car.id == car.id
            $scope.cars[i] = updated_car
        )
        $scope.updatePaymentStatistic()
      )
    )

  $scope.addCar = ->
    Car.save({}, (newCar) ->
      $scope.cars.push(newCar)
    )

  $scope.removeCar = (car) ->
    Car.remove({id: car.id}, ->
      $scope.cars = _.reject($scope.cars, (item) ->
        item.id == car.id)
      $scope.updatePaymentStatistic()
    )
])
