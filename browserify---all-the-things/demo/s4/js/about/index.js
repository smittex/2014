require('../../bower_components/angular/angular.js');
require('../../bower_components/angular-route/angular-route.js');

module.exports = angular.module('mwjs.about', [
  'ngRoute',
])

  .config([
    '$routeProvider',
    function ($routeProvider) {

      $routeProvider.when('/about', {
        templateUrl: 'js/about/about.tpl.html'
      });

    }
  ])

;
