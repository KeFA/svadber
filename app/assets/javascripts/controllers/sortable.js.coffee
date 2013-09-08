@SortableCtrl = ($scope) ->
  $scope.sort =
    column: ''
    descending: false

  $scope.changeSortOrder = (sortColumn) ->
    if sortColumn == $scope.sort.column
      $scope.sort.descending = !$scope.sort.descending
    else
      $scope.sort.column = sortColumn
      $scope.sort.descending = false

  $scope.getClass = (column) ->
    if column == $scope.sort.column
      "sort desc-#{$scope.sort.descending}"
    else
      ""