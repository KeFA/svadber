var svadber = angular.module('svadber', ['ngResource', 'ui.sortable']);

svadber.factory('Todo', ['$resource', function ($resource) {
  return $resource('/todos/:id.json', {id: '@id'}, {update: {method: 'PATCH'}});
}]);

svadber.factory('Expenditure', ['$resource', function ($resource) {
  return $resource('/expenditures/:id.json', {id: '@id'}, {update: {method: 'PATCH'}});
}]);

svadber.factory('Guest', ['$resource', function ($resource) {
  return $resource('/guests/:id.json', {id: '@id'}, {update: {method: 'PATCH'}});
}]);

svadber.factory('Car', ['$resource', function ($resource) {
  return $resource('/cars/:id.json', {id: '@id'}, {update: {method: 'PATCH'}});
}]);

svadber.directive('ngBlur', ['$parse', function($parse) {
  return function(scope, element, attr) {
    var fn = $parse(attr['nbBlur']);
    element.bind('blur', function(e) {
      scope.$apply(function() {
        fn(scope, {$event: e});
      });
    })
  };
}]);

