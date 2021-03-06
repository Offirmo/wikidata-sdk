// Generated by CoffeeScript 1.9.3
(function() {
  var simplifyClaims, wd_;

  wd_ = require('./helpers');

  simplifyClaims = require('./simplify_claims');

  module.exports = {
    wd: {
      entities: function(res) {
        var entities, entity, id;
        res = res.body || res;
        entities = res.entities;
        for (id in entities) {
          entity = entities[id];
          entity.claims = simplifyClaims(entity.claims);
        }
        return entities;
      }
    },
    wdq: {
      entities: function(res) {
        var ref;
        res = res.body || res;
        return (ref = res.items) != null ? ref.map(function(item) {
          return wd_.normalizeId(item);
        }) : void 0;
      }
    }
  };

}).call(this);
