@GuestsCtrl = ($scope, Guest, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')
  $scope.guests = Guest.query()

  $scope.updateGuest = (guest) ->
    $http.put("/guests/#{guest.id}", guest: guest)

  $scope.remove = (guest) ->
    Guest.delete(id: guest.id, ->
      $scope.guests = _.reject($scope.guests, (g) ->
        g.id == guest.id)
    )

  $scope.addGuest = () ->
    Guest.save((new_guest) ->
      $scope.guests.push(new_guest))
