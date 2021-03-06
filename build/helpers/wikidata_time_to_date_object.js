// Generated by CoffeeScript 1.9.3
(function() {
  var fullDateData, negativeDate, parseInvalideDate, positiveDate;

  module.exports = function(wikidataTime) {
    var date, rest, sign;
    sign = wikidataTime[0];
    rest = wikidataTime.slice(1);
    date = fullDateData(sign, rest);
    if (date.toString() === 'Invalid Date') {
      return parseInvalideDate(sign, rest);
    } else {
      return date;
    }
  };

  fullDateData = function(sign, rest) {
    if (sign === '-') {
      return negativeDate(rest);
    } else {
      return positiveDate(rest);
    }
  };

  positiveDate = function(rest) {
    return new Date(rest);
  };

  negativeDate = function(rest) {
    var date;
    date = "-00" + rest;
    return new Date(date);
  };

  parseInvalideDate = function(sign, rest) {
    var day, month, ref, year;
    ref = rest.split('T')[0].split('-'), year = ref[0], month = ref[1], day = ref[2];
    return fullDateData(sign, year);
  };

}).call(this);
