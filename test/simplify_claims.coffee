should = require 'should'
_ = require 'lodash'
fs = require 'fs'
Q571 = fs.readFileSync 'test/data/Q571.json', 'utf8'
Q571 = JSON.parse Q571

Q4132785 = JSON.parse fs.readFileSync('test/data/Q4132785.json', 'utf8')
Q328212 = JSON.parse fs.readFileSync('test/data/Q328212.json', 'utf8')
Q22002395 = JSON.parse fs.readFileSync('test/data/Q22002395.json', 'utf8')

# a fake entity to simulate a possible negative invalid date
Q4132785NegativeDate = fs.readFileSync 'test/data/Q4132785-negative-date.json', 'utf8'
Q4132785NegativeDate = JSON.parse Q4132785NegativeDate

simplifyClaims = require('../src/helpers/simplify_claims')

describe 'simplifyClaims', ->
  it 'env', (done)->
    Q571.should.be.an.Object
    Q571.claims.should.be.ok
    Q4132785.should.be.an.Object
    Q4132785.claims.P577[0].should.be.ok
    done()

  it 'should return an object', (done)->
    simplifyClaims(Q571.claims)
    done()

  it 'should return an object of same length', (done)->
    originalLength = Object.keys(Q571.claims).length
    simplified = simplifyClaims(Q571.claims)
    newLength = Object.keys(simplified).length
    newLength.should.equal originalLength
    done()

  it 'should return a collection of arrays', (done)->
    simplified = simplifyClaims(Q571.claims)
    for k, v of simplified
      v.should.be.an.Array
    done()

  it 'should return a valid time for possible invalid dates', (done)->
    # exemple: Q4132785>P577 is 1953-00-00T00:00:00Z
    simplified = simplifyClaims Q4132785.claims
    # console.log Q4132785.claims.P577[0].mainsnak
    firstP577 = simplified.P577[0]
    # console.log 'firstP577', firstP577
    isNaN(firstP577).should.equal false
    firstP577.should.equal -536457600000
    done()

  it 'should return a valid time even for possible invalid negative date', (done)->
    # exemple: Q4132785NegativeDate>P577 is -1953-00-00T00:00:00Z
    simplified = simplifyClaims Q4132785NegativeDate.claims
    # console.log Q4132785NegativeDate.claims.P577[0].mainsnak
    firstP577 = simplified.P577[0]
    # console.log 'firstP577', firstP577
    isNaN(firstP577).should.equal false
    firstP577.should.equal -123797894400000
    done()

  it 'should return a url for datatype url', (done)->
    simplified = simplifyClaims Q328212.claims
    firstP856 = simplified.P856[0]
    firstP856.should.equal "http://veronicarothbooks.blogspot.com"
    done()

  it 'should keep only non-null values', (done)->
    simplified = simplifyClaims Q22002395.claims
    # Q22002395 P50 has 2 values with "snaktype": "somevalue"
    # that should be removed
    _.all(simplified.P50, (qid)-> qid?).should.equal true
    done()
