spawn = require('child_process').spawn
expect = require('chai').expect

describe 'sample Test', ->
  it 'sample', (done) ->
    childProcess = spawn 'node', ['concat'],
      cwd: 'paiza-sample'
    childProcess.stdin.write '''
      4
      1000
      1992
      2000
      2001
    '''
    childProcess.stdin.end()

    stdoutData = ''
    childProcess.stdout.on 'data', (chunk) ->
      stdoutData += chunk

    childProcess.on 'close', ->
      expect(stdoutData).is.equal '''
        1000 is not a leap year
        1992 is a leap year
        2000 is a leap year
        2001 is not a leap year

      '''
      done()
