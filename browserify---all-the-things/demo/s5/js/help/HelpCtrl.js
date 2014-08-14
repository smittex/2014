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
  }
];
