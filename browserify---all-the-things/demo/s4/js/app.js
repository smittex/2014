require('../bower_components/angular/angular.js');
require('../bower_components/angular-route/angular-route.js');

angular.module('mwjs', [
  'ngRoute',
  require('./help/index').name,
  require('./about/index').name
])

  .config([
    '$routeProvider',
    '$locationProvider',
    function ($routeProvider, $locationProvider) {

      $routeProvider.when('/', {
        templateUrl: 'js/home.tpl.html'
      });

      //default location
      $routeProvider.otherwise({
        redirectTo: '/'
      });

      //non html 5 mode so we get [url]/#/[route]/:[id]
      $locationProvider.html5Mode(false);
    }
  ])
;
