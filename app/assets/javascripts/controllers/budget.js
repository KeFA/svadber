function BudgetCtrl($scope, Expenditure, $http) {
  $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');

  $scope.totalCost = function () {
    var totalCost = 0;
    _.each($scope.expenditures, function (exp) {
      totalCost += exp.cost;
    });
    return totalCost;
  };


  $scope.totalPaid = function () {
    var totalPaid = 0;
    _.each($scope.expenditures, function (exp) {
      totalPaid += exp.paid;
    });
    return totalPaid;
  };


  $scope.totalRemainToPay = function () {
    return $scope.totalCost() - $scope.totalPaid();
  };


  $scope.updatePaymentStatistic = function () {
    $scope.totalCostValue = $scope.totalCost();
    $scope.totalPaidValue = $scope.totalPaid();
    return $scope.totalRemainToPayValue = $scope.totalRemainToPay();
  };

  $scope.expenditures = Expenditure.query(function () {
    $scope.updatePaymentStatistic();
    $scope.config = {
      datatype: "local",
      height: '100%',
      colNames: [' ', 'Описание', 'Сумма', 'Оплачено', 'Осталось'],
      colModel: [
        {name: 'myac', index: '', width: 80, fixed: true, sortable: false, resize: false,
          formatter: 'actions',
          formatoptions: {
            keys: true,
            delOptions: {recreateForm: true, beforeShowForm: $scope.beforeDeleteCallback}
          }
        },
        { name: 'description', index: 'description', sorttype: "string" },
        { name: 'cost', index: 'cost', width: 100, align: 'right', sorttype: 'float' },
        { name: 'paid', index: 'paid', width: 100, align: 'right', sorttype: 'float' },
        { name: 'remain_to_pay', index: 'remain_to_pay', width: 100, align: 'right', sorttype: "float" }
      ],
      multiselect: true,
      viewrecords: true,
      rowNum: 10,
      rowList: [10, 20, 30],
      pager: '#grid-pager',
      altRows: true,
      multiboxonly: true,
      loadComplete: function () {
        var table = this;
        return setTimeout(function () {
          updatePagerIcons();
        }, 0);
      }
    };
    $scope.data = $scope.expenditures;
  });

  $scope.beforeDeleteCallback = function (e) {
    var form = $(e[0]);
    if (form.data('styled')) return false;

    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />');
    style_delete_form(form);

    form.data('styled', true);
  };


  function updatePagerIcons() {
    var replacement = {
      'ui-icon-seek-first': 'icon-double-angle-left bigger-140',
      'ui-icon-seek-prev': 'icon-angle-left bigger-140',
      'ui-icon-seek-next': 'icon-angle-right bigger-140',
      'ui-icon-seek-end': 'icon-double-angle-right bigger-140'
    };
    $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function () {
//            var $class, icon;
//            icon = $(this);
//            $class = $.trim(icon.attr('class').replace('ui-icon', ''));
//            if ((__indexOf.call(replacement, $class) >= 0)) {
//                return icon.attr('class', 'ui-icon ' + replacement[$class]);
//            }
    });
  }

  $scope.updateExpenditure = function (expenditure) {
    return $http.put("/expenditures/" + expenditure.id, expenditure).success(function () {
      $scope.updatePaymentStatistic();
    });
  };
  $scope.addExpenditure = function () {
    return Expenditure.save({}, function (newExpenditure) {
      $scope.expenditures.push(newExpenditure);
    });
  };
  $scope.removeExpenditure = function (expenditure) {
    Expenditure.remove({id: expenditure.id}, function () {
      $scope.expenditures = _.reject($scope.expenditures, function (item) {
        return item.id === expenditure.id;
      });
      $scope.updatePaymentStatistic();
    });
  };


  $scope.isWritable = function (expenditure) {
    return expenditure.type === 'expenditure';
  };
}