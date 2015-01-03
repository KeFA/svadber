angular.module('svadber').controller('SortableCtrl', ['$scope', function ($scope) {
  $scope.sort = {
    column: '',
    descending: false
  };

  $scope.changeSortOrder = function (sortColumn) {
    if (sortColumn == $scope.sort.column) {
      $scope.sort.descending = !$scope.sort.descending;
    } else {
      $scope.sort.column = sortColumn;
      $scope.sort.descending = false;
    }
  };

  $scope.getClass = function (column) {
    if (column == $scope.sort.column) {
      return 'sort desc-' + $scope.sort.descending;
    } else {
      return '';
    }
  }
}]);