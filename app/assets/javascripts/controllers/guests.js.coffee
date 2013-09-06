@GuestsCtrl = ($scope, Guest) ->
  $scope.guests = Guest.query()