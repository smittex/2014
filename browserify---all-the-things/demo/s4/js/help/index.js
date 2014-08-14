require('../../bower_components/angular/angular.js');
require('../../bower_components/angular-route/angular-route.js');

module.exports = angular.module('mwjs.help', [
  'ngRoute',
])

  .config([
    '$routeProvider',
    function ($routeProvider) {

      $routeProvider.when('/help', {
        templateUrl: 'js/help/help.tpl.html'
      });

    }
  ])

;
