var _ = require('lodash');

var characters = [
  { 'name': 'barney', 'age': 36, 'blocked': false },
  { 'name': 'fred',   'age': 40, 'blocked': true },
  { 'name': 'wilma', 'age': 36, 'blocked': false },
  { 'name': 'betty', 'age': 37, 'blocked': false },
];

module.exports = [
  '$scope',
  function($scope) {

    $scope.contactus = {
      subject: '',
      body: '',
      from: ''
    };

    $scope.sendEmail = function() {
      // Send email
      alert('Email sent from ' + $scope.contactus.from);
    };

    $scope.characters = characters;

    $scope.findEmAll = function() {
      var are36 = _.filter(characters, { 'age': 36 });
      return are36.length;
    };
  }
];
