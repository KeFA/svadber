@CongratulantCtrl = ($scope, Guest, $http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  $scope.guests = Guest.query()
  $scope.batchRequests = []

  $scope.sortableOptions =
    update: ->
      $scope.updateGuestsOrder()

  $scope.updateGuestsOrder = ->
    $('li.congratulant').each ->
      guest_id = $(this).find('.guest-id').val()
      guest_index = $(this).index()

      guest = _.find($scope.guests, (guest) ->
        guest.id.toString() == guest_id
      )
      guest.congratulate_order = guest_index

      $scope.batchRequests.push
        method: "PATCH"
        url: "/guests/#{guest_id}"
        body: $.param(guest: {congratulate_order: guest_index})

    $.post('/batch', requests: JSON.stringify($scope.batchRequests))
    $scope.batchRequests = []