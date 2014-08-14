module.exports = [
  function() {
    return {
      restrict: 'A',
      template: '<div class="alert" ng-click="toggleClass()">Click Me to toggle alert</div>',
      link: function($scope, ele, attrs) {
        $scope.toggleClass = function() {
          ele.toggleClass('alert-danger');
        };
      }
    };
  }
];
